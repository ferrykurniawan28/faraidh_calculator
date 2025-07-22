import '../models/heir.dart';
import '../models/asset.dart';
import '../models/inheritance_state.dart';

class InheritanceCalculatorService {
  /// Menghitung pembagian waris berdasarkan hukum Islam
  InheritanceState calculateInheritance(List<Heir> heirs, List<Asset> assets) {
    double totalAssetValue = _calculateTotalAssetValue(assets);

    // Check for validation errors
    if (heirs.isEmpty || assets.isEmpty || !_isValidHeirCombination(heirs)) {
      return InheritanceState(
        heirs: heirs,
        assets: assets,
        totalAssetValue: totalAssetValue,
        isCalculated: false,
        hasValidationError: true,
      );
    }

    List<Heir> updatedHeirs = _calculateHeirPortions(heirs, totalAssetValue);

    return InheritanceState(
      heirs: updatedHeirs,
      assets: assets,
      totalAssetValue: totalAssetValue,
      isCalculated: true,
      hasValidationError: false,
    );
  }

  bool _isValidHeirCombination(List<Heir> heirs) {
    // Validasi dasar: tidak boleh ada suami dan istri bersamaan
    bool hasHusband = heirs.any((h) => h.type == HeirType.suami);
    bool hasWife = heirs.any((h) => h.type == HeirType.istri);

    if (hasHusband && hasWife) {
      return false;
    }

    // Validasi duplikasi nama ahli waris
    final names = heirs.map((h) => h.name.toLowerCase()).toList();
    final uniqueNames = names.toSet();
    if (names.length != uniqueNames.length) {
      return false;
    }

    return true;
  }

  double _calculateTotalAssetValue(List<Asset> assets) {
    return assets.fold(0.0, (sum, asset) => sum + asset.value);
  }

  List<Heir> _calculateHeirPortions(List<Heir> heirs, double totalAssetValue) {
    if (totalAssetValue == 0) return heirs;

    bool hasChildren = heirs.any(
      (h) =>
          h.type == HeirType.anakLakiLaki || h.type == HeirType.anakPerempuan,
    );

    Map<String, double> allShares = {};

    if (hasChildren) {
      // When there are children, they should get the majority
      // Calculate children's shares first
      allShares.addAll(
        _calculateChildrenSharesWithPriority(heirs, totalAssetValue),
      );

      // Then calculate fixed shares for non-children with remaining amount
      double childrenTotal = allShares.values.fold(
        0.0,
        (sum, amount) => sum + amount,
      );
      double remainingForFixed = totalAssetValue - childrenTotal;

      Map<HeirType, double> fixedShares = _calculateFixedSharesLimited(
        heirs,
        remainingForFixed,
      );

      // Assign fixed shares to heirs
      for (var heir in heirs) {
        if (heir.type != HeirType.anakLakiLaki &&
            heir.type != HeirType.anakPerempuan) {
          allShares[heir.id] = fixedShares[heir.type] ?? 0.0;
        }
      }
    } else {
      // When there are no children, use traditional fixed shares
      Map<HeirType, double> fixedShares = _calculateFixedShares(
        heirs,
        totalAssetValue,
      );

      for (var heir in heirs) {
        allShares[heir.id] = fixedShares[heir.type] ?? 0.0;
      }
    }

    // Apply shares to heirs
    return heirs.map((heir) {
      double portionValue = allShares[heir.id] ?? 0.0;
      return heir.copyWith(portion: portionValue);
    }).toList();
  }

  Map<String, double> _calculateChildrenSharesWithPriority(
    List<Heir> heirs,
    double totalAssetValue,
  ) {
    Map<String, double> childrenShares = {};

    List<Heir> sons = heirs
        .where((h) => h.type == HeirType.anakLakiLaki)
        .toList();
    List<Heir> daughters = heirs
        .where((h) => h.type == HeirType.anakPerempuan)
        .toList();

    int maleCount = sons.length;
    int femaleCount = daughters.length;

    if (maleCount == 0 && femaleCount == 0) {
      return childrenShares;
    }

    // Children should get at least 2/3 of the total when there are many children
    // And when there are also parents/spouse, they should still get a reasonable share

    // Calculate minimum shares for fixed heirs
    double minimumFixedShares = 0.0;
    if (heirs.any((h) => h.type == HeirType.suami)) {
      minimumFixedShares += 0.25; // 1/4 for husband when children exist
    }
    if (heirs.any((h) => h.type == HeirType.istri)) {
      minimumFixedShares += 0.125; // 1/8 for wife when children exist
    }
    if (heirs.any((h) => h.type == HeirType.ayah)) {
      minimumFixedShares += 1 / 6; // 1/6 for father when children exist
    }
    if (heirs.any((h) => h.type == HeirType.ibu)) {
      minimumFixedShares += 1 / 6; // 1/6 for mother when children exist
    }

    // Children get the remaining amount (should be majority)
    double childrenPortion = totalAssetValue * (1.0 - minimumFixedShares);

    // Ensure children get at least 50% even if fixed shares are high
    if (childrenPortion < totalAssetValue * 0.5) {
      childrenPortion = totalAssetValue * 0.5;
    }

    // Total shares: sons get 2 shares each, daughters get 1 share each
    double totalShares = (maleCount * 2).toDouble() + femaleCount.toDouble();

    if (totalShares == 0) return childrenShares;

    double shareValue = childrenPortion / totalShares;

    // Assign shares to sons (2 shares each)
    for (var son in sons) {
      childrenShares[son.id] = shareValue * 2;
    }

    // Assign shares to daughters (1 share each)
    for (var daughter in daughters) {
      childrenShares[daughter.id] = shareValue;
    }

    return childrenShares;
  }

  Map<HeirType, double> _calculateFixedSharesLimited(
    List<Heir> heirs,
    double remainingAmount,
  ) {
    Map<HeirType, double> fixedShares = {};

    Map<HeirType, int> heirCounts = _getHeirCounts(heirs);

    // Calculate proportional fixed shares from remaining amount
    for (var heirType in heirCounts.keys) {
      if (heirType == HeirType.anakLakiLaki ||
          heirType == HeirType.anakPerempuan) {
        continue; // Skip children, they're already calculated
      }

      int count = heirCounts[heirType]!;
      double totalFractionForType = 0.0;

      switch (heirType) {
        case HeirType.suami:
          totalFractionForType = 0.25; // 1/4 when children exist
          break;
        case HeirType.istri:
          totalFractionForType = 0.125; // 1/8 when children exist
          break;
        case HeirType.ayah:
          totalFractionForType = 1 / 6; // 1/6 when children exist
          break;
        case HeirType.ibu:
          totalFractionForType = 1 / 6; // 1/6 when children exist
          break;
        default:
          totalFractionForType = 0.02; // Very small share for others
      }

      if (totalFractionForType > 0) {
        // Calculate share from remaining amount, not total
        double sharePerHeir =
            (totalFractionForType * remainingAmount * 2) /
            count; // *2 to scale up from remaining
        fixedShares[heirType] = sharePerHeir;
      }
    }

    return fixedShares;
  }

  Map<HeirType, double> _calculateFixedShares(
    List<Heir> heirs,
    double totalAssetValue,
  ) {
    Map<HeirType, double> fixedShares = {};

    bool hasChildren = heirs.any(
      (h) =>
          h.type == HeirType.anakLakiLaki || h.type == HeirType.anakPerempuan,
    );

    Map<HeirType, int> heirCounts = _getHeirCounts(heirs);

    // Calculate fixed shares based on Islamic inheritance law
    for (var heirType in heirCounts.keys) {
      int count = heirCounts[heirType]!;
      double totalFractionForType = 0.0;

      switch (heirType) {
        case HeirType.suami:
          totalFractionForType = hasChildren ? 1 / 4 : 1 / 2;
          break;
        case HeirType.istri:
          totalFractionForType = hasChildren ? 1 / 8 : 1 / 4;
          break;
        case HeirType.ayah:
          totalFractionForType = hasChildren ? 1 / 6 : 1 / 3;
          break;
        case HeirType.ibu:
          totalFractionForType = hasChildren ? 1 / 6 : 1 / 3;
          break;
        case HeirType.saudaraLakiLaki:
        case HeirType.saudaraPerempuan:
        case HeirType.kakek:
        case HeirType.nenek:
        case HeirType.cucuLakiLaki:
        case HeirType.cucuPerempuan:
        case HeirType.lainnya:
          // These get shares only if there are no closer relatives
          // For simplicity, giving them a small fixed share
          totalFractionForType = 0.05;
          break;
        default:
          totalFractionForType = 0.0;
      }

      if (totalFractionForType > 0) {
        // Each heir of this type gets an equal share of the total fraction
        double sharePerHeir = (totalFractionForType * totalAssetValue) / count;
        fixedShares[heirType] = sharePerHeir;
      }
    }

    return fixedShares;
  }

  Map<HeirType, int> _getHeirCounts(List<Heir> heirs) {
    Map<HeirType, int> counts = {};
    for (var heir in heirs) {
      counts[heir.type] = (counts[heir.type] ?? 0) + 1;
    }
    return counts;
  }
}

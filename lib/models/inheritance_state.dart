import 'package:equatable/equatable.dart';
import 'heir.dart';
import 'asset.dart';

class InheritanceState extends Equatable {
  final List<Heir> heirs;
  final List<Asset> assets;
  final double totalAssetValue;
  final bool isCalculated;

  const InheritanceState({
    this.heirs = const [],
    this.assets = const [],
    this.totalAssetValue = 0.0,
    this.isCalculated = false,
  });

  InheritanceState copyWith({
    List<Heir>? heirs,
    List<Asset>? assets,
    double? totalAssetValue,
    bool? isCalculated,
  }) {
    return InheritanceState(
      heirs: heirs ?? this.heirs,
      assets: assets ?? this.assets,
      totalAssetValue: totalAssetValue ?? this.totalAssetValue,
      isCalculated: isCalculated ?? this.isCalculated,
    );
  }

  @override
  List<Object?> get props => [heirs, assets, totalAssetValue, isCalculated];
}

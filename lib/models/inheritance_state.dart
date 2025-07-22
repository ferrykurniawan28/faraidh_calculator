import 'package:equatable/equatable.dart';
import 'heir.dart';
import 'asset.dart';

class InheritanceState extends Equatable {
  final List<Heir> heirs;
  final List<Asset> assets;
  final double totalAssetValue;
  final bool isCalculated;
  final bool hasValidationError;

  const InheritanceState({
    this.heirs = const [],
    this.assets = const [],
    this.totalAssetValue = 0.0,
    this.isCalculated = false,
    this.hasValidationError = false,
  });

  InheritanceState copyWith({
    List<Heir>? heirs,
    List<Asset>? assets,
    double? totalAssetValue,
    bool? isCalculated,
    bool? hasValidationError,
  }) {
    return InheritanceState(
      heirs: heirs ?? this.heirs,
      assets: assets ?? this.assets,
      totalAssetValue: totalAssetValue ?? this.totalAssetValue,
      isCalculated: isCalculated ?? this.isCalculated,
      hasValidationError: hasValidationError ?? this.hasValidationError,
    );
  }

  @override
  List<Object?> get props => [
    heirs,
    assets,
    totalAssetValue,
    isCalculated,
    hasValidationError,
  ];
}

import 'package:equatable/equatable.dart';
import '../models/heir.dart';
import '../models/asset.dart';

abstract class InheritanceEvent extends Equatable {
  const InheritanceEvent();

  @override
  List<Object?> get props => [];
}

class AddHeirEvent extends InheritanceEvent {
  final Heir heir;

  const AddHeirEvent(this.heir);

  @override
  List<Object?> get props => [heir];
}

class RemoveHeirEvent extends InheritanceEvent {
  final String heirId;

  const RemoveHeirEvent(this.heirId);

  @override
  List<Object?> get props => [heirId];
}

class UpdateHeirEvent extends InheritanceEvent {
  final Heir heir;

  const UpdateHeirEvent(this.heir);

  @override
  List<Object?> get props => [heir];
}

class AddAssetEvent extends InheritanceEvent {
  final Asset asset;

  const AddAssetEvent(this.asset);

  @override
  List<Object?> get props => [asset];
}

class RemoveAssetEvent extends InheritanceEvent {
  final String assetId;

  const RemoveAssetEvent(this.assetId);

  @override
  List<Object?> get props => [assetId];
}

class UpdateAssetEvent extends InheritanceEvent {
  final Asset asset;

  const UpdateAssetEvent(this.asset);

  @override
  List<Object?> get props => [asset];
}

class CalculateInheritanceEvent extends InheritanceEvent {
  const CalculateInheritanceEvent();
}

class ResetCalculationEvent extends InheritanceEvent {
  const ResetCalculationEvent();
}

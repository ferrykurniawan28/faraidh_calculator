import 'package:flutter_bloc/flutter_bloc.dart';
import 'inheritance_event.dart';
import '../models/inheritance_state.dart';
import '../models/heir.dart';
import '../models/asset.dart';
import '../services/inheritance_calculator_service.dart';

class InheritanceBloc extends Bloc<InheritanceEvent, InheritanceState> {
  final InheritanceCalculatorService _calculatorService;

  InheritanceBloc({InheritanceCalculatorService? calculatorService})
    : _calculatorService = calculatorService ?? InheritanceCalculatorService(),
      super(const InheritanceState()) {
    on<AddHeirEvent>(_onAddHeir);
    on<RemoveHeirEvent>(_onRemoveHeir);
    on<UpdateHeirEvent>(_onUpdateHeir);
    on<AddAssetEvent>(_onAddAsset);
    on<RemoveAssetEvent>(_onRemoveAsset);
    on<UpdateAssetEvent>(_onUpdateAsset);
    on<CalculateInheritanceEvent>(_onCalculateInheritance);
    on<ResetCalculationEvent>(_onResetCalculation);
  }

  void _onAddHeir(AddHeirEvent event, Emitter<InheritanceState> emit) {
    final updatedHeirs = List<Heir>.from(state.heirs)..add(event.heir);
    emit(state.copyWith(heirs: updatedHeirs, isCalculated: false));
  }

  void _onRemoveHeir(RemoveHeirEvent event, Emitter<InheritanceState> emit) {
    final updatedHeirs = state.heirs
        .where((heir) => heir.id != event.heirId)
        .toList();
    emit(state.copyWith(heirs: updatedHeirs, isCalculated: false));
  }

  void _onUpdateHeir(UpdateHeirEvent event, Emitter<InheritanceState> emit) {
    final updatedHeirs = state.heirs.map((heir) {
      return heir.id == event.heir.id ? event.heir : heir;
    }).toList();
    emit(state.copyWith(heirs: updatedHeirs, isCalculated: false));
  }

  void _onAddAsset(AddAssetEvent event, Emitter<InheritanceState> emit) {
    final updatedAssets = List<Asset>.from(state.assets)..add(event.asset);
    final totalValue = updatedAssets.fold(
      0.0,
      (sum, asset) => sum + asset.value,
    );
    emit(
      state.copyWith(
        assets: updatedAssets,
        totalAssetValue: totalValue,
        isCalculated: false,
      ),
    );
  }

  void _onRemoveAsset(RemoveAssetEvent event, Emitter<InheritanceState> emit) {
    final updatedAssets = state.assets
        .where((asset) => asset.id != event.assetId)
        .toList();
    final totalValue = updatedAssets.fold(
      0.0,
      (sum, asset) => sum + asset.value,
    );
    emit(
      state.copyWith(
        assets: updatedAssets,
        totalAssetValue: totalValue,
        isCalculated: false,
      ),
    );
  }

  void _onUpdateAsset(UpdateAssetEvent event, Emitter<InheritanceState> emit) {
    final updatedAssets = state.assets.map((asset) {
      return asset.id == event.asset.id ? event.asset : asset;
    }).toList();
    final totalValue = updatedAssets.fold(
      0.0,
      (sum, asset) => sum + asset.value,
    );
    emit(
      state.copyWith(
        assets: updatedAssets,
        totalAssetValue: totalValue,
        isCalculated: false,
      ),
    );
  }

  void _onCalculateInheritance(
    CalculateInheritanceEvent event,
    Emitter<InheritanceState> emit,
  ) {
    final result = _calculatorService.calculateInheritance(
      state.heirs,
      state.assets,
    );
    emit(result);
  }

  void _onResetCalculation(
    ResetCalculationEvent event,
    Emitter<InheritanceState> emit,
  ) {
    emit(const InheritanceState());
  }
}

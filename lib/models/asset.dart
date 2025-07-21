import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

enum AssetType { rumah, tanah, mobil, uang, emas, saham, tabungan, lainnya }

class Asset extends Equatable {
  final String id;
  final String name;
  final AssetType type;
  final double value;
  final String description;

  const Asset({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    this.description = '',
  });

  factory Asset.create({
    required String name,
    required AssetType type,
    required double value,
    String description = '',
  }) {
    return Asset(
      id: const Uuid().v4(),
      name: name,
      type: type,
      value: value,
      description: description,
    );
  }

  Asset copyWith({
    String? id,
    String? name,
    AssetType? type,
    double? value,
    String? description,
  }) {
    return Asset(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      description: description ?? this.description,
    );
  }

  String get typeDisplayName {
    switch (type) {
      case AssetType.rumah:
        return 'Rumah';
      case AssetType.tanah:
        return 'Tanah';
      case AssetType.mobil:
        return 'Mobil';
      case AssetType.uang:
        return 'Uang';
      case AssetType.emas:
        return 'Emas';
      case AssetType.saham:
        return 'Saham';
      case AssetType.tabungan:
        return 'Tabungan';
      case AssetType.lainnya:
        return 'Lainnya';
    }
  }

  String getLocalizedTypeDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case AssetType.rumah:
        return l10n.house;
      case AssetType.tanah:
        return l10n.land;
      case AssetType.mobil:
        return l10n.car;
      case AssetType.uang:
        return l10n.money;
      case AssetType.emas:
        return l10n.gold;
      case AssetType.saham:
        return l10n.stocks;
      case AssetType.tabungan:
        return l10n.savings;
      case AssetType.lainnya:
        return l10n.other;
    }
  }

  @override
  List<Object?> get props => [id, name, type, value, description];
}

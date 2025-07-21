import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

enum HeirType {
  suami,
  istri,
  ayah,
  ibu,
  anakLakiLaki,
  anakPerempuan,
  saudaraLakiLaki,
  saudaraPerempuan,
  kakek,
  nenek,
  cucuLakiLaki,
  cucuPerempuan,
  lainnya,
}

enum Gender { lakiLaki, perempuan }

class Heir extends Equatable {
  final String id;
  final String name;
  final HeirType type;
  final Gender gender;
  final double portion;

  const Heir({
    required this.id,
    required this.name,
    required this.type,
    required this.gender,
    this.portion = 0.0,
  });

  factory Heir.create({
    required String name,
    required HeirType type,
    required Gender gender,
  }) {
    return Heir(id: const Uuid().v4(), name: name, type: type, gender: gender);
  }

  Heir copyWith({
    String? id,
    String? name,
    HeirType? type,
    Gender? gender,
    double? portion,
  }) {
    return Heir(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      portion: portion ?? this.portion,
    );
  }

  String get typeDisplayName {
    switch (type) {
      case HeirType.suami:
        return 'Suami';
      case HeirType.istri:
        return 'Istri';
      case HeirType.ayah:
        return 'Ayah';
      case HeirType.ibu:
        return 'Ibu';
      case HeirType.anakLakiLaki:
        return 'Anak Laki-laki';
      case HeirType.anakPerempuan:
        return 'Anak Perempuan';
      case HeirType.saudaraLakiLaki:
        return 'Saudara Laki-laki';
      case HeirType.saudaraPerempuan:
        return 'Saudara Perempuan';
      case HeirType.kakek:
        return 'Kakek';
      case HeirType.nenek:
        return 'Nenek';
      case HeirType.cucuLakiLaki:
        return 'Cucu Laki-laki';
      case HeirType.cucuPerempuan:
        return 'Cucu Perempuan';
      case HeirType.lainnya:
        return 'Lainnya';
    }
  }

  String getLocalizedTypeDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case HeirType.suami:
        return l10n.husband;
      case HeirType.istri:
        return l10n.wife;
      case HeirType.ayah:
        return l10n.father;
      case HeirType.ibu:
        return l10n.mother;
      case HeirType.anakLakiLaki:
        return l10n.son;
      case HeirType.anakPerempuan:
        return l10n.daughter;
      case HeirType.saudaraLakiLaki:
        return l10n.brother;
      case HeirType.saudaraPerempuan:
        return l10n.sister;
      case HeirType.kakek:
        return l10n.grandfather;
      case HeirType.nenek:
        return l10n.grandmother;
      case HeirType.cucuLakiLaki:
        return l10n.grandson;
      case HeirType.cucuPerempuan:
        return l10n.granddaughter;
      case HeirType.lainnya:
        return l10n.other;
    }
  }

  @override
  List<Object?> get props => [id, name, type, gender, portion];
}

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/heir.dart';

class ValidationMessage extends StatelessWidget {
  final List<Heir> heirs;
  final List assets;

  const ValidationMessage({
    super.key,
    required this.heirs,
    required this.assets,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final validationErrors = _getValidationErrors(l10n);

    if (validationErrors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text(
                  l10n.warning,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...validationErrors.map(
              (error) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $error',
                  style: TextStyle(color: Colors.orange.shade700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getValidationErrors(AppLocalizations l10n) {
    List<String> errors = [];

    // Cek kombinasi suami dan istri
    bool hasHusband = heirs.any((h) => h.type == HeirType.suami);
    bool hasWife = heirs.any((h) => h.type == HeirType.istri);

    if (hasHusband && hasWife) {
      errors.add(l10n.cannotHaveHusbandAndWife);
    }

    // Cek apakah ada ahli waris
    if (heirs.isEmpty) {
      errors.add(l10n.addAtLeastOneHeir);
    }

    // Cek apakah ada aset
    if (assets.isEmpty) {
      errors.add(l10n.addAtLeastOneAsset);
    }

    // Cek duplikasi nama ahli waris
    final names = heirs.map((h) => h.name.toLowerCase()).toList();
    final uniqueNames = names.toSet();
    if (names.length != uniqueNames.length) {
      errors.add(l10n.duplicateHeirNames);
    }

    return errors;
  }
}

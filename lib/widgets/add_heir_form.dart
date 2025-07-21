import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/heir.dart';

class AddHeirForm extends StatefulWidget {
  final Function(Heir) onAddHeir;

  const AddHeirForm({super.key, required this.onAddHeir});

  @override
  State<AddHeirForm> createState() => _AddHeirFormState();
}

class _AddHeirFormState extends State<AddHeirForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  HeirType _selectedType = HeirType.suami;
  Gender _selectedGender = Gender.lakiLaki;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final heir = Heir.create(
        name: _nameController.text.trim(),
        type: _selectedType,
        gender: _selectedGender,
      );

      widget.onAddHeir(heir);
      _nameController.clear();
      setState(() {
        _selectedType = HeirType.suami;
        _selectedGender = Gender.lakiLaki;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.addHeir,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.heirName,
                  hintText: l10n.enterFullName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.nameCannotBeEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<HeirType>(
                value: _selectedType,
                decoration: InputDecoration(
                  labelText: l10n.heirType,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (HeirType? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                    // Auto-set gender based on heir type
                    switch (newValue) {
                      case HeirType.suami:
                      case HeirType.ayah:
                      case HeirType.anakLakiLaki:
                      case HeirType.saudaraLakiLaki:
                      case HeirType.kakek:
                      case HeirType.cucuLakiLaki:
                        _selectedGender = Gender.lakiLaki;
                        break;
                      case HeirType.istri:
                      case HeirType.ibu:
                      case HeirType.anakPerempuan:
                      case HeirType.saudaraPerempuan:
                      case HeirType.nenek:
                      case HeirType.cucuPerempuan:
                        _selectedGender = Gender.perempuan;
                        break;
                      default:
                        // Keep current gender for 'lainnya'
                        break;
                    }
                  });
                },
                items: HeirType.values.map((HeirType type) {
                  return DropdownMenuItem<HeirType>(
                    value: type,
                    child: Text(_getHeirTypeDisplayName(type, l10n)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: l10n.gender,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (Gender? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: Gender.values.map((Gender gender) {
                  return DropdownMenuItem<Gender>(
                    value: gender,
                    child: Text(
                      gender == Gender.lakiLaki ? l10n.male : l10n.female,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.person_add, size: 18),
                  label: Text(
                    l10n.addHeir,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getHeirTypeDisplayName(HeirType type, AppLocalizations l10n) {
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
}

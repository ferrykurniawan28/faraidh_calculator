import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../models/asset.dart';

class AddAssetForm extends StatefulWidget {
  final Function(Asset) onAddAsset;

  const AddAssetForm({super.key, required this.onAddAsset});

  @override
  State<AddAssetForm> createState() => _AddAssetFormState();
}

class _AddAssetFormState extends State<AddAssetForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();
  AssetType _selectedType = AssetType.rumah;

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final asset = Asset.create(
        name: _nameController.text.trim(),
        type: _selectedType,
        value: double.parse(_valueController.text.replaceAll(',', '')),
        description: _descriptionController.text.trim(),
      );

      widget.onAddAsset(asset);
      _nameController.clear();
      _valueController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedType = AssetType.rumah;
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
          l10n.addAsset,
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
                  labelText: l10n.assetName,
                  hintText: l10n.enterAssetName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.assetNameCannotBeEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<AssetType>(
                value: _selectedType,
                decoration: InputDecoration(
                  labelText: l10n.assetType,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (AssetType? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                items: AssetType.values.map((AssetType type) {
                  return DropdownMenuItem<AssetType>(
                    value: type,
                    child: Text(_getAssetTypeDisplayName(type, l10n)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _valueController,
                decoration: InputDecoration(
                  labelText: l10n.assetValue,
                  hintText: l10n.enterAssetValue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) {
                      return newValue;
                    }
                    final int value = int.parse(newValue.text);
                    final String formatted = value.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    );
                    return TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  }),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.assetValueCannotBeEmpty;
                  }
                  final numericValue = double.tryParse(
                    value.replaceAll(',', ''),
                  );
                  if (numericValue == null || numericValue <= 0) {
                    return l10n.assetValueMustBePositive;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.description,
                  hintText: l10n.addAssetDescription,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.add_circle, size: 18),
                  label: Text(
                    l10n.addAsset,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
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

  String _getAssetTypeDisplayName(AssetType type, AppLocalizations l10n) {
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
}

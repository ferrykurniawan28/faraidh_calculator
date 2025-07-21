import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/asset.dart';

class AssetsList extends StatelessWidget {
  final List<Asset> assets;
  final Function(String) onRemoveAsset;

  const AssetsList({
    super.key,
    required this.assets,
    required this.onRemoveAsset,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (assets.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.inventory_outlined,
                size: 48,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noAssetsYet,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.startByAddingFirstAsset,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    final totalValue = assets.fold(0.0, (sum, asset) => sum + asset.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.assetsList,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l10n.totalAssets(_formatCurrency(totalValue)),
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: assets.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final asset = assets[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getAssetColor(asset.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    _getAssetIcon(asset.type),
                    color: _getAssetColor(asset.type),
                    size: 24,
                  ),
                ),
                title: Text(
                  asset.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        asset.getLocalizedTypeDisplayName(context),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Rp ${_formatCurrency(asset.value)}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (asset.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        asset.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
                  onPressed: () => _showDeleteConfirmation(context, asset),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context, Asset asset) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.deleteAsset),
          content: Text(l10n.areYouSureDeleteAsset(asset.name)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () {
                onRemoveAsset(asset.id);
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.delete,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatCurrency(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  IconData _getAssetIcon(AssetType type) {
    switch (type) {
      case AssetType.rumah:
        return Icons.home;
      case AssetType.tanah:
        return Icons.terrain;
      case AssetType.mobil:
        return Icons.directions_car;
      case AssetType.uang:
        return Icons.attach_money;
      case AssetType.emas:
        return Icons.star;
      case AssetType.saham:
        return Icons.trending_up;
      case AssetType.tabungan:
        return Icons.savings;
      case AssetType.lainnya:
        return Icons.inventory;
    }
  }

  Color _getAssetColor(AssetType type) {
    switch (type) {
      case AssetType.rumah:
        return Colors.brown;
      case AssetType.tanah:
        return Colors.green;
      case AssetType.mobil:
        return Colors.blue;
      case AssetType.uang:
        return Colors.orange;
      case AssetType.emas:
        return Colors.amber;
      case AssetType.saham:
        return Colors.purple;
      case AssetType.tabungan:
        return Colors.teal;
      case AssetType.lainnya:
        return Colors.grey;
    }
  }
}

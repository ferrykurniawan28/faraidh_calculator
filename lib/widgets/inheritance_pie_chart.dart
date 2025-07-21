import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../l10n/app_localizations.dart';
import '../models/heir.dart';

class InheritancePieChart extends StatelessWidget {
  final List<Heir> heirs;
  final double totalValue;

  const InheritancePieChart({
    super.key,
    required this.heirs,
    required this.totalValue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (heirs.isEmpty || totalValue == 0) {
      return Center(
        child: Text(
          l10n.noDataToDisplay,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    final validHeirs = heirs.where((heir) => heir.portion > 0).toList();

    if (validHeirs.isEmpty) {
      return Center(
        child: Text(
          l10n.noInheritanceCalculation,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sections: _buildPieChartSections(validHeirs),
              centerSpaceRadius: 50,
              sectionsSpace: 2,
              startDegreeOffset: -90,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildLegend(validHeirs),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections(List<Heir> validHeirs) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.indigo,
      Colors.cyan,
    ];

    return validHeirs.asMap().entries.map((entry) {
      final index = entry.key;
      final heir = entry.value;
      final percentage = (heir.portion / totalValue) * 100;

      return PieChartSectionData(
        color: colors[index % colors.length],
        value: heir.portion,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildLegend(List<Heir> validHeirs) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.indigo,
      Colors.cyan,
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: validHeirs.asMap().entries.map((entry) {
        final index = entry.key;
        final heir = entry.value;
        final percentage = (heir.portion / totalValue) * 100;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${heir.name} (${percentage.toStringAsFixed(1)}%)',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }).toList(),
    );
  }
}

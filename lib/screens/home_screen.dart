import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/app_localizations.dart';
import '../bloc/inheritance_bloc.dart';
import '../bloc/inheritance_event.dart';
import '../models/inheritance_state.dart';
import '../widgets/add_heir_form.dart';
import '../widgets/add_asset_form.dart';
import '../widgets/heirs_list.dart';
import '../widgets/assets_list.dart';
import '../widgets/inheritance_pie_chart.dart';
import '../widgets/validation_message.dart';
import '../widgets/disclaimer_widget.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(context),
      body: BlocBuilder<InheritanceBloc, InheritanceState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero section
                _buildHeroSection(context, state),

                // Main content
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        // Validation messages
                        ValidationMessage(
                          heirs: state.heirs,
                          assets: state.assets,
                          showValidation: state.hasValidationError,
                        ),
                        const SizedBox(height: 24),

                        // Responsive layout
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 1000) {
                              return _buildDesktopLayout(context, state);
                            } else if (constraints.maxWidth > 600) {
                              return _buildTabletLayout(context, state);
                            } else {
                              return _buildMobileLayout(context, state);
                            }
                          },
                        ),

                        // Disclaimer (only show if calculation has been done)
                        if (state.isCalculated) ...[
                          const SizedBox(height: 24),
                          const DisclaimerWidget(),
                        ],
                      ],
                    ),
                  ),
                ),

                // Footer
                _buildFooter(),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.1),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.calculate,
              color: Colors.green.shade700,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            l10n.appTitle,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
          icon: const Icon(Icons.settings, color: Colors.grey),
          tooltip: l10n.settings,
        ),
        TextButton.icon(
          onPressed: () {
            context.read<InheritanceBloc>().add(const ResetCalculationEvent());
          },
          icon: const Icon(Icons.refresh, size: 18),
          label: Text(l10n.reset),
          style: TextButton.styleFrom(foregroundColor: Colors.grey.shade700),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context, InheritanceState state) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade50, Colors.blue.shade50],
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            children: [
              Text(
                l10n.appTitle,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.islamicInheritance,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Stats cards
              Wrap(
                spacing: 24,
                runSpacing: 16,
                children: [
                  _buildStatCard(
                    l10n.heirsList,
                    l10n.heirsCount(state.heirs.length),
                    Icons.people_outline,
                    Colors.blue,
                  ),
                  _buildStatCard(
                    l10n.totalAssets(''),
                    'Rp ${_formatCurrency(state.totalAssetValue)}',
                    Icons.account_balance_wallet_outlined,
                    Colors.green,
                  ),
                  _buildStatCard(
                    'Status',
                    state.isCalculated ? l10n.quickResults : 'Pending',
                    state.isCalculated
                        ? Icons.check_circle_outline
                        : Icons.pending_outlined,
                    state.isCalculated ? Colors.green : Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Calculate button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: state.heirs.isNotEmpty && state.assets.isNotEmpty
                      ? () {
                          context.read<InheritanceBloc>().add(
                            const CalculateInheritanceEvent(),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.calculate, size: 20),
                  label: Text(
                    l10n.calculate,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 32, color: color),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, InheritanceState state) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - Forms and Lists
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildWebCard(
                child: AddHeirForm(
                  onAddHeir: (heir) {
                    context.read<InheritanceBloc>().add(AddHeirEvent(heir));
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildWebCard(
                child: AddAssetForm(
                  onAddAsset: (asset) {
                    context.read<InheritanceBloc>().add(AddAssetEvent(asset));
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildWebCard(
                child: HeirsList(
                  heirs: state.heirs,
                  onRemoveHeir: (id) {
                    context.read<InheritanceBloc>().add(RemoveHeirEvent(id));
                  },
                  showPortion: state.isCalculated,
                ),
              ),
              const SizedBox(height: 24),
              _buildWebCard(
                child: AssetsList(
                  assets: state.assets,
                  onRemoveAsset: (id) {
                    context.read<InheritanceBloc>().add(RemoveAssetEvent(id));
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        // Right column - Chart
        Expanded(
          flex: 1,
          child: _buildWebCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.inheritanceDistribution,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 400,
                  child: InheritancePieChart(
                    heirs: state.heirs,
                    totalValue: state.totalAssetValue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, InheritanceState state) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildWebCard(
                child: AddHeirForm(
                  onAddHeir: (heir) {
                    context.read<InheritanceBloc>().add(AddHeirEvent(heir));
                  },
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildWebCard(
                child: AddAssetForm(
                  onAddAsset: (asset) {
                    context.read<InheritanceBloc>().add(AddAssetEvent(asset));
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildWebCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.inheritanceDistribution,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 300,
                child: InheritancePieChart(
                  heirs: state.heirs,
                  totalValue: state.totalAssetValue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildWebCard(
                child: HeirsList(
                  heirs: state.heirs,
                  onRemoveHeir: (id) {
                    context.read<InheritanceBloc>().add(RemoveHeirEvent(id));
                  },
                  showPortion: state.isCalculated,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildWebCard(
                child: AssetsList(
                  assets: state.assets,
                  onRemoveAsset: (id) {
                    context.read<InheritanceBloc>().add(RemoveAssetEvent(id));
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, InheritanceState state) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _buildWebCard(
          child: AddHeirForm(
            onAddHeir: (heir) {
              context.read<InheritanceBloc>().add(AddHeirEvent(heir));
            },
          ),
        ),
        const SizedBox(height: 24),
        _buildWebCard(
          child: AddAssetForm(
            onAddAsset: (asset) {
              context.read<InheritanceBloc>().add(AddAssetEvent(asset));
            },
          ),
        ),
        const SizedBox(height: 24),
        if (state.isCalculated)
          _buildWebCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.inheritanceDistribution,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 300,
                  child: InheritancePieChart(
                    heirs: state.heirs,
                    totalValue: state.totalAssetValue,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 24),
        _buildWebCard(
          child: HeirsList(
            heirs: state.heirs,
            onRemoveHeir: (id) {
              context.read<InheritanceBloc>().add(RemoveHeirEvent(id));
            },
            showPortion: state.isCalculated,
          ),
        ),
        const SizedBox(height: 24),
        _buildWebCard(
          child: AssetsList(
            assets: state.assets,
            onRemoveAsset: (id) {
              context.read<InheritanceBloc>().add(RemoveAssetEvent(id));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWebCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 48),
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(color: Colors.grey.shade800),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return Column(
                children: [
                  Text(
                    l10n.appTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.developedWith,
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.rightsReserved,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Islamic Inheritance Calculator';

  @override
  String heirsCount(int count) {
    return '$count people';
  }

  @override
  String totalAssets(String amount) {
    return 'Total: Rp $amount';
  }

  @override
  String heirPortion(String amount) {
    return 'Share: Rp $amount';
  }

  @override
  String get addHeir => 'Add Heir';

  @override
  String get addAsset => 'Add Asset';

  @override
  String get calculate => 'Calculate Inheritance';

  @override
  String get reset => 'Reset All';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get indonesian => 'Indonesian';

  @override
  String get heirName => 'Heir Name';

  @override
  String get enterFullName => 'Enter full name';

  @override
  String get heirType => 'Heir Type';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get assetName => 'Asset Name';

  @override
  String get enterAssetName => 'Enter asset name';

  @override
  String get assetType => 'Asset Type';

  @override
  String get assetValue => 'Asset Value (Rp)';

  @override
  String get enterAssetValue => 'Enter asset value';

  @override
  String get description => 'Description (Optional)';

  @override
  String get addAssetDescription => 'Add asset description';

  @override
  String get heirsList => 'List of Heirs';

  @override
  String get assetsList => 'List of Assets';

  @override
  String get noHeirsYet => 'No heirs added yet';

  @override
  String get startByAddingFirstHeir => 'Start by adding the first heir';

  @override
  String get noAssetsYet => 'No assets added yet';

  @override
  String get startByAddingFirstAsset => 'Start by adding the first asset';

  @override
  String get nameCannotBeEmpty => 'Name cannot be empty';

  @override
  String get assetNameCannotBeEmpty => 'Asset name cannot be empty';

  @override
  String get assetValueCannotBeEmpty => 'Asset value cannot be empty';

  @override
  String get assetValueMustBePositive =>
      'Asset value must be a positive number';

  @override
  String get deleteHeir => 'Delete Heir';

  @override
  String get deleteAsset => 'Delete Asset';

  @override
  String areYouSureDeleteHeir(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String areYouSureDeleteAsset(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get husband => 'Husband';

  @override
  String get wife => 'Wife';

  @override
  String get father => 'Father';

  @override
  String get mother => 'Mother';

  @override
  String get son => 'Son';

  @override
  String get daughter => 'Daughter';

  @override
  String get brother => 'Brother';

  @override
  String get sister => 'Sister';

  @override
  String get grandfather => 'Grandfather';

  @override
  String get grandmother => 'Grandmother';

  @override
  String get grandson => 'Grandson';

  @override
  String get granddaughter => 'Granddaughter';

  @override
  String get other => 'Other';

  @override
  String get house => 'House';

  @override
  String get land => 'Land';

  @override
  String get car => 'Car';

  @override
  String get money => 'Money';

  @override
  String get gold => 'Gold';

  @override
  String get stocks => 'Stocks';

  @override
  String get savings => 'Savings';

  @override
  String get islamicInheritance => 'Islamic Inheritance';

  @override
  String get accurateCalculation => 'Accurate Calculation';

  @override
  String get easyToUse => 'Easy to Use';

  @override
  String get quickResults => 'Quick Results';

  @override
  String get inheritanceDistribution => 'Inheritance Distribution';

  @override
  String get totalInheritance => 'Total Inheritance';

  @override
  String get learnMore => 'Learn More';

  @override
  String get getStarted => 'Get Started';

  @override
  String get poweredBy => 'Powered by';

  @override
  String get developedWith => 'Developed with ❤️ using Flutter';

  @override
  String get rightsReserved => 'All rights reserved.';

  @override
  String get about => 'About';

  @override
  String get privacy => 'Privacy';

  @override
  String get terms => 'Terms';

  @override
  String get contact => 'Contact';

  @override
  String get noDataToDisplay => 'No data to display';

  @override
  String get noInheritanceCalculation => 'No inheritance calculation yet';

  @override
  String get warning => 'Warning';

  @override
  String get cannotHaveHusbandAndWife =>
      'Cannot have both husband and wife in the same inheritance calculation';

  @override
  String get addAtLeastOneHeir => 'Add at least one heir';

  @override
  String get addAtLeastOneAsset => 'Add at least one asset';

  @override
  String get duplicateHeirNames => 'There are duplicate heir names';
}

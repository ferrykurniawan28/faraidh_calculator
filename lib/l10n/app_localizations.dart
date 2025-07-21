import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Islamic Inheritance Calculator'**
  String get appTitle;

  /// Number of heirs
  ///
  /// In en, this message translates to:
  /// **'{count} people'**
  String heirsCount(int count);

  /// Total assets amount
  ///
  /// In en, this message translates to:
  /// **'Total: Rp {amount}'**
  String totalAssets(String amount);

  /// Heir's inheritance portion
  ///
  /// In en, this message translates to:
  /// **'Share: Rp {amount}'**
  String heirPortion(String amount);

  /// No description provided for @addHeir.
  ///
  /// In en, this message translates to:
  /// **'Add Heir'**
  String get addHeir;

  /// No description provided for @addAsset.
  ///
  /// In en, this message translates to:
  /// **'Add Asset'**
  String get addAsset;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate Inheritance'**
  String get calculate;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get reset;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @indonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get indonesian;

  /// No description provided for @heirName.
  ///
  /// In en, this message translates to:
  /// **'Heir Name'**
  String get heirName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullName;

  /// No description provided for @heirType.
  ///
  /// In en, this message translates to:
  /// **'Heir Type'**
  String get heirType;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @assetName.
  ///
  /// In en, this message translates to:
  /// **'Asset Name'**
  String get assetName;

  /// No description provided for @enterAssetName.
  ///
  /// In en, this message translates to:
  /// **'Enter asset name'**
  String get enterAssetName;

  /// No description provided for @assetType.
  ///
  /// In en, this message translates to:
  /// **'Asset Type'**
  String get assetType;

  /// No description provided for @assetValue.
  ///
  /// In en, this message translates to:
  /// **'Asset Value (Rp)'**
  String get assetValue;

  /// No description provided for @enterAssetValue.
  ///
  /// In en, this message translates to:
  /// **'Enter asset value'**
  String get enterAssetValue;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get description;

  /// No description provided for @addAssetDescription.
  ///
  /// In en, this message translates to:
  /// **'Add asset description'**
  String get addAssetDescription;

  /// No description provided for @heirsList.
  ///
  /// In en, this message translates to:
  /// **'List of Heirs'**
  String get heirsList;

  /// No description provided for @assetsList.
  ///
  /// In en, this message translates to:
  /// **'List of Assets'**
  String get assetsList;

  /// No description provided for @noHeirsYet.
  ///
  /// In en, this message translates to:
  /// **'No heirs added yet'**
  String get noHeirsYet;

  /// No description provided for @startByAddingFirstHeir.
  ///
  /// In en, this message translates to:
  /// **'Start by adding the first heir'**
  String get startByAddingFirstHeir;

  /// No description provided for @noAssetsYet.
  ///
  /// In en, this message translates to:
  /// **'No assets added yet'**
  String get noAssetsYet;

  /// No description provided for @startByAddingFirstAsset.
  ///
  /// In en, this message translates to:
  /// **'Start by adding the first asset'**
  String get startByAddingFirstAsset;

  /// No description provided for @nameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get nameCannotBeEmpty;

  /// No description provided for @assetNameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Asset name cannot be empty'**
  String get assetNameCannotBeEmpty;

  /// No description provided for @assetValueCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Asset value cannot be empty'**
  String get assetValueCannotBeEmpty;

  /// No description provided for @assetValueMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'Asset value must be a positive number'**
  String get assetValueMustBePositive;

  /// No description provided for @deleteHeir.
  ///
  /// In en, this message translates to:
  /// **'Delete Heir'**
  String get deleteHeir;

  /// No description provided for @deleteAsset.
  ///
  /// In en, this message translates to:
  /// **'Delete Asset'**
  String get deleteAsset;

  /// Confirmation message for deleting heir
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String areYouSureDeleteHeir(String name);

  /// Confirmation message for deleting asset
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String areYouSureDeleteAsset(String name);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @husband.
  ///
  /// In en, this message translates to:
  /// **'Husband'**
  String get husband;

  /// No description provided for @wife.
  ///
  /// In en, this message translates to:
  /// **'Wife'**
  String get wife;

  /// No description provided for @father.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get father;

  /// No description provided for @mother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// No description provided for @son.
  ///
  /// In en, this message translates to:
  /// **'Son'**
  String get son;

  /// No description provided for @daughter.
  ///
  /// In en, this message translates to:
  /// **'Daughter'**
  String get daughter;

  /// No description provided for @brother.
  ///
  /// In en, this message translates to:
  /// **'Brother'**
  String get brother;

  /// No description provided for @sister.
  ///
  /// In en, this message translates to:
  /// **'Sister'**
  String get sister;

  /// No description provided for @grandfather.
  ///
  /// In en, this message translates to:
  /// **'Grandfather'**
  String get grandfather;

  /// No description provided for @grandmother.
  ///
  /// In en, this message translates to:
  /// **'Grandmother'**
  String get grandmother;

  /// No description provided for @grandson.
  ///
  /// In en, this message translates to:
  /// **'Grandson'**
  String get grandson;

  /// No description provided for @granddaughter.
  ///
  /// In en, this message translates to:
  /// **'Granddaughter'**
  String get granddaughter;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get house;

  /// No description provided for @land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get land;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @money.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get money;

  /// No description provided for @gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get gold;

  /// No description provided for @stocks.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get stocks;

  /// No description provided for @savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// No description provided for @islamicInheritance.
  ///
  /// In en, this message translates to:
  /// **'Islamic Inheritance'**
  String get islamicInheritance;

  /// No description provided for @accurateCalculation.
  ///
  /// In en, this message translates to:
  /// **'Accurate Calculation'**
  String get accurateCalculation;

  /// No description provided for @easyToUse.
  ///
  /// In en, this message translates to:
  /// **'Easy to Use'**
  String get easyToUse;

  /// No description provided for @quickResults.
  ///
  /// In en, this message translates to:
  /// **'Quick Results'**
  String get quickResults;

  /// No description provided for @inheritanceDistribution.
  ///
  /// In en, this message translates to:
  /// **'Inheritance Distribution'**
  String get inheritanceDistribution;

  /// No description provided for @totalInheritance.
  ///
  /// In en, this message translates to:
  /// **'Total Inheritance'**
  String get totalInheritance;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by'**
  String get poweredBy;

  /// No description provided for @developedWith.
  ///
  /// In en, this message translates to:
  /// **'Developed with ❤️ using Flutter'**
  String get developedWith;

  /// No description provided for @rightsReserved.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get rightsReserved;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @noDataToDisplay.
  ///
  /// In en, this message translates to:
  /// **'No data to display'**
  String get noDataToDisplay;

  /// No description provided for @noInheritanceCalculation.
  ///
  /// In en, this message translates to:
  /// **'No inheritance calculation yet'**
  String get noInheritanceCalculation;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @cannotHaveHusbandAndWife.
  ///
  /// In en, this message translates to:
  /// **'Cannot have both husband and wife in the same inheritance calculation'**
  String get cannotHaveHusbandAndWife;

  /// No description provided for @addAtLeastOneHeir.
  ///
  /// In en, this message translates to:
  /// **'Add at least one heir'**
  String get addAtLeastOneHeir;

  /// No description provided for @addAtLeastOneAsset.
  ///
  /// In en, this message translates to:
  /// **'Add at least one asset'**
  String get addAtLeastOneAsset;

  /// No description provided for @duplicateHeirNames.
  ///
  /// In en, this message translates to:
  /// **'There are duplicate heir names'**
  String get duplicateHeirNames;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer;

  /// No description provided for @inheritanceDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This calculator provides basic inheritance calculations according to Islamic law. For complex cases or official legal matters, please consult qualified Islamic scholars or legal experts.'**
  String get inheritanceDisclaimer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

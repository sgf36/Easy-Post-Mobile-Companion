import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('ar'),
    Locale('cs'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sv'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// Product name. A brand, so it is identical in every language.
  ///
  /// In en, this message translates to:
  /// **'Easy-Post Mobile Companion'**
  String get appTitle;

  /// Sidebar section: the list of tracked shipments.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get navTracking;

  /// Sidebar section: past shipments.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get navInsurance;

  /// No description provided for @navClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get navClaims;

  /// No description provided for @navPickups.
  ///
  /// In en, this message translates to:
  /// **'Pickups'**
  String get navPickups;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// Harmonized Tariff Schedule lookup. HTS stays as the acronym.
  ///
  /// In en, this message translates to:
  /// **'HTS Lookup'**
  String get navHts;

  /// No description provided for @navSectionManage.
  ///
  /// In en, this message translates to:
  /// **'Track & manage'**
  String get navSectionManage;

  /// No description provided for @navSectionTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get navSectionTools;

  /// No description provided for @drawerUnpair.
  ///
  /// In en, this message translates to:
  /// **'Unpair this device'**
  String get drawerUnpair;

  /// EasyPost tracker status. Statuses are prose and translate; carrier names never do.
  ///
  /// In en, this message translates to:
  /// **'Pre-transit'**
  String get statusPreTransit;

  /// No description provided for @statusInTransit.
  ///
  /// In en, this message translates to:
  /// **'In transit'**
  String get statusInTransit;

  /// No description provided for @statusOutForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get statusOutForDelivery;

  /// No description provided for @statusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get statusDelivered;

  /// No description provided for @statusAvailableForPickup.
  ///
  /// In en, this message translates to:
  /// **'Available for pickup'**
  String get statusAvailableForPickup;

  /// No description provided for @statusReturnToSender.
  ///
  /// In en, this message translates to:
  /// **'Return to sender'**
  String get statusReturnToSender;

  /// No description provided for @statusFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get statusFailure;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @statusError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get statusError;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @carrierUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown carrier'**
  String get carrierUnknown;

  /// No description provided for @carrierUnknownShort.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get carrierUnknownShort;

  /// No description provided for @sortTooltip.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortTooltip;

  /// No description provided for @sortByStatus.
  ///
  /// In en, this message translates to:
  /// **'Sort by status'**
  String get sortByStatus;

  /// No description provided for @sortByCarrier.
  ///
  /// In en, this message translates to:
  /// **'Sort by carrier'**
  String get sortByCarrier;

  /// No description provided for @sortByCode.
  ///
  /// In en, this message translates to:
  /// **'Sort by tracking code'**
  String get sortByCode;

  /// No description provided for @sortByUpdated.
  ///
  /// In en, this message translates to:
  /// **'Sort by recently updated'**
  String get sortByUpdated;

  /// No description provided for @filterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterTooltip;

  /// No description provided for @filterHideDelivered.
  ///
  /// In en, this message translates to:
  /// **'Hide delivered'**
  String get filterHideDelivered;

  /// No description provided for @filterStatusHeading.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get filterStatusHeading;

  /// No description provided for @filterCarrierHeading.
  ///
  /// In en, this message translates to:
  /// **'Carrier'**
  String get filterCarrierHeading;

  /// No description provided for @filterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get filterReset;

  /// No description provided for @trackersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No shipments are being tracked yet.'**
  String get trackersEmpty;

  /// Count line above a filtered tracker list.
  ///
  /// In en, this message translates to:
  /// **'Showing {shown} of {total}'**
  String trackersShowing(int shown, int total);

  /// No description provided for @trackersNoMatch.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches the current filters.'**
  String get trackersNoMatch;

  /// Estimated delivery date on a tracker row, abbreviated to fit.
  ///
  /// In en, this message translates to:
  /// **'ETA {date}'**
  String etaLabel(String date);

  /// No description provided for @detailEstimatedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery {date}'**
  String detailEstimatedDelivery(String date);

  /// No description provided for @detailSignedBy.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name}'**
  String detailSignedBy(String name);

  /// Heading above the scan events of one shipment.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get detailHistoryHeading;

  /// No description provided for @detailNoScanHistory.
  ///
  /// In en, this message translates to:
  /// **'No scan history yet.'**
  String get detailNoScanHistory;

  /// No description provided for @detailMapUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Map unavailable for these locations.'**
  String get detailMapUnavailable;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No shipments yet.'**
  String get historyEmpty;

  /// No description provided for @insuranceEmpty.
  ///
  /// In en, this message translates to:
  /// **'No insurance policies yet.'**
  String get insuranceEmpty;

  /// No description provided for @insuranceBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy insurance'**
  String get insuranceBuy;

  /// EasyPost caps declared insurance at 5,000 US dollars and always reads the amount as USD, so the currency is not localised.
  ///
  /// In en, this message translates to:
  /// **'Insured amount must be between \$0.01 and \$5,000 USD.'**
  String get insuranceAmountRange;

  /// No description provided for @insuranceNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'This EasyPost account is not enabled for standalone insurance. Ask EasyPost support to enable it, or add insurance when buying the label instead.'**
  String get insuranceNotEnabled;

  /// No description provided for @insuranceFromAddress.
  ///
  /// In en, this message translates to:
  /// **'From address'**
  String get insuranceFromAddress;

  /// No description provided for @insuranceToAddress.
  ///
  /// In en, this message translates to:
  /// **'To address'**
  String get insuranceToAddress;

  /// No description provided for @fieldTrackingCode.
  ///
  /// In en, this message translates to:
  /// **'Tracking code'**
  String get fieldTrackingCode;

  /// USPS is a carrier name and stays in English.
  ///
  /// In en, this message translates to:
  /// **'Carrier (e.g. USPS)'**
  String get fieldCarrierHint;

  /// No description provided for @fieldInsuredAmount.
  ///
  /// In en, this message translates to:
  /// **'Insured amount (USD)'**
  String get fieldInsuredAmount;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldStreet.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get fieldStreet;

  /// No description provided for @fieldCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get fieldCity;

  /// No description provided for @fieldStateRegion.
  ///
  /// In en, this message translates to:
  /// **'State / region'**
  String get fieldStateRegion;

  /// No description provided for @fieldPostcode.
  ///
  /// In en, this message translates to:
  /// **'Postcode'**
  String get fieldPostcode;

  /// No description provided for @fieldCountryIso.
  ///
  /// In en, this message translates to:
  /// **'Country (ISO, e.g. US)'**
  String get fieldCountryIso;

  /// No description provided for @fieldType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get fieldType;

  /// No description provided for @fieldAmountUsd.
  ///
  /// In en, this message translates to:
  /// **'Amount (USD)'**
  String get fieldAmountUsd;

  /// No description provided for @fieldContactEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact email'**
  String get fieldContactEmail;

  /// No description provided for @fieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get fieldDescription;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get validationRequired;

  /// No description provided for @validationEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount'**
  String get validationEnterAmount;

  /// No description provided for @validationEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter an email'**
  String get validationEnterEmail;

  /// No description provided for @validationDescribeIssue.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue'**
  String get validationDescribeIssue;

  /// No description provided for @claimsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No claims filed yet.'**
  String get claimsEmpty;

  /// No description provided for @claimsFile.
  ///
  /// In en, this message translates to:
  /// **'File a claim'**
  String get claimsFile;

  /// No description provided for @claimSubmit.
  ///
  /// In en, this message translates to:
  /// **'File claim'**
  String get claimSubmit;

  /// No description provided for @claimTypeDamage.
  ///
  /// In en, this message translates to:
  /// **'Damage'**
  String get claimTypeDamage;

  /// No description provided for @claimTypeTheft.
  ///
  /// In en, this message translates to:
  /// **'Theft'**
  String get claimTypeTheft;

  /// No description provided for @claimTypeLoss.
  ///
  /// In en, this message translates to:
  /// **'Loss'**
  String get claimTypeLoss;

  /// No description provided for @claimAttachmentNote.
  ///
  /// In en, this message translates to:
  /// **'Damage and theft claims need a supporting photo or invoice. File those on the desktop app, where documents can be attached.'**
  String get claimAttachmentNote;

  /// No description provided for @claimAttachmentSnack.
  ///
  /// In en, this message translates to:
  /// **'Damage and theft claims need a supporting photo or invoice, which has to be attached on the desktop app. A loss claim can be filed here.'**
  String get claimAttachmentSnack;

  /// No description provided for @pickupsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No pickups scheduled yet.'**
  String get pickupsEmpty;

  /// No description provided for @pickupCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel pickup?'**
  String get pickupCancelTitle;

  /// No description provided for @pickupCancelBody.
  ///
  /// In en, this message translates to:
  /// **'Cancel pickup {id}? This cannot be undone.'**
  String pickupCancelBody(String id);

  /// No description provided for @pickupKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get pickupKeep;

  /// No description provided for @pickupCancelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel pickup'**
  String get pickupCancelConfirm;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @reportsShipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get reportsShipments;

  /// No description provided for @reportsTotalSpend.
  ///
  /// In en, this message translates to:
  /// **'Total spend'**
  String get reportsTotalSpend;

  /// No description provided for @reportsByCarrier.
  ///
  /// In en, this message translates to:
  /// **'By carrier'**
  String get reportsByCarrier;

  /// No description provided for @reportsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No purchased shipments to report yet.'**
  String get reportsEmpty;

  /// Subtitle under a carrier in the Reports breakdown. Written as a label and a number rather than a counted noun, so no locale needs a plural rule for it.
  ///
  /// In en, this message translates to:
  /// **'Shipments: {count}'**
  String reportsCarrierShipments(int count);

  /// No description provided for @htsSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search tariff codes'**
  String get htsSearchLabel;

  /// No description provided for @htsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. copper wire'**
  String get htsSearchHint;

  /// No description provided for @htsSearchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get htsSearchButton;

  /// No description provided for @htsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Reference lookup from the U.S. International Trade Commission. Correct classification remains the shipper’s responsibility.'**
  String get htsDisclaimer;

  /// No description provided for @htsPrompt.
  ///
  /// In en, this message translates to:
  /// **'Search for a tariff code above.'**
  String get htsPrompt;

  /// No description provided for @htsNoResults.
  ///
  /// In en, this message translates to:
  /// **'No matching tariff codes.'**
  String get htsNoResults;

  /// No description provided for @htsRateGeneral.
  ///
  /// In en, this message translates to:
  /// **'General {rate}'**
  String htsRateGeneral(String rate);

  /// No description provided for @htsRateSpecial.
  ///
  /// In en, this message translates to:
  /// **'Special {rate}'**
  String htsRateSpecial(String rate);

  /// No description provided for @htsRateOther.
  ///
  /// In en, this message translates to:
  /// **'Other {rate}'**
  String htsRateOther(String rate);

  /// No description provided for @htsCopyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get htsCopyTooltip;

  /// No description provided for @htsCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied {code}'**
  String htsCopied(String code);

  /// No description provided for @htsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The tariff service is unavailable (error {code}). Please try again.'**
  String htsUnavailable(int code);

  /// No description provided for @pairTitle.
  ///
  /// In en, this message translates to:
  /// **'Pair with desktop'**
  String get pairTitle;

  /// No description provided for @pairInstructions.
  ///
  /// In en, this message translates to:
  /// **'Open Easy-Post Desktop, choose “Pair mobile app”, and scan the QR code shown there.'**
  String get pairInstructions;

  /// No description provided for @pairEnterReviewCode.
  ///
  /// In en, this message translates to:
  /// **'Enter review code instead'**
  String get pairEnterReviewCode;

  /// No description provided for @pairReviewDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter review code'**
  String get pairReviewDialogTitle;

  /// No description provided for @pairReviewCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Review code'**
  String get pairReviewCodeHint;

  /// No description provided for @pairAction.
  ///
  /// In en, this message translates to:
  /// **'Pair'**
  String get pairAction;

  /// No description provided for @errorPairingCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'That pairing code is invalid or has expired. Generate a fresh one on the desktop.'**
  String get errorPairingCodeInvalid;

  /// No description provided for @errorReviewCodeRejected.
  ///
  /// In en, this message translates to:
  /// **'That review code was not accepted.'**
  String get errorReviewCodeRejected;

  /// No description provided for @errorUnexpectedPairingResponse.
  ///
  /// In en, this message translates to:
  /// **'Unexpected response from the pairing service.'**
  String get errorUnexpectedPairingResponse;

  /// No description provided for @errorNotPaired.
  ///
  /// In en, this message translates to:
  /// **'This device is no longer paired. Pair again from the desktop.'**
  String get errorNotPaired;

  /// No description provided for @errorNotPairedShort.
  ///
  /// In en, this message translates to:
  /// **'This device is no longer paired.'**
  String get errorNotPairedShort;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'That action is not permitted from the app.'**
  String get errorForbidden;

  /// No description provided for @errorRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request failed (error {code}).'**
  String errorRequestFailed(int code);

  /// Title of the shipment detail page, opened from History.
  ///
  /// In en, this message translates to:
  /// **'Shipment'**
  String get detailShipment;

  /// Title of the insurance policy detail page.
  ///
  /// In en, this message translates to:
  /// **'Insurance policy'**
  String get detailInsurancePolicy;

  /// Title of the claim detail page.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get detailClaim;

  /// Title of the scheduled pickup detail page.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get detailPickup;

  /// Field label: the carrier brand, e.g. USPS. The value is never translated.
  ///
  /// In en, this message translates to:
  /// **'Carrier'**
  String get fieldCarrier;

  /// Field label: the carrier's service level.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get fieldService;

  /// Field label: the status of a shipment, claim or pickup.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get fieldStatus;

  /// Field label: when the record was created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get fieldCreated;

  /// Field label: an insured or claimed amount of money.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get fieldAmount;

  /// Field label: the insurance provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get fieldProvider;

  /// Field label: the user's own reference for a pickup.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get fieldReference;

  /// Field label: the time window a carrier will collect within.
  ///
  /// In en, this message translates to:
  /// **'Pickup window'**
  String get fieldPickupWindow;

  /// Field label: what a shipment cost to buy.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get fieldCost;

  /// Shown when a record carries no fields worth listing.
  ///
  /// In en, this message translates to:
  /// **'No further details.'**
  String get detailNothingFurther;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'cs',
    'de',
    'el',
    'en',
    'es',
    'fr',
    'he',
    'hi',
    'hr',
    'hu',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'sv',
    'th',
    'tr',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'cs':
      return AppLocalizationsCs();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sv':
      return AppLocalizationsSv();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

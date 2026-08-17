// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Tracking';

  @override
  String get navHistory => 'History';

  @override
  String get navInsurance => 'Insurance';

  @override
  String get navClaims => 'Claims';

  @override
  String get navPickups => 'Pickups';

  @override
  String get navReports => 'Reports';

  @override
  String get navHts => 'HTS Lookup';

  @override
  String get navSectionManage => 'Track & manage';

  @override
  String get navSectionTools => 'Tools';

  @override
  String get drawerUnpair => 'Unpair this device';

  @override
  String get statusPreTransit => 'Pre-transit';

  @override
  String get statusInTransit => 'In transit';

  @override
  String get statusOutForDelivery => 'Out for delivery';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get statusAvailableForPickup => 'Available for pickup';

  @override
  String get statusReturnToSender => 'Return to sender';

  @override
  String get statusFailure => 'Failed';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusError => 'Error';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get carrierUnknown => 'Unknown carrier';

  @override
  String get carrierUnknownShort => 'Unknown';

  @override
  String get sortTooltip => 'Sort';

  @override
  String get sortByStatus => 'Sort by status';

  @override
  String get sortByCarrier => 'Sort by carrier';

  @override
  String get sortByCode => 'Sort by tracking code';

  @override
  String get sortByUpdated => 'Sort by recently updated';

  @override
  String get filterTooltip => 'Filter';

  @override
  String get filterHideDelivered => 'Hide delivered';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Carrier';

  @override
  String get filterReset => 'Reset filters';

  @override
  String get trackersEmpty => 'No shipments are being tracked yet.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Showing $shown of $total';
  }

  @override
  String get trackersNoMatch => 'Nothing matches the current filters.';

  @override
  String etaLabel(String date) {
    return 'ETA $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Estimated delivery $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Signed by $name';
  }

  @override
  String get detailHistoryHeading => 'History';

  @override
  String get detailNoScanHistory => 'No scan history yet.';

  @override
  String get detailMapUnavailable => 'Map unavailable for these locations.';

  @override
  String get historyEmpty => 'No shipments yet.';

  @override
  String get insuranceEmpty => 'No insurance policies yet.';

  @override
  String get insuranceBuy => 'Buy insurance';

  @override
  String get insuranceAmountRange =>
      'Insured amount must be between \$0.01 and \$5,000 USD.';

  @override
  String get insuranceNotEnabled =>
      'This EasyPost account is not enabled for standalone insurance. Ask EasyPost support to enable it, or add insurance when buying the label instead.';

  @override
  String get insuranceFromAddress => 'From address';

  @override
  String get insuranceToAddress => 'To address';

  @override
  String get fieldTrackingCode => 'Tracking code';

  @override
  String get fieldCarrierHint => 'Carrier (e.g. USPS)';

  @override
  String get fieldInsuredAmount => 'Insured amount (USD)';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldStreet => 'Street';

  @override
  String get fieldCity => 'City';

  @override
  String get fieldStateRegion => 'State / region';

  @override
  String get fieldPostcode => 'Postcode';

  @override
  String get fieldCountryIso => 'Country (ISO, e.g. US)';

  @override
  String get fieldType => 'Type';

  @override
  String get fieldAmountUsd => 'Amount (USD)';

  @override
  String get fieldContactEmail => 'Contact email';

  @override
  String get fieldDescription => 'Description';

  @override
  String get validationRequired => 'Required';

  @override
  String get validationEnterAmount => 'Enter an amount';

  @override
  String get validationEnterEmail => 'Enter an email';

  @override
  String get validationDescribeIssue => 'Describe the issue';

  @override
  String get claimsEmpty => 'No claims filed yet.';

  @override
  String get claimsFile => 'File a claim';

  @override
  String get claimSubmit => 'File claim';

  @override
  String get claimTypeDamage => 'Damage';

  @override
  String get claimTypeTheft => 'Theft';

  @override
  String get claimTypeLoss => 'Loss';

  @override
  String get claimAttachmentNote =>
      'Damage and theft claims need a supporting photo or invoice. File those on the desktop app, where documents can be attached.';

  @override
  String get claimAttachmentSnack =>
      'Damage and theft claims need a supporting photo or invoice, which has to be attached on the desktop app. A loss claim can be filed here.';

  @override
  String get pickupsEmpty => 'No pickups scheduled yet.';

  @override
  String get pickupCancelTitle => 'Cancel pickup?';

  @override
  String pickupCancelBody(String id) {
    return 'Cancel pickup $id? This cannot be undone.';
  }

  @override
  String get pickupKeep => 'Keep';

  @override
  String get pickupCancelConfirm => 'Cancel pickup';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get reportsShipments => 'Shipments';

  @override
  String get reportsTotalSpend => 'Total spend';

  @override
  String get reportsByCarrier => 'By carrier';

  @override
  String get reportsEmpty => 'No purchased shipments to report yet.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Shipments: $count';
  }

  @override
  String get htsSearchLabel => 'Search tariff codes';

  @override
  String get htsSearchHint => 'e.g. copper wire';

  @override
  String get htsSearchButton => 'Search';

  @override
  String get htsDisclaimer =>
      'Reference lookup from the U.S. International Trade Commission. Correct classification remains the shipper’s responsibility.';

  @override
  String get htsPrompt => 'Search for a tariff code above.';

  @override
  String get htsNoResults => 'No matching tariff codes.';

  @override
  String htsRateGeneral(String rate) {
    return 'General $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Special $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Other $rate';
  }

  @override
  String get htsCopyTooltip => 'Copy code';

  @override
  String htsCopied(String code) {
    return 'Copied $code';
  }

  @override
  String htsUnavailable(int code) {
    return 'The tariff service is unavailable (error $code). Please try again.';
  }

  @override
  String get pairTitle => 'Pair with desktop';

  @override
  String get pairInstructions =>
      'Open Easy-Post Desktop, choose “Pair mobile app”, and scan the QR code shown there.';

  @override
  String get pairEnterReviewCode => 'Enter review code instead';

  @override
  String get pairReviewDialogTitle => 'Enter review code';

  @override
  String get pairReviewCodeHint => 'Review code';

  @override
  String get pairAction => 'Pair';

  @override
  String get errorPairingCodeInvalid =>
      'That pairing code is invalid or has expired. Generate a fresh one on the desktop.';

  @override
  String get errorReviewCodeRejected => 'That review code was not accepted.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Unexpected response from the pairing service.';

  @override
  String get errorNotPaired =>
      'This device is no longer paired. Pair again from the desktop.';

  @override
  String get errorNotPairedShort => 'This device is no longer paired.';

  @override
  String get errorForbidden => 'That action is not permitted from the app.';

  @override
  String errorRequestFailed(int code) {
    return 'Request failed (error $code).';
  }

  @override
  String get detailShipment => 'Shipment';

  @override
  String get detailInsurancePolicy => 'Insurance policy';

  @override
  String get detailClaim => 'Claim';

  @override
  String get detailPickup => 'Pickup';

  @override
  String get fieldCarrier => 'Carrier';

  @override
  String get fieldService => 'Service';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldCreated => 'Created';

  @override
  String get fieldAmount => 'Amount';

  @override
  String get fieldProvider => 'Provider';

  @override
  String get fieldReference => 'Reference';

  @override
  String get fieldPickupWindow => 'Pickup window';

  @override
  String get fieldCost => 'Cost';

  @override
  String get detailNothingFurther => 'No further details.';
}

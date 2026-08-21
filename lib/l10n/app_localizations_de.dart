// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Sendungsverfolgung';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navInsurance => 'Versicherung';

  @override
  String get navClaims => 'Schadensfälle';

  @override
  String get navPickups => 'Abholungen';

  @override
  String get navReports => 'Berichte';

  @override
  String get navHts => 'HTS-Suche';

  @override
  String get navSectionManage => 'Verfolgen & verwalten';

  @override
  String get navSectionTools => 'Werkzeuge';

  @override
  String get drawerUnpair => 'Kopplung dieses Geräts aufheben';

  @override
  String get statusPreTransit => 'Vor dem Transport';

  @override
  String get statusInTransit => 'Unterwegs';

  @override
  String get statusOutForDelivery => 'In Zustellung';

  @override
  String get statusDelivered => 'Zugestellt';

  @override
  String get statusAvailableForPickup => 'Zur Abholung bereit';

  @override
  String get statusReturnToSender => 'Rücksendung an Absender';

  @override
  String get statusFailure => 'Fehlgeschlagen';

  @override
  String get statusCancelled => 'Storniert';

  @override
  String get statusError => 'Fehler';

  @override
  String get statusUnknown => 'Unbekannt';

  @override
  String get carrierUnknown => 'Unbekannter Versanddienstleister';

  @override
  String get carrierUnknownShort => 'Unbekannt';

  @override
  String get sortTooltip => 'Sortieren';

  @override
  String get sortByStatus => 'Nach Status sortieren';

  @override
  String get sortByCarrier => 'Nach Versanddienstleister sortieren';

  @override
  String get sortByCode => 'Nach Sendungsnummer sortieren';

  @override
  String get sortByUpdated => 'Nach Aktualisierung sortieren';

  @override
  String get filterTooltip => 'Filtern';

  @override
  String get filterHideDelivered => 'Zugestellte ausblenden';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Versanddienstleister';

  @override
  String get filterReset => 'Filter zurücksetzen';

  @override
  String get trackersEmpty => 'Es werden noch keine Sendungen verfolgt.';

  @override
  String trackersShowing(int shown, int total) {
    return '$shown von $total angezeigt';
  }

  @override
  String get trackersNoMatch => 'Nichts entspricht den aktuellen Filtern.';

  @override
  String etaLabel(String date) {
    return 'Vsl. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Voraussichtliche Zustellung $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Unterschrieben von $name';
  }

  @override
  String get detailHistoryHeading => 'Verlauf';

  @override
  String get detailNoScanHistory => 'Noch keine Scan-Ereignisse.';

  @override
  String get detailMapUnavailable =>
      'Für diese Orte ist keine Karte verfügbar.';

  @override
  String get historyEmpty => 'Noch keine Sendungen.';

  @override
  String get insuranceEmpty => 'Noch keine Versicherungen.';

  @override
  String get insuranceBuy => 'Versicherung abschließen';

  @override
  String get insuranceAmountRange =>
      'Der Versicherungswert muss zwischen 0,01 und 5.000 USD liegen.';

  @override
  String get insuranceNotEnabled =>
      'Dieses EasyPost-Konto ist nicht für eigenständige Versicherungen freigeschaltet. Bitten Sie den EasyPost-Support um die Freischaltung oder fügen Sie die Versicherung stattdessen beim Kauf des Etiketts hinzu.';

  @override
  String get insuranceFromAddress => 'Absenderadresse';

  @override
  String get insuranceToAddress => 'Empfängeradresse';

  @override
  String get fieldTrackingCode => 'Sendungsnummer';

  @override
  String get fieldCarrierHint => 'Versanddienstleister (z. B. USPS)';

  @override
  String get fieldInsuredAmount => 'Versicherungswert (USD)';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldStreet => 'Straße';

  @override
  String get fieldCity => 'Stadt';

  @override
  String get fieldStateRegion => 'Bundesland / Region';

  @override
  String get fieldPostcode => 'Postleitzahl';

  @override
  String get fieldCountryIso => 'Land (ISO, z. B. US)';

  @override
  String get fieldType => 'Art';

  @override
  String get fieldAmountUsd => 'Betrag (USD)';

  @override
  String get fieldContactEmail => 'Kontakt-E-Mail';

  @override
  String get fieldDescription => 'Beschreibung';

  @override
  String get validationRequired => 'Erforderlich';

  @override
  String get validationEnterAmount => 'Betrag eingeben';

  @override
  String get validationEnterEmail => 'E-Mail-Adresse eingeben';

  @override
  String get validationDescribeIssue => 'Beschreiben Sie das Problem';

  @override
  String get claimsEmpty => 'Noch keine Schadensfälle.';

  @override
  String get claimsFile => 'Schadensfall melden';

  @override
  String get claimSubmit => 'Schadensfall einreichen';

  @override
  String get claimTypeDamage => 'Beschädigung';

  @override
  String get claimTypeTheft => 'Diebstahl';

  @override
  String get claimTypeLoss => 'Verlust';

  @override
  String get claimAttachmentNote =>
      'Bei Beschädigung und Diebstahl ist ein Foto oder eine Rechnung als Nachweis erforderlich. Melden Sie diese Fälle in der Desktop-App, wo Dokumente angehängt werden können.';

  @override
  String get claimAttachmentSnack =>
      'Bei Beschädigung und Diebstahl ist ein Nachweis erforderlich, der nur in der Desktop-App angehängt werden kann. Ein Verlustfall kann hier gemeldet werden.';

  @override
  String get pickupsEmpty => 'Noch keine Abholungen geplant.';

  @override
  String get pickupCancelTitle => 'Abholung stornieren?';

  @override
  String pickupCancelBody(String id) {
    return 'Abholung $id stornieren? Das kann nicht rückgängig gemacht werden.';
  }

  @override
  String get pickupKeep => 'Behalten';

  @override
  String get pickupCancelConfirm => 'Abholung stornieren';

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get reportsShipments => 'Sendungen';

  @override
  String get reportsTotalSpend => 'Gesamtausgaben';

  @override
  String get reportsByCarrier => 'Nach Versanddienstleister';

  @override
  String get reportsEmpty =>
      'Noch keine gekauften Sendungen für einen Bericht.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Sendungen: $count';
  }

  @override
  String get htsSearchLabel => 'Zolltarifnummern suchen';

  @override
  String get htsSearchHint => 'z. B. Kupferdraht';

  @override
  String get htsSearchButton => 'Suchen';

  @override
  String get htsDisclaimer =>
      'Referenzsuche der U.S. International Trade Commission. Die richtige Einreihung bleibt Sache des Versenders.';

  @override
  String get htsPrompt => 'Suchen Sie oben nach einer Zolltarifnummer.';

  @override
  String get htsNoResults => 'Keine passenden Zolltarifnummern.';

  @override
  String htsRateGeneral(String rate) {
    return 'Allgemein $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Sondersatz $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Andere $rate';
  }

  @override
  String get htsCopyTooltip => 'Code kopieren';

  @override
  String htsCopied(String code) {
    return '$code kopiert';
  }

  @override
  String htsUnavailable(int code) {
    return 'Der Zolltarifdienst ist nicht verfügbar (Fehler $code). Bitte erneut versuchen.';
  }

  @override
  String get pairTitle => 'Mit Desktop koppeln';

  @override
  String get pairInstructions =>
      'Öffnen Sie Easy-Post Desktop, wählen Sie „Mobile App koppeln“ und scannen Sie den dort angezeigten QR-Code.';

  @override
  String get pairEnterReviewCode => 'Stattdessen Prüfcode eingeben';

  @override
  String get pairReviewDialogTitle => 'Prüfcode eingeben';

  @override
  String get pairReviewCodeHint => 'Prüfcode';

  @override
  String get pairAction => 'Koppeln';

  @override
  String get errorPairingCodeInvalid =>
      'Dieser Kopplungscode ist ungültig oder abgelaufen. Erzeugen Sie auf dem Desktop einen neuen.';

  @override
  String get errorReviewCodeRejected =>
      'Dieser Prüfcode wurde nicht akzeptiert.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Unerwartete Antwort des Kopplungsdienstes.';

  @override
  String get errorNotPaired =>
      'Dieses Gerät ist nicht mehr gekoppelt. Koppeln Sie es erneut vom Desktop aus.';

  @override
  String get errorNotPairedShort => 'Dieses Gerät ist nicht mehr gekoppelt.';

  @override
  String get errorForbidden => 'Diese Aktion ist aus der App nicht zulässig.';

  @override
  String errorRequestFailed(int code) {
    return 'Anfrage fehlgeschlagen (Fehler $code).';
  }

  @override
  String get detailShipment => 'Sendung';

  @override
  String get detailInsurancePolicy => 'Versicherungspolice';

  @override
  String get detailClaim => 'Schadensfall';

  @override
  String get detailPickup => 'Abholung';

  @override
  String get fieldCarrier => 'Versanddienstleister';

  @override
  String get fieldService => 'Service';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldCreated => 'Erstellt';

  @override
  String get fieldAmount => 'Betrag';

  @override
  String get fieldProvider => 'Anbieter';

  @override
  String get fieldReference => 'Referenz';

  @override
  String get fieldPickupWindow => 'Abholzeitraum';

  @override
  String get fieldCost => 'Kosten';

  @override
  String get detailNothingFurther => 'Keine weiteren Angaben.';

  @override
  String get navRefunds => 'Erstattungen';

  @override
  String get refundsEmpty => 'Es wurden noch keine Erstattungen beantragt.';

  @override
  String get detailRefund => 'Erstattungsantrag';

  @override
  String get fieldRefundStatus => 'Erstattung';

  @override
  String get refundStatusSubmitted => 'Eingereicht';

  @override
  String get refundStatusRefunded => 'Erstattet';

  @override
  String get refundStatusRejected => 'Abgelehnt';
}

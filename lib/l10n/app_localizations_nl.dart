// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Tracking';

  @override
  String get navHistory => 'Geschiedenis';

  @override
  String get navInsurance => 'Verzekering';

  @override
  String get navClaims => 'Claims';

  @override
  String get navPickups => 'Ophalingen';

  @override
  String get navReports => 'Rapporten';

  @override
  String get navHts => 'HTS-opzoeken';

  @override
  String get navSectionManage => 'Volgen en beheren';

  @override
  String get navSectionTools => 'Hulpmiddelen';

  @override
  String get drawerUnpair => 'Dit apparaat ontkoppelen';

  @override
  String get statusPreTransit => 'Vóór transport';

  @override
  String get statusInTransit => 'Onderweg';

  @override
  String get statusOutForDelivery => 'Wordt bezorgd';

  @override
  String get statusDelivered => 'Bezorgd';

  @override
  String get statusAvailableForPickup => 'Klaar om af te halen';

  @override
  String get statusReturnToSender => 'Retour afzender';

  @override
  String get statusFailure => 'Mislukt';

  @override
  String get statusCancelled => 'Geannuleerd';

  @override
  String get statusError => 'Fout';

  @override
  String get statusUnknown => 'Onbekend';

  @override
  String get carrierUnknown => 'Onbekende vervoerder';

  @override
  String get carrierUnknownShort => 'Onbekend';

  @override
  String get sortTooltip => 'Sorteren';

  @override
  String get sortByStatus => 'Sorteren op status';

  @override
  String get sortByCarrier => 'Sorteren op vervoerder';

  @override
  String get sortByCode => 'Sorteren op trackingcode';

  @override
  String get sortByUpdated => 'Sorteren op recent bijgewerkt';

  @override
  String get filterTooltip => 'Filteren';

  @override
  String get filterHideDelivered => 'Bezorgde verbergen';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Vervoerder';

  @override
  String get filterReset => 'Filters wissen';

  @override
  String get trackersEmpty => 'Er worden nog geen zendingen gevolgd.';

  @override
  String trackersShowing(int shown, int total) {
    return '$shown van $total weergegeven';
  }

  @override
  String get trackersNoMatch => 'Niets komt overeen met de huidige filters.';

  @override
  String etaLabel(String date) {
    return 'Verw. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Verwachte bezorging $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Getekend door $name';
  }

  @override
  String get detailHistoryHeading => 'Geschiedenis';

  @override
  String get detailNoScanHistory => 'Nog geen scangegevens.';

  @override
  String get detailMapUnavailable =>
      'Kaart niet beschikbaar voor deze locaties.';

  @override
  String get historyEmpty => 'Nog geen zendingen.';

  @override
  String get insuranceEmpty => 'Nog geen verzekeringen.';

  @override
  String get insuranceBuy => 'Verzekering afsluiten';

  @override
  String get insuranceAmountRange =>
      'De verzekerde waarde moet tussen 0,01 en 5.000 USD liggen.';

  @override
  String get insuranceNotEnabled =>
      'Dit EasyPost-account is niet ingeschakeld voor een losse verzekering. Vraag EasyPost-support om dit in te schakelen, of voeg de verzekering toe bij het kopen van het label.';

  @override
  String get insuranceFromAddress => 'Afzenderadres';

  @override
  String get insuranceToAddress => 'Bezorgadres';

  @override
  String get fieldTrackingCode => 'Trackingcode';

  @override
  String get fieldCarrierHint => 'Vervoerder (bijv. USPS)';

  @override
  String get fieldInsuredAmount => 'Verzekerde waarde (USD)';

  @override
  String get fieldName => 'Naam';

  @override
  String get fieldStreet => 'Straat';

  @override
  String get fieldCity => 'Plaats';

  @override
  String get fieldStateRegion => 'Staat / regio';

  @override
  String get fieldPostcode => 'Postcode';

  @override
  String get fieldCountryIso => 'Land (ISO, bijv. US)';

  @override
  String get fieldType => 'Type';

  @override
  String get fieldAmountUsd => 'Bedrag (USD)';

  @override
  String get fieldContactEmail => 'Contact-e-mail';

  @override
  String get fieldDescription => 'Beschrijving';

  @override
  String get validationRequired => 'Verplicht';

  @override
  String get validationEnterAmount => 'Voer een bedrag in';

  @override
  String get validationEnterEmail => 'Voer een e-mailadres in';

  @override
  String get validationDescribeIssue => 'Beschrijf het probleem';

  @override
  String get claimsEmpty => 'Nog geen claims.';

  @override
  String get claimsFile => 'Claim indienen';

  @override
  String get claimSubmit => 'Claim versturen';

  @override
  String get claimTypeDamage => 'Schade';

  @override
  String get claimTypeTheft => 'Diefstal';

  @override
  String get claimTypeLoss => 'Verlies';

  @override
  String get claimAttachmentNote =>
      'Claims voor schade en diefstal vereisen een foto of factuur als bewijs. Dien die in via de desktop-app, waar documenten kunnen worden toegevoegd.';

  @override
  String get claimAttachmentSnack =>
      'Claims voor schade en diefstal vereisen een bewijsstuk, dat alleen in de desktop-app kan worden toegevoegd. Een verliesclaim kan hier worden ingediend.';

  @override
  String get pickupsEmpty => 'Nog geen ophalingen gepland.';

  @override
  String get pickupCancelTitle => 'Ophaling annuleren?';

  @override
  String pickupCancelBody(String id) {
    return 'Ophaling $id annuleren? Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String get pickupKeep => 'Behouden';

  @override
  String get pickupCancelConfirm => 'Ophaling annuleren';

  @override
  String get actionCancel => 'Annuleren';

  @override
  String get reportsShipments => 'Zendingen';

  @override
  String get reportsTotalSpend => 'Totale uitgaven';

  @override
  String get reportsByCarrier => 'Per vervoerder';

  @override
  String get reportsEmpty => 'Nog geen gekochte zendingen om te rapporteren.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Zendingen: $count';
  }

  @override
  String get htsSearchLabel => 'Tariefcodes zoeken';

  @override
  String get htsSearchHint => 'bijv. koperdraad';

  @override
  String get htsSearchButton => 'Zoeken';

  @override
  String get htsDisclaimer =>
      'Referentie-opzoeking bij de U.S. International Trade Commission. De juiste indeling blijft de verantwoordelijkheid van de verzender.';

  @override
  String get htsPrompt => 'Zoek hierboven naar een tariefcode.';

  @override
  String get htsNoResults => 'Geen overeenkomende tariefcodes.';

  @override
  String htsRateGeneral(String rate) {
    return 'Algemeen $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Speciaal $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Overig $rate';
  }

  @override
  String get htsCopyTooltip => 'Code kopiëren';

  @override
  String htsCopied(String code) {
    return '$code gekopieerd';
  }

  @override
  String htsUnavailable(int code) {
    return 'De tariefdienst is niet beschikbaar (fout $code). Probeer het opnieuw.';
  }

  @override
  String get pairTitle => 'Koppelen met desktop';

  @override
  String get pairInstructions =>
      'Open Easy-Post Desktop, kies ‘Mobiele app koppelen’ en scan de QR-code die daar wordt getoond.';

  @override
  String get pairEnterReviewCode =>
      'In plaats daarvan een beoordelingscode invoeren';

  @override
  String get pairReviewDialogTitle => 'Beoordelingscode invoeren';

  @override
  String get pairReviewCodeHint => 'Beoordelingscode';

  @override
  String get pairAction => 'Koppelen';

  @override
  String get errorPairingCodeInvalid =>
      'Die koppelcode is ongeldig of verlopen. Genereer een nieuwe op de desktop.';

  @override
  String get errorReviewCodeRejected =>
      'Die beoordelingscode is niet geaccepteerd.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Onverwacht antwoord van de koppeldienst.';

  @override
  String get errorNotPaired =>
      'Dit apparaat is niet meer gekoppeld. Koppel het opnieuw vanaf de desktop.';

  @override
  String get errorNotPairedShort => 'Dit apparaat is niet meer gekoppeld.';

  @override
  String get errorForbidden => 'Die actie is niet toegestaan vanuit de app.';

  @override
  String errorRequestFailed(int code) {
    return 'Verzoek mislukt (fout $code).';
  }

  @override
  String get detailShipment => 'Zending';

  @override
  String get detailInsurancePolicy => 'Verzekeringspolis';

  @override
  String get detailClaim => 'Claim';

  @override
  String get detailPickup => 'Ophaling';

  @override
  String get fieldCarrier => 'Vervoerder';

  @override
  String get fieldService => 'Service';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldCreated => 'Aangemaakt';

  @override
  String get fieldAmount => 'Bedrag';

  @override
  String get fieldProvider => 'Aanbieder';

  @override
  String get fieldReference => 'Referentie';

  @override
  String get fieldPickupWindow => 'Ophaalvenster';

  @override
  String get fieldCost => 'Kosten';

  @override
  String get detailNothingFurther => 'Geen verdere gegevens.';

  @override
  String get navRefunds => 'Terugbetalingen';

  @override
  String get refundsEmpty => 'Er zijn nog geen terugbetalingen aangevraagd.';

  @override
  String get detailRefund => 'Terugbetalingsverzoek';

  @override
  String get fieldRefundStatus => 'Terugbetaling';

  @override
  String get refundStatusSubmitted => 'Ingediend';

  @override
  String get refundStatusRefunded => 'Terugbetaald';

  @override
  String get refundStatusRejected => 'Afgewezen';
}

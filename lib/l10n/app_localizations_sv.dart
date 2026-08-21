// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Spårning';

  @override
  String get navHistory => 'Historik';

  @override
  String get navInsurance => 'Försäkring';

  @override
  String get navClaims => 'Skadeanmälningar';

  @override
  String get navPickups => 'Upphämtningar';

  @override
  String get navReports => 'Rapporter';

  @override
  String get navHts => 'HTS-sökning';

  @override
  String get navSectionManage => 'Spåra och hantera';

  @override
  String get navSectionTools => 'Verktyg';

  @override
  String get drawerUnpair => 'Koppla bort den här enheten';

  @override
  String get statusPreTransit => 'Före transport';

  @override
  String get statusInTransit => 'Under transport';

  @override
  String get statusOutForDelivery => 'Ute för leverans';

  @override
  String get statusDelivered => 'Levererad';

  @override
  String get statusAvailableForPickup => 'Kan hämtas';

  @override
  String get statusReturnToSender => 'Retur till avsändare';

  @override
  String get statusFailure => 'Misslyckades';

  @override
  String get statusCancelled => 'Avbruten';

  @override
  String get statusError => 'Fel';

  @override
  String get statusUnknown => 'Okänd';

  @override
  String get carrierUnknown => 'Okänd transportör';

  @override
  String get carrierUnknownShort => 'Okänd';

  @override
  String get sortTooltip => 'Sortera';

  @override
  String get sortByStatus => 'Sortera efter status';

  @override
  String get sortByCarrier => 'Sortera efter transportör';

  @override
  String get sortByCode => 'Sortera efter spårningsnummer';

  @override
  String get sortByUpdated => 'Sortera efter senast uppdaterad';

  @override
  String get filterTooltip => 'Filtrera';

  @override
  String get filterHideDelivered => 'Dölj levererade';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Transportör';

  @override
  String get filterReset => 'Återställ filter';

  @override
  String get trackersEmpty => 'Inga försändelser spåras ännu.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Visar $shown av $total';
  }

  @override
  String get trackersNoMatch => 'Inget matchar de aktuella filtren.';

  @override
  String etaLabel(String date) {
    return 'Ber. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Beräknad leverans $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Signerad av $name';
  }

  @override
  String get detailHistoryHeading => 'Historik';

  @override
  String get detailNoScanHistory => 'Inga avläsningar ännu.';

  @override
  String get detailMapUnavailable =>
      'Karta är inte tillgänglig för dessa platser.';

  @override
  String get historyEmpty => 'Inga försändelser ännu.';

  @override
  String get insuranceEmpty => 'Inga försäkringar ännu.';

  @override
  String get insuranceBuy => 'Köp försäkring';

  @override
  String get insuranceAmountRange =>
      'Det försäkrade värdet måste ligga mellan 0,01 och 5 000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Det här EasyPost-kontot är inte aktiverat för fristående försäkring. Be EasyPosts support att aktivera det, eller lägg till försäkring när fraktsedeln köps.';

  @override
  String get insuranceFromAddress => 'Avsändaradress';

  @override
  String get insuranceToAddress => 'Mottagaradress';

  @override
  String get fieldTrackingCode => 'Spårningsnummer';

  @override
  String get fieldCarrierHint => 'Transportör (t.ex. USPS)';

  @override
  String get fieldInsuredAmount => 'Försäkrat värde (USD)';

  @override
  String get fieldName => 'Namn';

  @override
  String get fieldStreet => 'Gata';

  @override
  String get fieldCity => 'Ort';

  @override
  String get fieldStateRegion => 'Delstat / region';

  @override
  String get fieldPostcode => 'Postnummer';

  @override
  String get fieldCountryIso => 'Land (ISO, t.ex. US)';

  @override
  String get fieldType => 'Typ';

  @override
  String get fieldAmountUsd => 'Belopp (USD)';

  @override
  String get fieldContactEmail => 'Kontakt-e-post';

  @override
  String get fieldDescription => 'Beskrivning';

  @override
  String get validationRequired => 'Obligatoriskt';

  @override
  String get validationEnterAmount => 'Ange ett belopp';

  @override
  String get validationEnterEmail => 'Ange en e-postadress';

  @override
  String get validationDescribeIssue => 'Beskriv problemet';

  @override
  String get claimsEmpty => 'Inga skadeanmälningar ännu.';

  @override
  String get claimsFile => 'Gör en skadeanmälan';

  @override
  String get claimSubmit => 'Skicka anmälan';

  @override
  String get claimTypeDamage => 'Skada';

  @override
  String get claimTypeTheft => 'Stöld';

  @override
  String get claimTypeLoss => 'Förlust';

  @override
  String get claimAttachmentNote =>
      'Anmälningar om skada och stöld kräver ett foto eller en faktura som underlag. Gör dem i skrivbordsappen, där dokument kan bifogas.';

  @override
  String get claimAttachmentSnack =>
      'Anmälningar om skada och stöld kräver ett underlag, som bara kan bifogas i skrivbordsappen. En förlustanmälan kan göras här.';

  @override
  String get pickupsEmpty => 'Inga upphämtningar är bokade ännu.';

  @override
  String get pickupCancelTitle => 'Avbryta upphämtningen?';

  @override
  String pickupCancelBody(String id) {
    return 'Avbryta upphämtning $id? Det går inte att ångra.';
  }

  @override
  String get pickupKeep => 'Behåll';

  @override
  String get pickupCancelConfirm => 'Avbryt upphämtning';

  @override
  String get actionCancel => 'Avbryt';

  @override
  String get reportsShipments => 'Försändelser';

  @override
  String get reportsTotalSpend => 'Totala utgifter';

  @override
  String get reportsByCarrier => 'Per transportör';

  @override
  String get reportsEmpty => 'Inga köpta försändelser att rapportera ännu.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Försändelser: $count';
  }

  @override
  String get htsSearchLabel => 'Sök tullkoder';

  @override
  String get htsSearchHint => 't.ex. koppartråd';

  @override
  String get htsSearchButton => 'Sök';

  @override
  String get htsDisclaimer =>
      'Referenssökning hos U.S. International Trade Commission. Rätt klassificering är fortfarande avsändarens ansvar.';

  @override
  String get htsPrompt => 'Sök efter en tullkod ovan.';

  @override
  String get htsNoResults => 'Inga matchande tullkoder.';

  @override
  String htsRateGeneral(String rate) {
    return 'Allmän $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Särskild $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Övrig $rate';
  }

  @override
  String get htsCopyTooltip => 'Kopiera kod';

  @override
  String htsCopied(String code) {
    return '$code kopierad';
  }

  @override
  String htsUnavailable(int code) {
    return 'Tulltjänsten är inte tillgänglig (fel $code). Försök igen.';
  }

  @override
  String get pairTitle => 'Parkoppla med datorn';

  @override
  String get pairInstructions =>
      'Öppna Easy-Post Desktop, välj ”Parkoppla mobilapp” och skanna QR-koden som visas där.';

  @override
  String get pairEnterReviewCode => 'Ange en granskningskod i stället';

  @override
  String get pairReviewDialogTitle => 'Ange granskningskod';

  @override
  String get pairReviewCodeHint => 'Granskningskod';

  @override
  String get pairAction => 'Parkoppla';

  @override
  String get errorPairingCodeInvalid =>
      'Den parkopplingskoden är ogiltig eller har gått ut. Skapa en ny på datorn.';

  @override
  String get errorReviewCodeRejected => 'Den granskningskoden godtogs inte.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Oväntat svar från parkopplingstjänsten.';

  @override
  String get errorNotPaired =>
      'Den här enheten är inte längre parkopplad. Parkoppla den igen från datorn.';

  @override
  String get errorNotPairedShort =>
      'Den här enheten är inte längre parkopplad.';

  @override
  String get errorForbidden => 'Den åtgärden är inte tillåten från appen.';

  @override
  String errorRequestFailed(int code) {
    return 'Begäran misslyckades (fel $code).';
  }

  @override
  String get detailShipment => 'Försändelse';

  @override
  String get detailInsurancePolicy => 'Försäkringsbrev';

  @override
  String get detailClaim => 'Skadeanmälan';

  @override
  String get detailPickup => 'Upphämtning';

  @override
  String get fieldCarrier => 'Transportör';

  @override
  String get fieldService => 'Tjänst';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldCreated => 'Skapad';

  @override
  String get fieldAmount => 'Belopp';

  @override
  String get fieldProvider => 'Leverantör';

  @override
  String get fieldReference => 'Referens';

  @override
  String get fieldPickupWindow => 'Upphämtningsfönster';

  @override
  String get fieldCost => 'Kostnad';

  @override
  String get detailNothingFurther => 'Inga fler uppgifter.';

  @override
  String get navRefunds => 'Återbetalningar';

  @override
  String get refundsEmpty => 'Inga återbetalningar har begärts ännu.';

  @override
  String get detailRefund => 'Begäran om återbetalning';

  @override
  String get fieldRefundStatus => 'Återbetalning';

  @override
  String get refundStatusSubmitted => 'Skickad';

  @override
  String get refundStatusRefunded => 'Återbetald';

  @override
  String get refundStatusRejected => 'Avvisad';
}

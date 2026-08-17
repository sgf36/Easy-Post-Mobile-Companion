// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Praćenje';

  @override
  String get navHistory => 'Povijest';

  @override
  String get navInsurance => 'Osiguranje';

  @override
  String get navClaims => 'Zahtjevi';

  @override
  String get navPickups => 'Preuzimanja';

  @override
  String get navReports => 'Izvještaji';

  @override
  String get navHts => 'HTS pretraga';

  @override
  String get navSectionManage => 'Praćenje i upravljanje';

  @override
  String get navSectionTools => 'Alati';

  @override
  String get drawerUnpair => 'Odspoji ovaj uređaj';

  @override
  String get statusPreTransit => 'Prije prijevoza';

  @override
  String get statusInTransit => 'U prijevozu';

  @override
  String get statusOutForDelivery => 'Na dostavi';

  @override
  String get statusDelivered => 'Dostavljeno';

  @override
  String get statusAvailableForPickup => 'Spremno za preuzimanje';

  @override
  String get statusReturnToSender => 'Vraćeno pošiljatelju';

  @override
  String get statusFailure => 'Neuspjelo';

  @override
  String get statusCancelled => 'Otkazano';

  @override
  String get statusError => 'Greška';

  @override
  String get statusUnknown => 'Nepoznato';

  @override
  String get carrierUnknown => 'Nepoznat dostavljač';

  @override
  String get carrierUnknownShort => 'Nepoznat';

  @override
  String get sortTooltip => 'Razvrstaj';

  @override
  String get sortByStatus => 'Razvrstaj po statusu';

  @override
  String get sortByCarrier => 'Razvrstaj po dostavljaču';

  @override
  String get sortByCode => 'Razvrstaj po broju za praćenje';

  @override
  String get sortByUpdated => 'Razvrstaj po nedavnom ažuriranju';

  @override
  String get filterTooltip => 'Filtriraj';

  @override
  String get filterHideDelivered => 'Sakrij dostavljene';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Dostavljač';

  @override
  String get filterReset => 'Poništi filtre';

  @override
  String get trackersEmpty => 'Još se ne prati nijedna pošiljka.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Prikazano $shown od $total';
  }

  @override
  String get trackersNoMatch => 'Ništa ne odgovara trenutnim filtrima.';

  @override
  String etaLabel(String date) {
    return 'Procj. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Procijenjena dostava $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Potpisao/la $name';
  }

  @override
  String get detailHistoryHeading => 'Povijest';

  @override
  String get detailNoScanHistory => 'Još nema zabilježenih očitanja.';

  @override
  String get detailMapUnavailable => 'Karta nije dostupna za ove lokacije.';

  @override
  String get historyEmpty => 'Još nema pošiljaka.';

  @override
  String get insuranceEmpty => 'Još nema polica.';

  @override
  String get insuranceBuy => 'Kupi osiguranje';

  @override
  String get insuranceAmountRange =>
      'Osigurani iznos mora biti između 0,01 i 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Ovaj EasyPost račun nema omogućeno samostalno osiguranje. Zatražite od EasyPost podrške da ga omogući ili dodajte osiguranje pri kupnji naljepnice.';

  @override
  String get insuranceFromAddress => 'Adresa pošiljatelja';

  @override
  String get insuranceToAddress => 'Adresa primatelja';

  @override
  String get fieldTrackingCode => 'Broj za praćenje';

  @override
  String get fieldCarrierHint => 'Dostavljač (npr. USPS)';

  @override
  String get fieldInsuredAmount => 'Osigurani iznos (USD)';

  @override
  String get fieldName => 'Ime';

  @override
  String get fieldStreet => 'Ulica';

  @override
  String get fieldCity => 'Grad';

  @override
  String get fieldStateRegion => 'Savezna država / regija';

  @override
  String get fieldPostcode => 'Poštanski broj';

  @override
  String get fieldCountryIso => 'Država (ISO, npr. US)';

  @override
  String get fieldType => 'Vrsta';

  @override
  String get fieldAmountUsd => 'Iznos (USD)';

  @override
  String get fieldContactEmail => 'Kontakt e-pošta';

  @override
  String get fieldDescription => 'Opis';

  @override
  String get validationRequired => 'Obavezno';

  @override
  String get validationEnterAmount => 'Unesite iznos';

  @override
  String get validationEnterEmail => 'Unesite e-poštu';

  @override
  String get validationDescribeIssue => 'Opišite problem';

  @override
  String get claimsEmpty => 'Još nema zahtjeva.';

  @override
  String get claimsFile => 'Podnesi zahtjev';

  @override
  String get claimSubmit => 'Pošalji zahtjev';

  @override
  String get claimTypeDamage => 'Oštećenje';

  @override
  String get claimTypeTheft => 'Krađa';

  @override
  String get claimTypeLoss => 'Gubitak';

  @override
  String get claimAttachmentNote =>
      'Zahtjevi za oštećenje i krađu zahtijevaju fotografiju ili račun kao dokaz. Podnesite ih u desktop aplikaciji, gdje se dokumenti mogu priložiti.';

  @override
  String get claimAttachmentSnack =>
      'Zahtjevi za oštećenje i krađu zahtijevaju dokaz koji se može priložiti samo u desktop aplikaciji. Zahtjev za gubitak može se podnijeti ovdje.';

  @override
  String get pickupsEmpty => 'Još nije zakazano nijedno preuzimanje.';

  @override
  String get pickupCancelTitle => 'Otkazati preuzimanje?';

  @override
  String pickupCancelBody(String id) {
    return 'Otkazati preuzimanje $id? Ovo se ne može poništiti.';
  }

  @override
  String get pickupKeep => 'Zadrži';

  @override
  String get pickupCancelConfirm => 'Otkaži preuzimanje';

  @override
  String get actionCancel => 'Odustani';

  @override
  String get reportsShipments => 'Pošiljke';

  @override
  String get reportsTotalSpend => 'Ukupna potrošnja';

  @override
  String get reportsByCarrier => 'Po dostavljaču';

  @override
  String get reportsEmpty => 'Još nema kupljenih pošiljaka za izvještaj.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Pošiljke: $count';
  }

  @override
  String get htsSearchLabel => 'Pretraži carinske oznake';

  @override
  String get htsSearchHint => 'npr. bakrena žica';

  @override
  String get htsSearchButton => 'Pretraži';

  @override
  String get htsDisclaimer =>
      'Referentna pretraga iz U.S. International Trade Commission. Za ispravno razvrstavanje odgovoran je pošiljatelj.';

  @override
  String get htsPrompt => 'Pretražite carinsku oznaku iznad.';

  @override
  String get htsNoResults => 'Nema odgovarajućih carinskih oznaka.';

  @override
  String htsRateGeneral(String rate) {
    return 'Opća $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Posebna $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Ostalo $rate';
  }

  @override
  String get htsCopyTooltip => 'Kopiraj kod';

  @override
  String htsCopied(String code) {
    return 'Kopirano $code';
  }

  @override
  String htsUnavailable(int code) {
    return 'Carinska usluga nije dostupna (greška $code). Pokušajte ponovno.';
  }

  @override
  String get pairTitle => 'Upari s računalom';

  @override
  String get pairInstructions =>
      'Otvorite Easy-Post Desktop, odaberite „Uparivanje mobilne aplikacije” i skenirajte prikazani QR kod.';

  @override
  String get pairEnterReviewCode => 'Umjesto toga unesite kod za recenziju';

  @override
  String get pairReviewDialogTitle => 'Unesite kod za recenziju';

  @override
  String get pairReviewCodeHint => 'Kod za recenziju';

  @override
  String get pairAction => 'Upari';

  @override
  String get errorPairingCodeInvalid =>
      'Taj kod za uparivanje nije valjan ili je istekao. Generirajte novi na računalu.';

  @override
  String get errorReviewCodeRejected => 'Taj kod za recenziju nije prihvaćen.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Neočekivani odgovor usluge uparivanja.';

  @override
  String get errorNotPaired =>
      'Ovaj uređaj više nije uparen. Uparite ga ponovno s računala.';

  @override
  String get errorNotPairedShort => 'Ovaj uređaj više nije uparen.';

  @override
  String get errorForbidden => 'Ta radnja nije dopuštena iz aplikacije.';

  @override
  String errorRequestFailed(int code) {
    return 'Zahtjev nije uspio (greška $code).';
  }

  @override
  String get detailShipment => 'Pošiljka';

  @override
  String get detailInsurancePolicy => 'Polica osiguranja';

  @override
  String get detailClaim => 'Odštetni zahtjev';

  @override
  String get detailPickup => 'Preuzimanje';

  @override
  String get fieldCarrier => 'Prijevoznik';

  @override
  String get fieldService => 'Usluga';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldCreated => 'Stvoreno';

  @override
  String get fieldAmount => 'Iznos';

  @override
  String get fieldProvider => 'Pružatelj';

  @override
  String get fieldReference => 'Referenca';

  @override
  String get fieldPickupWindow => 'Razdoblje preuzimanja';

  @override
  String get fieldCost => 'Cijena';

  @override
  String get detailNothingFurther => 'Nema dodatnih pojedinosti.';
}

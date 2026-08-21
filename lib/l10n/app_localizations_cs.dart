// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Sledování';

  @override
  String get navHistory => 'Historie';

  @override
  String get navInsurance => 'Pojištění';

  @override
  String get navClaims => 'Reklamace';

  @override
  String get navPickups => 'Vyzvednutí';

  @override
  String get navReports => 'Přehledy';

  @override
  String get navHts => 'Vyhledávání HTS';

  @override
  String get navSectionManage => 'Sledování a správa';

  @override
  String get navSectionTools => 'Nástroje';

  @override
  String get drawerUnpair => 'Zrušit spárování tohoto zařízení';

  @override
  String get statusPreTransit => 'Před přepravou';

  @override
  String get statusInTransit => 'Na cestě';

  @override
  String get statusOutForDelivery => 'Na cestě k doručení';

  @override
  String get statusDelivered => 'Doručeno';

  @override
  String get statusAvailableForPickup => 'K vyzvednutí';

  @override
  String get statusReturnToSender => 'Vráceno odesílateli';

  @override
  String get statusFailure => 'Selhalo';

  @override
  String get statusCancelled => 'Zrušeno';

  @override
  String get statusError => 'Chyba';

  @override
  String get statusUnknown => 'Neznámé';

  @override
  String get carrierUnknown => 'Neznámý dopravce';

  @override
  String get carrierUnknownShort => 'Neznámý';

  @override
  String get sortTooltip => 'Seřadit';

  @override
  String get sortByStatus => 'Seřadit podle stavu';

  @override
  String get sortByCarrier => 'Seřadit podle dopravce';

  @override
  String get sortByCode => 'Seřadit podle sledovacího čísla';

  @override
  String get sortByUpdated => 'Seřadit podle poslední aktualizace';

  @override
  String get filterTooltip => 'Filtrovat';

  @override
  String get filterHideDelivered => 'Skrýt doručené';

  @override
  String get filterStatusHeading => 'Stav';

  @override
  String get filterCarrierHeading => 'Dopravce';

  @override
  String get filterReset => 'Zrušit filtry';

  @override
  String get trackersEmpty => 'Zatím není sledována žádná zásilka.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Zobrazeno $shown z $total';
  }

  @override
  String get trackersNoMatch => 'Aktuálním filtrům nic neodpovídá.';

  @override
  String etaLabel(String date) {
    return 'Odh. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Odhadované doručení $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Podepsal(a) $name';
  }

  @override
  String get detailHistoryHeading => 'Historie';

  @override
  String get detailNoScanHistory => 'Zatím žádné záznamy o skenování.';

  @override
  String get detailMapUnavailable => 'Pro tato místa není mapa k dispozici.';

  @override
  String get historyEmpty => 'Zatím žádné zásilky.';

  @override
  String get insuranceEmpty => 'Zatím žádné pojistky.';

  @override
  String get insuranceBuy => 'Zakoupit pojištění';

  @override
  String get insuranceAmountRange =>
      'Pojistná částka musí být mezi 0,01 a 5 000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Tento účet EasyPost nemá povoleno samostatné pojištění. Požádejte podporu EasyPost o jeho povolení, nebo pojištění přidejte při nákupu štítku.';

  @override
  String get insuranceFromAddress => 'Adresa odesílatele';

  @override
  String get insuranceToAddress => 'Adresa příjemce';

  @override
  String get fieldTrackingCode => 'Sledovací číslo';

  @override
  String get fieldCarrierHint => 'Dopravce (např. USPS)';

  @override
  String get fieldInsuredAmount => 'Pojistná částka (USD)';

  @override
  String get fieldName => 'Jméno';

  @override
  String get fieldStreet => 'Ulice';

  @override
  String get fieldCity => 'Město';

  @override
  String get fieldStateRegion => 'Stát / region';

  @override
  String get fieldPostcode => 'PSČ';

  @override
  String get fieldCountryIso => 'Země (ISO, např. US)';

  @override
  String get fieldType => 'Typ';

  @override
  String get fieldAmountUsd => 'Částka (USD)';

  @override
  String get fieldContactEmail => 'Kontaktní e-mail';

  @override
  String get fieldDescription => 'Popis';

  @override
  String get validationRequired => 'Povinné';

  @override
  String get validationEnterAmount => 'Zadejte částku';

  @override
  String get validationEnterEmail => 'Zadejte e-mail';

  @override
  String get validationDescribeIssue => 'Popište problém';

  @override
  String get claimsEmpty => 'Zatím žádné reklamace.';

  @override
  String get claimsFile => 'Podat reklamaci';

  @override
  String get claimSubmit => 'Odeslat reklamaci';

  @override
  String get claimTypeDamage => 'Poškození';

  @override
  String get claimTypeTheft => 'Odcizení';

  @override
  String get claimTypeLoss => 'Ztráta';

  @override
  String get claimAttachmentNote =>
      'Reklamace poškození a odcizení vyžadují fotografii nebo fakturu jako doklad. Podejte je v desktopové aplikaci, kde lze dokumenty přiložit.';

  @override
  String get claimAttachmentSnack =>
      'Reklamace poškození a odcizení vyžadují doklad, který lze přiložit jen v desktopové aplikaci. Reklamaci ztráty lze podat zde.';

  @override
  String get pickupsEmpty => 'Zatím není naplánováno žádné vyzvednutí.';

  @override
  String get pickupCancelTitle => 'Zrušit vyzvednutí?';

  @override
  String pickupCancelBody(String id) {
    return 'Zrušit vyzvednutí $id? Tuto akci nelze vzít zpět.';
  }

  @override
  String get pickupKeep => 'Ponechat';

  @override
  String get pickupCancelConfirm => 'Zrušit vyzvednutí';

  @override
  String get actionCancel => 'Zrušit';

  @override
  String get reportsShipments => 'Zásilky';

  @override
  String get reportsTotalSpend => 'Celkové výdaje';

  @override
  String get reportsByCarrier => 'Podle dopravce';

  @override
  String get reportsEmpty =>
      'Zatím nejsou k dispozici žádné zakoupené zásilky.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Zásilky: $count';
  }

  @override
  String get htsSearchLabel => 'Hledat celní kódy';

  @override
  String get htsSearchHint => 'např. měděný drát';

  @override
  String get htsSearchButton => 'Hledat';

  @override
  String get htsDisclaimer =>
      'Referenční vyhledávání z U.S. International Trade Commission. Za správné zařazení odpovídá odesílatel.';

  @override
  String get htsPrompt => 'Vyhledejte celní kód výše.';

  @override
  String get htsNoResults => 'Žádné odpovídající celní kódy.';

  @override
  String htsRateGeneral(String rate) {
    return 'Obecná $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Zvláštní $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Ostatní $rate';
  }

  @override
  String get htsCopyTooltip => 'Kopírovat kód';

  @override
  String htsCopied(String code) {
    return 'Zkopírováno $code';
  }

  @override
  String htsUnavailable(int code) {
    return 'Celní služba je nedostupná (chyba $code). Zkuste to znovu.';
  }

  @override
  String get pairTitle => 'Spárovat s počítačem';

  @override
  String get pairInstructions =>
      'Otevřete Easy-Post Desktop, zvolte „Spárovat mobilní aplikaci“ a naskenujte zobrazený QR kód.';

  @override
  String get pairEnterReviewCode => 'Zadat místo toho kód pro recenzenta';

  @override
  String get pairReviewDialogTitle => 'Zadat kód pro recenzenta';

  @override
  String get pairReviewCodeHint => 'Kód pro recenzenta';

  @override
  String get pairAction => 'Spárovat';

  @override
  String get errorPairingCodeInvalid =>
      'Tento párovací kód je neplatný nebo vypršel. Vygenerujte nový v počítači.';

  @override
  String get errorReviewCodeRejected =>
      'Tento kód pro recenzenta nebyl přijat.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Neočekávaná odpověď párovací služby.';

  @override
  String get errorNotPaired =>
      'Toto zařízení již není spárováno. Spárujte je znovu z počítače.';

  @override
  String get errorNotPairedShort => 'Toto zařízení již není spárováno.';

  @override
  String get errorForbidden => 'Tato akce není z aplikace povolena.';

  @override
  String errorRequestFailed(int code) {
    return 'Požadavek se nezdařil (chyba $code).';
  }

  @override
  String get detailShipment => 'Zásilka';

  @override
  String get detailInsurancePolicy => 'Pojistka';

  @override
  String get detailClaim => 'Reklamace';

  @override
  String get detailPickup => 'Svoz';

  @override
  String get fieldCarrier => 'Dopravce';

  @override
  String get fieldService => 'Služba';

  @override
  String get fieldStatus => 'Stav';

  @override
  String get fieldCreated => 'Vytvořeno';

  @override
  String get fieldAmount => 'Částka';

  @override
  String get fieldProvider => 'Poskytovatel';

  @override
  String get fieldReference => 'Reference';

  @override
  String get fieldPickupWindow => 'Časové okno svozu';

  @override
  String get fieldCost => 'Cena';

  @override
  String get detailNothingFurther => 'Žádné další podrobnosti.';

  @override
  String get navRefunds => 'Refundace';

  @override
  String get refundsEmpty => 'Zatím nebyla vyžádána žádná refundace.';

  @override
  String get detailRefund => 'Žádost o refundaci';

  @override
  String get fieldRefundStatus => 'Refundace';

  @override
  String get refundStatusSubmitted => 'Odesláno';

  @override
  String get refundStatusRefunded => 'Refundováno';

  @override
  String get refundStatusRejected => 'Zamítnuto';
}

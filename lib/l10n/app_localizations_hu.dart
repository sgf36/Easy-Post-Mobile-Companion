// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Nyomkövetés';

  @override
  String get navHistory => 'Előzmények';

  @override
  String get navInsurance => 'Biztosítás';

  @override
  String get navClaims => 'Kárigények';

  @override
  String get navPickups => 'Átvételek';

  @override
  String get navReports => 'Jelentések';

  @override
  String get navHts => 'HTS keresés';

  @override
  String get navSectionManage => 'Követés és kezelés';

  @override
  String get navSectionTools => 'Eszközök';

  @override
  String get drawerUnpair => 'Eszköz párosításának megszüntetése';

  @override
  String get statusPreTransit => 'Szállítás előtt';

  @override
  String get statusInTransit => 'Úton';

  @override
  String get statusOutForDelivery => 'Kiszállítás alatt';

  @override
  String get statusDelivered => 'Kézbesítve';

  @override
  String get statusAvailableForPickup => 'Átvehető';

  @override
  String get statusReturnToSender => 'Visszaküldve a feladónak';

  @override
  String get statusFailure => 'Sikertelen';

  @override
  String get statusCancelled => 'Törölve';

  @override
  String get statusError => 'Hiba';

  @override
  String get statusUnknown => 'Ismeretlen';

  @override
  String get carrierUnknown => 'Ismeretlen szállító';

  @override
  String get carrierUnknownShort => 'Ismeretlen';

  @override
  String get sortTooltip => 'Rendezés';

  @override
  String get sortByStatus => 'Rendezés állapot szerint';

  @override
  String get sortByCarrier => 'Rendezés szállító szerint';

  @override
  String get sortByCode => 'Rendezés nyomkövetési szám szerint';

  @override
  String get sortByUpdated => 'Rendezés frissítés szerint';

  @override
  String get filterTooltip => 'Szűrés';

  @override
  String get filterHideDelivered => 'Kézbesítettek elrejtése';

  @override
  String get filterStatusHeading => 'Állapot';

  @override
  String get filterCarrierHeading => 'Szállító';

  @override
  String get filterReset => 'Szűrők törlése';

  @override
  String get trackersEmpty => 'Még nincs követett küldemény.';

  @override
  String trackersShowing(int shown, int total) {
    return '$total közül $shown látható';
  }

  @override
  String get trackersNoMatch => 'Semmi sem felel meg a jelenlegi szűrőknek.';

  @override
  String etaLabel(String date) {
    return 'Vár. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Becsült kézbesítés: $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Aláírta: $name';
  }

  @override
  String get detailHistoryHeading => 'Előzmények';

  @override
  String get detailNoScanHistory => 'Még nincs beolvasási esemény.';

  @override
  String get detailMapUnavailable =>
      'Ezekhez a helyekhez nem érhető el térkép.';

  @override
  String get historyEmpty => 'Még nincsenek küldemények.';

  @override
  String get insuranceEmpty => 'Még nincs biztosítás.';

  @override
  String get insuranceBuy => 'Biztosítás vásárlása';

  @override
  String get insuranceAmountRange =>
      'A biztosított összegnek 0,01 és 5000 USD között kell lennie.';

  @override
  String get insuranceNotEnabled =>
      'Ez az EasyPost-fiók nem jogosult önálló biztosításra. Kérje az EasyPost ügyfélszolgálatától az engedélyezését, vagy adjon hozzá biztosítást a címke vásárlásakor.';

  @override
  String get insuranceFromAddress => 'Feladó címe';

  @override
  String get insuranceToAddress => 'Címzett címe';

  @override
  String get fieldTrackingCode => 'Nyomkövetési szám';

  @override
  String get fieldCarrierHint => 'Szállító (pl. USPS)';

  @override
  String get fieldInsuredAmount => 'Biztosított összeg (USD)';

  @override
  String get fieldName => 'Név';

  @override
  String get fieldStreet => 'Utca';

  @override
  String get fieldCity => 'Város';

  @override
  String get fieldStateRegion => 'Állam / régió';

  @override
  String get fieldPostcode => 'Irányítószám';

  @override
  String get fieldCountryIso => 'Ország (ISO, pl. US)';

  @override
  String get fieldType => 'Típus';

  @override
  String get fieldAmountUsd => 'Összeg (USD)';

  @override
  String get fieldContactEmail => 'Kapcsolattartási e-mail';

  @override
  String get fieldDescription => 'Leírás';

  @override
  String get validationRequired => 'Kötelező';

  @override
  String get validationEnterAmount => 'Adjon meg egy összeget';

  @override
  String get validationEnterEmail => 'Adjon meg egy e-mail-címet';

  @override
  String get validationDescribeIssue => 'Írja le a problémát';

  @override
  String get claimsEmpty => 'Még nincs kárigény.';

  @override
  String get claimsFile => 'Kárigény benyújtása';

  @override
  String get claimSubmit => 'Kárigény elküldése';

  @override
  String get claimTypeDamage => 'Sérülés';

  @override
  String get claimTypeTheft => 'Lopás';

  @override
  String get claimTypeLoss => 'Elvesztés';

  @override
  String get claimAttachmentNote =>
      'A sérüléssel és lopással kapcsolatos kárigényekhez fénykép vagy számla szükséges igazolásként. Ezeket az asztali alkalmazásban nyújtsa be, ahol dokumentum csatolható.';

  @override
  String get claimAttachmentSnack =>
      'A sérüléssel és lopással kapcsolatos kárigényekhez igazolás szükséges, amelyet csak az asztali alkalmazásban lehet csatolni. Elvesztés miatti kárigény itt is benyújtható.';

  @override
  String get pickupsEmpty => 'Még nincs ütemezett átvétel.';

  @override
  String get pickupCancelTitle => 'Törli az átvételt?';

  @override
  String pickupCancelBody(String id) {
    return 'Törli a(z) $id átvételt? Ez nem vonható vissza.';
  }

  @override
  String get pickupKeep => 'Megtartás';

  @override
  String get pickupCancelConfirm => 'Átvétel törlése';

  @override
  String get actionCancel => 'Mégse';

  @override
  String get reportsShipments => 'Küldemények';

  @override
  String get reportsTotalSpend => 'Teljes kiadás';

  @override
  String get reportsByCarrier => 'Szállítónként';

  @override
  String get reportsEmpty => 'Még nincs megvásárolt küldemény a jelentéshez.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Küldemények: $count';
  }

  @override
  String get htsSearchLabel => 'Vámtarifaszámok keresése';

  @override
  String get htsSearchHint => 'pl. rézhuzal';

  @override
  String get htsSearchButton => 'Keresés';

  @override
  String get htsDisclaimer =>
      'Referenciakeresés a U.S. International Trade Commission adataiból. A helyes besorolás továbbra is a feladó felelőssége.';

  @override
  String get htsPrompt => 'Keressen fent egy vámtarifaszámot.';

  @override
  String get htsNoResults => 'Nincs találat a vámtarifaszámok között.';

  @override
  String htsRateGeneral(String rate) {
    return 'Általános $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Kedvezményes $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Egyéb $rate';
  }

  @override
  String get htsCopyTooltip => 'Kód másolása';

  @override
  String htsCopied(String code) {
    return '$code másolva';
  }

  @override
  String htsUnavailable(int code) {
    return 'A vámtarifa-szolgáltatás nem érhető el ($code hiba). Próbálja újra.';
  }

  @override
  String get pairTitle => 'Párosítás az asztali alkalmazással';

  @override
  String get pairInstructions =>
      'Nyissa meg az Easy-Post Desktopot, válassza a „Mobilalkalmazás párosítása” lehetőséget, majd olvassa be az ott megjelenő QR-kódot.';

  @override
  String get pairEnterReviewCode => 'Inkább ellenőrzési kód megadása';

  @override
  String get pairReviewDialogTitle => 'Ellenőrzési kód megadása';

  @override
  String get pairReviewCodeHint => 'Ellenőrzési kód';

  @override
  String get pairAction => 'Párosítás';

  @override
  String get errorPairingCodeInvalid =>
      'Ez a párosítási kód érvénytelen vagy lejárt. Hozzon létre újat az asztali alkalmazásban.';

  @override
  String get errorReviewCodeRejected =>
      'Ezt az ellenőrzési kódot nem fogadta el a rendszer.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Váratlan válasz a párosítási szolgáltatástól.';

  @override
  String get errorNotPaired =>
      'Ez az eszköz már nincs párosítva. Párosítsa újra az asztali alkalmazásból.';

  @override
  String get errorNotPairedShort => 'Ez az eszköz már nincs párosítva.';

  @override
  String get errorForbidden =>
      'Ez a művelet nem engedélyezett az alkalmazásból.';

  @override
  String errorRequestFailed(int code) {
    return 'A kérés sikertelen ($code hiba).';
  }

  @override
  String get detailShipment => 'Küldemény';

  @override
  String get detailInsurancePolicy => 'Biztosítási kötvény';

  @override
  String get detailClaim => 'Kárigény';

  @override
  String get detailPickup => 'Átvétel';

  @override
  String get fieldCarrier => 'Szállító';

  @override
  String get fieldService => 'Szolgáltatás';

  @override
  String get fieldStatus => 'Állapot';

  @override
  String get fieldCreated => 'Létrehozva';

  @override
  String get fieldAmount => 'Összeg';

  @override
  String get fieldProvider => 'Szolgáltató';

  @override
  String get fieldReference => 'Hivatkozás';

  @override
  String get fieldPickupWindow => 'Átvételi időablak';

  @override
  String get fieldCost => 'Költség';

  @override
  String get detailNothingFurther => 'Nincs további részlet.';
}

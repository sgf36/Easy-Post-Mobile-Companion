// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Urmărire';

  @override
  String get navHistory => 'Istoric';

  @override
  String get navInsurance => 'Asigurare';

  @override
  String get navClaims => 'Reclamații';

  @override
  String get navPickups => 'Ridicări';

  @override
  String get navReports => 'Rapoarte';

  @override
  String get navHts => 'Căutare HTS';

  @override
  String get navSectionManage => 'Urmărire și gestionare';

  @override
  String get navSectionTools => 'Instrumente';

  @override
  String get drawerUnpair => 'Deconectează acest dispozitiv';

  @override
  String get statusPreTransit => 'Înainte de transport';

  @override
  String get statusInTransit => 'În tranzit';

  @override
  String get statusOutForDelivery => 'Ieșit pentru livrare';

  @override
  String get statusDelivered => 'Livrat';

  @override
  String get statusAvailableForPickup => 'Disponibil pentru ridicare';

  @override
  String get statusReturnToSender => 'Returnat expeditorului';

  @override
  String get statusFailure => 'Eșuat';

  @override
  String get statusCancelled => 'Anulat';

  @override
  String get statusError => 'Eroare';

  @override
  String get statusUnknown => 'Necunoscut';

  @override
  String get carrierUnknown => 'Curier necunoscut';

  @override
  String get carrierUnknownShort => 'Necunoscut';

  @override
  String get sortTooltip => 'Sortare';

  @override
  String get sortByStatus => 'Sortează după stare';

  @override
  String get sortByCarrier => 'Sortează după curier';

  @override
  String get sortByCode => 'Sortează după codul de urmărire';

  @override
  String get sortByUpdated => 'Sortează după actualizare recentă';

  @override
  String get filterTooltip => 'Filtrare';

  @override
  String get filterHideDelivered => 'Ascunde livrările finalizate';

  @override
  String get filterStatusHeading => 'Stare';

  @override
  String get filterCarrierHeading => 'Curier';

  @override
  String get filterReset => 'Resetează filtrele';

  @override
  String get trackersEmpty => 'Nu se urmărește încă niciun colet.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Se afișează $shown din $total';
  }

  @override
  String get trackersNoMatch => 'Nimic nu corespunde filtrelor curente.';

  @override
  String etaLabel(String date) {
    return 'Est. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Livrare estimată $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Semnat de $name';
  }

  @override
  String get detailHistoryHeading => 'Istoric';

  @override
  String get detailNoScanHistory => 'Încă nu există scanări.';

  @override
  String get detailMapUnavailable =>
      'Harta nu este disponibilă pentru aceste locații.';

  @override
  String get historyEmpty => 'Încă nu există expedieri.';

  @override
  String get insuranceEmpty =>
      'Încă nu există polițe. Apasă „Achiziționează asigurare”.';

  @override
  String get insuranceBuy => 'Achiziționează asigurare';

  @override
  String get insuranceAmountRange =>
      'Suma asigurată trebuie să fie între 0,01 și 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Acest cont EasyPost nu are activată asigurarea independentă. Cere asistenței EasyPost să o activeze sau adaugă asigurarea la cumpărarea etichetei.';

  @override
  String get insuranceFromAddress => 'Adresa expeditorului';

  @override
  String get insuranceToAddress => 'Adresa destinatarului';

  @override
  String get fieldTrackingCode => 'Cod de urmărire';

  @override
  String get fieldCarrierHint => 'Curier (ex. USPS)';

  @override
  String get fieldInsuredAmount => 'Sumă asigurată (USD)';

  @override
  String get fieldName => 'Nume';

  @override
  String get fieldStreet => 'Stradă';

  @override
  String get fieldCity => 'Oraș';

  @override
  String get fieldStateRegion => 'Stat / regiune';

  @override
  String get fieldPostcode => 'Cod poștal';

  @override
  String get fieldCountryIso => 'Țară (ISO, ex. US)';

  @override
  String get fieldType => 'Tip';

  @override
  String get fieldAmountUsd => 'Sumă (USD)';

  @override
  String get fieldContactEmail => 'E-mail de contact';

  @override
  String get fieldDescription => 'Descriere';

  @override
  String get validationRequired => 'Obligatoriu';

  @override
  String get validationEnterAmount => 'Introdu o sumă';

  @override
  String get validationEnterEmail => 'Introdu un e-mail';

  @override
  String get validationDescribeIssue => 'Descrie problema';

  @override
  String get claimsEmpty =>
      'Încă nu există reclamații. Apasă „Depune o reclamație”.';

  @override
  String get claimsFile => 'Depune o reclamație';

  @override
  String get claimSubmit => 'Trimite reclamația';

  @override
  String get claimTypeDamage => 'Deteriorare';

  @override
  String get claimTypeTheft => 'Furt';

  @override
  String get claimTypeLoss => 'Pierdere';

  @override
  String get claimAttachmentNote =>
      'Reclamațiile pentru deteriorare și furt necesită o fotografie sau o factură ca dovadă. Depune-le din aplicația desktop, unde se pot atașa documente.';

  @override
  String get claimAttachmentSnack =>
      'Reclamațiile pentru deteriorare și furt necesită o dovadă, care poate fi atașată doar în aplicația desktop. O reclamație pentru pierdere poate fi depusă aici.';

  @override
  String get pickupsEmpty => 'Nu este programată încă nicio ridicare.';

  @override
  String get pickupCancelTitle => 'Anulezi ridicarea?';

  @override
  String pickupCancelBody(String id) {
    return 'Anulezi ridicarea $id? Această acțiune nu poate fi anulată.';
  }

  @override
  String get pickupKeep => 'Păstrează';

  @override
  String get pickupCancelConfirm => 'Anulează ridicarea';

  @override
  String get actionCancel => 'Anulează';

  @override
  String get reportsShipments => 'Expedieri';

  @override
  String get reportsTotalSpend => 'Cheltuieli totale';

  @override
  String get reportsByCarrier => 'Pe curier';

  @override
  String get reportsEmpty => 'Încă nu există expedieri cumpărate de raportat.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Expedieri: $count';
  }

  @override
  String get htsSearchLabel => 'Caută coduri tarifare';

  @override
  String get htsSearchHint => 'ex. sârmă de cupru';

  @override
  String get htsSearchButton => 'Caută';

  @override
  String get htsDisclaimer =>
      'Căutare de referință de la U.S. International Trade Commission. Clasificarea corectă rămâne responsabilitatea expeditorului.';

  @override
  String get htsPrompt => 'Caută un cod tarifar mai sus.';

  @override
  String get htsNoResults => 'Niciun cod tarifar corespunzător.';

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
    return 'Altul $rate';
  }

  @override
  String get htsCopyTooltip => 'Copiază codul';

  @override
  String htsCopied(String code) {
    return '$code copiat';
  }

  @override
  String htsUnavailable(int code) {
    return 'Serviciul tarifar este indisponibil (eroare $code). Încearcă din nou.';
  }

  @override
  String get pairTitle => 'Asociază cu desktopul';

  @override
  String get pairInstructions =>
      'Deschide Easy-Post Desktop, alege „Asociere aplicație mobilă” și scanează codul QR afișat acolo.';

  @override
  String get pairEnterReviewCode => 'Introdu în schimb un cod de evaluare';

  @override
  String get pairReviewDialogTitle => 'Introdu codul de evaluare';

  @override
  String get pairReviewCodeHint => 'Cod de evaluare';

  @override
  String get pairAction => 'Asociază';

  @override
  String get errorPairingCodeInvalid =>
      'Acest cod de asociere este invalid sau a expirat. Generează unul nou pe desktop.';

  @override
  String get errorReviewCodeRejected =>
      'Acest cod de evaluare nu a fost acceptat.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Răspuns neașteptat de la serviciul de asociere.';

  @override
  String get errorNotPaired =>
      'Acest dispozitiv nu mai este asociat. Asociază-l din nou de pe desktop.';

  @override
  String get errorNotPairedShort => 'Acest dispozitiv nu mai este asociat.';

  @override
  String get errorForbidden => 'Această acțiune nu este permisă din aplicație.';

  @override
  String errorRequestFailed(int code) {
    return 'Cererea a eșuat (eroare $code).';
  }

  @override
  String get detailShipment => 'Expediere';

  @override
  String get detailInsurancePolicy => 'Poliță de asigurare';

  @override
  String get detailClaim => 'Reclamație';

  @override
  String get detailPickup => 'Ridicare';

  @override
  String get fieldCarrier => 'Curier';

  @override
  String get fieldService => 'Serviciu';

  @override
  String get fieldStatus => 'Stare';

  @override
  String get fieldCreated => 'Creat';

  @override
  String get fieldAmount => 'Sumă';

  @override
  String get fieldProvider => 'Furnizor';

  @override
  String get fieldReference => 'Referință';

  @override
  String get fieldPickupWindow => 'Interval de ridicare';

  @override
  String get fieldCost => 'Cost';

  @override
  String get detailNothingFurther => 'Nu există alte detalii.';
}

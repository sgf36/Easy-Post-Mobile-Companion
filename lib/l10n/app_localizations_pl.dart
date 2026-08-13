// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Śledzenie';

  @override
  String get navHistory => 'Historia';

  @override
  String get navInsurance => 'Ubezpieczenie';

  @override
  String get navClaims => 'Roszczenia';

  @override
  String get navPickups => 'Odbiory';

  @override
  String get navReports => 'Raporty';

  @override
  String get navHts => 'Wyszukiwanie HTS';

  @override
  String get navSectionManage => 'Śledzenie i zarządzanie';

  @override
  String get navSectionTools => 'Narzędzia';

  @override
  String get drawerUnpair => 'Odłącz to urządzenie';

  @override
  String get statusPreTransit => 'Przed wysyłką';

  @override
  String get statusInTransit => 'W drodze';

  @override
  String get statusOutForDelivery => 'W doręczeniu';

  @override
  String get statusDelivered => 'Doręczono';

  @override
  String get statusAvailableForPickup => 'Do odbioru';

  @override
  String get statusReturnToSender => 'Zwrot do nadawcy';

  @override
  String get statusFailure => 'Niepowodzenie';

  @override
  String get statusCancelled => 'Anulowano';

  @override
  String get statusError => 'Błąd';

  @override
  String get statusUnknown => 'Nieznane';

  @override
  String get carrierUnknown => 'Nieznany przewoźnik';

  @override
  String get carrierUnknownShort => 'Nieznany';

  @override
  String get sortTooltip => 'Sortuj';

  @override
  String get sortByStatus => 'Sortuj według statusu';

  @override
  String get sortByCarrier => 'Sortuj według przewoźnika';

  @override
  String get sortByCode => 'Sortuj według numeru śledzenia';

  @override
  String get sortByUpdated => 'Sortuj według ostatniej aktualizacji';

  @override
  String get filterTooltip => 'Filtruj';

  @override
  String get filterHideDelivered => 'Ukryj doręczone';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Przewoźnik';

  @override
  String get filterReset => 'Wyczyść filtry';

  @override
  String get trackersEmpty => 'Żadna przesyłka nie jest jeszcze śledzona.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Widoczne $shown z $total';
  }

  @override
  String get trackersNoMatch => 'Nic nie pasuje do bieżących filtrów.';

  @override
  String etaLabel(String date) {
    return 'Przew. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Przewidywane doręczenie $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Podpisano przez $name';
  }

  @override
  String get detailHistoryHeading => 'Historia';

  @override
  String get detailNoScanHistory => 'Brak zarejestrowanych skanów.';

  @override
  String get detailMapUnavailable => 'Mapa niedostępna dla tych lokalizacji.';

  @override
  String get historyEmpty => 'Brak przesyłek.';

  @override
  String get insuranceEmpty => 'Brak polis. Dotknij „Kup ubezpieczenie”.';

  @override
  String get insuranceBuy => 'Kup ubezpieczenie';

  @override
  String get insuranceAmountRange =>
      'Suma ubezpieczenia musi mieścić się między 0,01 a 5000 USD.';

  @override
  String get insuranceNotEnabled =>
      'To konto EasyPost nie ma włączonego samodzielnego ubezpieczenia. Poproś pomoc techniczną EasyPost o włączenie tej opcji lub dodaj ubezpieczenie przy zakupie etykiety.';

  @override
  String get insuranceFromAddress => 'Adres nadawcy';

  @override
  String get insuranceToAddress => 'Adres odbiorcy';

  @override
  String get fieldTrackingCode => 'Numer śledzenia';

  @override
  String get fieldCarrierHint => 'Przewoźnik (np. USPS)';

  @override
  String get fieldInsuredAmount => 'Suma ubezpieczenia (USD)';

  @override
  String get fieldName => 'Nazwa';

  @override
  String get fieldStreet => 'Ulica';

  @override
  String get fieldCity => 'Miasto';

  @override
  String get fieldStateRegion => 'Stan / region';

  @override
  String get fieldPostcode => 'Kod pocztowy';

  @override
  String get fieldCountryIso => 'Kraj (ISO, np. US)';

  @override
  String get fieldType => 'Typ';

  @override
  String get fieldAmountUsd => 'Kwota (USD)';

  @override
  String get fieldContactEmail => 'E-mail kontaktowy';

  @override
  String get fieldDescription => 'Opis';

  @override
  String get validationRequired => 'Wymagane';

  @override
  String get validationEnterAmount => 'Podaj kwotę';

  @override
  String get validationEnterEmail => 'Podaj adres e-mail';

  @override
  String get validationDescribeIssue => 'Opisz problem';

  @override
  String get claimsEmpty => 'Brak roszczeń. Dotknij „Złóż roszczenie”.';

  @override
  String get claimsFile => 'Złóż roszczenie';

  @override
  String get claimSubmit => 'Wyślij roszczenie';

  @override
  String get claimTypeDamage => 'Uszkodzenie';

  @override
  String get claimTypeTheft => 'Kradzież';

  @override
  String get claimTypeLoss => 'Zagubienie';

  @override
  String get claimAttachmentNote =>
      'Roszczenia z tytułu uszkodzenia i kradzieży wymagają zdjęcia lub faktury jako dowodu. Złóż je w aplikacji na komputer, gdzie można dołączyć dokumenty.';

  @override
  String get claimAttachmentSnack =>
      'Roszczenia z tytułu uszkodzenia i kradzieży wymagają dowodu, który można dołączyć tylko w aplikacji na komputer. Roszczenie z tytułu zagubienia można złożyć tutaj.';

  @override
  String get pickupsEmpty => 'Nie zaplanowano jeszcze żadnych odbiorów.';

  @override
  String get pickupCancelTitle => 'Anulować odbiór?';

  @override
  String pickupCancelBody(String id) {
    return 'Anulować odbiór $id? Tej operacji nie można cofnąć.';
  }

  @override
  String get pickupKeep => 'Zachowaj';

  @override
  String get pickupCancelConfirm => 'Anuluj odbiór';

  @override
  String get actionCancel => 'Anuluj';

  @override
  String get reportsShipments => 'Przesyłki';

  @override
  String get reportsTotalSpend => 'Łączne wydatki';

  @override
  String get reportsByCarrier => 'Według przewoźnika';

  @override
  String get reportsEmpty => 'Brak zakupionych przesyłek do zaraportowania.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Przesyłki: $count';
  }

  @override
  String get htsSearchLabel => 'Szukaj kodów taryfowych';

  @override
  String get htsSearchHint => 'np. drut miedziany';

  @override
  String get htsSearchButton => 'Szukaj';

  @override
  String get htsDisclaimer =>
      'Wyszukiwanie referencyjne w U.S. International Trade Commission. Prawidłowa klasyfikacja pozostaje obowiązkiem nadawcy.';

  @override
  String get htsPrompt => 'Wyszukaj kod taryfowy powyżej.';

  @override
  String get htsNoResults => 'Brak pasujących kodów taryfowych.';

  @override
  String htsRateGeneral(String rate) {
    return 'Ogólna $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Preferencyjna $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Inna $rate';
  }

  @override
  String get htsCopyTooltip => 'Kopiuj kod';

  @override
  String htsCopied(String code) {
    return 'Skopiowano $code';
  }

  @override
  String htsUnavailable(int code) {
    return 'Usługa taryfowa jest niedostępna (błąd $code). Spróbuj ponownie.';
  }

  @override
  String get pairTitle => 'Sparuj z komputerem';

  @override
  String get pairInstructions =>
      'Otwórz Easy-Post Desktop, wybierz „Sparuj aplikację mobilną” i zeskanuj wyświetlony kod QR.';

  @override
  String get pairEnterReviewCode => 'Zamiast tego wpisz kod recenzenta';

  @override
  String get pairReviewDialogTitle => 'Wpisz kod recenzenta';

  @override
  String get pairReviewCodeHint => 'Kod recenzenta';

  @override
  String get pairAction => 'Sparuj';

  @override
  String get errorPairingCodeInvalid =>
      'Ten kod parowania jest nieprawidłowy lub wygasł. Wygeneruj nowy na komputerze.';

  @override
  String get errorReviewCodeRejected =>
      'Ten kod recenzenta nie został przyjęty.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Nieoczekiwana odpowiedź usługi parowania.';

  @override
  String get errorNotPaired =>
      'To urządzenie nie jest już sparowane. Sparuj je ponownie z komputera.';

  @override
  String get errorNotPairedShort => 'To urządzenie nie jest już sparowane.';

  @override
  String get errorForbidden =>
      'Ta operacja nie jest dozwolona z poziomu aplikacji.';

  @override
  String errorRequestFailed(int code) {
    return 'Żądanie nie powiodło się (błąd $code).';
  }
}

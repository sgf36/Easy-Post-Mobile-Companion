// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Παρακολούθηση';

  @override
  String get navHistory => 'Ιστορικό';

  @override
  String get navInsurance => 'Ασφάλιση';

  @override
  String get navClaims => 'Αιτήματα αποζημίωσης';

  @override
  String get navPickups => 'Παραλαβές';

  @override
  String get navReports => 'Αναφορές';

  @override
  String get navHts => 'Αναζήτηση HTS';

  @override
  String get navSectionManage => 'Παρακολούθηση και διαχείριση';

  @override
  String get navSectionTools => 'Εργαλεία';

  @override
  String get drawerUnpair => 'Αποσύνδεση αυτής της συσκευής';

  @override
  String get statusPreTransit => 'Πριν τη μεταφορά';

  @override
  String get statusInTransit => 'Σε μεταφορά';

  @override
  String get statusOutForDelivery => 'Προς παράδοση';

  @override
  String get statusDelivered => 'Παραδόθηκε';

  @override
  String get statusAvailableForPickup => 'Διαθέσιμο για παραλαβή';

  @override
  String get statusReturnToSender => 'Επιστροφή στον αποστολέα';

  @override
  String get statusFailure => 'Απέτυχε';

  @override
  String get statusCancelled => 'Ακυρώθηκε';

  @override
  String get statusError => 'Σφάλμα';

  @override
  String get statusUnknown => 'Άγνωστο';

  @override
  String get carrierUnknown => 'Άγνωστος μεταφορέας';

  @override
  String get carrierUnknownShort => 'Άγνωστο';

  @override
  String get sortTooltip => 'Ταξινόμηση';

  @override
  String get sortByStatus => 'Ταξινόμηση κατά κατάσταση';

  @override
  String get sortByCarrier => 'Ταξινόμηση κατά μεταφορέα';

  @override
  String get sortByCode => 'Ταξινόμηση κατά κωδικό παρακολούθησης';

  @override
  String get sortByUpdated => 'Ταξινόμηση κατά πρόσφατη ενημέρωση';

  @override
  String get filterTooltip => 'Φίλτρο';

  @override
  String get filterHideDelivered => 'Απόκρυψη παραδομένων';

  @override
  String get filterStatusHeading => 'Κατάσταση';

  @override
  String get filterCarrierHeading => 'Μεταφορέας';

  @override
  String get filterReset => 'Επαναφορά φίλτρων';

  @override
  String get trackersEmpty => 'Δεν παρακολουθείται ακόμη καμία αποστολή.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Εμφανίζονται $shown από $total';
  }

  @override
  String get trackersNoMatch => 'Τίποτα δεν ταιριάζει στα τρέχοντα φίλτρα.';

  @override
  String etaLabel(String date) {
    return 'Εκτ. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Εκτιμώμενη παράδοση $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Υπογραφή από $name';
  }

  @override
  String get detailHistoryHeading => 'Ιστορικό';

  @override
  String get detailNoScanHistory => 'Δεν υπάρχουν ακόμη σαρώσεις.';

  @override
  String get detailMapUnavailable =>
      'Ο χάρτης δεν είναι διαθέσιμος για αυτές τις τοποθεσίες.';

  @override
  String get historyEmpty => 'Δεν υπάρχουν ακόμη αποστολές.';

  @override
  String get insuranceEmpty => 'Δεν υπάρχουν ακόμη ασφαλιστήρια.';

  @override
  String get insuranceBuy => 'Αγορά ασφάλισης';

  @override
  String get insuranceAmountRange =>
      'Το ασφαλισμένο ποσό πρέπει να είναι μεταξύ 0,01 και 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Αυτός ο λογαριασμός EasyPost δεν είναι ενεργοποιημένος για ανεξάρτητη ασφάλιση. Ζητήστε από την υποστήριξη EasyPost να την ενεργοποιήσει ή προσθέστε ασφάλιση κατά την αγορά της ετικέτας.';

  @override
  String get insuranceFromAddress => 'Διεύθυνση αποστολέα';

  @override
  String get insuranceToAddress => 'Διεύθυνση παραλήπτη';

  @override
  String get fieldTrackingCode => 'Κωδικός παρακολούθησης';

  @override
  String get fieldCarrierHint => 'Μεταφορέας (π.χ. USPS)';

  @override
  String get fieldInsuredAmount => 'Ασφαλισμένο ποσό (USD)';

  @override
  String get fieldName => 'Όνομα';

  @override
  String get fieldStreet => 'Οδός';

  @override
  String get fieldCity => 'Πόλη';

  @override
  String get fieldStateRegion => 'Πολιτεία / περιφέρεια';

  @override
  String get fieldPostcode => 'Ταχυδρομικός κώδικας';

  @override
  String get fieldCountryIso => 'Χώρα (ISO, π.χ. US)';

  @override
  String get fieldType => 'Τύπος';

  @override
  String get fieldAmountUsd => 'Ποσό (USD)';

  @override
  String get fieldContactEmail => 'Email επικοινωνίας';

  @override
  String get fieldDescription => 'Περιγραφή';

  @override
  String get validationRequired => 'Απαιτείται';

  @override
  String get validationEnterAmount => 'Εισαγάγετε ποσό';

  @override
  String get validationEnterEmail => 'Εισαγάγετε email';

  @override
  String get validationDescribeIssue => 'Περιγράψτε το πρόβλημα';

  @override
  String get claimsEmpty => 'Δεν υπάρχουν ακόμη αιτήματα.';

  @override
  String get claimsFile => 'Υποβολή αιτήματος';

  @override
  String get claimSubmit => 'Αποστολή αιτήματος';

  @override
  String get claimTypeDamage => 'Ζημιά';

  @override
  String get claimTypeTheft => 'Κλοπή';

  @override
  String get claimTypeLoss => 'Απώλεια';

  @override
  String get claimAttachmentNote =>
      'Τα αιτήματα για ζημιά και κλοπή απαιτούν φωτογραφία ή τιμολόγιο ως δικαιολογητικό. Υποβάλετέ τα από την εφαρμογή υπολογιστή, όπου μπορούν να επισυναφθούν έγγραφα.';

  @override
  String get claimAttachmentSnack =>
      'Τα αιτήματα για ζημιά και κλοπή απαιτούν δικαιολογητικό, το οποίο επισυνάπτεται μόνο από την εφαρμογή υπολογιστή. Αίτημα για απώλεια μπορεί να υποβληθεί εδώ.';

  @override
  String get pickupsEmpty => 'Δεν έχει προγραμματιστεί ακόμη καμία παραλαβή.';

  @override
  String get pickupCancelTitle => 'Ακύρωση παραλαβής;';

  @override
  String pickupCancelBody(String id) {
    return 'Ακύρωση της παραλαβής $id; Η ενέργεια δεν αναιρείται.';
  }

  @override
  String get pickupKeep => 'Διατήρηση';

  @override
  String get pickupCancelConfirm => 'Ακύρωση παραλαβής';

  @override
  String get actionCancel => 'Ακύρωση';

  @override
  String get reportsShipments => 'Αποστολές';

  @override
  String get reportsTotalSpend => 'Συνολικές δαπάνες';

  @override
  String get reportsByCarrier => 'Ανά μεταφορέα';

  @override
  String get reportsEmpty =>
      'Δεν υπάρχουν ακόμη αγορασμένες αποστολές για αναφορά.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Αποστολές: $count';
  }

  @override
  String get htsSearchLabel => 'Αναζήτηση δασμολογικών κωδικών';

  @override
  String get htsSearchHint => 'π.χ. χάλκινο σύρμα';

  @override
  String get htsSearchButton => 'Αναζήτηση';

  @override
  String get htsDisclaimer =>
      'Αναζήτηση αναφοράς από την U.S. International Trade Commission. Η σωστή κατάταξη παραμένει ευθύνη του αποστολέα.';

  @override
  String get htsPrompt => 'Αναζητήστε έναν δασμολογικό κωδικό παραπάνω.';

  @override
  String get htsNoResults => 'Δεν βρέθηκαν αντίστοιχοι δασμολογικοί κωδικοί.';

  @override
  String htsRateGeneral(String rate) {
    return 'Γενικός $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Ειδικός $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Άλλος $rate';
  }

  @override
  String get htsCopyTooltip => 'Αντιγραφή κωδικού';

  @override
  String htsCopied(String code) {
    return 'Αντιγράφηκε $code';
  }

  @override
  String htsUnavailable(int code) {
    return 'Η δασμολογική υπηρεσία δεν είναι διαθέσιμη (σφάλμα $code). Δοκιμάστε ξανά.';
  }

  @override
  String get pairTitle => 'Σύζευξη με τον υπολογιστή';

  @override
  String get pairInstructions =>
      'Ανοίξτε το Easy-Post Desktop, επιλέξτε «Σύζευξη εφαρμογής κινητού» και σαρώστε τον κωδικό QR που εμφανίζεται.';

  @override
  String get pairEnterReviewCode => 'Εισαγωγή κωδικού αξιολόγησης';

  @override
  String get pairReviewDialogTitle => 'Εισαγωγή κωδικού αξιολόγησης';

  @override
  String get pairReviewCodeHint => 'Κωδικός αξιολόγησης';

  @override
  String get pairAction => 'Σύζευξη';

  @override
  String get errorPairingCodeInvalid =>
      'Αυτός ο κωδικός σύζευξης δεν είναι έγκυρος ή έχει λήξει. Δημιουργήστε νέον στον υπολογιστή.';

  @override
  String get errorReviewCodeRejected =>
      'Αυτός ο κωδικός αξιολόγησης δεν έγινε δεκτός.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Μη αναμενόμενη απάντηση από την υπηρεσία σύζευξης.';

  @override
  String get errorNotPaired =>
      'Αυτή η συσκευή δεν είναι πλέον συζευγμένη. Επαναλάβετε τη σύζευξη από τον υπολογιστή.';

  @override
  String get errorNotPairedShort =>
      'Αυτή η συσκευή δεν είναι πλέον συζευγμένη.';

  @override
  String get errorForbidden =>
      'Αυτή η ενέργεια δεν επιτρέπεται από την εφαρμογή.';

  @override
  String errorRequestFailed(int code) {
    return 'Το αίτημα απέτυχε (σφάλμα $code).';
  }

  @override
  String get detailShipment => 'Αποστολή';

  @override
  String get detailInsurancePolicy => 'Ασφαλιστήριο';

  @override
  String get detailClaim => 'Απαίτηση';

  @override
  String get detailPickup => 'Παραλαβή';

  @override
  String get fieldCarrier => 'Μεταφορέας';

  @override
  String get fieldService => 'Υπηρεσία';

  @override
  String get fieldStatus => 'Κατάσταση';

  @override
  String get fieldCreated => 'Δημιουργήθηκε';

  @override
  String get fieldAmount => 'Ποσό';

  @override
  String get fieldProvider => 'Πάροχος';

  @override
  String get fieldReference => 'Αναφορά';

  @override
  String get fieldPickupWindow => 'Χρονικό παράθυρο παραλαβής';

  @override
  String get fieldCost => 'Κόστος';

  @override
  String get detailNothingFurther => 'Δεν υπάρχουν περισσότερες λεπτομέρειες.';

  @override
  String get navRefunds => 'Επιστροφές χρημάτων';

  @override
  String get refundsEmpty => 'Δεν έχει ζητηθεί ακόμη καμία επιστροφή χρημάτων.';

  @override
  String get detailRefund => 'Αίτημα επιστροφής χρημάτων';

  @override
  String get fieldRefundStatus => 'Επιστροφή χρημάτων';

  @override
  String get refundStatusSubmitted => 'Υποβλήθηκε';

  @override
  String get refundStatusRefunded => 'Επιστράφηκε';

  @override
  String get refundStatusRejected => 'Απορρίφθηκε';
}

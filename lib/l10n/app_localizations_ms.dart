// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Penjejakan';

  @override
  String get navHistory => 'Sejarah';

  @override
  String get navInsurance => 'Insurans';

  @override
  String get navClaims => 'Tuntutan';

  @override
  String get navPickups => 'Pengambilan';

  @override
  String get navReports => 'Laporan';

  @override
  String get navHts => 'Carian HTS';

  @override
  String get navSectionManage => 'Jejak dan urus';

  @override
  String get navSectionTools => 'Alat';

  @override
  String get drawerUnpair => 'Nyahgandingkan peranti ini';

  @override
  String get statusPreTransit => 'Sebelum penghantaran';

  @override
  String get statusInTransit => 'Dalam penghantaran';

  @override
  String get statusOutForDelivery => 'Dalam penghantaran akhir';

  @override
  String get statusDelivered => 'Dihantar';

  @override
  String get statusAvailableForPickup => 'Sedia untuk diambil';

  @override
  String get statusReturnToSender => 'Dikembalikan kepada penghantar';

  @override
  String get statusFailure => 'Gagal';

  @override
  String get statusCancelled => 'Dibatalkan';

  @override
  String get statusError => 'Ralat';

  @override
  String get statusUnknown => 'Tidak diketahui';

  @override
  String get carrierUnknown => 'Syarikat penghantaran tidak diketahui';

  @override
  String get carrierUnknownShort => 'Tidak diketahui';

  @override
  String get sortTooltip => 'Isih';

  @override
  String get sortByStatus => 'Isih mengikut status';

  @override
  String get sortByCarrier => 'Isih mengikut syarikat penghantaran';

  @override
  String get sortByCode => 'Isih mengikut kod penjejakan';

  @override
  String get sortByUpdated => 'Isih mengikut kemas kini terkini';

  @override
  String get filterTooltip => 'Tapis';

  @override
  String get filterHideDelivered => 'Sembunyikan yang dihantar';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Syarikat penghantaran';

  @override
  String get filterReset => 'Set semula penapis';

  @override
  String get trackersEmpty => 'Belum ada penghantaran yang dijejak.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Memaparkan $shown daripada $total';
  }

  @override
  String get trackersNoMatch => 'Tiada yang sepadan dengan penapis semasa.';

  @override
  String etaLabel(String date) {
    return 'Angg. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Anggaran penghantaran $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Ditandatangani oleh $name';
  }

  @override
  String get detailHistoryHeading => 'Sejarah';

  @override
  String get detailNoScanHistory => 'Belum ada rekod imbasan.';

  @override
  String get detailMapUnavailable => 'Peta tidak tersedia untuk lokasi ini.';

  @override
  String get historyEmpty => 'Belum ada penghantaran.';

  @override
  String get insuranceEmpty => 'Belum ada polisi. Ketik «Beli insurans».';

  @override
  String get insuranceBuy => 'Beli insurans';

  @override
  String get insuranceAmountRange =>
      'Nilai dilindungi mestilah antara 0.01 dan 5,000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Akaun EasyPost ini tidak didayakan untuk insurans berasingan. Minta sokongan EasyPost mendayakannya, atau tambah insurans semasa membeli label.';

  @override
  String get insuranceFromAddress => 'Alamat penghantar';

  @override
  String get insuranceToAddress => 'Alamat penerima';

  @override
  String get fieldTrackingCode => 'Kod penjejakan';

  @override
  String get fieldCarrierHint => 'Syarikat penghantaran (cth. USPS)';

  @override
  String get fieldInsuredAmount => 'Nilai dilindungi (USD)';

  @override
  String get fieldName => 'Nama';

  @override
  String get fieldStreet => 'Jalan';

  @override
  String get fieldCity => 'Bandar';

  @override
  String get fieldStateRegion => 'Negeri / wilayah';

  @override
  String get fieldPostcode => 'Poskod';

  @override
  String get fieldCountryIso => 'Negara (ISO, cth. US)';

  @override
  String get fieldType => 'Jenis';

  @override
  String get fieldAmountUsd => 'Jumlah (USD)';

  @override
  String get fieldContactEmail => 'E-mel hubungan';

  @override
  String get fieldDescription => 'Penerangan';

  @override
  String get validationRequired => 'Diperlukan';

  @override
  String get validationEnterAmount => 'Masukkan jumlah';

  @override
  String get validationEnterEmail => 'Masukkan e-mel';

  @override
  String get validationDescribeIssue => 'Terangkan masalahnya';

  @override
  String get claimsEmpty => 'Belum ada tuntutan. Ketik «Failkan tuntutan».';

  @override
  String get claimsFile => 'Failkan tuntutan';

  @override
  String get claimSubmit => 'Hantar tuntutan';

  @override
  String get claimTypeDamage => 'Kerosakan';

  @override
  String get claimTypeTheft => 'Kecurian';

  @override
  String get claimTypeLoss => 'Kehilangan';

  @override
  String get claimAttachmentNote =>
      'Tuntutan kerosakan dan kecurian memerlukan foto atau invois sebagai bukti. Failkannya dalam aplikasi desktop, tempat dokumen boleh dilampirkan.';

  @override
  String get claimAttachmentSnack =>
      'Tuntutan kerosakan dan kecurian memerlukan bukti yang hanya boleh dilampirkan dalam aplikasi desktop. Tuntutan kehilangan boleh difailkan di sini.';

  @override
  String get pickupsEmpty => 'Belum ada pengambilan dijadualkan.';

  @override
  String get pickupCancelTitle => 'Batalkan pengambilan?';

  @override
  String pickupCancelBody(String id) {
    return 'Batalkan pengambilan $id? Tindakan ini tidak boleh dibatalkan.';
  }

  @override
  String get pickupKeep => 'Kekalkan';

  @override
  String get pickupCancelConfirm => 'Batalkan pengambilan';

  @override
  String get actionCancel => 'Batal';

  @override
  String get reportsShipments => 'Penghantaran';

  @override
  String get reportsTotalSpend => 'Jumlah perbelanjaan';

  @override
  String get reportsByCarrier => 'Mengikut syarikat penghantaran';

  @override
  String get reportsEmpty => 'Belum ada penghantaran dibeli untuk dilaporkan.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Penghantaran: $count';
  }

  @override
  String get htsSearchLabel => 'Cari kod tarif';

  @override
  String get htsSearchHint => 'cth. dawai tembaga';

  @override
  String get htsSearchButton => 'Cari';

  @override
  String get htsDisclaimer =>
      'Carian rujukan daripada U.S. International Trade Commission. Pengelasan yang betul kekal menjadi tanggungjawab penghantar.';

  @override
  String get htsPrompt => 'Cari kod tarif di atas.';

  @override
  String get htsNoResults => 'Tiada kod tarif yang sepadan.';

  @override
  String htsRateGeneral(String rate) {
    return 'Umum $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Khas $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Lain $rate';
  }

  @override
  String get htsCopyTooltip => 'Salin kod';

  @override
  String htsCopied(String code) {
    return '$code disalin';
  }

  @override
  String htsUnavailable(int code) {
    return 'Perkhidmatan tarif tidak tersedia (ralat $code). Sila cuba lagi.';
  }

  @override
  String get pairTitle => 'Gandingkan dengan desktop';

  @override
  String get pairInstructions =>
      'Buka Easy-Post Desktop, pilih «Gandingkan aplikasi mudah alih», kemudian imbas kod QR yang dipaparkan.';

  @override
  String get pairEnterReviewCode => 'Masukkan kod semakan sebaliknya';

  @override
  String get pairReviewDialogTitle => 'Masukkan kod semakan';

  @override
  String get pairReviewCodeHint => 'Kod semakan';

  @override
  String get pairAction => 'Gandingkan';

  @override
  String get errorPairingCodeInvalid =>
      'Kod gandingan ini tidak sah atau telah tamat tempoh. Jana yang baharu pada desktop.';

  @override
  String get errorReviewCodeRejected => 'Kod semakan ini tidak diterima.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Respons tidak dijangka daripada perkhidmatan gandingan.';

  @override
  String get errorNotPaired =>
      'Peranti ini tidak lagi digandingkan. Gandingkannya semula dari desktop.';

  @override
  String get errorNotPairedShort => 'Peranti ini tidak lagi digandingkan.';

  @override
  String get errorForbidden =>
      'Tindakan itu tidak dibenarkan daripada aplikasi.';

  @override
  String errorRequestFailed(int code) {
    return 'Permintaan gagal (ralat $code).';
  }

  @override
  String get detailShipment => 'Penghantaran';

  @override
  String get detailInsurancePolicy => 'Polisi insurans';

  @override
  String get detailClaim => 'Tuntutan';

  @override
  String get detailPickup => 'Pengambilan';

  @override
  String get fieldCarrier => 'Kurier';

  @override
  String get fieldService => 'Perkhidmatan';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldCreated => 'Dicipta';

  @override
  String get fieldAmount => 'Jumlah';

  @override
  String get fieldProvider => 'Penyedia';

  @override
  String get fieldReference => 'Rujukan';

  @override
  String get fieldPickupWindow => 'Tempoh pengambilan';

  @override
  String get fieldCost => 'Kos';

  @override
  String get detailNothingFurther => 'Tiada butiran lanjut.';
}

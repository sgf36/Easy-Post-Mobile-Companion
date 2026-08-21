// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Pelacakan';

  @override
  String get navHistory => 'Riwayat';

  @override
  String get navInsurance => 'Asuransi';

  @override
  String get navClaims => 'Klaim';

  @override
  String get navPickups => 'Penjemputan';

  @override
  String get navReports => 'Laporan';

  @override
  String get navHts => 'Pencarian HTS';

  @override
  String get navSectionManage => 'Lacak dan kelola';

  @override
  String get navSectionTools => 'Alat';

  @override
  String get drawerUnpair => 'Putuskan pasangan perangkat ini';

  @override
  String get statusPreTransit => 'Sebelum pengiriman';

  @override
  String get statusInTransit => 'Dalam pengiriman';

  @override
  String get statusOutForDelivery => 'Sedang diantar';

  @override
  String get statusDelivered => 'Terkirim';

  @override
  String get statusAvailableForPickup => 'Siap diambil';

  @override
  String get statusReturnToSender => 'Dikembalikan ke pengirim';

  @override
  String get statusFailure => 'Gagal';

  @override
  String get statusCancelled => 'Dibatalkan';

  @override
  String get statusError => 'Kesalahan';

  @override
  String get statusUnknown => 'Tidak diketahui';

  @override
  String get carrierUnknown => 'Kurir tidak diketahui';

  @override
  String get carrierUnknownShort => 'Tidak diketahui';

  @override
  String get sortTooltip => 'Urutkan';

  @override
  String get sortByStatus => 'Urutkan menurut status';

  @override
  String get sortByCarrier => 'Urutkan menurut kurir';

  @override
  String get sortByCode => 'Urutkan menurut nomor resi';

  @override
  String get sortByUpdated => 'Urutkan menurut pembaruan terbaru';

  @override
  String get filterTooltip => 'Filter';

  @override
  String get filterHideDelivered => 'Sembunyikan yang terkirim';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Kurir';

  @override
  String get filterReset => 'Atur ulang filter';

  @override
  String get trackersEmpty => 'Belum ada pengiriman yang dilacak.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Menampilkan $shown dari $total';
  }

  @override
  String get trackersNoMatch => 'Tidak ada yang cocok dengan filter saat ini.';

  @override
  String etaLabel(String date) {
    return 'Perk. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Estimasi pengiriman $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Ditandatangani oleh $name';
  }

  @override
  String get detailHistoryHeading => 'Riwayat';

  @override
  String get detailNoScanHistory => 'Belum ada catatan pemindaian.';

  @override
  String get detailMapUnavailable => 'Peta tidak tersedia untuk lokasi ini.';

  @override
  String get historyEmpty => 'Belum ada pengiriman.';

  @override
  String get insuranceEmpty => 'Belum ada polis.';

  @override
  String get insuranceBuy => 'Beli asuransi';

  @override
  String get insuranceAmountRange =>
      'Nilai pertanggungan harus antara 0,01 dan 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Akun EasyPost ini tidak diaktifkan untuk asuransi mandiri. Minta dukungan EasyPost mengaktifkannya, atau tambahkan asuransi saat membeli label.';

  @override
  String get insuranceFromAddress => 'Alamat pengirim';

  @override
  String get insuranceToAddress => 'Alamat penerima';

  @override
  String get fieldTrackingCode => 'Nomor resi';

  @override
  String get fieldCarrierHint => 'Kurir (mis. USPS)';

  @override
  String get fieldInsuredAmount => 'Nilai pertanggungan (USD)';

  @override
  String get fieldName => 'Nama';

  @override
  String get fieldStreet => 'Jalan';

  @override
  String get fieldCity => 'Kota';

  @override
  String get fieldStateRegion => 'Negara bagian / wilayah';

  @override
  String get fieldPostcode => 'Kode pos';

  @override
  String get fieldCountryIso => 'Negara (ISO, mis. US)';

  @override
  String get fieldType => 'Jenis';

  @override
  String get fieldAmountUsd => 'Jumlah (USD)';

  @override
  String get fieldContactEmail => 'Email kontak';

  @override
  String get fieldDescription => 'Deskripsi';

  @override
  String get validationRequired => 'Wajib diisi';

  @override
  String get validationEnterAmount => 'Masukkan jumlah';

  @override
  String get validationEnterEmail => 'Masukkan email';

  @override
  String get validationDescribeIssue => 'Jelaskan masalahnya';

  @override
  String get claimsEmpty => 'Belum ada klaim.';

  @override
  String get claimsFile => 'Ajukan klaim';

  @override
  String get claimSubmit => 'Kirim klaim';

  @override
  String get claimTypeDamage => 'Kerusakan';

  @override
  String get claimTypeTheft => 'Pencurian';

  @override
  String get claimTypeLoss => 'Kehilangan';

  @override
  String get claimAttachmentNote =>
      'Klaim kerusakan dan pencurian memerlukan foto atau faktur sebagai bukti. Ajukan lewat aplikasi desktop, tempat dokumen dapat dilampirkan.';

  @override
  String get claimAttachmentSnack =>
      'Klaim kerusakan dan pencurian memerlukan bukti yang hanya dapat dilampirkan di aplikasi desktop. Klaim kehilangan dapat diajukan di sini.';

  @override
  String get pickupsEmpty => 'Belum ada penjemputan terjadwal.';

  @override
  String get pickupCancelTitle => 'Batalkan penjemputan?';

  @override
  String pickupCancelBody(String id) {
    return 'Batalkan penjemputan $id? Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String get pickupKeep => 'Pertahankan';

  @override
  String get pickupCancelConfirm => 'Batalkan penjemputan';

  @override
  String get actionCancel => 'Batal';

  @override
  String get reportsShipments => 'Pengiriman';

  @override
  String get reportsTotalSpend => 'Total pengeluaran';

  @override
  String get reportsByCarrier => 'Per kurir';

  @override
  String get reportsEmpty => 'Belum ada pengiriman terbeli untuk dilaporkan.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Pengiriman: $count';
  }

  @override
  String get htsSearchLabel => 'Cari kode tarif';

  @override
  String get htsSearchHint => 'mis. kawat tembaga';

  @override
  String get htsSearchButton => 'Cari';

  @override
  String get htsDisclaimer =>
      'Pencarian rujukan dari U.S. International Trade Commission. Klasifikasi yang benar tetap menjadi tanggung jawab pengirim.';

  @override
  String get htsPrompt => 'Cari kode tarif di atas.';

  @override
  String get htsNoResults => 'Tidak ada kode tarif yang cocok.';

  @override
  String htsRateGeneral(String rate) {
    return 'Umum $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Khusus $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Lainnya $rate';
  }

  @override
  String get htsCopyTooltip => 'Salin kode';

  @override
  String htsCopied(String code) {
    return '$code disalin';
  }

  @override
  String htsUnavailable(int code) {
    return 'Layanan tarif tidak tersedia (kesalahan $code). Silakan coba lagi.';
  }

  @override
  String get pairTitle => 'Pasangkan dengan desktop';

  @override
  String get pairInstructions =>
      'Buka Easy-Post Desktop, pilih «Pasangkan aplikasi seluler», lalu pindai kode QR yang ditampilkan.';

  @override
  String get pairEnterReviewCode => 'Masukkan kode peninjauan saja';

  @override
  String get pairReviewDialogTitle => 'Masukkan kode peninjauan';

  @override
  String get pairReviewCodeHint => 'Kode peninjauan';

  @override
  String get pairAction => 'Pasangkan';

  @override
  String get errorPairingCodeInvalid =>
      'Kode pemasangan ini tidak valid atau telah kedaluwarsa. Buat yang baru di desktop.';

  @override
  String get errorReviewCodeRejected => 'Kode peninjauan ini tidak diterima.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Respons tak terduga dari layanan pemasangan.';

  @override
  String get errorNotPaired =>
      'Perangkat ini tidak lagi terpasang. Pasangkan lagi dari desktop.';

  @override
  String get errorNotPairedShort => 'Perangkat ini tidak lagi terpasang.';

  @override
  String get errorForbidden => 'Tindakan itu tidak diizinkan dari aplikasi.';

  @override
  String errorRequestFailed(int code) {
    return 'Permintaan gagal (kesalahan $code).';
  }

  @override
  String get detailShipment => 'Pengiriman';

  @override
  String get detailInsurancePolicy => 'Polis asuransi';

  @override
  String get detailClaim => 'Klaim';

  @override
  String get detailPickup => 'Penjemputan';

  @override
  String get fieldCarrier => 'Kurir';

  @override
  String get fieldService => 'Layanan';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldCreated => 'Dibuat';

  @override
  String get fieldAmount => 'Jumlah';

  @override
  String get fieldProvider => 'Penyedia';

  @override
  String get fieldReference => 'Referensi';

  @override
  String get fieldPickupWindow => 'Jendela penjemputan';

  @override
  String get fieldCost => 'Biaya';

  @override
  String get detailNothingFurther => 'Tidak ada detail lain.';

  @override
  String get navRefunds => 'Pengembalian dana';

  @override
  String get refundsEmpty => 'Belum ada pengembalian dana yang diminta.';

  @override
  String get detailRefund => 'Permintaan pengembalian dana';

  @override
  String get fieldRefundStatus => 'Pengembalian dana';

  @override
  String get refundStatusSubmitted => 'Dikirim';

  @override
  String get refundStatusRefunded => 'Dikembalikan';

  @override
  String get refundStatusRejected => 'Ditolak';
}

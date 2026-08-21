// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Takip';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navInsurance => 'Sigorta';

  @override
  String get navClaims => 'Hasar/kayıp talepleri';

  @override
  String get navPickups => 'Kargo alımları';

  @override
  String get navReports => 'Raporlar';

  @override
  String get navHts => 'HTS arama';

  @override
  String get navSectionManage => 'Takip ve yönetim';

  @override
  String get navSectionTools => 'Araçlar';

  @override
  String get drawerUnpair => 'Bu cihazın eşleşmesini kaldır';

  @override
  String get statusPreTransit => 'Taşımadan önce';

  @override
  String get statusInTransit => 'Yolda';

  @override
  String get statusOutForDelivery => 'Dağıtımda';

  @override
  String get statusDelivered => 'Teslim edildi';

  @override
  String get statusAvailableForPickup => 'Teslim alınabilir';

  @override
  String get statusReturnToSender => 'Göndericiye iade';

  @override
  String get statusFailure => 'Başarısız';

  @override
  String get statusCancelled => 'İptal edildi';

  @override
  String get statusError => 'Hata';

  @override
  String get statusUnknown => 'Bilinmiyor';

  @override
  String get carrierUnknown => 'Bilinmeyen kargo şirketi';

  @override
  String get carrierUnknownShort => 'Bilinmiyor';

  @override
  String get sortTooltip => 'Sırala';

  @override
  String get sortByStatus => 'Duruma göre sırala';

  @override
  String get sortByCarrier => 'Kargo şirketine göre sırala';

  @override
  String get sortByCode => 'Takip numarasına göre sırala';

  @override
  String get sortByUpdated => 'Son güncellemeye göre sırala';

  @override
  String get filterTooltip => 'Filtrele';

  @override
  String get filterHideDelivered => 'Teslim edilenleri gizle';

  @override
  String get filterStatusHeading => 'Durum';

  @override
  String get filterCarrierHeading => 'Kargo şirketi';

  @override
  String get filterReset => 'Filtreleri sıfırla';

  @override
  String get trackersEmpty => 'Henüz takip edilen gönderi yok.';

  @override
  String trackersShowing(int shown, int total) {
    return '$total gönderiden $shown tanesi gösteriliyor';
  }

  @override
  String get trackersNoMatch => 'Geçerli filtrelerle eşleşen bir şey yok.';

  @override
  String etaLabel(String date) {
    return 'Tahmini $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Tahmini teslimat $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'İmzalayan: $name';
  }

  @override
  String get detailHistoryHeading => 'Geçmiş';

  @override
  String get detailNoScanHistory => 'Henüz okutma kaydı yok.';

  @override
  String get detailMapUnavailable => 'Bu konumlar için harita kullanılamıyor.';

  @override
  String get historyEmpty => 'Henüz gönderi yok.';

  @override
  String get insuranceEmpty => 'Henüz poliçe yok.';

  @override
  String get insuranceBuy => 'Sigorta satın al';

  @override
  String get insuranceAmountRange =>
      'Sigorta tutarı 0,01 ile 5.000 USD arasında olmalıdır.';

  @override
  String get insuranceNotEnabled =>
      'Bu EasyPost hesabı bağımsız sigorta için etkin değil. EasyPost desteğinden etkinleştirmesini isteyin veya etiketi satın alırken sigorta ekleyin.';

  @override
  String get insuranceFromAddress => 'Gönderici adresi';

  @override
  String get insuranceToAddress => 'Alıcı adresi';

  @override
  String get fieldTrackingCode => 'Takip numarası';

  @override
  String get fieldCarrierHint => 'Kargo şirketi (ör. USPS)';

  @override
  String get fieldInsuredAmount => 'Sigorta tutarı (USD)';

  @override
  String get fieldName => 'Ad';

  @override
  String get fieldStreet => 'Sokak';

  @override
  String get fieldCity => 'Şehir';

  @override
  String get fieldStateRegion => 'Eyalet / bölge';

  @override
  String get fieldPostcode => 'Posta kodu';

  @override
  String get fieldCountryIso => 'Ülke (ISO, ör. US)';

  @override
  String get fieldType => 'Tür';

  @override
  String get fieldAmountUsd => 'Tutar (USD)';

  @override
  String get fieldContactEmail => 'İletişim e-postası';

  @override
  String get fieldDescription => 'Açıklama';

  @override
  String get validationRequired => 'Zorunlu';

  @override
  String get validationEnterAmount => 'Bir tutar girin';

  @override
  String get validationEnterEmail => 'Bir e-posta girin';

  @override
  String get validationDescribeIssue => 'Sorunu açıklayın';

  @override
  String get claimsEmpty => 'Henüz talep yok.';

  @override
  String get claimsFile => 'Talep oluştur';

  @override
  String get claimSubmit => 'Talebi gönder';

  @override
  String get claimTypeDamage => 'Hasar';

  @override
  String get claimTypeTheft => 'Hırsızlık';

  @override
  String get claimTypeLoss => 'Kayıp';

  @override
  String get claimAttachmentNote =>
      'Hasar ve hırsızlık talepleri için fotoğraf veya fatura gibi bir belge gerekir. Bunları belge eklenebilen masaüstü uygulamasından oluşturun.';

  @override
  String get claimAttachmentSnack =>
      'Hasar ve hırsızlık talepleri için yalnızca masaüstü uygulamasında eklenebilen bir belge gerekir. Kayıp talebi burada oluşturulabilir.';

  @override
  String get pickupsEmpty => 'Henüz planlanmış kargo alımı yok.';

  @override
  String get pickupCancelTitle => 'Kargo alımı iptal edilsin mi?';

  @override
  String pickupCancelBody(String id) {
    return '$id kargo alımı iptal edilsin mi? Bu işlem geri alınamaz.';
  }

  @override
  String get pickupKeep => 'Vazgeç';

  @override
  String get pickupCancelConfirm => 'Kargo alımını iptal et';

  @override
  String get actionCancel => 'İptal';

  @override
  String get reportsShipments => 'Gönderiler';

  @override
  String get reportsTotalSpend => 'Toplam harcama';

  @override
  String get reportsByCarrier => 'Kargo şirketine göre';

  @override
  String get reportsEmpty => 'Raporlanacak satın alınmış gönderi yok.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Gönderi: $count';
  }

  @override
  String get htsSearchLabel => 'Gümrük tarife kodu ara';

  @override
  String get htsSearchHint => 'ör. bakır tel';

  @override
  String get htsSearchButton => 'Ara';

  @override
  String get htsDisclaimer =>
      'U.S. International Trade Commission kaynaklı referans arama. Doğru sınıflandırma göndericinin sorumluluğundadır.';

  @override
  String get htsPrompt => 'Yukarıdan bir gümrük tarife kodu arayın.';

  @override
  String get htsNoResults => 'Eşleşen gümrük tarife kodu yok.';

  @override
  String htsRateGeneral(String rate) {
    return 'Genel $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Özel $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Diğer $rate';
  }

  @override
  String get htsCopyTooltip => 'Kodu kopyala';

  @override
  String htsCopied(String code) {
    return '$code kopyalandı';
  }

  @override
  String htsUnavailable(int code) {
    return 'Tarife hizmeti kullanılamıyor (hata $code). Lütfen tekrar deneyin.';
  }

  @override
  String get pairTitle => 'Masaüstüyle eşleştir';

  @override
  String get pairInstructions =>
      'Easy-Post Desktop’ı açın, “Mobil uygulamayı eşleştir” seçeneğini seçin ve orada görünen QR kodunu okutun.';

  @override
  String get pairEnterReviewCode => 'Bunun yerine inceleme kodu gir';

  @override
  String get pairReviewDialogTitle => 'İnceleme kodunu girin';

  @override
  String get pairReviewCodeHint => 'İnceleme kodu';

  @override
  String get pairAction => 'Eşleştir';

  @override
  String get errorPairingCodeInvalid =>
      'Bu eşleştirme kodu geçersiz veya süresi dolmuş. Masaüstünde yenisini oluşturun.';

  @override
  String get errorReviewCodeRejected => 'Bu inceleme kodu kabul edilmedi.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Eşleştirme hizmetinden beklenmeyen yanıt.';

  @override
  String get errorNotPaired =>
      'Bu cihaz artık eşleşmiş değil. Masaüstünden yeniden eşleştirin.';

  @override
  String get errorNotPairedShort => 'Bu cihaz artık eşleşmiş değil.';

  @override
  String get errorForbidden => 'Bu işleme uygulamadan izin verilmiyor.';

  @override
  String errorRequestFailed(int code) {
    return 'İstek başarısız oldu (hata $code).';
  }

  @override
  String get detailShipment => 'Gönderi';

  @override
  String get detailInsurancePolicy => 'Sigorta poliçesi';

  @override
  String get detailClaim => 'Talep';

  @override
  String get detailPickup => 'Alım';

  @override
  String get fieldCarrier => 'Taşıyıcı';

  @override
  String get fieldService => 'Hizmet';

  @override
  String get fieldStatus => 'Durum';

  @override
  String get fieldCreated => 'Oluşturuldu';

  @override
  String get fieldAmount => 'Tutar';

  @override
  String get fieldProvider => 'Sağlayıcı';

  @override
  String get fieldReference => 'Referans';

  @override
  String get fieldPickupWindow => 'Alım zaman aralığı';

  @override
  String get fieldCost => 'Maliyet';

  @override
  String get detailNothingFurther => 'Başka ayrıntı yok.';

  @override
  String get navRefunds => 'İadeler';

  @override
  String get refundsEmpty => 'Henüz iade talep edilmedi.';

  @override
  String get detailRefund => 'İade talebi';

  @override
  String get fieldRefundStatus => 'İade';

  @override
  String get refundStatusSubmitted => 'Gönderildi';

  @override
  String get refundStatusRefunded => 'İade edildi';

  @override
  String get refundStatusRejected => 'Reddedildi';
}

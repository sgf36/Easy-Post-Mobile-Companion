// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'التتبع';

  @override
  String get navHistory => 'السجل';

  @override
  String get navInsurance => 'التأمين';

  @override
  String get navClaims => 'المطالبات';

  @override
  String get navPickups => 'الاستلام';

  @override
  String get navReports => 'التقارير';

  @override
  String get navHts => 'بحث HTS';

  @override
  String get navSectionManage => 'التتبع والإدارة';

  @override
  String get navSectionTools => 'الأدوات';

  @override
  String get drawerUnpair => 'إلغاء إقران هذا الجهاز';

  @override
  String get statusPreTransit => 'قبل الشحن';

  @override
  String get statusInTransit => 'قيد الشحن';

  @override
  String get statusOutForDelivery => 'خارج للتسليم';

  @override
  String get statusDelivered => 'تم التسليم';

  @override
  String get statusAvailableForPickup => 'جاهز للاستلام';

  @override
  String get statusReturnToSender => 'إرجاع إلى المرسل';

  @override
  String get statusFailure => 'فشل';

  @override
  String get statusCancelled => 'ملغى';

  @override
  String get statusError => 'خطأ';

  @override
  String get statusUnknown => 'غير معروف';

  @override
  String get carrierUnknown => 'شركة شحن غير معروفة';

  @override
  String get carrierUnknownShort => 'غير معروف';

  @override
  String get sortTooltip => 'ترتيب';

  @override
  String get sortByStatus => 'الترتيب حسب الحالة';

  @override
  String get sortByCarrier => 'الترتيب حسب شركة الشحن';

  @override
  String get sortByCode => 'الترتيب حسب رقم التتبع';

  @override
  String get sortByUpdated => 'الترتيب حسب آخر تحديث';

  @override
  String get filterTooltip => 'تصفية';

  @override
  String get filterHideDelivered => 'إخفاء المسلَّمة';

  @override
  String get filterStatusHeading => 'الحالة';

  @override
  String get filterCarrierHeading => 'شركة الشحن';

  @override
  String get filterReset => 'إعادة ضبط التصفية';

  @override
  String get trackersEmpty => 'لا توجد شحنات متتبَّعة بعد.';

  @override
  String trackersShowing(int shown, int total) {
    return 'عرض $shown من $total';
  }

  @override
  String get trackersNoMatch => 'لا شيء يطابق عوامل التصفية الحالية.';

  @override
  String etaLabel(String date) {
    return 'متوقع $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'التسليم المقدر $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'وقّع بالاستلام $name';
  }

  @override
  String get detailHistoryHeading => 'السجل';

  @override
  String get detailNoScanHistory => 'لا توجد عمليات مسح بعد.';

  @override
  String get detailMapUnavailable => 'الخريطة غير متاحة لهذه المواقع.';

  @override
  String get historyEmpty => 'لا توجد شحنات بعد.';

  @override
  String get insuranceEmpty => 'لا توجد وثائق تأمين بعد. اضغط «شراء التأمين».';

  @override
  String get insuranceBuy => 'شراء التأمين';

  @override
  String get insuranceAmountRange =>
      'يجب أن تتراوح قيمة التأمين بين 0.01 و5000 دولار أمريكي.';

  @override
  String get insuranceNotEnabled =>
      'حساب EasyPost هذا غير مفعَّل للتأمين المستقل. اطلب من دعم EasyPost تفعيله، أو أضف التأمين عند شراء الملصق.';

  @override
  String get insuranceFromAddress => 'عنوان المرسِل';

  @override
  String get insuranceToAddress => 'عنوان المستلِم';

  @override
  String get fieldTrackingCode => 'رقم التتبع';

  @override
  String get fieldCarrierHint => 'شركة الشحن (مثل USPS)';

  @override
  String get fieldInsuredAmount => 'قيمة التأمين (دولار أمريكي)';

  @override
  String get fieldName => 'الاسم';

  @override
  String get fieldStreet => 'الشارع';

  @override
  String get fieldCity => 'المدينة';

  @override
  String get fieldStateRegion => 'الولاية / المنطقة';

  @override
  String get fieldPostcode => 'الرمز البريدي';

  @override
  String get fieldCountryIso => 'الدولة (ISO، مثل US)';

  @override
  String get fieldType => 'النوع';

  @override
  String get fieldAmountUsd => 'المبلغ (دولار أمريكي)';

  @override
  String get fieldContactEmail => 'البريد الإلكتروني للتواصل';

  @override
  String get fieldDescription => 'الوصف';

  @override
  String get validationRequired => 'مطلوب';

  @override
  String get validationEnterAmount => 'أدخل مبلغًا';

  @override
  String get validationEnterEmail => 'أدخل بريدًا إلكترونيًا';

  @override
  String get validationDescribeIssue => 'صف المشكلة';

  @override
  String get claimsEmpty => 'لا توجد مطالبات بعد. اضغط «تقديم مطالبة».';

  @override
  String get claimsFile => 'تقديم مطالبة';

  @override
  String get claimSubmit => 'إرسال المطالبة';

  @override
  String get claimTypeDamage => 'تلف';

  @override
  String get claimTypeTheft => 'سرقة';

  @override
  String get claimTypeLoss => 'فقدان';

  @override
  String get claimAttachmentNote =>
      'تتطلب مطالبات التلف والسرقة صورة أو فاتورة كمستند داعم. قدِّمها من تطبيق سطح المكتب حيث يمكن إرفاق المستندات.';

  @override
  String get claimAttachmentSnack =>
      'تتطلب مطالبات التلف والسرقة مستندًا داعمًا لا يمكن إرفاقه إلا من تطبيق سطح المكتب. أما مطالبة الفقدان فيمكن تقديمها هنا.';

  @override
  String get pickupsEmpty => 'لا توجد عمليات استلام مجدولة بعد.';

  @override
  String get pickupCancelTitle => 'إلغاء الاستلام؟';

  @override
  String pickupCancelBody(String id) {
    return 'إلغاء الاستلام $id؟ لا يمكن التراجع عن ذلك.';
  }

  @override
  String get pickupKeep => 'الإبقاء عليه';

  @override
  String get pickupCancelConfirm => 'إلغاء الاستلام';

  @override
  String get actionCancel => 'إلغاء';

  @override
  String get reportsShipments => 'الشحنات';

  @override
  String get reportsTotalSpend => 'إجمالي الإنفاق';

  @override
  String get reportsByCarrier => 'حسب شركة الشحن';

  @override
  String get reportsEmpty => 'لا توجد شحنات مشتراة لعرضها في التقرير بعد.';

  @override
  String reportsCarrierShipments(int count) {
    return 'الشحنات: $count';
  }

  @override
  String get htsSearchLabel => 'البحث عن رموز التعريفة الجمركية';

  @override
  String get htsSearchHint => 'مثل سلك نحاسي';

  @override
  String get htsSearchButton => 'بحث';

  @override
  String get htsDisclaimer =>
      'بحث مرجعي من U.S. International Trade Commission. يظل التصنيف الصحيح مسؤولية الشاحن.';

  @override
  String get htsPrompt => 'ابحث عن رمز تعريفة جمركية أعلاه.';

  @override
  String get htsNoResults => 'لا توجد رموز تعريفة جمركية مطابقة.';

  @override
  String htsRateGeneral(String rate) {
    return 'عام $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'خاص $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'أخرى $rate';
  }

  @override
  String get htsCopyTooltip => 'نسخ الرمز';

  @override
  String htsCopied(String code) {
    return 'تم نسخ $code';
  }

  @override
  String htsUnavailable(int code) {
    return 'خدمة التعريفة الجمركية غير متاحة (خطأ $code). يُرجى المحاولة مرة أخرى.';
  }

  @override
  String get pairTitle => 'الإقران مع سطح المكتب';

  @override
  String get pairInstructions =>
      'افتح Easy-Post Desktop، واختر «إقران التطبيق المحمول»، ثم امسح رمز QR المعروض هناك.';

  @override
  String get pairEnterReviewCode => 'إدخال رمز المراجعة بدلاً من ذلك';

  @override
  String get pairReviewDialogTitle => 'إدخال رمز المراجعة';

  @override
  String get pairReviewCodeHint => 'رمز المراجعة';

  @override
  String get pairAction => 'إقران';

  @override
  String get errorPairingCodeInvalid =>
      'رمز الإقران هذا غير صالح أو منتهي الصلاحية. أنشئ رمزًا جديدًا على سطح المكتب.';

  @override
  String get errorReviewCodeRejected => 'لم يتم قبول رمز المراجعة هذا.';

  @override
  String get errorUnexpectedPairingResponse =>
      'استجابة غير متوقعة من خدمة الإقران.';

  @override
  String get errorNotPaired =>
      'لم يعد هذا الجهاز مقترنًا. أعد الإقران من سطح المكتب.';

  @override
  String get errorNotPairedShort => 'لم يعد هذا الجهاز مقترنًا.';

  @override
  String get errorForbidden => 'هذا الإجراء غير مسموح به من التطبيق.';

  @override
  String errorRequestFailed(int code) {
    return 'فشل الطلب (خطأ $code).';
  }
}

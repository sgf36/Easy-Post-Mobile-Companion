// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'מעקב';

  @override
  String get navHistory => 'היסטוריה';

  @override
  String get navInsurance => 'ביטוח';

  @override
  String get navClaims => 'תביעות';

  @override
  String get navPickups => 'איסופים';

  @override
  String get navReports => 'דוחות';

  @override
  String get navHts => 'חיפוש HTS';

  @override
  String get navSectionManage => 'מעקב וניהול';

  @override
  String get navSectionTools => 'כלים';

  @override
  String get drawerUnpair => 'ביטול הצימוד של מכשיר זה';

  @override
  String get statusPreTransit => 'לפני משלוח';

  @override
  String get statusInTransit => 'בדרך';

  @override
  String get statusOutForDelivery => 'יצא למסירה';

  @override
  String get statusDelivered => 'נמסר';

  @override
  String get statusAvailableForPickup => 'מוכן לאיסוף';

  @override
  String get statusReturnToSender => 'הוחזר לשולח';

  @override
  String get statusFailure => 'נכשל';

  @override
  String get statusCancelled => 'בוטל';

  @override
  String get statusError => 'שגיאה';

  @override
  String get statusUnknown => 'לא ידוע';

  @override
  String get carrierUnknown => 'חברת שילוח לא ידועה';

  @override
  String get carrierUnknownShort => 'לא ידוע';

  @override
  String get sortTooltip => 'מיון';

  @override
  String get sortByStatus => 'מיון לפי סטטוס';

  @override
  String get sortByCarrier => 'מיון לפי חברת שילוח';

  @override
  String get sortByCode => 'מיון לפי מספר מעקב';

  @override
  String get sortByUpdated => 'מיון לפי עדכון אחרון';

  @override
  String get filterTooltip => 'סינון';

  @override
  String get filterHideDelivered => 'הסתרת משלוחים שנמסרו';

  @override
  String get filterStatusHeading => 'סטטוס';

  @override
  String get filterCarrierHeading => 'חברת שילוח';

  @override
  String get filterReset => 'איפוס הסינון';

  @override
  String get trackersEmpty => 'עדיין לא נעקב אף משלוח.';

  @override
  String trackersShowing(int shown, int total) {
    return 'מוצגים $shown מתוך $total';
  }

  @override
  String get trackersNoMatch => 'אין תוצאות לסינון הנוכחי.';

  @override
  String etaLabel(String date) {
    return 'צפוי $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'אספקה משוערת $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'נחתם על ידי $name';
  }

  @override
  String get detailHistoryHeading => 'היסטוריה';

  @override
  String get detailNoScanHistory => 'אין עדיין סריקות.';

  @override
  String get detailMapUnavailable => 'מפה אינה זמינה עבור מיקומים אלה.';

  @override
  String get historyEmpty => 'אין עדיין משלוחים.';

  @override
  String get insuranceEmpty => 'אין עדיין פוליסות.';

  @override
  String get insuranceBuy => 'רכישת ביטוח';

  @override
  String get insuranceAmountRange =>
      'סכום הביטוח חייב להיות בין 0.01 ל‑5,000 דולר ארה״ב.';

  @override
  String get insuranceNotEnabled =>
      'חשבון EasyPost זה אינו מאושר לביטוח עצמאי. יש לבקש מהתמיכה של EasyPost להפעיל זאת, או להוסיף ביטוח בעת רכישת התווית.';

  @override
  String get insuranceFromAddress => 'כתובת השולח';

  @override
  String get insuranceToAddress => 'כתובת הנמען';

  @override
  String get fieldTrackingCode => 'מספר מעקב';

  @override
  String get fieldCarrierHint => 'חברת שילוח (למשל USPS)';

  @override
  String get fieldInsuredAmount => 'סכום ביטוח (דולר ארה״ב)';

  @override
  String get fieldName => 'שם';

  @override
  String get fieldStreet => 'רחוב';

  @override
  String get fieldCity => 'עיר';

  @override
  String get fieldStateRegion => 'מדינה / אזור';

  @override
  String get fieldPostcode => 'מיקוד';

  @override
  String get fieldCountryIso => 'ארץ (ISO, למשל US)';

  @override
  String get fieldType => 'סוג';

  @override
  String get fieldAmountUsd => 'סכום (דולר ארה״ב)';

  @override
  String get fieldContactEmail => 'אימייל ליצירת קשר';

  @override
  String get fieldDescription => 'תיאור';

  @override
  String get validationRequired => 'שדה חובה';

  @override
  String get validationEnterAmount => 'יש להזין סכום';

  @override
  String get validationEnterEmail => 'יש להזין אימייל';

  @override
  String get validationDescribeIssue => 'יש לתאר את הבעיה';

  @override
  String get claimsEmpty => 'אין עדיין תביעות.';

  @override
  String get claimsFile => 'הגשת תביעה';

  @override
  String get claimSubmit => 'שליחת התביעה';

  @override
  String get claimTypeDamage => 'נזק';

  @override
  String get claimTypeTheft => 'גניבה';

  @override
  String get claimTypeLoss => 'אובדן';

  @override
  String get claimAttachmentNote =>
      'תביעות נזק וגניבה מחייבות תמונה או חשבונית כאסמכתה. יש להגיש אותן ביישום המחשב, שבו אפשר לצרף מסמכים.';

  @override
  String get claimAttachmentSnack =>
      'תביעות נזק וגניבה מחייבות אסמכתה, שניתן לצרף רק ביישום המחשב. תביעת אובדן אפשר להגיש כאן.';

  @override
  String get pickupsEmpty => 'לא נקבעו עדיין איסופים.';

  @override
  String get pickupCancelTitle => 'לבטל את האיסוף?';

  @override
  String pickupCancelBody(String id) {
    return 'לבטל את האיסוף $id? לא ניתן לבטל פעולה זו.';
  }

  @override
  String get pickupKeep => 'להשאיר';

  @override
  String get pickupCancelConfirm => 'ביטול האיסוף';

  @override
  String get actionCancel => 'ביטול';

  @override
  String get reportsShipments => 'משלוחים';

  @override
  String get reportsTotalSpend => 'סך ההוצאות';

  @override
  String get reportsByCarrier => 'לפי חברת שילוח';

  @override
  String get reportsEmpty => 'אין עדיין משלוחים שנרכשו לדיווח.';

  @override
  String reportsCarrierShipments(int count) {
    return 'משלוחים: $count';
  }

  @override
  String get htsSearchLabel => 'חיפוש קודי מכס';

  @override
  String get htsSearchHint => 'למשל חוט נחושת';

  @override
  String get htsSearchButton => 'חיפוש';

  @override
  String get htsDisclaimer =>
      'חיפוש עזר מתוך U.S. International Trade Commission. האחריות לסיווג הנכון נותרת על השולח.';

  @override
  String get htsPrompt => 'יש לחפש קוד מכס למעלה.';

  @override
  String get htsNoResults => 'לא נמצאו קודי מכס מתאימים.';

  @override
  String htsRateGeneral(String rate) {
    return 'כללי $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'מיוחד $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'אחר $rate';
  }

  @override
  String get htsCopyTooltip => 'העתקת הקוד';

  @override
  String htsCopied(String code) {
    return '$code הועתק';
  }

  @override
  String htsUnavailable(int code) {
    return 'שירות המכס אינו זמין (שגיאה $code). יש לנסות שוב.';
  }

  @override
  String get pairTitle => 'צימוד למחשב';

  @override
  String get pairInstructions =>
      'יש לפתוח את Easy-Post Desktop, לבחור «צימוד אפליקציית הנייד» ולסרוק את קוד ה‑QR המוצג שם.';

  @override
  String get pairEnterReviewCode => 'הזנת קוד בדיקה במקום';

  @override
  String get pairReviewDialogTitle => 'הזנת קוד בדיקה';

  @override
  String get pairReviewCodeHint => 'קוד בדיקה';

  @override
  String get pairAction => 'צימוד';

  @override
  String get errorPairingCodeInvalid =>
      'קוד הצימוד אינו תקף או שפג תוקפו. יש להפיק קוד חדש במחשב.';

  @override
  String get errorReviewCodeRejected => 'קוד הבדיקה לא התקבל.';

  @override
  String get errorUnexpectedPairingResponse =>
      'תגובה בלתי צפויה משירות הצימוד.';

  @override
  String get errorNotPaired =>
      'המכשיר אינו מצומד עוד. יש לצמד אותו מחדש מהמחשב.';

  @override
  String get errorNotPairedShort => 'המכשיר אינו מצומד עוד.';

  @override
  String get errorForbidden => 'פעולה זו אינה מותרת מהאפליקציה.';

  @override
  String errorRequestFailed(int code) {
    return 'הבקשה נכשלה (שגיאה $code).';
  }

  @override
  String get detailShipment => 'משלוח';

  @override
  String get detailInsurancePolicy => 'פוליסת ביטוח';

  @override
  String get detailClaim => 'תביעה';

  @override
  String get detailPickup => 'איסוף';

  @override
  String get fieldCarrier => 'מוביל';

  @override
  String get fieldService => 'שירות';

  @override
  String get fieldStatus => 'סטטוס';

  @override
  String get fieldCreated => 'נוצר';

  @override
  String get fieldAmount => 'סכום';

  @override
  String get fieldProvider => 'ספק';

  @override
  String get fieldReference => 'אסמכתא';

  @override
  String get fieldPickupWindow => 'חלון איסוף';

  @override
  String get fieldCost => 'עלות';

  @override
  String get detailNothingFurther => 'אין פרטים נוספים.';
}

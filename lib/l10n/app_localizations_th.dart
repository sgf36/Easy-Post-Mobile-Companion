// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'ติดตามพัสดุ';

  @override
  String get navHistory => 'ประวัติ';

  @override
  String get navInsurance => 'ประกัน';

  @override
  String get navClaims => 'เคลม';

  @override
  String get navPickups => 'นัดรับพัสดุ';

  @override
  String get navReports => 'รายงาน';

  @override
  String get navHts => 'ค้นหา HTS';

  @override
  String get navSectionManage => 'ติดตามและจัดการ';

  @override
  String get navSectionTools => 'เครื่องมือ';

  @override
  String get drawerUnpair => 'ยกเลิกการจับคู่อุปกรณ์นี้';

  @override
  String get statusPreTransit => 'ก่อนขนส่ง';

  @override
  String get statusInTransit => 'อยู่ระหว่างขนส่ง';

  @override
  String get statusOutForDelivery => 'กำลังนำส่ง';

  @override
  String get statusDelivered => 'จัดส่งแล้ว';

  @override
  String get statusAvailableForPickup => 'พร้อมให้รับ';

  @override
  String get statusReturnToSender => 'ส่งคืนผู้ส่ง';

  @override
  String get statusFailure => 'ล้มเหลว';

  @override
  String get statusCancelled => 'ยกเลิกแล้ว';

  @override
  String get statusError => 'ข้อผิดพลาด';

  @override
  String get statusUnknown => 'ไม่ทราบ';

  @override
  String get carrierUnknown => 'ไม่ทราบผู้ให้บริการขนส่ง';

  @override
  String get carrierUnknownShort => 'ไม่ทราบ';

  @override
  String get sortTooltip => 'เรียงลำดับ';

  @override
  String get sortByStatus => 'เรียงตามสถานะ';

  @override
  String get sortByCarrier => 'เรียงตามผู้ให้บริการขนส่ง';

  @override
  String get sortByCode => 'เรียงตามเลขพัสดุ';

  @override
  String get sortByUpdated => 'เรียงตามการอัปเดตล่าสุด';

  @override
  String get filterTooltip => 'ตัวกรอง';

  @override
  String get filterHideDelivered => 'ซ่อนรายการที่จัดส่งแล้ว';

  @override
  String get filterStatusHeading => 'สถานะ';

  @override
  String get filterCarrierHeading => 'ผู้ให้บริการขนส่ง';

  @override
  String get filterReset => 'ล้างตัวกรอง';

  @override
  String get trackersEmpty => 'ยังไม่มีพัสดุที่กำลังติดตาม';

  @override
  String trackersShowing(int shown, int total) {
    return 'แสดง $shown จาก $total';
  }

  @override
  String get trackersNoMatch => 'ไม่มีรายการที่ตรงกับตัวกรองปัจจุบัน';

  @override
  String etaLabel(String date) {
    return 'คาดว่า $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'กำหนดส่งโดยประมาณ $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'ผู้รับลงชื่อ $name';
  }

  @override
  String get detailHistoryHeading => 'ประวัติ';

  @override
  String get detailNoScanHistory => 'ยังไม่มีข้อมูลการสแกน';

  @override
  String get detailMapUnavailable => 'ไม่มีแผนที่สำหรับตำแหน่งเหล่านี้';

  @override
  String get historyEmpty => 'ยังไม่มีพัสดุ';

  @override
  String get insuranceEmpty => 'ยังไม่มีกรมธรรม์ แตะ «ซื้อประกัน»';

  @override
  String get insuranceBuy => 'ซื้อประกัน';

  @override
  String get insuranceAmountRange =>
      'มูลค่าเอาประกันต้องอยู่ระหว่าง 0.01 ถึง 5,000 USD';

  @override
  String get insuranceNotEnabled =>
      'บัญชี EasyPost นี้ไม่ได้เปิดใช้งานประกันแบบแยกต่างหาก โปรดขอให้ฝ่ายสนับสนุนของ EasyPost เปิดใช้งาน หรือเพิ่มประกันตอนซื้อใบปะหน้าแทน';

  @override
  String get insuranceFromAddress => 'ที่อยู่ผู้ส่ง';

  @override
  String get insuranceToAddress => 'ที่อยู่ผู้รับ';

  @override
  String get fieldTrackingCode => 'เลขพัสดุ';

  @override
  String get fieldCarrierHint => 'ผู้ให้บริการขนส่ง (เช่น USPS)';

  @override
  String get fieldInsuredAmount => 'มูลค่าเอาประกัน (USD)';

  @override
  String get fieldName => 'ชื่อ';

  @override
  String get fieldStreet => 'ถนน';

  @override
  String get fieldCity => 'เมือง';

  @override
  String get fieldStateRegion => 'รัฐ / ภูมิภาค';

  @override
  String get fieldPostcode => 'รหัสไปรษณีย์';

  @override
  String get fieldCountryIso => 'ประเทศ (ISO เช่น US)';

  @override
  String get fieldType => 'ประเภท';

  @override
  String get fieldAmountUsd => 'จำนวนเงิน (USD)';

  @override
  String get fieldContactEmail => 'อีเมลติดต่อ';

  @override
  String get fieldDescription => 'รายละเอียด';

  @override
  String get validationRequired => 'จำเป็น';

  @override
  String get validationEnterAmount => 'กรอกจำนวนเงิน';

  @override
  String get validationEnterEmail => 'กรอกอีเมล';

  @override
  String get validationDescribeIssue => 'อธิบายปัญหา';

  @override
  String get claimsEmpty => 'ยังไม่มีการยื่นเคลม แตะ «ยื่นเคลม»';

  @override
  String get claimsFile => 'ยื่นเคลม';

  @override
  String get claimSubmit => 'ส่งเคลม';

  @override
  String get claimTypeDamage => 'เสียหาย';

  @override
  String get claimTypeTheft => 'ถูกขโมย';

  @override
  String get claimTypeLoss => 'สูญหาย';

  @override
  String get claimAttachmentNote =>
      'เคลมกรณีเสียหายและถูกขโมยต้องมีรูปถ่ายหรือใบแจ้งหนี้เป็นหลักฐาน โปรดยื่นผ่านแอปบนเดสก์ท็อปซึ่งแนบเอกสารได้';

  @override
  String get claimAttachmentSnack =>
      'เคลมกรณีเสียหายและถูกขโมยต้องมีหลักฐานซึ่งแนบได้เฉพาะในแอปบนเดสก์ท็อป ส่วนเคลมกรณีสูญหายยื่นที่นี่ได้';

  @override
  String get pickupsEmpty => 'ยังไม่มีการนัดรับพัสดุ';

  @override
  String get pickupCancelTitle => 'ยกเลิกการนัดรับพัสดุ?';

  @override
  String pickupCancelBody(String id) {
    return 'ยกเลิกการนัดรับพัสดุ $id หรือไม่ การกระทำนี้ย้อนกลับไม่ได้';
  }

  @override
  String get pickupKeep => 'เก็บไว้';

  @override
  String get pickupCancelConfirm => 'ยกเลิกการนัดรับ';

  @override
  String get actionCancel => 'ยกเลิก';

  @override
  String get reportsShipments => 'พัสดุ';

  @override
  String get reportsTotalSpend => 'ค่าใช้จ่ายรวม';

  @override
  String get reportsByCarrier => 'ตามผู้ให้บริการขนส่ง';

  @override
  String get reportsEmpty => 'ยังไม่มีพัสดุที่ซื้อแล้วสำหรับรายงาน';

  @override
  String reportsCarrierShipments(int count) {
    return 'พัสดุ: $count';
  }

  @override
  String get htsSearchLabel => 'ค้นหารหัสพิกัดศุลกากร';

  @override
  String get htsSearchHint => 'เช่น ลวดทองแดง';

  @override
  String get htsSearchButton => 'ค้นหา';

  @override
  String get htsDisclaimer =>
      'ข้อมูลอ้างอิงจาก U.S. International Trade Commission การจัดประเภทที่ถูกต้องยังคงเป็นความรับผิดชอบของผู้ส่ง';

  @override
  String get htsPrompt => 'ค้นหารหัสพิกัดศุลกากรด้านบน';

  @override
  String get htsNoResults => 'ไม่พบรหัสพิกัดศุลกากรที่ตรงกัน';

  @override
  String htsRateGeneral(String rate) {
    return 'ทั่วไป $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'พิเศษ $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'อื่น ๆ $rate';
  }

  @override
  String get htsCopyTooltip => 'คัดลอกรหัส';

  @override
  String htsCopied(String code) {
    return 'คัดลอก $code แล้ว';
  }

  @override
  String htsUnavailable(int code) {
    return 'บริการพิกัดศุลกากรไม่พร้อมใช้งาน (ข้อผิดพลาด $code) โปรดลองอีกครั้ง';
  }

  @override
  String get pairTitle => 'จับคู่กับเดสก์ท็อป';

  @override
  String get pairInstructions =>
      'เปิด Easy-Post Desktop เลือก «จับคู่แอปมือถือ» แล้วสแกนรหัส QR ที่แสดงอยู่';

  @override
  String get pairEnterReviewCode => 'กรอกรหัสสำหรับผู้ตรวจสอบแทน';

  @override
  String get pairReviewDialogTitle => 'กรอกรหัสสำหรับผู้ตรวจสอบ';

  @override
  String get pairReviewCodeHint => 'รหัสสำหรับผู้ตรวจสอบ';

  @override
  String get pairAction => 'จับคู่';

  @override
  String get errorPairingCodeInvalid =>
      'รหัสจับคู่นี้ไม่ถูกต้องหรือหมดอายุแล้ว โปรดสร้างรหัสใหม่บนเดสก์ท็อป';

  @override
  String get errorReviewCodeRejected =>
      'รหัสสำหรับผู้ตรวจสอบนี้ไม่ได้รับการยอมรับ';

  @override
  String get errorUnexpectedPairingResponse =>
      'การตอบกลับที่ไม่คาดคิดจากบริการจับคู่';

  @override
  String get errorNotPaired =>
      'อุปกรณ์นี้ไม่ได้จับคู่อีกต่อไป โปรดจับคู่ใหม่จากเดสก์ท็อป';

  @override
  String get errorNotPairedShort => 'อุปกรณ์นี้ไม่ได้จับคู่อีกต่อไป';

  @override
  String get errorForbidden => 'ไม่อนุญาตให้ดำเนินการนี้จากแอป';

  @override
  String errorRequestFailed(int code) {
    return 'คำขอล้มเหลว (ข้อผิดพลาด $code)';
  }
}

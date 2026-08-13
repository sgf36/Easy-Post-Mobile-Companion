// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Theo dõi';

  @override
  String get navHistory => 'Lịch sử';

  @override
  String get navInsurance => 'Bảo hiểm';

  @override
  String get navClaims => 'Yêu cầu bồi thường';

  @override
  String get navPickups => 'Lấy hàng';

  @override
  String get navReports => 'Báo cáo';

  @override
  String get navHts => 'Tra cứu HTS';

  @override
  String get navSectionManage => 'Theo dõi và quản lý';

  @override
  String get navSectionTools => 'Công cụ';

  @override
  String get drawerUnpair => 'Hủy ghép nối thiết bị này';

  @override
  String get statusPreTransit => 'Trước khi vận chuyển';

  @override
  String get statusInTransit => 'Đang vận chuyển';

  @override
  String get statusOutForDelivery => 'Đang giao hàng';

  @override
  String get statusDelivered => 'Đã giao';

  @override
  String get statusAvailableForPickup => 'Sẵn sàng để nhận';

  @override
  String get statusReturnToSender => 'Trả lại người gửi';

  @override
  String get statusFailure => 'Thất bại';

  @override
  String get statusCancelled => 'Đã hủy';

  @override
  String get statusError => 'Lỗi';

  @override
  String get statusUnknown => 'Không rõ';

  @override
  String get carrierUnknown => 'Không rõ đơn vị vận chuyển';

  @override
  String get carrierUnknownShort => 'Không rõ';

  @override
  String get sortTooltip => 'Sắp xếp';

  @override
  String get sortByStatus => 'Sắp xếp theo trạng thái';

  @override
  String get sortByCarrier => 'Sắp xếp theo đơn vị vận chuyển';

  @override
  String get sortByCode => 'Sắp xếp theo mã vận đơn';

  @override
  String get sortByUpdated => 'Sắp xếp theo cập nhật gần nhất';

  @override
  String get filterTooltip => 'Lọc';

  @override
  String get filterHideDelivered => 'Ẩn đơn đã giao';

  @override
  String get filterStatusHeading => 'Trạng thái';

  @override
  String get filterCarrierHeading => 'Đơn vị vận chuyển';

  @override
  String get filterReset => 'Đặt lại bộ lọc';

  @override
  String get trackersEmpty => 'Chưa có lô hàng nào được theo dõi.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Hiển thị $shown trên $total';
  }

  @override
  String get trackersNoMatch => 'Không có gì khớp với bộ lọc hiện tại.';

  @override
  String etaLabel(String date) {
    return 'Dự kiến $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Ngày giao hàng dự kiến $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Người ký nhận: $name';
  }

  @override
  String get detailHistoryHeading => 'Lịch sử';

  @override
  String get detailNoScanHistory => 'Chưa có lần quét nào.';

  @override
  String get detailMapUnavailable => 'Không có bản đồ cho những địa điểm này.';

  @override
  String get historyEmpty => 'Chưa có lô hàng nào.';

  @override
  String get insuranceEmpty =>
      'Chưa có hợp đồng bảo hiểm. Chạm vào «Mua bảo hiểm».';

  @override
  String get insuranceBuy => 'Mua bảo hiểm';

  @override
  String get insuranceAmountRange =>
      'Giá trị bảo hiểm phải nằm trong khoảng 0,01 đến 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Tài khoản EasyPost này chưa được bật bảo hiểm độc lập. Hãy đề nghị bộ phận hỗ trợ EasyPost bật tính năng này, hoặc thêm bảo hiểm khi mua nhãn.';

  @override
  String get insuranceFromAddress => 'Địa chỉ người gửi';

  @override
  String get insuranceToAddress => 'Địa chỉ người nhận';

  @override
  String get fieldTrackingCode => 'Mã vận đơn';

  @override
  String get fieldCarrierHint => 'Đơn vị vận chuyển (ví dụ USPS)';

  @override
  String get fieldInsuredAmount => 'Giá trị bảo hiểm (USD)';

  @override
  String get fieldName => 'Tên';

  @override
  String get fieldStreet => 'Đường';

  @override
  String get fieldCity => 'Thành phố';

  @override
  String get fieldStateRegion => 'Tiểu bang / vùng';

  @override
  String get fieldPostcode => 'Mã bưu điện';

  @override
  String get fieldCountryIso => 'Quốc gia (ISO, ví dụ US)';

  @override
  String get fieldType => 'Loại';

  @override
  String get fieldAmountUsd => 'Số tiền (USD)';

  @override
  String get fieldContactEmail => 'Email liên hệ';

  @override
  String get fieldDescription => 'Mô tả';

  @override
  String get validationRequired => 'Bắt buộc';

  @override
  String get validationEnterAmount => 'Nhập số tiền';

  @override
  String get validationEnterEmail => 'Nhập email';

  @override
  String get validationDescribeIssue => 'Mô tả sự cố';

  @override
  String get claimsEmpty =>
      'Chưa có yêu cầu bồi thường. Chạm vào «Gửi yêu cầu bồi thường».';

  @override
  String get claimsFile => 'Gửi yêu cầu bồi thường';

  @override
  String get claimSubmit => 'Nộp yêu cầu';

  @override
  String get claimTypeDamage => 'Hư hỏng';

  @override
  String get claimTypeTheft => 'Bị đánh cắp';

  @override
  String get claimTypeLoss => 'Thất lạc';

  @override
  String get claimAttachmentNote =>
      'Yêu cầu bồi thường hư hỏng và bị đánh cắp cần ảnh chụp hoặc hóa đơn làm chứng từ. Hãy gửi từ ứng dụng máy tính, nơi có thể đính kèm tài liệu.';

  @override
  String get claimAttachmentSnack =>
      'Yêu cầu bồi thường hư hỏng và bị đánh cắp cần chứng từ, chỉ đính kèm được trong ứng dụng máy tính. Yêu cầu bồi thường thất lạc có thể gửi tại đây.';

  @override
  String get pickupsEmpty => 'Chưa có lịch lấy hàng nào.';

  @override
  String get pickupCancelTitle => 'Hủy lịch lấy hàng?';

  @override
  String pickupCancelBody(String id) {
    return 'Hủy lịch lấy hàng $id? Thao tác này không thể hoàn tác.';
  }

  @override
  String get pickupKeep => 'Giữ lại';

  @override
  String get pickupCancelConfirm => 'Hủy lịch lấy hàng';

  @override
  String get actionCancel => 'Hủy';

  @override
  String get reportsShipments => 'Lô hàng';

  @override
  String get reportsTotalSpend => 'Tổng chi tiêu';

  @override
  String get reportsByCarrier => 'Theo đơn vị vận chuyển';

  @override
  String get reportsEmpty => 'Chưa có lô hàng đã mua nào để báo cáo.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Lô hàng: $count';
  }

  @override
  String get htsSearchLabel => 'Tìm mã thuế quan';

  @override
  String get htsSearchHint => 'ví dụ dây đồng';

  @override
  String get htsSearchButton => 'Tìm kiếm';

  @override
  String get htsDisclaimer =>
      'Tra cứu tham khảo từ U.S. International Trade Commission. Việc phân loại đúng vẫn thuộc trách nhiệm của người gửi.';

  @override
  String get htsPrompt => 'Hãy tìm một mã thuế quan ở trên.';

  @override
  String get htsNoResults => 'Không tìm thấy mã thuế quan phù hợp.';

  @override
  String htsRateGeneral(String rate) {
    return 'Chung $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Đặc biệt $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Khác $rate';
  }

  @override
  String get htsCopyTooltip => 'Sao chép mã';

  @override
  String htsCopied(String code) {
    return 'Đã sao chép $code';
  }

  @override
  String htsUnavailable(int code) {
    return 'Dịch vụ thuế quan không khả dụng (lỗi $code). Vui lòng thử lại.';
  }

  @override
  String get pairTitle => 'Ghép nối với máy tính';

  @override
  String get pairInstructions =>
      'Mở Easy-Post Desktop, chọn «Ghép nối ứng dụng di động» rồi quét mã QR hiển thị ở đó.';

  @override
  String get pairEnterReviewCode => 'Nhập mã đánh giá thay thế';

  @override
  String get pairReviewDialogTitle => 'Nhập mã đánh giá';

  @override
  String get pairReviewCodeHint => 'Mã đánh giá';

  @override
  String get pairAction => 'Ghép nối';

  @override
  String get errorPairingCodeInvalid =>
      'Mã ghép nối này không hợp lệ hoặc đã hết hạn. Hãy tạo mã mới trên máy tính.';

  @override
  String get errorReviewCodeRejected => 'Mã đánh giá này không được chấp nhận.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Phản hồi không mong đợi từ dịch vụ ghép nối.';

  @override
  String get errorNotPaired =>
      'Thiết bị này không còn được ghép nối. Hãy ghép nối lại từ máy tính.';

  @override
  String get errorNotPairedShort => 'Thiết bị này không còn được ghép nối.';

  @override
  String get errorForbidden => 'Thao tác này không được phép từ ứng dụng.';

  @override
  String errorRequestFailed(int code) {
    return 'Yêu cầu thất bại (lỗi $code).';
  }
}

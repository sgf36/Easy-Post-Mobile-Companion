// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => '추적';

  @override
  String get navHistory => '내역';

  @override
  String get navInsurance => '보험';

  @override
  String get navClaims => '배상 청구';

  @override
  String get navPickups => '픽업';

  @override
  String get navReports => '보고서';

  @override
  String get navHts => 'HTS 조회';

  @override
  String get navSectionManage => '추적 및 관리';

  @override
  String get navSectionTools => '도구';

  @override
  String get drawerUnpair => '이 기기 페어링 해제';

  @override
  String get statusPreTransit => '발송 준비 중';

  @override
  String get statusInTransit => '배송 중';

  @override
  String get statusOutForDelivery => '배달 중';

  @override
  String get statusDelivered => '배달 완료';

  @override
  String get statusAvailableForPickup => '수령 가능';

  @override
  String get statusReturnToSender => '발송인에게 반송';

  @override
  String get statusFailure => '실패';

  @override
  String get statusCancelled => '취소됨';

  @override
  String get statusError => '오류';

  @override
  String get statusUnknown => '알 수 없음';

  @override
  String get carrierUnknown => '배송업체 알 수 없음';

  @override
  String get carrierUnknownShort => '알 수 없음';

  @override
  String get sortTooltip => '정렬';

  @override
  String get sortByStatus => '상태순 정렬';

  @override
  String get sortByCarrier => '배송업체순 정렬';

  @override
  String get sortByCode => '운송장 번호순 정렬';

  @override
  String get sortByUpdated => '최근 업데이트순 정렬';

  @override
  String get filterTooltip => '필터';

  @override
  String get filterHideDelivered => '배달 완료 숨기기';

  @override
  String get filterStatusHeading => '상태';

  @override
  String get filterCarrierHeading => '배송업체';

  @override
  String get filterReset => '필터 초기화';

  @override
  String get trackersEmpty => '아직 추적 중인 배송이 없습니다.';

  @override
  String trackersShowing(int shown, int total) {
    return '$total건 중 $shown건 표시';
  }

  @override
  String get trackersNoMatch => '현재 필터와 일치하는 항목이 없습니다.';

  @override
  String etaLabel(String date) {
    return '예상 $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return '예상 도착일 $date';
  }

  @override
  String detailSignedBy(String name) {
    return '수령 서명: $name';
  }

  @override
  String get detailHistoryHeading => '내역';

  @override
  String get detailNoScanHistory => '아직 스캔 기록이 없습니다.';

  @override
  String get detailMapUnavailable => '이 위치들의 지도를 사용할 수 없습니다.';

  @override
  String get historyEmpty => '아직 배송 내역이 없습니다.';

  @override
  String get insuranceEmpty => '아직 보험이 없습니다. ‘보험 구매’를 누르세요.';

  @override
  String get insuranceBuy => '보험 구매';

  @override
  String get insuranceAmountRange => '보험 금액은 0.01~5,000 USD 사이여야 합니다.';

  @override
  String get insuranceNotEnabled =>
      '이 EasyPost 계정은 단독 보험이 활성화되어 있지 않습니다. EasyPost 지원팀에 활성화를 요청하거나 운송장 구매 시 보험을 추가하세요.';

  @override
  String get insuranceFromAddress => '보내는 주소';

  @override
  String get insuranceToAddress => '받는 주소';

  @override
  String get fieldTrackingCode => '운송장 번호';

  @override
  String get fieldCarrierHint => '배송업체 (예: USPS)';

  @override
  String get fieldInsuredAmount => '보험 금액 (USD)';

  @override
  String get fieldName => '이름';

  @override
  String get fieldStreet => '도로명';

  @override
  String get fieldCity => '도시';

  @override
  String get fieldStateRegion => '주 / 지역';

  @override
  String get fieldPostcode => '우편번호';

  @override
  String get fieldCountryIso => '국가 (ISO, 예: US)';

  @override
  String get fieldType => '유형';

  @override
  String get fieldAmountUsd => '금액 (USD)';

  @override
  String get fieldContactEmail => '연락처 이메일';

  @override
  String get fieldDescription => '설명';

  @override
  String get validationRequired => '필수';

  @override
  String get validationEnterAmount => '금액을 입력하세요';

  @override
  String get validationEnterEmail => '이메일을 입력하세요';

  @override
  String get validationDescribeIssue => '문제를 설명하세요';

  @override
  String get claimsEmpty => '아직 청구가 없습니다. ‘배상 청구하기’를 누르세요.';

  @override
  String get claimsFile => '배상 청구하기';

  @override
  String get claimSubmit => '청구 제출';

  @override
  String get claimTypeDamage => '파손';

  @override
  String get claimTypeTheft => '도난';

  @override
  String get claimTypeLoss => '분실';

  @override
  String get claimAttachmentNote =>
      '파손과 도난 청구에는 사진이나 인보이스 같은 증빙이 필요합니다. 문서를 첨부할 수 있는 데스크톱 앱에서 제출하세요.';

  @override
  String get claimAttachmentSnack =>
      '파손과 도난 청구에는 증빙이 필요하며 데스크톱 앱에서만 첨부할 수 있습니다. 분실 청구는 여기서 제출할 수 있습니다.';

  @override
  String get pickupsEmpty => '예약된 픽업이 아직 없습니다.';

  @override
  String get pickupCancelTitle => '픽업을 취소할까요?';

  @override
  String pickupCancelBody(String id) {
    return '픽업 $id을(를) 취소할까요? 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String get pickupKeep => '유지';

  @override
  String get pickupCancelConfirm => '픽업 취소';

  @override
  String get actionCancel => '취소';

  @override
  String get reportsShipments => '배송 건수';

  @override
  String get reportsTotalSpend => '총 지출';

  @override
  String get reportsByCarrier => '배송업체별';

  @override
  String get reportsEmpty => '보고서에 표시할 구매된 배송이 아직 없습니다.';

  @override
  String reportsCarrierShipments(int count) {
    return '배송: $count';
  }

  @override
  String get htsSearchLabel => '관세 코드 검색';

  @override
  String get htsSearchHint => '예: 구리 전선';

  @override
  String get htsSearchButton => '검색';

  @override
  String get htsDisclaimer =>
      'U.S. International Trade Commission의 참고 자료입니다. 올바른 분류는 발송인의 책임입니다.';

  @override
  String get htsPrompt => '위에서 관세 코드를 검색하세요.';

  @override
  String get htsNoResults => '일치하는 관세 코드가 없습니다.';

  @override
  String htsRateGeneral(String rate) {
    return '일반 $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return '특별 $rate';
  }

  @override
  String htsRateOther(String rate) {
    return '기타 $rate';
  }

  @override
  String get htsCopyTooltip => '코드 복사';

  @override
  String htsCopied(String code) {
    return '$code 복사됨';
  }

  @override
  String htsUnavailable(int code) {
    return '관세 서비스를 사용할 수 없습니다 (오류 $code). 다시 시도하세요.';
  }

  @override
  String get pairTitle => '데스크톱과 페어링';

  @override
  String get pairInstructions =>
      'Easy-Post Desktop을 열고 ‘모바일 앱 페어링’을 선택한 뒤 표시된 QR 코드를 스캔하세요.';

  @override
  String get pairEnterReviewCode => '대신 심사용 코드 입력';

  @override
  String get pairReviewDialogTitle => '심사용 코드 입력';

  @override
  String get pairReviewCodeHint => '심사용 코드';

  @override
  String get pairAction => '페어링';

  @override
  String get errorPairingCodeInvalid =>
      '이 페어링 코드는 유효하지 않거나 만료되었습니다. 데스크톱에서 새로 생성하세요.';

  @override
  String get errorReviewCodeRejected => '이 심사용 코드는 승인되지 않았습니다.';

  @override
  String get errorUnexpectedPairingResponse => '페어링 서비스에서 예기치 않은 응답이 왔습니다.';

  @override
  String get errorNotPaired => '이 기기는 더 이상 페어링되어 있지 않습니다. 데스크톱에서 다시 페어링하세요.';

  @override
  String get errorNotPairedShort => '이 기기는 더 이상 페어링되어 있지 않습니다.';

  @override
  String get errorForbidden => '앱에서는 허용되지 않는 작업입니다.';

  @override
  String errorRequestFailed(int code) {
    return '요청이 실패했습니다 (오류 $code).';
  }
}

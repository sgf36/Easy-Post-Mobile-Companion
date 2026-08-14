// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => '追跡';

  @override
  String get navHistory => '履歴';

  @override
  String get navInsurance => '保険';

  @override
  String get navClaims => '保険金請求';

  @override
  String get navPickups => '集荷';

  @override
  String get navReports => 'レポート';

  @override
  String get navHts => 'HTS検索';

  @override
  String get navSectionManage => '追跡と管理';

  @override
  String get navSectionTools => 'ツール';

  @override
  String get drawerUnpair => 'このデバイスのペアリングを解除';

  @override
  String get statusPreTransit => '発送準備中';

  @override
  String get statusInTransit => '輸送中';

  @override
  String get statusOutForDelivery => '配達中';

  @override
  String get statusDelivered => '配達完了';

  @override
  String get statusAvailableForPickup => '受け取り可能';

  @override
  String get statusReturnToSender => '差出人へ返送';

  @override
  String get statusFailure => '失敗';

  @override
  String get statusCancelled => 'キャンセル済み';

  @override
  String get statusError => 'エラー';

  @override
  String get statusUnknown => '不明';

  @override
  String get carrierUnknown => '配送業者不明';

  @override
  String get carrierUnknownShort => '不明';

  @override
  String get sortTooltip => '並べ替え';

  @override
  String get sortByStatus => '状況で並べ替え';

  @override
  String get sortByCarrier => '配送業者で並べ替え';

  @override
  String get sortByCode => '追跡番号で並べ替え';

  @override
  String get sortByUpdated => '更新が新しい順に並べ替え';

  @override
  String get filterTooltip => '絞り込み';

  @override
  String get filterHideDelivered => '配達完了を非表示';

  @override
  String get filterStatusHeading => '状況';

  @override
  String get filterCarrierHeading => '配送業者';

  @override
  String get filterReset => '絞り込みをリセット';

  @override
  String get trackersEmpty => '追跡中の荷物はまだありません。';

  @override
  String trackersShowing(int shown, int total) {
    return '$total 件中 $shown 件を表示';
  }

  @override
  String get trackersNoMatch => '現在の絞り込み条件に一致するものはありません。';

  @override
  String etaLabel(String date) {
    return '予定 $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return '配達予定日 $date';
  }

  @override
  String detailSignedBy(String name) {
    return '受領サイン: $name';
  }

  @override
  String get detailHistoryHeading => '履歴';

  @override
  String get detailNoScanHistory => 'スキャン履歴はまだありません。';

  @override
  String get detailMapUnavailable => 'これらの地点の地図は利用できません。';

  @override
  String get historyEmpty => '荷物はまだありません。';

  @override
  String get insuranceEmpty => '保険はまだありません。「保険を購入」をタップしてください。';

  @override
  String get insuranceBuy => '保険を購入';

  @override
  String get insuranceAmountRange => '保険金額は 0.01〜5,000 USD の範囲で入力してください。';

  @override
  String get insuranceNotEnabled =>
      'この EasyPost アカウントでは単独保険が有効になっていません。EasyPost サポートに有効化を依頼するか、ラベル購入時に保険を追加してください。';

  @override
  String get insuranceFromAddress => '差出人の住所';

  @override
  String get insuranceToAddress => '宛先の住所';

  @override
  String get fieldTrackingCode => '追跡番号';

  @override
  String get fieldCarrierHint => '配送業者 (例: USPS)';

  @override
  String get fieldInsuredAmount => '保険金額 (USD)';

  @override
  String get fieldName => '名前';

  @override
  String get fieldStreet => '住所';

  @override
  String get fieldCity => '市区町村';

  @override
  String get fieldStateRegion => '州 / 地域';

  @override
  String get fieldPostcode => '郵便番号';

  @override
  String get fieldCountryIso => '国 (ISO、例: US)';

  @override
  String get fieldType => '種類';

  @override
  String get fieldAmountUsd => '金額 (USD)';

  @override
  String get fieldContactEmail => '連絡先メール';

  @override
  String get fieldDescription => '説明';

  @override
  String get validationRequired => '必須';

  @override
  String get validationEnterAmount => '金額を入力してください';

  @override
  String get validationEnterEmail => 'メールアドレスを入力してください';

  @override
  String get validationDescribeIssue => '問題を記入してください';

  @override
  String get claimsEmpty => '請求はまだありません。「保険金を請求」をタップしてください。';

  @override
  String get claimsFile => '保険金を請求';

  @override
  String get claimSubmit => '請求を提出';

  @override
  String get claimTypeDamage => '破損';

  @override
  String get claimTypeTheft => '盗難';

  @override
  String get claimTypeLoss => '紛失';

  @override
  String get claimAttachmentNote =>
      '破損と盗難の請求には、写真や請求書などの証憑が必要です。書類を添付できるデスクトップアプリから提出してください。';

  @override
  String get claimAttachmentSnack =>
      '破損と盗難の請求には証憑が必要で、添付はデスクトップアプリからのみ行えます。紛失の請求はここから提出できます。';

  @override
  String get pickupsEmpty => '予約された集荷はまだありません。';

  @override
  String get pickupCancelTitle => '集荷をキャンセルしますか？';

  @override
  String pickupCancelBody(String id) {
    return '集荷 $id をキャンセルしますか？この操作は取り消せません。';
  }

  @override
  String get pickupKeep => 'そのままにする';

  @override
  String get pickupCancelConfirm => '集荷をキャンセル';

  @override
  String get actionCancel => 'キャンセル';

  @override
  String get reportsShipments => '荷物';

  @override
  String get reportsTotalSpend => '支出合計';

  @override
  String get reportsByCarrier => '配送業者別';

  @override
  String get reportsEmpty => 'レポートに表示できる購入済みの荷物はまだありません。';

  @override
  String reportsCarrierShipments(int count) {
    return '荷物: $count';
  }

  @override
  String get htsSearchLabel => '関税分類番号を検索';

  @override
  String get htsSearchHint => '例: 銅線';

  @override
  String get htsSearchButton => '検索';

  @override
  String get htsDisclaimer =>
      'U.S. International Trade Commission の参考データです。正しい分類は荷送人の責任です。';

  @override
  String get htsPrompt => '上の欄で関税分類番号を検索してください。';

  @override
  String get htsNoResults => '該当する関税分類番号はありません。';

  @override
  String htsRateGeneral(String rate) {
    return '一般 $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return '特別 $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'その他 $rate';
  }

  @override
  String get htsCopyTooltip => 'コードをコピー';

  @override
  String htsCopied(String code) {
    return '$code をコピーしました';
  }

  @override
  String htsUnavailable(int code) {
    return '関税サービスを利用できません (エラー $code)。もう一度お試しください。';
  }

  @override
  String get pairTitle => 'デスクトップとペアリング';

  @override
  String get pairInstructions =>
      'Easy-Post Desktop を開き、「モバイルアプリをペアリング」を選んで、表示された QR コードを読み取ってください。';

  @override
  String get pairEnterReviewCode => '代わりに審査用コードを入力';

  @override
  String get pairReviewDialogTitle => '審査用コードを入力';

  @override
  String get pairReviewCodeHint => '審査用コード';

  @override
  String get pairAction => 'ペアリング';

  @override
  String get errorPairingCodeInvalid =>
      'このペアリングコードは無効か期限切れです。デスクトップで新しいコードを生成してください。';

  @override
  String get errorReviewCodeRejected => 'この審査用コードは受け付けられませんでした。';

  @override
  String get errorUnexpectedPairingResponse => 'ペアリングサービスから予期しない応答がありました。';

  @override
  String get errorNotPaired => 'このデバイスのペアリングは解除されています。デスクトップから再度ペアリングしてください。';

  @override
  String get errorNotPairedShort => 'このデバイスのペアリングは解除されています。';

  @override
  String get errorForbidden => 'この操作はアプリからは許可されていません。';

  @override
  String errorRequestFailed(int code) {
    return 'リクエストに失敗しました (エラー $code)。';
  }

  @override
  String get detailShipment => '配送';

  @override
  String get detailInsurancePolicy => '保険証券';

  @override
  String get detailClaim => '請求';

  @override
  String get detailPickup => '集荷';

  @override
  String get fieldCarrier => '配送業者';

  @override
  String get fieldService => 'サービス';

  @override
  String get fieldStatus => 'ステータス';

  @override
  String get fieldCreated => '作成日';

  @override
  String get fieldAmount => '金額';

  @override
  String get fieldProvider => '提供元';

  @override
  String get fieldReference => '参照番号';

  @override
  String get fieldPickupWindow => '集荷時間帯';

  @override
  String get fieldCost => '料金';

  @override
  String get detailNothingFurther => 'これ以上の詳細はありません。';
}

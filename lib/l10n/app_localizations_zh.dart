// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => '追踪';

  @override
  String get navHistory => '历史';

  @override
  String get navInsurance => '保险';

  @override
  String get navClaims => '理赔';

  @override
  String get navPickups => '上门取件';

  @override
  String get navReports => '报表';

  @override
  String get navHts => 'HTS 查询';

  @override
  String get navSectionManage => '跟踪与管理';

  @override
  String get navSectionTools => '工具';

  @override
  String get drawerUnpair => '解除本设备配对';

  @override
  String get statusPreTransit => '待发货';

  @override
  String get statusInTransit => '运输中';

  @override
  String get statusOutForDelivery => '派送中';

  @override
  String get statusDelivered => '已送达';

  @override
  String get statusAvailableForPickup => '可自取';

  @override
  String get statusReturnToSender => '退回寄件人';

  @override
  String get statusFailure => '失败';

  @override
  String get statusCancelled => '已取消';

  @override
  String get statusError => '错误';

  @override
  String get statusUnknown => '未知';

  @override
  String get carrierUnknown => '承运商未知';

  @override
  String get carrierUnknownShort => '未知';

  @override
  String get sortTooltip => '排序';

  @override
  String get sortByStatus => '按状态排序';

  @override
  String get sortByCarrier => '按承运商排序';

  @override
  String get sortByCode => '按追踪号排序';

  @override
  String get sortByUpdated => '按最近更新排序';

  @override
  String get filterTooltip => '筛选';

  @override
  String get filterHideDelivered => '隐藏已送达';

  @override
  String get filterStatusHeading => '状态';

  @override
  String get filterCarrierHeading => '承运商';

  @override
  String get filterReset => '重置筛选';

  @override
  String get trackersEmpty => '尚未追踪任何包裹。';

  @override
  String trackersShowing(int shown, int total) {
    return '显示 $total 件中的 $shown 件';
  }

  @override
  String get trackersNoMatch => '没有符合当前筛选条件的内容。';

  @override
  String etaLabel(String date) {
    return '预计 $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return '预计送达 $date';
  }

  @override
  String detailSignedBy(String name) {
    return '签收人：$name';
  }

  @override
  String get detailHistoryHeading => '历史';

  @override
  String get detailNoScanHistory => '暂无扫描记录。';

  @override
  String get detailMapUnavailable => '这些地点暂无地图。';

  @override
  String get historyEmpty => '暂无包裹。';

  @override
  String get insuranceEmpty => '暂无保单。点按“购买保险”。';

  @override
  String get insuranceBuy => '购买保险';

  @override
  String get insuranceAmountRange => '投保金额必须介于 0.01 至 5,000 美元之间。';

  @override
  String get insuranceNotEnabled =>
      '此 EasyPost 账户未启用独立保险。请联系 EasyPost 支持团队开通，或在购买面单时添加保险。';

  @override
  String get insuranceFromAddress => '寄件地址';

  @override
  String get insuranceToAddress => '收件地址';

  @override
  String get fieldTrackingCode => '追踪号';

  @override
  String get fieldCarrierHint => '承运商（例如 USPS）';

  @override
  String get fieldInsuredAmount => '投保金额（美元）';

  @override
  String get fieldName => '姓名';

  @override
  String get fieldStreet => '街道';

  @override
  String get fieldCity => '城市';

  @override
  String get fieldStateRegion => '州 / 地区';

  @override
  String get fieldPostcode => '邮政编码';

  @override
  String get fieldCountryIso => '国家（ISO，例如 US）';

  @override
  String get fieldType => '类型';

  @override
  String get fieldAmountUsd => '金额（美元）';

  @override
  String get fieldContactEmail => '联系邮箱';

  @override
  String get fieldDescription => '说明';

  @override
  String get validationRequired => '必填';

  @override
  String get validationEnterAmount => '请输入金额';

  @override
  String get validationEnterEmail => '请输入邮箱地址';

  @override
  String get validationDescribeIssue => '请描述问题';

  @override
  String get claimsEmpty => '暂无理赔。点按“提交理赔”。';

  @override
  String get claimsFile => '提交理赔';

  @override
  String get claimSubmit => '发送理赔';

  @override
  String get claimTypeDamage => '损坏';

  @override
  String get claimTypeTheft => '被盗';

  @override
  String get claimTypeLoss => '丢失';

  @override
  String get claimAttachmentNote => '损坏与被盗理赔需要照片或发票作为凭证。请在可添加附件的桌面应用中提交。';

  @override
  String get claimAttachmentSnack => '损坏与被盗理赔需要凭证，只能在桌面应用中添加附件。丢失理赔可以在此提交。';

  @override
  String get pickupsEmpty => '尚未预约取件。';

  @override
  String get pickupCancelTitle => '取消取件？';

  @override
  String pickupCancelBody(String id) {
    return '取消取件 $id？此操作无法撤销。';
  }

  @override
  String get pickupKeep => '保留';

  @override
  String get pickupCancelConfirm => '取消取件';

  @override
  String get actionCancel => '取消';

  @override
  String get reportsShipments => '包裹数';

  @override
  String get reportsTotalSpend => '总支出';

  @override
  String get reportsByCarrier => '按承运商';

  @override
  String get reportsEmpty => '暂无已购买的包裹可供统计。';

  @override
  String reportsCarrierShipments(int count) {
    return '包裹：$count';
  }

  @override
  String get htsSearchLabel => '搜索关税编码';

  @override
  String get htsSearchHint => '例如 铜线';

  @override
  String get htsSearchButton => '搜索';

  @override
  String get htsDisclaimer =>
      '数据参考自 U.S. International Trade Commission。正确归类仍由寄件人负责。';

  @override
  String get htsPrompt => '请在上方搜索关税编码。';

  @override
  String get htsNoResults => '未找到匹配的关税编码。';

  @override
  String htsRateGeneral(String rate) {
    return '一般 $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return '特别 $rate';
  }

  @override
  String htsRateOther(String rate) {
    return '其他 $rate';
  }

  @override
  String get htsCopyTooltip => '复制编码';

  @override
  String htsCopied(String code) {
    return '已复制 $code';
  }

  @override
  String htsUnavailable(int code) {
    return '关税服务不可用（错误 $code）。请重试。';
  }

  @override
  String get pairTitle => '与桌面端配对';

  @override
  String get pairInstructions =>
      '打开 Easy-Post Desktop，选择“配对移动应用”，然后扫描其中显示的二维码。';

  @override
  String get pairEnterReviewCode => '改为输入审核代码';

  @override
  String get pairReviewDialogTitle => '输入审核代码';

  @override
  String get pairReviewCodeHint => '审核代码';

  @override
  String get pairAction => '配对';

  @override
  String get errorPairingCodeInvalid => '该配对码无效或已过期。请在桌面端重新生成。';

  @override
  String get errorReviewCodeRejected => '该审核代码未被接受。';

  @override
  String get errorUnexpectedPairingResponse => '配对服务返回了意外响应。';

  @override
  String get errorNotPaired => '此设备已不再配对。请从桌面端重新配对。';

  @override
  String get errorNotPairedShort => '此设备已不再配对。';

  @override
  String get errorForbidden => '应用不允许执行该操作。';

  @override
  String errorRequestFailed(int code) {
    return '请求失败（错误 $code）。';
  }
}

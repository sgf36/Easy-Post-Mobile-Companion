// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Отслеживание';

  @override
  String get navHistory => 'История';

  @override
  String get navInsurance => 'Страхование';

  @override
  String get navClaims => 'Претензии';

  @override
  String get navPickups => 'Забор груза';

  @override
  String get navReports => 'Отчёты';

  @override
  String get navHts => 'Поиск HTS';

  @override
  String get navSectionManage => 'Отслеживание и управление';

  @override
  String get navSectionTools => 'Инструменты';

  @override
  String get drawerUnpair => 'Отвязать это устройство';

  @override
  String get statusPreTransit => 'До отправки';

  @override
  String get statusInTransit => 'В пути';

  @override
  String get statusOutForDelivery => 'Курьер в пути';

  @override
  String get statusDelivered => 'Доставлено';

  @override
  String get statusAvailableForPickup => 'Готово к получению';

  @override
  String get statusReturnToSender => 'Возврат отправителю';

  @override
  String get statusFailure => 'Сбой доставки';

  @override
  String get statusCancelled => 'Отменено';

  @override
  String get statusError => 'Ошибка';

  @override
  String get statusUnknown => 'Неизвестно';

  @override
  String get carrierUnknown => 'Неизвестный перевозчик';

  @override
  String get carrierUnknownShort => 'Неизвестно';

  @override
  String get sortTooltip => 'Сортировка';

  @override
  String get sortByStatus => 'Сортировать по статусу';

  @override
  String get sortByCarrier => 'Сортировать по перевозчику';

  @override
  String get sortByCode => 'Сортировать по номеру отслеживания';

  @override
  String get sortByUpdated => 'Сортировать по последнему обновлению';

  @override
  String get filterTooltip => 'Фильтр';

  @override
  String get filterHideDelivered => 'Скрыть доставленные';

  @override
  String get filterStatusHeading => 'Статус';

  @override
  String get filterCarrierHeading => 'Перевозчик';

  @override
  String get filterReset => 'Сбросить фильтры';

  @override
  String get trackersEmpty => 'Отслеживаемых отправлений пока нет.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Показано $shown из $total';
  }

  @override
  String get trackersNoMatch => 'Ничего не соответствует текущим фильтрам.';

  @override
  String etaLabel(String date) {
    return 'Ожидается $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Ожидаемая доставка $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Подпись получателя: $name';
  }

  @override
  String get detailHistoryHeading => 'История';

  @override
  String get detailNoScanHistory => 'Событий сканирования пока нет.';

  @override
  String get detailMapUnavailable => 'Карта для этих мест недоступна.';

  @override
  String get historyEmpty => 'Отправлений пока нет.';

  @override
  String get insuranceEmpty =>
      'Полисов пока нет. Нажмите «Оформить страховку».';

  @override
  String get insuranceBuy => 'Оформить страховку';

  @override
  String get insuranceAmountRange =>
      'Страховая сумма должна быть от 0,01 до 5 000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Для этого аккаунта EasyPost не включено отдельное страхование. Обратитесь в поддержку EasyPost, чтобы его включили, или добавляйте страховку при покупке этикетки.';

  @override
  String get insuranceFromAddress => 'Адрес отправителя';

  @override
  String get insuranceToAddress => 'Адрес получателя';

  @override
  String get fieldTrackingCode => 'Номер отслеживания';

  @override
  String get fieldCarrierHint => 'Перевозчик (например, USPS)';

  @override
  String get fieldInsuredAmount => 'Страховая сумма (USD)';

  @override
  String get fieldName => 'Имя';

  @override
  String get fieldStreet => 'Улица';

  @override
  String get fieldCity => 'Город';

  @override
  String get fieldStateRegion => 'Штат / регион';

  @override
  String get fieldPostcode => 'Почтовый индекс';

  @override
  String get fieldCountryIso => 'Страна (ISO, например, US)';

  @override
  String get fieldType => 'Тип';

  @override
  String get fieldAmountUsd => 'Сумма (USD)';

  @override
  String get fieldContactEmail => 'Контактный email';

  @override
  String get fieldDescription => 'Описание';

  @override
  String get validationRequired => 'Обязательно';

  @override
  String get validationEnterAmount => 'Введите сумму';

  @override
  String get validationEnterEmail => 'Введите адрес эл. почты';

  @override
  String get validationDescribeIssue => 'Опишите проблему';

  @override
  String get claimsEmpty => 'Претензий пока нет. Нажмите «Подать претензию».';

  @override
  String get claimsFile => 'Подать претензию';

  @override
  String get claimSubmit => 'Отправить претензию';

  @override
  String get claimTypeDamage => 'Повреждение';

  @override
  String get claimTypeTheft => 'Кража';

  @override
  String get claimTypeLoss => 'Утрата';

  @override
  String get claimAttachmentNote =>
      'Для претензий о повреждении и краже нужны фотография или счёт в качестве подтверждения. Подавайте их в настольном приложении, где можно приложить документы.';

  @override
  String get claimAttachmentSnack =>
      'Для претензий о повреждении и краже нужно подтверждение, которое прикладывается только в настольном приложении. Претензию об утрате можно подать здесь.';

  @override
  String get pickupsEmpty => 'Заборов груза пока не запланировано.';

  @override
  String get pickupCancelTitle => 'Отменить забор груза?';

  @override
  String pickupCancelBody(String id) {
    return 'Отменить забор груза $id? Это действие необратимо.';
  }

  @override
  String get pickupKeep => 'Оставить';

  @override
  String get pickupCancelConfirm => 'Отменить забор';

  @override
  String get actionCancel => 'Отмена';

  @override
  String get reportsShipments => 'Отправления';

  @override
  String get reportsTotalSpend => 'Общие расходы';

  @override
  String get reportsByCarrier => 'По перевозчикам';

  @override
  String get reportsEmpty => 'Оплаченных отправлений для отчёта пока нет.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Отправления: $count';
  }

  @override
  String get htsSearchLabel => 'Поиск тарифных кодов';

  @override
  String get htsSearchHint => 'например, медная проволока';

  @override
  String get htsSearchButton => 'Искать';

  @override
  String get htsDisclaimer =>
      'Справочный поиск по данным U.S. International Trade Commission. Ответственность за правильную классификацию несёт отправитель.';

  @override
  String get htsPrompt => 'Найдите тарифный код выше.';

  @override
  String get htsNoResults => 'Подходящих тарифных кодов нет.';

  @override
  String htsRateGeneral(String rate) {
    return 'Общая $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Льготная $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Прочая $rate';
  }

  @override
  String get htsCopyTooltip => 'Копировать код';

  @override
  String htsCopied(String code) {
    return '$code скопирован';
  }

  @override
  String htsUnavailable(int code) {
    return 'Тарифная служба недоступна (ошибка $code). Повторите попытку.';
  }

  @override
  String get pairTitle => 'Сопряжение с компьютером';

  @override
  String get pairInstructions =>
      'Откройте Easy-Post Desktop, выберите «Сопряжение с мобильным приложением» и отсканируйте показанный QR-код.';

  @override
  String get pairEnterReviewCode => 'Ввести код проверки';

  @override
  String get pairReviewDialogTitle => 'Ввод кода проверки';

  @override
  String get pairReviewCodeHint => 'Код проверки';

  @override
  String get pairAction => 'Связать';

  @override
  String get errorPairingCodeInvalid =>
      'Этот код сопряжения недействителен или истёк. Создайте новый на компьютере.';

  @override
  String get errorReviewCodeRejected => 'Этот код проверки не принят.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Неожиданный ответ службы сопряжения.';

  @override
  String get errorNotPaired =>
      'Это устройство больше не связано. Выполните сопряжение заново с компьютера.';

  @override
  String get errorNotPairedShort => 'Это устройство больше не связано.';

  @override
  String get errorForbidden => 'Это действие недоступно из приложения.';

  @override
  String errorRequestFailed(int code) {
    return 'Запрос не выполнен (ошибка $code).';
  }
}

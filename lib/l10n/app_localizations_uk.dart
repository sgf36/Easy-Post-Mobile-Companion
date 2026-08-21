// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Відстеження';

  @override
  String get navHistory => 'Історія';

  @override
  String get navInsurance => 'Страхування';

  @override
  String get navClaims => 'Претензії';

  @override
  String get navPickups => 'Забори';

  @override
  String get navReports => 'Звіти';

  @override
  String get navHts => 'Пошук HTS';

  @override
  String get navSectionManage => 'Відстеження та керування';

  @override
  String get navSectionTools => 'Інструменти';

  @override
  String get drawerUnpair => 'Відв’язати цей пристрій';

  @override
  String get statusPreTransit => 'До відправлення';

  @override
  String get statusInTransit => 'У дорозі';

  @override
  String get statusOutForDelivery => 'Курʼєр у дорозі';

  @override
  String get statusDelivered => 'Доставлено';

  @override
  String get statusAvailableForPickup => 'Готово до отримання';

  @override
  String get statusReturnToSender => 'Повернення відправнику';

  @override
  String get statusFailure => 'Невдала доставка';

  @override
  String get statusCancelled => 'Скасовано';

  @override
  String get statusError => 'Помилка';

  @override
  String get statusUnknown => 'Невідомо';

  @override
  String get carrierUnknown => 'Невідомий перевізник';

  @override
  String get carrierUnknownShort => 'Невідомо';

  @override
  String get sortTooltip => 'Сортування';

  @override
  String get sortByStatus => 'Сортувати за статусом';

  @override
  String get sortByCarrier => 'Сортувати за перевізником';

  @override
  String get sortByCode => 'Сортувати за номером відстеження';

  @override
  String get sortByUpdated => 'Сортувати за останнім оновленням';

  @override
  String get filterTooltip => 'Фільтр';

  @override
  String get filterHideDelivered => 'Приховати доставлені';

  @override
  String get filterStatusHeading => 'Статус';

  @override
  String get filterCarrierHeading => 'Перевізник';

  @override
  String get filterReset => 'Скинути фільтри';

  @override
  String get trackersEmpty => 'Наразі не відстежується жодне відправлення.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Показано $shown із $total';
  }

  @override
  String get trackersNoMatch => 'Нічого не відповідає поточним фільтрам.';

  @override
  String etaLabel(String date) {
    return 'Орієнт. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Орієнтовна доставка $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Підпис одержувача: $name';
  }

  @override
  String get detailHistoryHeading => 'Історія';

  @override
  String get detailNoScanHistory => 'Подій сканування ще немає.';

  @override
  String get detailMapUnavailable => 'Карта для цих місць недоступна.';

  @override
  String get historyEmpty => 'Відправлень ще немає.';

  @override
  String get insuranceEmpty => 'Полісів ще немає.';

  @override
  String get insuranceBuy => 'Придбати страхування';

  @override
  String get insuranceAmountRange =>
      'Страхова сума має бути від 0,01 до 5 000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Цей обліковий запис EasyPost не має дозволу на окреме страхування. Попросіть службу підтримки EasyPost увімкнути його або додавайте страхування під час придбання етикетки.';

  @override
  String get insuranceFromAddress => 'Адреса відправника';

  @override
  String get insuranceToAddress => 'Адреса одержувача';

  @override
  String get fieldTrackingCode => 'Номер відстеження';

  @override
  String get fieldCarrierHint => 'Перевізник (наприклад, USPS)';

  @override
  String get fieldInsuredAmount => 'Страхова сума (USD)';

  @override
  String get fieldName => 'Ім’я';

  @override
  String get fieldStreet => 'Вулиця';

  @override
  String get fieldCity => 'Місто';

  @override
  String get fieldStateRegion => 'Штат / регіон';

  @override
  String get fieldPostcode => 'Поштовий індекс';

  @override
  String get fieldCountryIso => 'Країна (ISO, наприклад, US)';

  @override
  String get fieldType => 'Тип';

  @override
  String get fieldAmountUsd => 'Сума (USD)';

  @override
  String get fieldContactEmail => 'Контактна електронна пошта';

  @override
  String get fieldDescription => 'Опис';

  @override
  String get validationRequired => 'Обов’язково';

  @override
  String get validationEnterAmount => 'Введіть суму';

  @override
  String get validationEnterEmail => 'Введіть електронну пошту';

  @override
  String get validationDescribeIssue => 'Опишіть проблему';

  @override
  String get claimsEmpty => 'Претензій ще немає.';

  @override
  String get claimsFile => 'Подати претензію';

  @override
  String get claimSubmit => 'Надіслати претензію';

  @override
  String get claimTypeDamage => 'Пошкодження';

  @override
  String get claimTypeTheft => 'Крадіжка';

  @override
  String get claimTypeLoss => 'Втрата';

  @override
  String get claimAttachmentNote =>
      'Претензії щодо пошкодження та крадіжки потребують фотографії або рахунку як підтвердження. Подавайте їх у настільному застосунку, де можна долучити документи.';

  @override
  String get claimAttachmentSnack =>
      'Претензії щодо пошкодження та крадіжки потребують підтвердження, яке можна долучити лише в настільному застосунку. Претензію щодо втрати можна подати тут.';

  @override
  String get pickupsEmpty => 'Заборів ще не заплановано.';

  @override
  String get pickupCancelTitle => 'Скасувати забір?';

  @override
  String pickupCancelBody(String id) {
    return 'Скасувати забір $id? Цю дію неможливо скасувати.';
  }

  @override
  String get pickupKeep => 'Залишити';

  @override
  String get pickupCancelConfirm => 'Скасувати забір';

  @override
  String get actionCancel => 'Скасувати';

  @override
  String get reportsShipments => 'Відправлення';

  @override
  String get reportsTotalSpend => 'Загальні витрати';

  @override
  String get reportsByCarrier => 'За перевізником';

  @override
  String get reportsEmpty => 'Оплачених відправлень для звіту ще немає.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Відправлення: $count';
  }

  @override
  String get htsSearchLabel => 'Пошук тарифних кодів';

  @override
  String get htsSearchHint => 'наприклад, мідний дріт';

  @override
  String get htsSearchButton => 'Шукати';

  @override
  String get htsDisclaimer =>
      'Довідковий пошук за даними U.S. International Trade Commission. Відповідальність за правильну класифікацію несе відправник.';

  @override
  String get htsPrompt => 'Знайдіть тарифний код вище.';

  @override
  String get htsNoResults => 'Відповідних тарифних кодів немає.';

  @override
  String htsRateGeneral(String rate) {
    return 'Загальна $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Пільгова $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Інша $rate';
  }

  @override
  String get htsCopyTooltip => 'Скопіювати код';

  @override
  String htsCopied(String code) {
    return '$code скопійовано';
  }

  @override
  String htsUnavailable(int code) {
    return 'Тарифна служба недоступна (помилка $code). Спробуйте ще раз.';
  }

  @override
  String get pairTitle => 'Прив’язати до комп’ютера';

  @override
  String get pairInstructions =>
      'Відкрийте Easy-Post Desktop, виберіть «Прив’язати мобільний додаток» і відскануйте показаний QR-код.';

  @override
  String get pairEnterReviewCode => 'Ввести код перевірки';

  @override
  String get pairReviewDialogTitle => 'Введення коду перевірки';

  @override
  String get pairReviewCodeHint => 'Код перевірки';

  @override
  String get pairAction => 'Прив’язати';

  @override
  String get errorPairingCodeInvalid =>
      'Цей код прив’язки недійсний або застарів. Створіть новий на комп’ютері.';

  @override
  String get errorReviewCodeRejected => 'Цей код перевірки не прийнято.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Неочікувана відповідь служби прив’язки.';

  @override
  String get errorNotPaired =>
      'Цей пристрій більше не прив’язано. Прив’яжіть його знову з комп’ютера.';

  @override
  String get errorNotPairedShort => 'Цей пристрій більше не прив’язано.';

  @override
  String get errorForbidden => 'Ця дія недоступна з додатка.';

  @override
  String errorRequestFailed(int code) {
    return 'Запит не виконано (помилка $code).';
  }

  @override
  String get detailShipment => 'Відправлення';

  @override
  String get detailInsurancePolicy => 'Страховий поліс';

  @override
  String get detailClaim => 'Претензія';

  @override
  String get detailPickup => 'Забір';

  @override
  String get fieldCarrier => 'Перевізник';

  @override
  String get fieldService => 'Послуга';

  @override
  String get fieldStatus => 'Статус';

  @override
  String get fieldCreated => 'Створено';

  @override
  String get fieldAmount => 'Сума';

  @override
  String get fieldProvider => 'Постачальник';

  @override
  String get fieldReference => 'Посилання';

  @override
  String get fieldPickupWindow => 'Інтервал забору';

  @override
  String get fieldCost => 'Вартість';

  @override
  String get detailNothingFurther => 'Додаткових відомостей немає.';

  @override
  String get navRefunds => 'Повернення коштів';

  @override
  String get refundsEmpty => 'Повернення коштів ще не запитувалися.';

  @override
  String get detailRefund => 'Запит на повернення';

  @override
  String get fieldRefundStatus => 'Повернення';

  @override
  String get refundStatusSubmitted => 'Надіслано';

  @override
  String get refundStatusRefunded => 'Повернено';

  @override
  String get refundStatusRejected => 'Відхилено';
}

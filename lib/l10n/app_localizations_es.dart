// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Seguimiento';

  @override
  String get navHistory => 'Historial';

  @override
  String get navInsurance => 'Seguro';

  @override
  String get navClaims => 'Reclamaciones';

  @override
  String get navPickups => 'Recogidas';

  @override
  String get navReports => 'Informes';

  @override
  String get navHts => 'Búsqueda HTS';

  @override
  String get navSectionManage => 'Seguimiento y gestión';

  @override
  String get navSectionTools => 'Herramientas';

  @override
  String get drawerUnpair => 'Desvincular este dispositivo';

  @override
  String get statusPreTransit => 'Pendiente de envío';

  @override
  String get statusInTransit => 'En tránsito';

  @override
  String get statusOutForDelivery => 'En reparto';

  @override
  String get statusDelivered => 'Entregado';

  @override
  String get statusAvailableForPickup => 'Disponible para recoger';

  @override
  String get statusReturnToSender => 'Devuelto al remitente';

  @override
  String get statusFailure => 'Fallido';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get statusError => 'Error';

  @override
  String get statusUnknown => 'Desconocido';

  @override
  String get carrierUnknown => 'Transportista desconocido';

  @override
  String get carrierUnknownShort => 'Desconocido';

  @override
  String get sortTooltip => 'Ordenar';

  @override
  String get sortByStatus => 'Ordenar por estado';

  @override
  String get sortByCarrier => 'Ordenar por transportista';

  @override
  String get sortByCode => 'Ordenar por número de seguimiento';

  @override
  String get sortByUpdated => 'Ordenar por actualización reciente';

  @override
  String get filterTooltip => 'Filtrar';

  @override
  String get filterHideDelivered => 'Ocultar los entregados';

  @override
  String get filterStatusHeading => 'Estado';

  @override
  String get filterCarrierHeading => 'Transportista';

  @override
  String get filterReset => 'Restablecer filtros';

  @override
  String get trackersEmpty => 'Todavía no se sigue ningún envío.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Mostrando $shown de $total';
  }

  @override
  String get trackersNoMatch => 'Nada coincide con los filtros actuales.';

  @override
  String etaLabel(String date) {
    return 'Prev. $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Entrega estimada $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Firmado por $name';
  }

  @override
  String get detailHistoryHeading => 'Historial';

  @override
  String get detailNoScanHistory => 'Todavía no hay registros de escaneo.';

  @override
  String get detailMapUnavailable =>
      'Mapa no disponible para estas ubicaciones.';

  @override
  String get historyEmpty => 'Todavía no hay envíos.';

  @override
  String get insuranceEmpty => 'Todavía no hay pólizas.';

  @override
  String get insuranceBuy => 'Comprar seguro';

  @override
  String get insuranceAmountRange =>
      'El valor asegurado debe estar entre 0,01 y 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Esta cuenta de EasyPost no está habilitada para el seguro independiente. Pide al soporte de EasyPost que lo habilite, o añade el seguro al comprar la etiqueta.';

  @override
  String get insuranceFromAddress => 'Dirección de origen';

  @override
  String get insuranceToAddress => 'Dirección de destino';

  @override
  String get fieldTrackingCode => 'Número de seguimiento';

  @override
  String get fieldCarrierHint => 'Transportista (p. ej. USPS)';

  @override
  String get fieldInsuredAmount => 'Valor asegurado (USD)';

  @override
  String get fieldName => 'Nombre';

  @override
  String get fieldStreet => 'Calle';

  @override
  String get fieldCity => 'Ciudad';

  @override
  String get fieldStateRegion => 'Estado / región';

  @override
  String get fieldPostcode => 'Código postal';

  @override
  String get fieldCountryIso => 'País (ISO, p. ej. US)';

  @override
  String get fieldType => 'Tipo';

  @override
  String get fieldAmountUsd => 'Importe (USD)';

  @override
  String get fieldContactEmail => 'Correo de contacto';

  @override
  String get fieldDescription => 'Descripción';

  @override
  String get validationRequired => 'Obligatorio';

  @override
  String get validationEnterAmount => 'Introduce un importe';

  @override
  String get validationEnterEmail => 'Introduce un correo electrónico';

  @override
  String get validationDescribeIssue => 'Describe el problema';

  @override
  String get claimsEmpty => 'Todavía no hay reclamaciones.';

  @override
  String get claimsFile => 'Presentar una reclamación';

  @override
  String get claimSubmit => 'Presentar reclamación';

  @override
  String get claimTypeDamage => 'Daño';

  @override
  String get claimTypeTheft => 'Robo';

  @override
  String get claimTypeLoss => 'Pérdida';

  @override
  String get claimAttachmentNote =>
      'Las reclamaciones por daño y robo necesitan una foto o factura justificativa. Preséntalas en la aplicación de escritorio, donde se pueden adjuntar documentos.';

  @override
  String get claimAttachmentSnack =>
      'Las reclamaciones por daño y robo necesitan un justificante, que solo se puede adjuntar en la aplicación de escritorio. Una reclamación por pérdida sí se puede presentar aquí.';

  @override
  String get pickupsEmpty => 'Todavía no hay recogidas programadas.';

  @override
  String get pickupCancelTitle => '¿Cancelar la recogida?';

  @override
  String pickupCancelBody(String id) {
    return '¿Cancelar la recogida $id? Esta acción no se puede deshacer.';
  }

  @override
  String get pickupKeep => 'Mantener';

  @override
  String get pickupCancelConfirm => 'Cancelar recogida';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get reportsShipments => 'Envíos';

  @override
  String get reportsTotalSpend => 'Gasto total';

  @override
  String get reportsByCarrier => 'Por transportista';

  @override
  String get reportsEmpty => 'Todavía no hay envíos comprados que informar.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Envíos: $count';
  }

  @override
  String get htsSearchLabel => 'Buscar códigos arancelarios';

  @override
  String get htsSearchHint => 'p. ej. hilo de cobre';

  @override
  String get htsSearchButton => 'Buscar';

  @override
  String get htsDisclaimer =>
      'Consulta de referencia de la U.S. International Trade Commission. La clasificación correcta sigue siendo responsabilidad del expedidor.';

  @override
  String get htsPrompt => 'Busca un código arancelario arriba.';

  @override
  String get htsNoResults => 'No hay códigos arancelarios coincidentes.';

  @override
  String htsRateGeneral(String rate) {
    return 'General $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Especial $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Otro $rate';
  }

  @override
  String get htsCopyTooltip => 'Copiar código';

  @override
  String htsCopied(String code) {
    return '$code copiado';
  }

  @override
  String htsUnavailable(int code) {
    return 'El servicio arancelario no está disponible (error $code). Inténtalo de nuevo.';
  }

  @override
  String get pairTitle => 'Vincular con el escritorio';

  @override
  String get pairInstructions =>
      'Abre Easy-Post Desktop, elige «Emparejar aplicación móvil» y escanea el código QR que aparece.';

  @override
  String get pairEnterReviewCode => 'Introducir un código de revisión';

  @override
  String get pairReviewDialogTitle => 'Introducir código de revisión';

  @override
  String get pairReviewCodeHint => 'Código de revisión';

  @override
  String get pairAction => 'Vincular';

  @override
  String get errorPairingCodeInvalid =>
      'Ese código de vinculación no es válido o ha caducado. Genera uno nuevo en el escritorio.';

  @override
  String get errorReviewCodeRejected =>
      'Ese código de revisión no se ha aceptado.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Respuesta inesperada del servicio de vinculación.';

  @override
  String get errorNotPaired =>
      'Este dispositivo ya no está vinculado. Vuelve a vincularlo desde el escritorio.';

  @override
  String get errorNotPairedShort => 'Este dispositivo ya no está vinculado.';

  @override
  String get errorForbidden =>
      'Esa acción no está permitida desde la aplicación.';

  @override
  String errorRequestFailed(int code) {
    return 'La solicitud ha fallado (error $code).';
  }

  @override
  String get detailShipment => 'Envío';

  @override
  String get detailInsurancePolicy => 'Póliza de seguro';

  @override
  String get detailClaim => 'Reclamación';

  @override
  String get detailPickup => 'Recogida';

  @override
  String get fieldCarrier => 'Transportista';

  @override
  String get fieldService => 'Servicio';

  @override
  String get fieldStatus => 'Estado';

  @override
  String get fieldCreated => 'Creado';

  @override
  String get fieldAmount => 'Importe';

  @override
  String get fieldProvider => 'Proveedor';

  @override
  String get fieldReference => 'Referencia';

  @override
  String get fieldPickupWindow => 'Franja de recogida';

  @override
  String get fieldCost => 'Coste';

  @override
  String get detailNothingFurther => 'No hay más detalles.';

  @override
  String get navRefunds => 'Reembolsos';

  @override
  String get refundsEmpty => 'Todavía no se ha solicitado ningún reembolso.';

  @override
  String get detailRefund => 'Solicitud de reembolso';

  @override
  String get fieldRefundStatus => 'Reembolso';

  @override
  String get refundStatusSubmitted => 'Enviado';

  @override
  String get refundStatusRefunded => 'Reembolsado';

  @override
  String get refundStatusRejected => 'Rechazado';
}

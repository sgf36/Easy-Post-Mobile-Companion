// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Rastreamento';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navInsurance => 'Seguro';

  @override
  String get navClaims => 'Reclamações';

  @override
  String get navPickups => 'Coletas';

  @override
  String get navReports => 'Relatórios';

  @override
  String get navHts => 'Consulta HTS';

  @override
  String get navSectionManage => 'Rastrear e gerenciar';

  @override
  String get navSectionTools => 'Ferramentas';

  @override
  String get drawerUnpair => 'Desparear este dispositivo';

  @override
  String get statusPreTransit => 'Antes do transporte';

  @override
  String get statusInTransit => 'Em trânsito';

  @override
  String get statusOutForDelivery => 'Saiu para entrega';

  @override
  String get statusDelivered => 'Entregue';

  @override
  String get statusAvailableForPickup => 'Disponível para retirada';

  @override
  String get statusReturnToSender => 'Devolvido ao remetente';

  @override
  String get statusFailure => 'Falhou';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get statusError => 'Erro';

  @override
  String get statusUnknown => 'Desconhecido';

  @override
  String get carrierUnknown => 'Transportadora desconhecida';

  @override
  String get carrierUnknownShort => 'Desconhecida';

  @override
  String get sortTooltip => 'Ordenar';

  @override
  String get sortByStatus => 'Ordenar por status';

  @override
  String get sortByCarrier => 'Ordenar por transportadora';

  @override
  String get sortByCode => 'Ordenar por código de rastreamento';

  @override
  String get sortByUpdated => 'Ordenar por atualização recente';

  @override
  String get filterTooltip => 'Filtrar';

  @override
  String get filterHideDelivered => 'Ocultar entregues';

  @override
  String get filterStatusHeading => 'Status';

  @override
  String get filterCarrierHeading => 'Transportadora';

  @override
  String get filterReset => 'Redefinir filtros';

  @override
  String get trackersEmpty => 'Nenhum envio está sendo rastreado ainda.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Mostrando $shown de $total';
  }

  @override
  String get trackersNoMatch => 'Nada corresponde aos filtros atuais.';

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
    return 'Assinado por $name';
  }

  @override
  String get detailHistoryHeading => 'Histórico';

  @override
  String get detailNoScanHistory => 'Ainda sem registros de leitura.';

  @override
  String get detailMapUnavailable => 'Mapa indisponível para estes locais.';

  @override
  String get historyEmpty => 'Ainda não há envios.';

  @override
  String get insuranceEmpty =>
      'Ainda não há apólices. Toque em «Comprar seguro».';

  @override
  String get insuranceBuy => 'Comprar seguro';

  @override
  String get insuranceAmountRange =>
      'O valor segurado deve estar entre 0,01 e 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Esta conta EasyPost não está habilitada para seguro avulso. Peça ao suporte da EasyPost para habilitar, ou adicione o seguro ao comprar a etiqueta.';

  @override
  String get insuranceFromAddress => 'Endereço de origem';

  @override
  String get insuranceToAddress => 'Endereço de destino';

  @override
  String get fieldTrackingCode => 'Código de rastreamento';

  @override
  String get fieldCarrierHint => 'Transportadora (ex.: USPS)';

  @override
  String get fieldInsuredAmount => 'Valor segurado (USD)';

  @override
  String get fieldName => 'Nome';

  @override
  String get fieldStreet => 'Rua';

  @override
  String get fieldCity => 'Cidade';

  @override
  String get fieldStateRegion => 'Estado / região';

  @override
  String get fieldPostcode => 'CEP';

  @override
  String get fieldCountryIso => 'País (ISO, ex.: US)';

  @override
  String get fieldType => 'Tipo';

  @override
  String get fieldAmountUsd => 'Valor (USD)';

  @override
  String get fieldContactEmail => 'E-mail de contato';

  @override
  String get fieldDescription => 'Descrição';

  @override
  String get validationRequired => 'Obrigatório';

  @override
  String get validationEnterAmount => 'Informe um valor';

  @override
  String get validationEnterEmail => 'Informe um e-mail';

  @override
  String get validationDescribeIssue => 'Descreva o problema';

  @override
  String get claimsEmpty =>
      'Ainda não há reclamações. Toque em «Abrir uma reclamação».';

  @override
  String get claimsFile => 'Abrir uma reclamação';

  @override
  String get claimSubmit => 'Registrar reclamação';

  @override
  String get claimTypeDamage => 'Dano';

  @override
  String get claimTypeTheft => 'Roubo';

  @override
  String get claimTypeLoss => 'Perda';

  @override
  String get claimAttachmentNote =>
      'Reclamações de dano e roubo exigem uma foto ou nota fiscal como comprovante. Registre-as no aplicativo de desktop, onde é possível anexar documentos.';

  @override
  String get claimAttachmentSnack =>
      'Reclamações de dano e roubo exigem um comprovante, que só pode ser anexado no aplicativo de desktop. Uma reclamação de perda pode ser registrada aqui.';

  @override
  String get pickupsEmpty => 'Ainda não há coletas agendadas.';

  @override
  String get pickupCancelTitle => 'Cancelar a coleta?';

  @override
  String pickupCancelBody(String id) {
    return 'Cancelar a coleta $id? Esta ação não pode ser desfeita.';
  }

  @override
  String get pickupKeep => 'Manter';

  @override
  String get pickupCancelConfirm => 'Cancelar coleta';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get reportsShipments => 'Envios';

  @override
  String get reportsTotalSpend => 'Gasto total';

  @override
  String get reportsByCarrier => 'Por transportadora';

  @override
  String get reportsEmpty => 'Ainda não há envios comprados para relatar.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Envios: $count';
  }

  @override
  String get htsSearchLabel => 'Pesquisar códigos tarifários';

  @override
  String get htsSearchHint => 'ex.: fio de cobre';

  @override
  String get htsSearchButton => 'Pesquisar';

  @override
  String get htsDisclaimer =>
      'Consulta de referência da U.S. International Trade Commission. A classificação correta continua sendo responsabilidade do expedidor.';

  @override
  String get htsPrompt => 'Pesquise um código tarifário acima.';

  @override
  String get htsNoResults => 'Nenhum código tarifário correspondente.';

  @override
  String htsRateGeneral(String rate) {
    return 'Geral $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Especial $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Outra $rate';
  }

  @override
  String get htsCopyTooltip => 'Copiar código';

  @override
  String htsCopied(String code) {
    return '$code copiado';
  }

  @override
  String htsUnavailable(int code) {
    return 'O serviço tarifário está indisponível (erro $code). Tente novamente.';
  }

  @override
  String get pairTitle => 'Parear com o desktop';

  @override
  String get pairInstructions =>
      'Abra o Easy-Post Desktop, escolha «Parear aplicativo móvel» e leia o código QR exibido.';

  @override
  String get pairEnterReviewCode => 'Inserir um código de revisão';

  @override
  String get pairReviewDialogTitle => 'Inserir código de revisão';

  @override
  String get pairReviewCodeHint => 'Código de revisão';

  @override
  String get pairAction => 'Parear';

  @override
  String get errorPairingCodeInvalid =>
      'Esse código de pareamento é inválido ou expirou. Gere um novo no desktop.';

  @override
  String get errorReviewCodeRejected =>
      'Esse código de revisão não foi aceito.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Resposta inesperada do serviço de pareamento.';

  @override
  String get errorNotPaired =>
      'Este dispositivo não está mais pareado. Pareie-o novamente pelo desktop.';

  @override
  String get errorNotPairedShort => 'Este dispositivo não está mais pareado.';

  @override
  String get errorForbidden => 'Essa ação não é permitida pelo aplicativo.';

  @override
  String errorRequestFailed(int code) {
    return 'A solicitação falhou (erro $code).';
  }

  @override
  String get detailShipment => 'Envio';

  @override
  String get detailInsurancePolicy => 'Apólice de seguro';

  @override
  String get detailClaim => 'Reclamação';

  @override
  String get detailPickup => 'Recolha';

  @override
  String get fieldCarrier => 'Transportadora';

  @override
  String get fieldService => 'Serviço';

  @override
  String get fieldStatus => 'Estado';

  @override
  String get fieldCreated => 'Criado';

  @override
  String get fieldAmount => 'Valor';

  @override
  String get fieldProvider => 'Fornecedor';

  @override
  String get fieldReference => 'Referência';

  @override
  String get fieldPickupWindow => 'Janela de recolha';

  @override
  String get fieldCost => 'Custo';

  @override
  String get detailNothingFurther => 'Sem mais detalhes.';
}

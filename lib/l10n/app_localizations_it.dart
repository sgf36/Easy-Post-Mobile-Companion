// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Tracciamento';

  @override
  String get navHistory => 'Cronologia';

  @override
  String get navInsurance => 'Assicurazione';

  @override
  String get navClaims => 'Reclami';

  @override
  String get navPickups => 'Ritiri';

  @override
  String get navReports => 'Report';

  @override
  String get navHts => 'Ricerca HTS';

  @override
  String get navSectionManage => 'Traccia e gestisci';

  @override
  String get navSectionTools => 'Strumenti';

  @override
  String get drawerUnpair => 'Scollega questo dispositivo';

  @override
  String get statusPreTransit => 'In preparazione';

  @override
  String get statusInTransit => 'In transito';

  @override
  String get statusOutForDelivery => 'In consegna';

  @override
  String get statusDelivered => 'Consegnato';

  @override
  String get statusAvailableForPickup => 'Disponibile al ritiro';

  @override
  String get statusReturnToSender => 'Restituito al mittente';

  @override
  String get statusFailure => 'Non riuscito';

  @override
  String get statusCancelled => 'Annullato';

  @override
  String get statusError => 'Errore';

  @override
  String get statusUnknown => 'Sconosciuto';

  @override
  String get carrierUnknown => 'Corriere sconosciuto';

  @override
  String get carrierUnknownShort => 'Sconosciuto';

  @override
  String get sortTooltip => 'Ordina';

  @override
  String get sortByStatus => 'Ordina per stato';

  @override
  String get sortByCarrier => 'Ordina per corriere';

  @override
  String get sortByCode => 'Ordina per numero di tracciamento';

  @override
  String get sortByUpdated => 'Ordina per aggiornamento recente';

  @override
  String get filterTooltip => 'Filtra';

  @override
  String get filterHideDelivered => 'Nascondi i consegnati';

  @override
  String get filterStatusHeading => 'Stato';

  @override
  String get filterCarrierHeading => 'Corriere';

  @override
  String get filterReset => 'Reimposta i filtri';

  @override
  String get trackersEmpty => 'Nessuna spedizione è ancora tracciata.';

  @override
  String trackersShowing(int shown, int total) {
    return 'Visualizzati $shown di $total';
  }

  @override
  String get trackersNoMatch => 'Nessun risultato per i filtri attuali.';

  @override
  String etaLabel(String date) {
    return 'Prevista $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Consegna stimata $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Firmato da $name';
  }

  @override
  String get detailHistoryHeading => 'Cronologia';

  @override
  String get detailNoScanHistory => 'Ancora nessuna scansione.';

  @override
  String get detailMapUnavailable =>
      'Mappa non disponibile per queste località.';

  @override
  String get historyEmpty => 'Ancora nessuna spedizione.';

  @override
  String get insuranceEmpty =>
      'Ancora nessuna polizza. Tocca «Acquista assicurazione».';

  @override
  String get insuranceBuy => 'Acquista assicurazione';

  @override
  String get insuranceAmountRange =>
      'Il valore assicurato deve essere compreso tra 0,01 e 5.000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Questo account EasyPost non è abilitato all’assicurazione indipendente. Chiedi al supporto EasyPost di abilitarla, oppure aggiungi l’assicurazione al momento dell’acquisto dell’etichetta.';

  @override
  String get insuranceFromAddress => 'Indirizzo del mittente';

  @override
  String get insuranceToAddress => 'Indirizzo del destinatario';

  @override
  String get fieldTrackingCode => 'Numero di tracciamento';

  @override
  String get fieldCarrierHint => 'Corriere (es. USPS)';

  @override
  String get fieldInsuredAmount => 'Valore assicurato (USD)';

  @override
  String get fieldName => 'Nome';

  @override
  String get fieldStreet => 'Via';

  @override
  String get fieldCity => 'Città';

  @override
  String get fieldStateRegion => 'Stato / regione';

  @override
  String get fieldPostcode => 'CAP';

  @override
  String get fieldCountryIso => 'Paese (ISO, es. US)';

  @override
  String get fieldType => 'Tipo';

  @override
  String get fieldAmountUsd => 'Importo (USD)';

  @override
  String get fieldContactEmail => 'Email di contatto';

  @override
  String get fieldDescription => 'Descrizione';

  @override
  String get validationRequired => 'Obbligatorio';

  @override
  String get validationEnterAmount => 'Inserisci un importo';

  @override
  String get validationEnterEmail => 'Inserisci un indirizzo email';

  @override
  String get validationDescribeIssue => 'Descrivi il problema';

  @override
  String get claimsEmpty =>
      'Ancora nessun reclamo. Tocca «Presenta un reclamo».';

  @override
  String get claimsFile => 'Presenta un reclamo';

  @override
  String get claimSubmit => 'Presenta reclamo';

  @override
  String get claimTypeDamage => 'Danno';

  @override
  String get claimTypeTheft => 'Furto';

  @override
  String get claimTypeLoss => 'Smarrimento';

  @override
  String get claimAttachmentNote =>
      'I reclami per danno e furto richiedono una foto o una fattura a supporto. Presentali dall’app desktop, dove è possibile allegare documenti.';

  @override
  String get claimAttachmentSnack =>
      'I reclami per danno e furto richiedono un documento di supporto, allegabile solo dall’app desktop. Un reclamo per smarrimento può essere presentato qui.';

  @override
  String get pickupsEmpty => 'Nessun ritiro programmato.';

  @override
  String get pickupCancelTitle => 'Annullare il ritiro?';

  @override
  String pickupCancelBody(String id) {
    return 'Annullare il ritiro $id? L’operazione non può essere annullata.';
  }

  @override
  String get pickupKeep => 'Mantieni';

  @override
  String get pickupCancelConfirm => 'Annulla ritiro';

  @override
  String get actionCancel => 'Annulla';

  @override
  String get reportsShipments => 'Spedizioni';

  @override
  String get reportsTotalSpend => 'Spesa totale';

  @override
  String get reportsByCarrier => 'Per corriere';

  @override
  String get reportsEmpty =>
      'Ancora nessuna spedizione acquistata da riportare.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Spedizioni: $count';
  }

  @override
  String get htsSearchLabel => 'Cerca codici tariffari';

  @override
  String get htsSearchHint => 'es. filo di rame';

  @override
  String get htsSearchButton => 'Cerca';

  @override
  String get htsDisclaimer =>
      'Ricerca di riferimento della U.S. International Trade Commission. La corretta classificazione resta responsabilità del mittente.';

  @override
  String get htsPrompt => 'Cerca un codice tariffario qui sopra.';

  @override
  String get htsNoResults => 'Nessun codice tariffario corrispondente.';

  @override
  String htsRateGeneral(String rate) {
    return 'Generale $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Speciale $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Altro $rate';
  }

  @override
  String get htsCopyTooltip => 'Copia codice';

  @override
  String htsCopied(String code) {
    return '$code copiato';
  }

  @override
  String htsUnavailable(int code) {
    return 'Il servizio tariffario non è disponibile (errore $code). Riprova.';
  }

  @override
  String get pairTitle => 'Associa al desktop';

  @override
  String get pairInstructions =>
      'Apri Easy-Post Desktop, scegli «Associa app mobile» e inquadra il codice QR mostrato.';

  @override
  String get pairEnterReviewCode => 'Inserisci invece un codice di revisione';

  @override
  String get pairReviewDialogTitle => 'Inserisci il codice di revisione';

  @override
  String get pairReviewCodeHint => 'Codice di revisione';

  @override
  String get pairAction => 'Associa';

  @override
  String get errorPairingCodeInvalid =>
      'Questo codice di associazione non è valido o è scaduto. Generane uno nuovo sul desktop.';

  @override
  String get errorReviewCodeRejected =>
      'Questo codice di revisione non è stato accettato.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Risposta inattesa dal servizio di associazione.';

  @override
  String get errorNotPaired =>
      'Questo dispositivo non è più associato. Associalo di nuovo dal desktop.';

  @override
  String get errorNotPairedShort => 'Questo dispositivo non è più associato.';

  @override
  String get errorForbidden => 'Questa azione non è consentita dall’app.';

  @override
  String errorRequestFailed(int code) {
    return 'Richiesta non riuscita (errore $code).';
  }
}

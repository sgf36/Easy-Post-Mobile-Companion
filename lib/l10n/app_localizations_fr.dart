// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'Suivi';

  @override
  String get navHistory => 'Historique';

  @override
  String get navInsurance => 'Assurance';

  @override
  String get navClaims => 'Réclamations';

  @override
  String get navPickups => 'Enlèvements';

  @override
  String get navReports => 'Rapports';

  @override
  String get navHts => 'Recherche HTS';

  @override
  String get navSectionManage => 'Suivi et gestion';

  @override
  String get navSectionTools => 'Outils';

  @override
  String get drawerUnpair => 'Dissocier cet appareil';

  @override
  String get statusPreTransit => 'Avant expédition';

  @override
  String get statusInTransit => 'En transit';

  @override
  String get statusOutForDelivery => 'En cours de livraison';

  @override
  String get statusDelivered => 'Livré';

  @override
  String get statusAvailableForPickup => 'Disponible en point relais';

  @override
  String get statusReturnToSender => 'Retour à l’expéditeur';

  @override
  String get statusFailure => 'Échec';

  @override
  String get statusCancelled => 'Annulé';

  @override
  String get statusError => 'Erreur';

  @override
  String get statusUnknown => 'Inconnu';

  @override
  String get carrierUnknown => 'Transporteur inconnu';

  @override
  String get carrierUnknownShort => 'Inconnu';

  @override
  String get sortTooltip => 'Trier';

  @override
  String get sortByStatus => 'Trier par statut';

  @override
  String get sortByCarrier => 'Trier par transporteur';

  @override
  String get sortByCode => 'Trier par numéro de suivi';

  @override
  String get sortByUpdated => 'Trier par mise à jour récente';

  @override
  String get filterTooltip => 'Filtrer';

  @override
  String get filterHideDelivered => 'Masquer les colis livrés';

  @override
  String get filterStatusHeading => 'Statut';

  @override
  String get filterCarrierHeading => 'Transporteur';

  @override
  String get filterReset => 'Réinitialiser les filtres';

  @override
  String get trackersEmpty => 'Aucune expédition n’est encore suivie.';

  @override
  String trackersShowing(int shown, int total) {
    return '$shown sur $total affichés';
  }

  @override
  String get trackersNoMatch => 'Rien ne correspond aux filtres actuels.';

  @override
  String etaLabel(String date) {
    return 'Prévu le $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'Livraison estimée le $date';
  }

  @override
  String detailSignedBy(String name) {
    return 'Signé par $name';
  }

  @override
  String get detailHistoryHeading => 'Historique';

  @override
  String get detailNoScanHistory => 'Aucun scan pour le moment.';

  @override
  String get detailMapUnavailable => 'Carte indisponible pour ces lieux.';

  @override
  String get historyEmpty => 'Aucune expédition pour le moment.';

  @override
  String get insuranceEmpty =>
      'Aucune assurance pour le moment. Appuyez sur « Souscrire une assurance ».';

  @override
  String get insuranceBuy => 'Souscrire une assurance';

  @override
  String get insuranceAmountRange =>
      'La valeur assurée doit être comprise entre 0,01 et 5 000 USD.';

  @override
  String get insuranceNotEnabled =>
      'Ce compte EasyPost n’est pas autorisé à souscrire une assurance autonome. Demandez à l’assistance EasyPost de l’activer, ou ajoutez plutôt l’assurance lors de l’achat de l’étiquette.';

  @override
  String get insuranceFromAddress => 'Adresse d’expédition';

  @override
  String get insuranceToAddress => 'Adresse de livraison';

  @override
  String get fieldTrackingCode => 'Numéro de suivi';

  @override
  String get fieldCarrierHint => 'Transporteur (ex. USPS)';

  @override
  String get fieldInsuredAmount => 'Valeur assurée (USD)';

  @override
  String get fieldName => 'Nom';

  @override
  String get fieldStreet => 'Rue';

  @override
  String get fieldCity => 'Ville';

  @override
  String get fieldStateRegion => 'État / région';

  @override
  String get fieldPostcode => 'Code postal';

  @override
  String get fieldCountryIso => 'Pays (ISO, ex. US)';

  @override
  String get fieldType => 'Type';

  @override
  String get fieldAmountUsd => 'Montant (USD)';

  @override
  String get fieldContactEmail => 'E-mail de contact';

  @override
  String get fieldDescription => 'Description';

  @override
  String get validationRequired => 'Obligatoire';

  @override
  String get validationEnterAmount => 'Saisissez un montant';

  @override
  String get validationEnterEmail => 'Saisissez une adresse e-mail';

  @override
  String get validationDescribeIssue => 'Décrivez le problème';

  @override
  String get claimsEmpty =>
      'Aucune réclamation pour le moment. Appuyez sur « Déposer une réclamation ».';

  @override
  String get claimsFile => 'Déposer une réclamation';

  @override
  String get claimSubmit => 'Déposer la réclamation';

  @override
  String get claimTypeDamage => 'Dommage';

  @override
  String get claimTypeTheft => 'Vol';

  @override
  String get claimTypeLoss => 'Perte';

  @override
  String get claimAttachmentNote =>
      'Les réclamations pour dommage et vol exigent une photo ou une facture justificative. Déposez-les depuis l’application de bureau, où des documents peuvent être joints.';

  @override
  String get claimAttachmentSnack =>
      'Les réclamations pour dommage et vol exigent un justificatif, qui ne peut être joint que depuis l’application de bureau. Une réclamation pour perte peut être déposée ici.';

  @override
  String get pickupsEmpty => 'Aucun enlèvement programmé.';

  @override
  String get pickupCancelTitle => 'Annuler l’enlèvement ?';

  @override
  String pickupCancelBody(String id) {
    return 'Annuler l’enlèvement $id ? Cette action est irréversible.';
  }

  @override
  String get pickupKeep => 'Conserver';

  @override
  String get pickupCancelConfirm => 'Annuler l’enlèvement';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get reportsShipments => 'Expéditions';

  @override
  String get reportsTotalSpend => 'Dépenses totales';

  @override
  String get reportsByCarrier => 'Par transporteur';

  @override
  String get reportsEmpty => 'Aucune expédition achetée à présenter.';

  @override
  String reportsCarrierShipments(int count) {
    return 'Expéditions : $count';
  }

  @override
  String get htsSearchLabel => 'Rechercher des codes tarifaires';

  @override
  String get htsSearchHint => 'ex. fil de cuivre';

  @override
  String get htsSearchButton => 'Rechercher';

  @override
  String get htsDisclaimer =>
      'Recherche de référence auprès de la U.S. International Trade Commission. La classification correcte reste la responsabilité de l’expéditeur.';

  @override
  String get htsPrompt => 'Recherchez un code tarifaire ci-dessus.';

  @override
  String get htsNoResults => 'Aucun code tarifaire correspondant.';

  @override
  String htsRateGeneral(String rate) {
    return 'Général $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'Spécial $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'Autre $rate';
  }

  @override
  String get htsCopyTooltip => 'Copier le code';

  @override
  String htsCopied(String code) {
    return '$code copié';
  }

  @override
  String htsUnavailable(int code) {
    return 'Le service tarifaire est indisponible (erreur $code). Veuillez réessayer.';
  }

  @override
  String get pairTitle => 'Jumeler avec le bureau';

  @override
  String get pairInstructions =>
      'Ouvrez Easy-Post Desktop, choisissez « Jumeler l’application mobile », puis scannez le QR code affiché.';

  @override
  String get pairEnterReviewCode => 'Saisir un code de test à la place';

  @override
  String get pairReviewDialogTitle => 'Saisir un code de test';

  @override
  String get pairReviewCodeHint => 'Code de test';

  @override
  String get pairAction => 'Jumeler';

  @override
  String get errorPairingCodeInvalid =>
      'Ce code de jumelage est invalide ou expiré. Générez-en un nouveau sur le bureau.';

  @override
  String get errorReviewCodeRejected => 'Ce code de test n’a pas été accepté.';

  @override
  String get errorUnexpectedPairingResponse =>
      'Réponse inattendue du service de jumelage.';

  @override
  String get errorNotPaired =>
      'Cet appareil n’est plus jumelé. Jumelez-le à nouveau depuis le bureau.';

  @override
  String get errorNotPairedShort => 'Cet appareil n’est plus jumelé.';

  @override
  String get errorForbidden =>
      'Cette action n’est pas autorisée depuis l’application.';

  @override
  String errorRequestFailed(int code) {
    return 'Échec de la requête (erreur $code).';
  }
}

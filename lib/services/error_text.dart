import '../l10n/app_localizations.dart';
import 'hts_service.dart';
import 'proxy_client.dart';

/// Turns a thrown object into a sentence in the reader's language.
///
/// Every screen renders failures the same way — `Text('${snapshot.error}')` —
/// which was fine while the app spoke one language and is not fine now: an
/// untranslated error message is the string a user reads most carefully. The
/// services throw a *kind*, having no `BuildContext` to look up localisations
/// with, and this is the single place that turns kinds into words.
String describeError(AppLocalizations t, Object? error) {
  if (error is ProxyException) {
    switch (error.kind) {
      case ProxyErrorKind.pairingCodeInvalid:
        return t.errorPairingCodeInvalid;
      case ProxyErrorKind.reviewCodeRejected:
        return t.errorReviewCodeRejected;
      case ProxyErrorKind.unexpectedPairingResponse:
        return t.errorUnexpectedPairingResponse;
      case ProxyErrorKind.notPaired:
        return t.errorNotPaired;
      case ProxyErrorKind.notPairedShort:
        return t.errorNotPairedShort;
      case ProxyErrorKind.forbidden:
        return t.errorForbidden;
      case ProxyErrorKind.requestFailed:
        return t.errorRequestFailed(error.statusCode ?? 0);
      case ProxyErrorKind.apiMessage:
        // EasyPost's wording, passed through rather than paraphrased.
        return error.message;
    }
  }
  if (error is HtsUnavailableException) {
    return t.htsUnavailable(error.statusCode);
  }
  return '$error';
}

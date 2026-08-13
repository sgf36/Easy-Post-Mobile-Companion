// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Easy-Post Mobile Companion';

  @override
  String get navTracking => 'ट्रैकिंग';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get navInsurance => 'बीमा';

  @override
  String get navClaims => 'दावे';

  @override
  String get navPickups => 'पिकअप';

  @override
  String get navReports => 'रिपोर्ट';

  @override
  String get navHts => 'HTS खोज';

  @override
  String get navSectionManage => 'ट्रैकिंग और प्रबंधन';

  @override
  String get navSectionTools => 'उपकरण';

  @override
  String get drawerUnpair => 'इस डिवाइस का युग्मन हटाएँ';

  @override
  String get statusPreTransit => 'परिवहन से पहले';

  @override
  String get statusInTransit => 'रास्ते में';

  @override
  String get statusOutForDelivery => 'डिलीवरी के लिए निकला';

  @override
  String get statusDelivered => 'वितरित';

  @override
  String get statusAvailableForPickup => 'पिकअप के लिए उपलब्ध';

  @override
  String get statusReturnToSender => 'प्रेषक को वापस';

  @override
  String get statusFailure => 'विफल';

  @override
  String get statusCancelled => 'रद्द';

  @override
  String get statusError => 'त्रुटि';

  @override
  String get statusUnknown => 'अज्ञात';

  @override
  String get carrierUnknown => 'अज्ञात कैरियर';

  @override
  String get carrierUnknownShort => 'अज्ञात';

  @override
  String get sortTooltip => 'क्रमबद्ध करें';

  @override
  String get sortByStatus => 'स्थिति के अनुसार क्रमबद्ध करें';

  @override
  String get sortByCarrier => 'कैरियर के अनुसार क्रमबद्ध करें';

  @override
  String get sortByCode => 'ट्रैकिंग कोड के अनुसार क्रमबद्ध करें';

  @override
  String get sortByUpdated => 'हाल की अपडेट के अनुसार क्रमबद्ध करें';

  @override
  String get filterTooltip => 'फ़िल्टर';

  @override
  String get filterHideDelivered => 'वितरित छिपाएँ';

  @override
  String get filterStatusHeading => 'स्थिति';

  @override
  String get filterCarrierHeading => 'कैरियर';

  @override
  String get filterReset => 'फ़िल्टर रीसेट करें';

  @override
  String get trackersEmpty =>
      'अभी तक किसी शिपमेंट को ट्रैक नहीं किया जा रहा है।';

  @override
  String trackersShowing(int shown, int total) {
    return '$total में से $shown दिखाए जा रहे हैं';
  }

  @override
  String get trackersNoMatch => 'वर्तमान फ़िल्टर से कुछ भी मेल नहीं खाता।';

  @override
  String etaLabel(String date) {
    return 'अनुमानित $date';
  }

  @override
  String detailEstimatedDelivery(String date) {
    return 'अनुमानित डिलीवरी $date';
  }

  @override
  String detailSignedBy(String name) {
    return '$name द्वारा हस्ताक्षरित';
  }

  @override
  String get detailHistoryHeading => 'इतिहास';

  @override
  String get detailNoScanHistory => 'अभी तक कोई स्कैन रिकॉर्ड नहीं।';

  @override
  String get detailMapUnavailable =>
      'इन स्थानों के लिए मानचित्र उपलब्ध नहीं है।';

  @override
  String get historyEmpty => 'अभी तक कोई शिपमेंट नहीं।';

  @override
  String get insuranceEmpty =>
      'अभी तक कोई बीमा पॉलिसी नहीं। «बीमा खरीदें» पर टैप करें।';

  @override
  String get insuranceBuy => 'बीमा खरीदें';

  @override
  String get insuranceAmountRange =>
      'बीमित राशि 0.01 और 5,000 USD के बीच होनी चाहिए।';

  @override
  String get insuranceNotEnabled =>
      'यह EasyPost खाता स्वतंत्र बीमा के लिए सक्षम नहीं है। EasyPost सहायता से इसे सक्षम कराने को कहें, या लेबल खरीदते समय बीमा जोड़ें।';

  @override
  String get insuranceFromAddress => 'प्रेषक का पता';

  @override
  String get insuranceToAddress => 'प्राप्तकर्ता का पता';

  @override
  String get fieldTrackingCode => 'ट्रैकिंग कोड';

  @override
  String get fieldCarrierHint => 'कैरियर (जैसे USPS)';

  @override
  String get fieldInsuredAmount => 'बीमित राशि (USD)';

  @override
  String get fieldName => 'नाम';

  @override
  String get fieldStreet => 'सड़क';

  @override
  String get fieldCity => 'शहर';

  @override
  String get fieldStateRegion => 'राज्य / क्षेत्र';

  @override
  String get fieldPostcode => 'डाक कोड';

  @override
  String get fieldCountryIso => 'देश (ISO, जैसे US)';

  @override
  String get fieldType => 'प्रकार';

  @override
  String get fieldAmountUsd => 'राशि (USD)';

  @override
  String get fieldContactEmail => 'संपर्क ईमेल';

  @override
  String get fieldDescription => 'विवरण';

  @override
  String get validationRequired => 'आवश्यक';

  @override
  String get validationEnterAmount => 'राशि दर्ज करें';

  @override
  String get validationEnterEmail => 'ईमेल दर्ज करें';

  @override
  String get validationDescribeIssue => 'समस्या का वर्णन करें';

  @override
  String get claimsEmpty =>
      'अभी तक कोई दावा दर्ज नहीं। «दावा दर्ज करें» पर टैप करें।';

  @override
  String get claimsFile => 'दावा दर्ज करें';

  @override
  String get claimSubmit => 'दावा भेजें';

  @override
  String get claimTypeDamage => 'क्षति';

  @override
  String get claimTypeTheft => 'चोरी';

  @override
  String get claimTypeLoss => 'हानि';

  @override
  String get claimAttachmentNote =>
      'क्षति और चोरी के दावों के लिए प्रमाण के तौर पर फ़ोटो या चालान आवश्यक है। इन्हें डेस्कटॉप ऐप से दर्ज करें, जहाँ दस्तावेज़ संलग्न किए जा सकते हैं।';

  @override
  String get claimAttachmentSnack =>
      'क्षति और चोरी के दावों के लिए प्रमाण आवश्यक है, जिसे केवल डेस्कटॉप ऐप में संलग्न किया जा सकता है। हानि का दावा यहाँ दर्ज किया जा सकता है।';

  @override
  String get pickupsEmpty => 'अभी तक कोई पिकअप निर्धारित नहीं।';

  @override
  String get pickupCancelTitle => 'पिकअप रद्द करें?';

  @override
  String pickupCancelBody(String id) {
    return 'पिकअप $id रद्द करें? इसे पूर्ववत नहीं किया जा सकता।';
  }

  @override
  String get pickupKeep => 'रहने दें';

  @override
  String get pickupCancelConfirm => 'पिकअप रद्द करें';

  @override
  String get actionCancel => 'रद्द करें';

  @override
  String get reportsShipments => 'शिपमेंट';

  @override
  String get reportsTotalSpend => 'कुल खर्च';

  @override
  String get reportsByCarrier => 'कैरियर के अनुसार';

  @override
  String get reportsEmpty =>
      'रिपोर्ट के लिए अभी तक कोई खरीदा गया शिपमेंट नहीं।';

  @override
  String reportsCarrierShipments(int count) {
    return 'शिपमेंट: $count';
  }

  @override
  String get htsSearchLabel => 'टैरिफ कोड खोजें';

  @override
  String get htsSearchHint => 'जैसे तांबे का तार';

  @override
  String get htsSearchButton => 'खोजें';

  @override
  String get htsDisclaimer =>
      'U.S. International Trade Commission से संदर्भ खोज। सही वर्गीकरण की ज़िम्मेदारी शिपर की रहती है।';

  @override
  String get htsPrompt => 'ऊपर टैरिफ कोड खोजें।';

  @override
  String get htsNoResults => 'कोई मेल खाता टैरिफ कोड नहीं।';

  @override
  String htsRateGeneral(String rate) {
    return 'सामान्य $rate';
  }

  @override
  String htsRateSpecial(String rate) {
    return 'विशेष $rate';
  }

  @override
  String htsRateOther(String rate) {
    return 'अन्य $rate';
  }

  @override
  String get htsCopyTooltip => 'कोड कॉपी करें';

  @override
  String htsCopied(String code) {
    return '$code कॉपी किया गया';
  }

  @override
  String htsUnavailable(int code) {
    return 'टैरिफ सेवा उपलब्ध नहीं है (त्रुटि $code)। कृपया पुनः प्रयास करें।';
  }

  @override
  String get pairTitle => 'डेस्कटॉप से जोड़ें';

  @override
  String get pairInstructions =>
      'Easy-Post Desktop खोलें, «मोबाइल ऐप जोड़ें» चुनें और वहाँ दिखाया गया QR कोड स्कैन करें।';

  @override
  String get pairEnterReviewCode => 'इसके बजाय समीक्षा कोड दर्ज करें';

  @override
  String get pairReviewDialogTitle => 'समीक्षा कोड दर्ज करें';

  @override
  String get pairReviewCodeHint => 'समीक्षा कोड';

  @override
  String get pairAction => 'जोड़ें';

  @override
  String get errorPairingCodeInvalid =>
      'यह युग्मन कोड अमान्य है या समाप्त हो चुका है। डेस्कटॉप पर नया कोड बनाएँ।';

  @override
  String get errorReviewCodeRejected => 'यह समीक्षा कोड स्वीकार नहीं किया गया।';

  @override
  String get errorUnexpectedPairingResponse =>
      'युग्मन सेवा से अप्रत्याशित प्रतिक्रिया।';

  @override
  String get errorNotPaired =>
      'यह डिवाइस अब युग्मित नहीं है। डेस्कटॉप से दोबारा जोड़ें।';

  @override
  String get errorNotPairedShort => 'यह डिवाइस अब युग्मित नहीं है।';

  @override
  String get errorForbidden => 'यह क्रिया ऐप से अनुमत नहीं है।';

  @override
  String errorRequestFailed(int code) {
    return 'अनुरोध विफल (त्रुटि $code)।';
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:praja_palana/models/application_search/application_search_response.dart';
import 'package:praja_palana/models/cheyuta/cheyuta_submit_local.dart';

class AppConstants {
  AppConstants._();
  static String appVersion = "";
  static String updatedDate = "";
  static String userName = "";
  static String appName = "PRAJA PALANA";
  static String? applicantNumber;
  static String applicantDetails = "APPLICANT DETAILS";
  static String familyDetails = "FAMILY DETAILS";
  static String addressDetails = "ADDRESS DETAILS";
  static String mahaLakshmiScheme = "mahaLakshmiScheme".tr();
  static String rythuBharosaScheme = "rythuBharosaScheme".tr();
  static String indirammaIndluScheme = "indirammaIlluScheme".tr();
  static String gruhaJyothiScheme = "gruhaJyothiScheme".tr();
  static String cheyuthaScheme = "cheyuthaScheme".tr();
  static String server_not_responding =
      "Server not Responding ,Please try later";
  static String? version_number = "";
  static String? titleText;
  static String applicantName = "";
  static String rationNumber = "";
  static String aadharNumber = "";

  //Flags to check whether the data Flag in schemes or not
  static bool? isApplicantDetailsFlag;
  static bool? isFamilyDetailsFlag;
  static bool? isAddressDetailsFlag;
  static bool? isMahalakshmiDetailsFlag;
  static bool? isRythuBharosaDetailsFlag;
  static bool? isIndirammaIndluDetailsFlag;
  static bool? isGruhaJyothiDetailsFlag;
  static bool? isCheyuthaDetailsFlag;

  static ApplicationStatus? RemarksdDropdownList;

  //static CheyutaSubmitLocalData? cheyutaSubmitLocalModelList;
  static List<CheyutaSubmitLocalData>? cheyutaSubmitLocalModelList;
  // static String projectDetailsIconPath = "";
  // static String agenttDetails = "";
  // static String agenttDetailsIconPath = "";
  // static String aboutUs = "";
  // static String contactUs = "";
  // static String contactUsUrl="";
  //   static String contactUsIcon="";
  // static String aboutUsUrl = "";
  // static String aboutUsIcon = "";
  // static String feedbackIconPath = "";
  // static String feedback = "";
  // static String faq = "";
  // static String faqurl = "";
  // static String faqIcon = "";
}

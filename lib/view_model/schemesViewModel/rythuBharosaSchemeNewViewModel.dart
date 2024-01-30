import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class RythuBharosaSchemeNewViewModel extends ChangeNotifier {
  String selectedFarmerType = '';
  String selectedLeaseDocType = '';
  String selectedFarmerRythuBandhuType = '';
  String selectedTenantFarmerType = '';
  String selectedFarmLabourType = '';
  String selectedAnyHouseholdWithLandType = '';
  String selectedExistingRythuBandhuBenficiary = '';
  TextEditingController passbookController = TextEditingController();
  TextEditingController registeredWageSeekerController =
      TextEditingController();
  TextEditingController noOfWageSeekerController = TextEditingController();
  TextEditingController totalDaysWorkedController = TextEditingController();
  TextEditingController passbookTenantController = TextEditingController();
  TextEditingController surveyNoController = TextEditingController();
  TextEditingController subDivisionController = TextEditingController();
  TextEditingController areaAcresController = TextEditingController();
  TextEditingController areaGuntasController = TextEditingController();
  TextEditingController landOwnerNameController = TextEditingController();
  TextEditingController periodFromController = TextEditingController();
  TextEditingController periodToController = TextEditingController();
  TextEditingController jobCardcontroller = TextEditingController();
  String? prefixText = 'TS';

  TextEditingController passbookHouseholdController = TextEditingController();
  TextEditingController surveyNoHouseholdController = TextEditingController();
  TextEditingController subDivisionHouseholdController =
      TextEditingController();
  TextEditingController areaAcresHouseholdController = TextEditingController();
  TextEditingController areaGuntasHouseholsController = TextEditingController();
  TextEditingController landOwnerNameHouseholdController =
      TextEditingController();
  TextEditingController periodFromHouseholdController = TextEditingController();
  TextEditingController periodToHouseholdController = TextEditingController();
  TextEditingController jobCardHouseholdcontroller = TextEditingController();
  String selectedLeaseDocTypeHousehold = '';
  bool? isRythuBharosaDetailsFlag;

  changeStatusOfFarmerType(String val) {
    selectedFarmerType = val;
    notifyListeners();
  }

  changeStatusOfFarmerRythuBandhuType(String val) {
    selectedFarmerRythuBandhuType = val;
    notifyListeners();
  }

  changeStatusOfLeaseDocType(String val) {
    selectedLeaseDocType = val;
    notifyListeners();
  }

  changeStatusOfLeaseDocTypeHousehold(String val) {
    selectedLeaseDocTypeHousehold = val;
    notifyListeners();
  }

  changeStatusOfTenantFarmerType(String val) {
    selectedTenantFarmerType = val;
    notifyListeners();
  }

  changeStatusOfFarmLabourType(String val) {
    selectedFarmLabourType = val;
    notifyListeners();
  }

  changeAnyHouseholdWithLand(String val) {
    selectedAnyHouseholdWithLandType = val;
    notifyListeners();
  }

  RythubharosaEdit? editData;
  getConfigurableFlags() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.rythuBharosaFlag);
    final list = json.decode(Stringlist ?? "");
    editData = (RythubharosaEdit.fromJson(list));
    return editData;
  }

  RaithubharosaMdl? rythuBarosaDetails;
  getRythuBarosaDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.rythuBharosaDetailsData);
    final list = json.decode(Stringlist ?? "");
    rythuBarosaDetails = (RaithubharosaMdl.fromJson(list));
    return rythuBarosaDetails;
  }

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  onSaveClick({
    required BuildContext context,
    required String farmerType,
    required String farmer1500,
    required String tenantFarmerType,
    required String farmLabourType,
    required String existingRythuBandhuBenficiary,
    required String anyHouseholdWithLandType,
    required String registeredWageSeeker,
    required String noOfWageSeeker,
    required String totalDaysWorked,
    required List<SurveyListMdl>? surveyListMdl,
    required List<PassbookListMdl>? passbookListMdl,
    required List<OwneRDTLS> passbokkSurveyNoList,
    required List<OwneRDTLS> tenantSurveyNoList,
    required List<OwneRDTLS> houseHoldWithAgricultureList,
    required String jobCardNumber,
    required String registeredWageSeekerJobCard,
    required String noOfWageSeekerFY,
    required String totalDaysWorkedFY,
  }) async {
    final RaithubharosaMdl rythuBarosaDetails = RaithubharosaMdl(
        cooliE12000: farmLabourType,
        farmeR15000: farmer1500,
        jobcarDNO: jobCardNumber,
        koulURAITHU: tenantFarmerType,
        passbookListMdl: passbookListMdl,
        raithu: farmer1500,
        surveyListMdl: surveyListMdl,
        tenenTDTLS: tenantSurveyNoList,
        householDDTLS: houseHoldWithAgricultureList,
        owneRDTLS: passbokkSurveyNoList,
        beneficiarYRAITHUBANDHU: existingRythuBandhuBenficiary,
        householDAGRI: anyHouseholdWithLandType,
        totaLDAYSWORKEDFY: totalDaysWorkedFY,
        totaLREGWAGEJOBCARD: registeredWageSeekerJobCard,
        wagEWORKFY: noOfWageSeekerFY);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoadingStatus(true);
    final editedRythuBarosaDetailsString = jsonEncode(rythuBarosaDetails);

    await prefs
        .setString(SharedPrefConstants.rythuBharosaDetailsData,
            editedRythuBarosaDetailsString)
        .then((value) async {
      print("on save rythubarosa :: ${editedRythuBarosaDetailsString}");
      await prefs.setBool(SharedPrefConstants.isRythuBharosaDetailsSaved, true);
      isRythuBharosaDetailsFlag =
          prefs.getBool(SharedPrefConstants.isRythuBharosaDetailsSaved) ??
              false;
      notifyListeners();
      setIsLoadingStatus(false);
    });
  }

  changeExistingRythuBandhuBenficiary(String string) {
    selectedExistingRythuBandhuBenficiary = string;
    notifyListeners();
  }

  int? maxlength;
  bool validateFields(BuildContext context, String passbook) {
    if (passbook.trim().isEmpty) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter passbook number",
      );
      return false;
    } else if (!passbook.startsWith('R') && !passbook.startsWith('T')) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter passbook number starts with R or T",
      );
      return false;
    } else if (passbook.startsWith('R') && passbook.length != 16) {
      RegExp regex = RegExp(r'^ROFR\d{12}$');
      if (!regex.hasMatch(passbook)) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter valid passbook number",
        );
      }
      return false;
    } else if (passbook.startsWith('T') && passbook.length != 12) {
      RegExp regex = RegExp(r'^T\d{11}$');
      if (!regex.hasMatch(passbook)) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter valid passbook number",
        );
      }
      return false;
    }
    return true;
  }

  bool validatePassbook(
      BuildContext context,
      RythubharosaEdit? editFlags,
      String selectedFarmerType,
      String selectedTenantFarmerType,
      String selectedAnyHouseholdWithLandType,
      List<OwneRDTLS> passbokkSurveyNoList,
      List<OwneRDTLS> tenantSurveyNoList,
      List<OwneRDTLS> houseHoldWithAgricultureList,
      String jobCardcontroller,
      String totalDaysWorkedController,
      String registeredWageSeeker,
      String howManyWageSeekers,
      String selectedExistingRythuBandhuType,
      String selectedFarmLabourType,
      PersonalDtlsMdl? applicantDetails) {
    /* if (selectedFarmerType == 'Y' &&
        (passbokkSurveyNoList.isEmpty || passbokkSurveyNoList.length == 0)) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter farmer passbook number",
      );
      return false;
    } else if (selectedTenantFarmerType == 'Y' &&
        (tenantSurveyNoList.isEmpty || tenantSurveyNoList.length == 0)) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter tenant passbook number",
      );
      return false;
    } else if (selectedAnyHouseholdWithLandType == 'Y' &&
        (houseHoldWithAgricultureList.isEmpty ||
            houseHoldWithAgricultureList.length == 0)) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter household passbook number",
      );
      return false;
    } */
    if (selectedExistingRythuBandhuType == '') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please select Existing Beneficiary of Rythu Bandhu",
      );
      return false;
    } else if (selectedAnyHouseholdWithLandType == '') {
      ValidationIoSAlert().showAlert(
        context,
        description:
            "Please select any of the household member having agriculture land",
      );
      return false;
    } else if (selectedAnyHouseholdWithLandType == 'Y' &&
        (houseHoldWithAgricultureList.isEmpty ||
            houseHoldWithAgricultureList.length == 0)) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter household passbook number",
      );
      return false;
    } else if (registeredWageSeeker.trim().isEmpty &&
        selectedFarmLabourType == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter total registered wage seeker",
      );
      return false;
    } //Added Validation for jobCard only when the jobcardflg is Y and jobCarNo is less than the max length
    else if (jobCardcontroller.trim().isEmpty &&
        selectedFarmLabourType == 'Y' &&
        applicantDetails?.jobcardflg == "Y") {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter job card number",
      );
      return false;
    } //Added Validation for jobCard only when the jobcardflg is Y and jobCarNo is less than the max length
    else if (jobCardcontroller.trim().isNotEmpty &&
        selectedFarmLabourType == 'Y' &&
        jobCardcontroller.length < (applicantDetails?.jobcardmaxl ?? 17) &&
        applicantDetails?.jobcardflg == "Y") {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter valid job card number",
      );
      return false;
    } else if (howManyWageSeekers.trim().isEmpty &&
        selectedFarmLabourType == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter how many wage seekeres worked in this FY",
      );
      return false;
    } else if (totalDaysWorkedController.trim().isEmpty &&
        selectedFarmLabourType == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter total days worked in this FY",
      );
      return false;
    }
    return true;
  }
}

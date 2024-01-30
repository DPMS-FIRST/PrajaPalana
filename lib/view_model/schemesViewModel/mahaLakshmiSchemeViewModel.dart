import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/data/database.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/models/master_data/master_geograpics_response.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class MahaLakshmiSchemeViewModel extends ChangeNotifier {
  String selectedMonthlyFinancialHelp = '';
  String areYouGettingAsara = '';
  String selectedGasCylinderFor500 = '';
  Pension? selectedPensionType;
  TextEditingController gasConsumerNoController = TextEditingController();
  TextEditingController gasSupplyingCompanycontroller = TextEditingController();
  TextEditingController cylindersCountcontroller = TextEditingController();

  bool? isMahalakshmiDetailsFlag;

  changeStatusOfAreYouGettingAsara(String val) {
    areYouGettingAsara = val;
    if (val == 'N') {
      selectedPensionType = pensionList[0];
    }
    notifyListeners();
  }

  changePensionType(Pension pension) {
    selectedPensionType = pension;
    notifyListeners();
  }

  changeStatusOfMonthlyFinancialHelp(String val) {
    selectedMonthlyFinancialHelp = val;
    notifyListeners();
  }

  changeStatusOfGasCylinder(String val) {
    selectedGasCylinderFor500 = val;
    notifyListeners();
  }

  MahalakshmiEdit? editData;
  getConfigurableFlags() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.mahalakshmiFlag);
    final list = json.decode(Stringlist ?? "");
    editData = (MahalakshmiEdit.fromJson(list));
    return editData;
  }

  MahalakshmiMdl? mahalakshmiDetails;
  getMahalakshmiDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.mahalakshmiDetailsData);
    final list = json.decode(Stringlist ?? "");
    mahalakshmiDetails = (MahalakshmiMdl.fromJson(list));
    notifyListeners();
    return mahalakshmiDetails;
  }

  final databaseInstance = DatabaseClient();
  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  List<Pension> pensionList = [];
  List<Pension> get getPensionList => pensionList;
  getPensionDetails(BuildContext context) async {
    pensionList = [];
    final pensionData = await databaseInstance.getPensionData();
    pensionList = pensionData;
    pensionList.insert(
      0,
      Pension(pensioNID: 0, pensioNNAME: 'Select type of pension'),
    );
    selectedPensionType = pensionList[0];
    notifyListeners();
  }

  onSaveClick({
    required BuildContext context,
    required String finhelP2500,
    required String gaS500,
    required String gaSCOMPANYNAME,
    required String gaSCOMPANYNAMEOTHER,
    required String gaSCONNECTIONNO,
    required String nOOFCYLINDERS,
    required int familyMemberId,
    required List<PensionsList> pensionList,
  }) async {
    print("selectedMonthlyFinancialHelp $selectedMonthlyFinancialHelp");

    final MahalakshmiMdl mahalakshmiDetails = MahalakshmiMdl(
      finhelP2500: finhelP2500,
      gaS500: gaS500,
      gaSCOMPANYNAME: gaSCOMPANYNAME,
      gaSCOMPANYNAMEOTHER: gaSCOMPANYNAMEOTHER,
      gaSCONNECTIONNO: gaSCONNECTIONNO,
      nOOFCYLINDERS: nOOFCYLINDERS,
      selecteDUSERID: familyMemberId.toString(),
      pensionID: selectedPensionType?.pensioNID.toString(),
      pensionType: areYouGettingAsara,
      listPensions: pensionList,
    );
    print("mahalakshmiDetails ${mahalakshmiDetails.toJson()}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoadingStatus(true);
    final editedMahalakshmiDetailsString = jsonEncode(mahalakshmiDetails);
    print("editedMahalakshmiDetailsString $editedMahalakshmiDetailsString");
    await prefs
        .setString(SharedPrefConstants.mahalakshmiDetailsData,
            editedMahalakshmiDetailsString)
        .then((value) async {
      await prefs.setBool(SharedPrefConstants.isMahalakshmiDetailsSaved, true);
      isMahalakshmiDetailsFlag =
          prefs.getBool(SharedPrefConstants.isMahalakshmiDetailsSaved) ?? false;
      setIsLoadingStatus(false);
    });
  }

  bool validateFinancialHelp(BuildContext context, int? selectedID,
      String? gender, int femaleListLength) {
    if (selectedMonthlyFinancialHelp == 'Y') {
      if (areYouGettingAsara == '') {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please Select Asara(Y/N)",
        );
        return false;
      } else if (areYouGettingAsara == 'Y') {
        if (selectedPensionType?.pensioNID == 0) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please Select type of Pension",
          );
          return false;
        } else if (gender != "F" && selectedID == 0 && femaleListLength > 1) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please Select Family member name",
          );
          return false;
        }
      } else if (areYouGettingAsara == 'N' && femaleListLength > 1) {
        if (gender != "F" && selectedID == 0) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please Select Family member name",
          );
          return false;
        }
      }
      return true;
    }
    // if (selectedMonthlyFinancialHelp == 'N') {
    //   if (Remarkscontroller.text.isEmpty) {
    //     ValidationIoSAlert().showAlert(
    //       context,
    //       description: "Please Enter Remarks",
    //     );
    //   }
    //   return false;
    // }
    return true;
  }

  bool validateGasCylinder(BuildContext context,
      Gascompanies? selectedGasCompanies, PersonalDtlsMdl? applicantDetails) {
    print("#############");
    if (selectedGasCylinderFor500 == 'Y') {
      print(
          " gasconsumer controler @@@@@@@@@@@@@@ ${gasConsumerNoController.text}");
      //Added Validation for gasConsumerNo only when the gasflg is Y
      if (gasConsumerNoController.text.trim().isEmpty &&
          applicantDetails?.gasflg == 'Y') {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please Enter Gas Consumer No",
        );

        return false;
      }
      //Length of gasConsumerNo validation
      else if (gasConsumerNoController.text.trim().length <
              (applicantDetails?.gasmaxl ?? 12) &&
          applicantDetails?.gasflg == 'Y') {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please Enter Valid Gas Consumer No",
        );

        return false;
      }
      //Commented this because gasCompany selection is not mandatory
      /*  else if (selectedGasCompanies?.id == "0") {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please Select Gas Company name",
        );
        return false;
      } */
    }
    return true;
  }

  addPensionDataInitially(MahalakshmiMdl? mahalakshmiDetails) {
    print("maha@@@@@@@@@@@@@@@@@@@@ ${mahalakshmiDetails?.pensionID}");
    (mahalakshmiDetails?.pensionID == null ||
            mahalakshmiDetails?.pensionID == '')
        ? selectedPensionType = pensionList[0]
        : selectedPensionType = pensionList.firstWhere((element) =>
            element.pensioNID ==
            int.tryParse(mahalakshmiDetails?.pensionID ?? ''));
    notifyListeners();
  }

  void addAsaraInitially(MahalakshmiMdl? mahalakshmiDetails) {
    (mahalakshmiDetails?.pensionType != null)
        ? areYouGettingAsara = mahalakshmiDetails?.pensionType ?? ''
        : areYouGettingAsara = '';
    notifyListeners();
  }

  
  bool areYouGettingValidateFields(
      BuildContext context,
      FamilyListMdl? familyListMdlPension,
      Pension? selectedPensionType,
      String areYouGettingAsara,
      List<FamilyListMdl> femaleList) {
    if (areYouGettingAsara == 'Y' &&
        selectedPensionType?.pensioNNAME == "Select type of pension") {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Select type of Pension",
      );
      return false;
    } else if (areYouGettingAsara == 'Y' &&
        familyListMdlPension?.name == "Select Family Member Name" &&
        femaleList.length > 1) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Select Family member name",
      );
      return false;
    }
    return true;
  }
}

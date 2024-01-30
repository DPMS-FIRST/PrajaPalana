/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class RythuBharosaSchemeViewModel extends ChangeNotifier {
  String selectedFarmerType = '';
  String selectedTenantFarmerType = '';
  String selectedFarmLabourType = '';
  TextEditingController passbookController = TextEditingController();
  TextEditingController surveyNoController = TextEditingController();
  TextEditingController areaAcresController = TextEditingController();
  TextEditingController areaGuntasController = TextEditingController();
  TextEditingController jobCardcontroller = TextEditingController(text: 'TS');
  changeStatusOfFarmerType(String val) {
    selectedFarmerType = val;
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
    required List<SurveyListMdl>? surveyListMdl,
    required List<PassbookListMdl>? passbookListMdl,
    required String jobCard,
  }) async {
    final RaithubharosaMdl rythuBarosaDetails = RaithubharosaMdl(
      cooliE12000: farmLabourType,
      farmeR15000: farmer1500,
      jobcarDNO: jobCard,
      koulURAITHU: tenantFarmerType,
      passbookListMdl: passbookListMdl,
      raithu: farmerType,
      surveyListMdl: surveyListMdl,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoadingStatus(true);
    final editedRythuBarosaDetailsString = jsonEncode(rythuBarosaDetails);
    await prefs
        .setString(SharedPrefConstants.rythuBharosaDetailsData,
            editedRythuBarosaDetailsString)
        .then((value) async {
      await prefs.setBool(SharedPrefConstants.isRythuBharosaDetailsSaved, true);
      setIsLoadingStatus(false);
    });
  }
}
 */
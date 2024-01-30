import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class GruhaJyothiSchemeViewModel extends ChangeNotifier {
  TextEditingController meterConnectionNoController = TextEditingController();
  GruhajyothiEdit? gruhaJyothiDetailsEdit;
  getConfigurableGruhaJyothiData() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.gruhaJyothiFlag);
    final list = json.decode(Stringlist ?? "");
    gruhaJyothiDetailsEdit = (GruhajyothiEdit.fromJson(list));
    return gruhaJyothiDetailsEdit;
  }

  GruhajyothiMdl? gruhaJyothiDetails;
  getGruhaJyothiDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.gruhaJyothiDetailsData);
    final list = json.decode(Stringlist ?? "");
    gruhaJyothiDetails = (GruhajyothiMdl.fromJson(list));
    return gruhaJyothiDetails;
  }

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  bool? isGruhaJyothiDetailsFlag;

  onSaveClick({
    required BuildContext context,
    required String meterConnectionNo,
    required String selectedElectUnitId,
    required String? electricity200,
  }) async {
    final GruhajyothiMdl gruhaJyothiDetails = GruhajyothiMdl(
      meteRNO: meterConnectionNo,
      electricitYCONSUMPTION: selectedElectUnitId,
      electricitY200: electricity200,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoadingStatus(true);
    final editedgruhajyothiDetailsString = jsonEncode(gruhaJyothiDetails);
    await prefs
        .setString(SharedPrefConstants.gruhaJyothiDetailsData,
            editedgruhajyothiDetailsString)
        .then((value) async {
      await prefs.setBool(SharedPrefConstants.isGruhaJyothiDetailsSaved, true);
      isGruhaJyothiDetailsFlag =
          prefs.getBool(SharedPrefConstants.isGruhaJyothiDetailsSaved) ?? false;
      setIsLoadingStatus(false);
    });
  }

  bool validateFields(BuildContext context, Electricityunits? selectedElectUnit,
      String meterConnectionNumber, PersonalDtlsMdl? applicantDetails) {
    if (selectedElectUnit?.id == '0') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please select electricity consumption units",
      );
      return false;
    }
    //added meterConnectionNo validation based on flag 
    else if (meterConnectionNumber.isEmpty && applicantDetails?.meterflg == "Y") {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter meter connection number",
      );
      return false;
    }
    return true;
  }
}

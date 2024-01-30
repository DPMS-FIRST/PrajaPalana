/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_details_response.dart';
import '../../utils/shared_pref_constants.dart';

class AddressDetailsViewModel with ChangeNotifier {
  bool isLoading = false;

  String selectedGPOrMunicipality = '';

  TextEditingController wardNoController = TextEditingController();
  bool get getIsLoading => isLoading;
  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  AddressdetailsEdit? editData;
  getConfigurableFlags() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist = await prefs.getString(SharedPrefConstants.addressFlag);
    final list = json.decode(Stringlist ?? "");
    editData = (AddressdetailsEdit.fromJson(list));
    return editData;
  }

  PersonalDtlsMdl? addressDetails;
  getAddressDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.applicantDetailsData);
    final list = json.decode(Stringlist ?? "");
    addressDetails = (PersonalDtlsMdl.fromJson(list));
    return addressDetails;
  }

  changeGPOrMunicipality(String value) {
    selectedGPOrMunicipality = value;
    notifyListeners();
  }
}
 */
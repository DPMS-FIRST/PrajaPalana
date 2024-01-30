import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../utils/shared_pref_constants.dart';

class FamilyDetailsViewModel with ChangeNotifier {
  FamilydetailsEdit? editData;
  getConfigurableFamilyData() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist = await prefs.getString(SharedPrefConstants.familyFlag);
    final list = json.decode(Stringlist ?? "");
    editData = (FamilydetailsEdit.fromJson(list));
    return editData;
  }

  List<FamilyListMdl> familyData = [];
  getFamilyData() async {
    familyData.clear();
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.familyDetailsData);
    final list = json.decode(Stringlist ?? "");

    list.forEach((element) {
      print(element);
      familyData.add(FamilyListMdl.fromJson(element));
    });
    return familyData;
  }

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  bool? isFamilyDetailsFlag;
  SaveOnClick({
    required BuildContext context,
    required List<FamilyListMdl>? familyEditedList,
  }) async {
    final List<FamilyListMdl> familySavedList = familyEditedList ?? [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoadingStatus(true);
    final editedfamilyDetailsString = jsonEncode(familySavedList);
    await prefs
        .setString(
            SharedPrefConstants.familyDetailsData, editedfamilyDetailsString)
        .then((value) async {
      await prefs.setBool(SharedPrefConstants.isFamilyDetailsSaved, true);
      isFamilyDetailsFlag =
          prefs.getBool(SharedPrefConstants.isFamilyDetailsSaved) ?? false;
      setIsLoadingStatus(false);
    });
  }
}

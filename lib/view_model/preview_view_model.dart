import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/shared_pref_constants.dart';
import 'package:praja_palana/data/database.dart';

import '../models/applicant_details/applicant_schemewise_details_response.dart';

class PreviewViewModel with ChangeNotifier {
  bool isLoading = false;
  final databaseInstance = DatabaseClient();

  bool get getIsLoading => isLoading;
  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Applicant Details
  getGenderData() async {
    final genderData = await databaseInstance.getGenderData();
    return genderData;
  }

  getCasteData() async {
    final casteData = await databaseInstance.getCasteData();
    return casteData;
  }

  PersonalDtlsMdl? applicantDetails;
  getApplicationDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.applicantDetailsData);
    final list = json.decode(Stringlist ?? "");
    applicantDetails = (PersonalDtlsMdl.fromJson(list));
    notifyListeners();
  }

  // Address Details
  String selectedGPOrMunicipality = '';
  TextEditingController wardNoController = TextEditingController();

  PersonalDtlsMdl? addressDetails;
  getAddressDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.applicantDetailsData);
    final list = json.decode(Stringlist ?? "");
    addressDetails = (PersonalDtlsMdl.fromJson(list));
    notifyListeners();
  }

  changeGPOrMunicipality(String value) {
    selectedGPOrMunicipality = value;
    notifyListeners();
  }

  List<FamilyListMdl> familyData = [];
  getFamilyDetails() async {
    familyData.clear();
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.familyDetailsData);
    final list = json.decode(Stringlist ?? "");

    list.forEach((element) {
      print(element);
      familyData.add(FamilyListMdl.fromJson(element));
    });
    familyData = familyData;
    notifyListeners();
  }

  //Mahalakshmi
  MahalakshmiMdl? mahalakshmiDetails;
  getMahalakshmiDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.mahalakshmiDetailsData);
    final list = json.decode(Stringlist ?? "");
    mahalakshmiDetails = (MahalakshmiMdl.fromJson(list));
    notifyListeners();
  }

  //rythu bharosa

  RaithubharosaMdl? rythuBarosaDetails;
  getRythuBarosaDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.rythuBharosaDetailsData);
    final list = json.decode(Stringlist ?? "");
    rythuBarosaDetails = (RaithubharosaMdl.fromJson(list));
    return rythuBarosaDetails;
  }

  //indiramma indlu

  IndirammaIndluMdl? indirammaIndluDetails;
  getIndirammaIndluDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.indirammaIndluDetailsData);
    final list = json.decode(Stringlist ?? "");
    indirammaIndluDetails = (IndirammaIndluMdl.fromJson(list));
    return indirammaIndluDetails;
  }

  //gruha Jyothi

  GruhajyothiMdl? gruhaJyothiDetails;
  getGruhaJyothiDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.gruhaJyothiDetailsData);
    final list = json.decode(Stringlist ?? "");
    gruhaJyothiDetails = (GruhajyothiMdl.fromJson(list));
    return gruhaJyothiDetails;
  }

  //cheyutha

  CheyuthaMdl? cheyuthaDetails;
  getCheyuthaDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.cheyuthaDetailsData);
    final list = json.decode(Stringlist ?? "");
    cheyuthaDetails = (CheyuthaMdl.fromJson(list));
    return cheyuthaDetails;
  }
}

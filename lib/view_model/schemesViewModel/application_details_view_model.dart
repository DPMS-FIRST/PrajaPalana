import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/data/database.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../utils/get_device_address.dart';
import '../validate_mpin_view_model.dart';

class ApplicantDetailsViewModel with ChangeNotifier {
  final databaseInstance = DatabaseClient();
  String selectedGPOrMunicipality = '';
  String selectedRationNumnber = '';
  TextEditingController wardNoController = TextEditingController();
  bool? isApplicantDetailsFlag;
  getGenderData() async {
    final genderData = await databaseInstance.getGenderData();
    return genderData;
  }

  getCasteData() async {
    final casteData = await databaseInstance.getCasteData();
    return casteData;
  }

  ApplicantdetailsEdit? applicantdetailsEdit;
  getConfigurableApplicantData() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist = await prefs.getString(SharedPrefConstants.applicantFlag);
    final list = json.decode(Stringlist ?? "");
    applicantdetailsEdit = (ApplicantdetailsEdit.fromJson(list));
    return applicantdetailsEdit;
  }

  PersonalDtlsMdl? applicantDetails;
  getApplicationDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.applicantDetailsData);
    final list = json.decode(Stringlist ?? "");
    applicantDetails = (PersonalDtlsMdl.fromJson(list));
    return applicantDetails;
  }

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  AddressdetailsEdit? editData;
  getAddressConfigurableFlags() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist = await prefs.getString(SharedPrefConstants.addressFlag);
    final list = json.decode(Stringlist ?? "");
    editData = (AddressdetailsEdit.fromJson(list));
    return editData;
  }

  changeGPOrMunicipality(String value) {
    selectedGPOrMunicipality = value;
    notifyListeners();
  }

  onSaveClick({
    required BuildContext context,
    required String aadhaar,
    required String onlineApplicationNo,
    required String offlineApplicationNo,
    required String applicantName,
    required String dob,
    required String gender,
    required String caste,
    required String districtId,
    required String gpMunicipality,
    required String houseNo,
    required String mandalId,
    required String mobileNo,
    required String municipalId,
    required String occupation,
    required String panchayatId,
    required String rationCardNo,
    required String wardNo,
    required String departmenTCATAGORY,
    required String enablEAPPFAMILY,
    required String enablESCHEMES,
    required String familyDtlsXML,
    required String gruhajyothi,
    required String id,
    required String idd,
    required String indirammAILLU,
    required String iteCCATAGORY,
    required String mHSCHEME,
    required String passbookDtlsXML,
    required String raithUBAROSA,
    required String remarks,
    required String sadaramDtlsXML,
    required String surveyDtlsXML,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final deviceId = await GetDeviceId().getDeviceId();
    final loginResponseProvider =
        Provider.of<ValidateMpinViewModel>(context, listen: false);
    final loginDetailsResponse = loginResponseProvider.getLoginDetails;
    final ipAddress = await GetDeviceIpAddress().GetIp();
    final saveApplicantDetailsList = PersonalDtlsMdl(
      aadhaRNO: aadhaar,
      onlinEAPPLICATIONNO: onlineApplicationNo,
      offlinEAPPLICATIONNO: offlineApplicationNo,
      applicanTNAME: applicantName,
      caste: caste,
      datEOFBIRTH: dob,
      districTID: districtId,
      gPMUN: gpMunicipality,
      gender: gender,
      housENO: houseNo,
      mandaLID: mandalId,
      mobilENO: mobileNo,
      municipaLID: municipalId,
      occupation: occupation,
      panchayaTID: panchayatId,
      ratioNCARDNO: rationCardNo,
      warDNO: wardNo,
      createdBy: loginDetailsResponse?.data?.userid ?? "",
      createdDeviceID: deviceId,
      createdIP: ipAddress,
      departmenTCATAGORY: departmenTCATAGORY,
      enablEAPPFAMILY: enablEAPPFAMILY,
      enablESCHEMES: enablESCHEMES,
      familyDtlsXML: familyDtlsXML,
      gruhajyothi: gruhajyothi,
      id: id,
      idd: idd,
      indirammAILLU: indirammAILLU,
      iteCCATAGORY: iteCCATAGORY,
      mHSCHEME: mHSCHEME,
      passbookDtlsXML: passbookDtlsXML,
      raithUBAROSA: raithUBAROSA,
      remarks: remarks,
      sadaramDtlsXML: sadaramDtlsXML,
      surveyDtlsXML: surveyDtlsXML,
      tokenID: loginDetailsResponse?.data?.iTOKENID ?? "",
    );
    setIsLoadingStatus(true);
    final applicantNewDetailsString = jsonEncode(saveApplicantDetailsList);
    await prefs
        .setString(
            SharedPrefConstants.applicantDetailsData, applicantNewDetailsString)
        .then((value) async {
      await prefs.setBool(SharedPrefConstants.isApplicantDetailsSaved, true);
      isApplicantDetailsFlag =
          prefs.getBool(SharedPrefConstants.isApplicantDetailsSaved) ?? false;
      setIsLoadingStatus(false);
    });
  }

  bool flag = false;
  bool aadharflags(
      bool aadharVerifyFlag,
      /* bool rationVerifyFlag, */
      PersonalDtlsMdl? applicantDetails) {
    // Submitting without ration number also
    if (applicantDetails?.aadharflg ==
            'Y' /* &&
        applicantDetails?.rationflg == 'Y' */
        ) {
      if (aadharVerifyFlag == true /* && rationVerifyFlag == true */) {
        flag = true;
      } else {
        flag = false;
      }
      return flag;
    } else if (applicantDetails?.aadharflg ==
            'Y' /* &&
        applicantDetails?.rationflg == 'N' */
        ) {
      if (aadharVerifyFlag == true /* && rationVerifyFlag == false */) {
        flag = true;
      } else {
        flag = false;
      }
      return flag;
    } else if (applicantDetails?.aadharflg ==
            'N' /* &&
        applicantDetails?.rationflg == 'Y' */
        ) {
      if (aadharVerifyFlag == false /*  && rationVerifyFlag == true */) {
        flag = true;
      } else {
        flag = false;
      }
      return flag;
    } else if (applicantDetails?.mobileflg == 'Y' ||
        applicantDetails?.addressflg == 'Y ') {
      flag = true;
      return flag;
    } else {
      flag = false;
    }
    return flag;
  }

  bool validateFields(BuildContext context, String mno, String address,
      PersonalDtlsMdl? applicantDetails, String aadharNo, String ratioNCARDNO) {
    //Added validation based on mobileflg and addressflg for mobile and address
    print("mobinle length----- ${mno.length}");
    if (mno.trim().isEmpty && applicantDetails?.mobileflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter mobile number",
      );
      return false;
    } else if ((mno.length < 10 || mno.length > 10) &&
        applicantDetails?.mobileflg == 'Y') {
      print("dasdasfs----");
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Valid Mobile Number",
      );
      return false;
    } else if (address.trim().isEmpty && applicantDetails?.addressflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Address",
      );
      return false;
    }
    //Addhaar and ration validation already added in validateAadhar and validateRation so commented here
    /* else if (aadharNo.trim().isEmpty && applicantDetails?.aadharflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Aadhar Number",
      );
      return false;
    } else if (ratioNCARDNO.trim().isEmpty &&
        applicantDetails?.rationflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Ration Card Number",
      );
      return false;
    } */

    return true;
  }
}

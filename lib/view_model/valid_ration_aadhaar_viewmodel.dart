import 'package:flutter/cupertino.dart';
import 'package:praja_palana/models/applicant_details/applicant_schemewise_details_response.dart';
import 'package:praja_palana/models/getRationValid_payload.dart';
import 'package:praja_palana/repository/aadhaar_ration_valid_repository.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import '../models/getAadharNumberValid_payload.dart';

class ValidateAadhaarRationViewModel with ChangeNotifier {
  bool isLoading = false;
  bool aadharVerifyFlag = false;
  bool rationVerifyFlag = false;
  bool getIsLoadingStatus() => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  final validateaadhaarrepo = ValidateAadhaarRationRepository();
  getAadhaarValidVM(
      BuildContext context,
      String mobileNumber,
      String deviceId,
      String iTOKENID,
      String vCDEVICEID,
      String districtid,
      String panchayatid,
      String iPaddress,
      String userid,
      String iMPIN,
      String sessionID,
      String onlinEAPPLICATIONNO,
      String aadhaRNO,
      String ratioNCARDNO,
      String applicantmobileNumber,
      String applicantName,
      String applType,
      String any,
      int distid,
      int panMun,
      int idd,
      String ptype) async {
    final payload = GetAadharNumberValidPayload(
        mobileNumber: mobileNumber,
        deviceId: deviceId,
        iTOKENID: iTOKENID,
        vCDEVICEID: vCDEVICEID,
        districtid: districtid,
        panchayatid: panchayatid,
        iPaddress: iPaddress,
        userid: userid,
        iMPIN: iMPIN,
        sessionID: sessionID,
        onlinEAPPLICATIONNO: onlinEAPPLICATIONNO,
        aadhaRNO: aadhaRNO,
        ratioNCARDNO: ratioNCARDNO,
        applicantmobileNumber: applicantmobileNumber,
        applicantName: applicantName,
        applType: applType,
        any: any,
        distid: distid,
        panMun: panMun,
        idd: idd,
        ptype: ptype);
    final result =
        await validateaadhaarrepo.ValidateAadhaarRepo(context, payload);
    setIsLoadingStatus(false);
    if (result.statusCode == 200) {
      SuccessCustomCupertinoAlert().showAlert(
          context: context,
          title: result.message ?? "",
          onPressed: () {
            aadharVerifyFlag = true;
            notifyListeners();
            Navigator.pop(context);
          });

      return result;
    } else {
      SuccessCustomCupertinoAlert().showAlert(
          context: context,
          title: result.message ?? "",
          onPressed: () {
            aadharVerifyFlag = false;
            notifyListeners();
            Navigator.pop(context);
          });
    }

    notifyListeners();
  }

  getRationValidVM(
      BuildContext context,
      String? mobileNumber,
      String? deviceId,
      String? iTOKENID,
      String? vCDEVICEID,
      String? districtid,
      String? panchayatid,
      String? iPaddress,
      String? userid,
      String? iMPIN,
      String? sessionID,
      String? onlinEAPPLICATIONNO,
      String? aadhaRNO,
      String? ratioNCARDNO,
      String? applicantmobileNumber,
      String? applicantName,
      String? applType,
      String? any,
      int? distid,
      int? panMun,
      int? idd,
      String? ptype) async {
    final payload = GetRationNumberValidPayload(
        mobileNumber: mobileNumber,
        deviceId: deviceId,
        iTOKENID: iTOKENID,
        vCDEVICEID: vCDEVICEID,
        districtid: districtid,
        panchayatid: panchayatid,
        iPaddress: iPaddress,
        userid: userid,
        iMPIN: iMPIN,
        sessionID: sessionID,
        onlinEAPPLICATIONNO: onlinEAPPLICATIONNO,
        aadhaRNO: aadhaRNO,
        ratioNCARDNO: ratioNCARDNO,
        applicantmobileNumber: applicantmobileNumber,
        applicantName: applicantName,
        applType: applType,
        any: any,
        distid: distid,
        panMun: panMun,
        idd: idd,
        ptype: ptype);
    final result =
        await validateaadhaarrepo.ValidateRationRepo(context, payload);
    setIsLoadingStatus(false);
    if (result.statusCode == 200) {
      SuccessCustomCupertinoAlert().showAlert(
          context: context,
          title: result.message ?? "",
          onPressed: () {
            rationVerifyFlag = true;
            notifyListeners();
            Navigator.pop(context);
          });
      return result;
    } else {
      SuccessCustomCupertinoAlert().showAlert(
          context: context,
          title: result.message ?? "",
          onPressed: () {
            rationVerifyFlag = false;
            notifyListeners();
            Navigator.pop(context);
          });
    }

    notifyListeners();
  }

  bool validateRation(String ratioNCARDNO, BuildContext context,
      PersonalDtlsMdl? applicantDetails) {
            //Added validation based on rationflg
    if (ratioNCARDNO.trim().isEmpty && applicantDetails?.rationflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter Ration Card Number",
      );
      return false;
    } else if (ratioNCARDNO.length < (applicantDetails?.rationmaxl ?? 12) &&
        applicantDetails?.rationflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Valid Ration Card Number",
      );
      return false;
    }
    return true;
  }

  bool validateAadhar(String aadharNO, BuildContext context,
      PersonalDtlsMdl? applicantDetails) {
        //Added validation based on aadharflg
    if ((aadharNO == '' || aadharNO.trim().isEmpty) &&
        applicantDetails?.aadharflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter Aadhaar Number",
      );
      return false;
    } else if (aadharNO.length < (applicantDetails?.aadharmaxl ?? 12) &&
        applicantDetails?.aadharflg == 'Y') {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Valid Aadhaar Number",
      );
      return false;
    }
    return true;
  }
}

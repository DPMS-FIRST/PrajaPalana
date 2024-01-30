import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/data/database.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/models/master_data/master_geograpics_response.dart';
import 'package:praja_palana/models/ps_masters_payload.dart';
import 'package:praja_palana/models/ps_masters_response.dart';
import 'package:praja_palana/repository/indiramma_masters_repository.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/api_error_codes.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class IndirammaIndluSchemeViewModel extends ChangeNotifier {
  String selectedFinancialAssistanceForHouse = '';
  String selectedMartyrsFamilyType = '';
  String selectedTelanganaMovementType = '';
  String selectedJailType = '';
  String selectedHavingHouseSite = '';
  String selectedHousesiteonApplicantName = '';
  String selectedWhetherRemanded = '';
  String selectedSentToJail = '';
  TextEditingController martyrsNameController = TextEditingController();
  TextEditingController yearOfDeathController = TextEditingController();
  TextEditingController martyrfirNocontroller = TextEditingController();
  TextEditingController deathCertificateNocontroller = TextEditingController();
  TextEditingController telanganaMovemntfirNocontroller =
      TextEditingController();
  TextEditingController telanganaMovemntfirYearcontroller =
      TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController jailNameController = TextEditingController();
  TextEditingController jailPlaceController = TextEditingController();
  TextEditingController jailNoOfYearsController = TextEditingController();
  TextEditingController jailNoOfMonthsController = TextEditingController();
  TextEditingController jailNoOfDaysController = TextEditingController();
  final databaseInstance = DatabaseClient();

  changeStatusOfFinancialHouseAssistance(String val) {
    selectedFinancialAssistanceForHouse = val;
    notifyListeners();
  }

  getResidentailData() async {
    final residentialData = await databaseInstance.getResidentailStatusData();
    return residentialData;
  }

  getTypeRoofData() async {
    final typeRoofData = await databaseInstance.getRoofTypeStatusData();
    notifyListeners();
    return typeRoofData;
  }

  getOwnershipData() async {
    final ownershipData = await databaseInstance.getOwnerShipData();
    return ownershipData;
  }

  changeStatusOfHavingaHouseSite(String val) {
    selectedHavingHouseSite = val;
    print("selected value ${val}");
    notifyListeners();
  }

  changeStatusOfHouseSiteonApplicantName(String val) {
    selectedHousesiteonApplicantName = val;
    print("in the name of ${val}");

    notifyListeners();
  }

  changeStatusOfMartyrsFamily(String val) {
    selectedMartyrsFamilyType = val;
    notifyListeners();
  }

  changeStatusOfMovementType(String val) {
    selectedTelanganaMovementType = val;
    notifyListeners();
  }

  changeStatusOfjailType(String val) {
    selectedJailType = val;
    notifyListeners();
  }
   changeStatusOfRemanded(String val) {
    selectedWhetherRemanded = val;
    notifyListeners();
  }

  changeStatusOfSentToJail(String val) {
   selectedSentToJail = val;
    notifyListeners();
  }

  InditammaEdit? editData;
  getConfigurableFlags() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.indirammaIndluFlag);
    final list = json.decode(Stringlist ?? "");
    editData = (InditammaEdit.fromJson(list));
    return editData;
  }

  IndirammaIndluMdl? indirammaIndluDetails;
  getIndirammaIndluDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.indirammaIndluDetailsData);
    final list = json.decode(Stringlist ?? "");
    indirammaIndluDetails = (IndirammaIndluMdl.fromJson(list));
    return indirammaIndluDetails;
  }

  ValidLoginDetailsResponse? loginDetails;
  ValidLoginDetailsResponse? get getLoginDetails => loginDetails;
  getLoginResponseDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginResponse = await prefs.getString('ValidateLoginResponse') ?? '';

    if (loginResponse.isEmpty || loginResponse == "") {
      loginDetails = ValidLoginDetailsResponse();
    } else {
      Map<String, dynamic> jsonData = json.decode(loginResponse);
      loginDetails = ValidLoginDetailsResponse.fromJson(jsonData);
    }
  }

  List<PSData>? psMasterData;
  getPSDetails(BuildContext context) async {
    await getLoginResponseDetails();
    String? districtIdString = loginDetails?.data?.districtid;
    final pSPayload =
        PSPayload(districTID: int.tryParse(districtIdString ?? ""));
    bool isConnected = await InternetCheck();
    if (isConnected) {
      setIsLoadingStatus(true);
      final response = await IndirammaMastersRepository()
          .downloadPSMastersRepo(context, pSPayload);
      setIsLoadingStatus(false);

      if (response?.statusCode == ApiErrorCodes.SUCCESS) {
        if (response?.psData != null) {
          psMasterData = response?.psData;
          notifyListeners();
        }
      } else if (response?.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response?.statusMessage ?? "",
          onPressed: () async {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
        );
      } else if (response?.statusCode == ApiErrorCodes.BAD_REQUEST) {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response?.statusMessage ?? "",
          onPressed: () async {
            Navigator.pop(context);
          },
        );
      } else {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response?.statusMessage ?? "",
          onPressed: () async {
            Navigator.pop(context);
          },
        );
      }
    } else {
      InternetCheckAlert().showAlert(context);
    }
  }

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  bool? isIndirammaIndluDetailsFlag;

  onSaveClick({
    required BuildContext context,
    required String selectedFinancialAssistanceForHouse,
    required String selectedMartyrsFamilyType,
    required String selectedTelanganaMovementType,
    required String selectedJailType,
    required String martyrS250,
    required String martyrsName,
    required String yearOfDeath,
    required String martyrfirNo,
    required String deathCertificateNo,
    required String telanganaMovemntfirNo,
    required String telanganaMovemntfirYear,
    required String remarks,
    required String jailName,
    required String jailPlace,
    required String jailNoOfYears,
    required String jailNoOfMonths,
    required String jailNoOfDays,
    required String selectedResidentialStatus,
    required String selectedOwnershipStatus,
    required String plotArea,
    required String psName,
    required String selectedFamilyMember,
    required String familyRelation,
    required String typeOfRoof,
    required String selectedApplicantHavingHouseSite,
    required String houseSiteInTheNameOf,
    required String quidino,
    required String dateofimprisonment,
    required String dateofrelease,
    required String dateofsuicide,
    required String martyrfirYear,
    required String selectedPSDataofMartyr,
    required String whetherRemanded,
    required String selectedPSDataoftelanganamovement,
    required String underTrialNumber,
  }) async {
    final IndirammaIndluMdl indirammaIndluDetails = IndirammaIndluMdl(
      finhelPHOME: selectedFinancialAssistanceForHouse,
      activisTFIRNO: telanganaMovemntfirNo,
      activisTFIRYEAR: telanganaMovemntfirYear,
      activist: selectedTelanganaMovementType,
      housESITE: selectedHavingHouseSite,
      jaiLNAME: jailName,
      jaiLPLACE: jailPlace,
      martyrS250: martyrS250,
      martyrSDEATHCERTIFICATENO: deathCertificateNo,
      martyrSDEATHDATE: yearOfDeath,
      martyrSFAMILY: selectedMartyrsFamilyType,
      martyrSFIRNO: martyrfirNo,
      martyrSNAME: martyrsName,
      prisoNPERIODDAYS: jailNoOfDays,
      prisoNPERIODMONTH: jailNoOfMonths,
      prisoNPERIODYEAR: jailNoOfYears,
      wenTTOJAIL: selectedJailType,
      typEROOF: typeOfRoof,
      relationship: familyRelation,
      ploTAREA: plotArea,
      policestation: psName,
      housESITEAPPLICANT: selectedHousesiteonApplicantName,
      indiraselecteDID: selectedFamilyMember,
      naturEOWNERSHIP: selectedOwnershipStatus,
      prsnTRESIDENCSTATUS: selectedResidentialStatus,
      datEOFIMPRISONMENT: dateofimprisonment,
      datEOFRELEASE: dateofrelease,
      quaidINO: quidino,
      dateOFSuicide: dateofsuicide,
      martyrFIRYear: martyrfirYear,
      martyrPoliceStation: selectedPSDataofMartyr,
      remanded: whetherRemanded,
     activistPoliceStation: selectedPSDataoftelanganamovement,
     underTrailNumber: underTrialNumber,

    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoadingStatus(true);
    final editedIndirammaIndluDetailsString = jsonEncode(indirammaIndluDetails);

    await prefs
        .setString(SharedPrefConstants.indirammaIndluDetailsData,
            editedIndirammaIndluDetailsString)
        .then((value) async {
      await prefs.setBool(
          SharedPrefConstants.isIndirammaIndluDetailsSaved, true);
      isIndirammaIndluDetailsFlag =
          prefs.getBool(SharedPrefConstants.isIndirammaIndluDetailsSaved) ??
              false;
      setIsLoadingStatus(false);
    });
    notifyListeners();
  }

  bool validateFields(
      BuildContext context,
      String selectedFinancialAssistanceForHouse,
      ResidentiaLSTATUS? selectedResidentialStatus,
      Ownership? selectedOwnershipStatus,
      TypEROOF? selectedTypeRoofStatus,
      String? selectedHavingHouseSite,
      String? selectedHousesiteonApplicantName,
      FamilyListMdl? selectedFamilyMember,
      String plotArea,
      PSData? selectedPSData,
      String quidino,
      String dateofimprisonment,
      String dateofrelease,
      PersonalDtlsMdl? applicantDetails,
      String _martyrDateOfSuicide,
      String _martyrFirYear,
      PSData? selectedPSDataofMartyr,
      PSData? selectedPSDataoftelanganamovement,
      String underTrailNumber,) {
    print("selected Telangana Movement Type ${selectedTelanganaMovementType}");
    if (selectedFinancialAssistanceForHouse == 'Y') {
      if (selectedResidentialStatus?.reSID == null ||
          selectedResidentialStatus?.reSID == 0) {
        print("selectedjalil ${selectedJailType}  ");
        ValidationIoSAlert().showAlert(
          context,
          description: "Please select residential status",
        );
        return false;
      } else if (selectedResidentialStatus?.reSID == 1 &&
          (selectedTypeRoofStatus?.rooFID == 0 ||
              selectedTypeRoofStatus?.rooFID == null)) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please select type of roof",
        );
        return false;
      } else if (selectedHavingHouseSite == null ||
          selectedHavingHouseSite == '') {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please select House site",
        );
        return false;
      } else if (selectedHavingHouseSite == 'Y' &&
          selectedOwnershipStatus?.ownershiPID == null) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please select ownership status",
        );
        return false;
      } else if (selectedHavingHouseSite == 'Y' &&
          (selectedHousesiteonApplicantName == null ||
              selectedHousesiteonApplicantName == '')) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please select House site in the name of Applicant",
        );
        return false;
      } else if (selectedHousesiteonApplicantName == 'N' &&
          (selectedFamilyMember?.id == null || selectedFamilyMember?.id == 0)) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please select family member",
        );
        return false;
      } else if (selectedHavingHouseSite == 'Y' && plotArea.trim().isEmpty) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter plot area",
        );
        return false;
      } 
    }
 
    if (selectedMartyrsFamilyType == "Y")
    {
      if(_martyrDateOfSuicide.trim().isEmpty)
      {
         ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Date of Suicide",
        );
         return false;
      }
      else if( martyrfirNocontroller.text.trim().isEmpty &&
          applicantDetails?.firflg == "Y")
          {  ValidationIoSAlert().showAlert(
          context,
          description: "Please enter FIR No of the Martyr",
        );
        return false;

          }
          /* else if(martyrsNameController.text.trim().isEmpty)
          {
          ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Martyr's Name",
        );
        return false;

          } */
           else if( _martyrFirYear.trim().isEmpty 
          )
          {  ValidationIoSAlert().showAlert(
          context,
          description: "Please enter year of FIR ",
        );
        return false;

          }
           else if (
          deathCertificateNocontroller.text.trim().isEmpty &&
          applicantDetails?.dodflg == "Y") {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter death certificate no of the Martyr",
        );
        return false;
      }
      else if (selectedPSDataofMartyr?.pSID == null || selectedPSDataofMartyr?.pSID == 0) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please  select Police Station",
          );
          return false;     
    }
   
   
      if (selectedTelanganaMovementType == "Y") 
      {
        if(selectedWhetherRemanded.trim().isEmpty)
        {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please select whether remanded",
          );
          return false;

        }
      else  if (telanganaMovemntfirNocontroller.text.trim().isEmpty) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please enter FIR No",
          );
          return false;
        } else if (telanganaMovemntfirYearcontroller.text.trim().isEmpty) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please enter FIR Year",
          );
          return false;
        }
        ////////////
        else if (selectedPSDataoftelanganamovement?.pSID == null || selectedPSDataoftelanganamovement?.pSID == 0) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please select Police Station",
          );
          return false;
        }
      }
      if(selectedJailType == "Y" )
      {
             if (selectedJailType == "Y" &&
          jailNameController.text.trim().isEmpty) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Jail Name",
        );
        return false;
      } else if (selectedJailType == "Y" &&
          jailPlaceController.text.trim().isEmpty) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Jail Place",
        );
        return false;
      }
      else if(underTrailNumber.trim().isEmpty)
      {
         ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Under Trial Number",
        );
        return false;

      }
      else if (selectedJailType == "Y" &&
          jailNoOfYearsController.text.trim().isEmpty) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Jail No of Years",
        );
        return false;
      } else if (selectedJailType == "Y" &&
          jailNoOfMonthsController.text.trim().isEmpty) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Jail No of Months",
        );
        return false;
      } else if (selectedJailType == "Y" &&
          jailNoOfDaysController.text.trim().isEmpty) {
        ValidationIoSAlert().showAlert(
          context,
          description: "Please enter Jail No of Days",
        );
        return false;
      } 
      //Changed here for selectedJailTYpe y because it was shown as dead code
      else if (selectedJailType == "Y") {
        /*  if (selectedPSData?.pSID == null || selectedPSData?.pSID == 0) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please  select Police Station",
          );
          return false;
        } else  */
        if (quidino.trim().isEmpty) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please enter Quidi Number",
          );
          return false;
        } else if (dateofimprisonment.trim().isEmpty) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please enter Date of imprisonment",
          );
          return false;
        } else if (dateofrelease.trim().isEmpty) {
          ValidationIoSAlert().showAlert(
            context,
            description: "Please enter Date of release",
          );
          return false;
        }
      }
      
      
      
      } else {
        return true;
      }
    } else {
      return true;
    }
    return true;
  }

}
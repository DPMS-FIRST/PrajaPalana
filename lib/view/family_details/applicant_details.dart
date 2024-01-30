import 'dart:async';

import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/datepicker.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/get_device_address.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/dashboard_view_model.dart';
import 'package:praja_palana/view_model/login_view_model.dart';
import 'package:praja_palana/view_model/valid_ration_aadhaar_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../models/configurable_fields/configurable_fields_response.dart';
import '../../res/reusable_widgets/dropdown_resuable.dart';
import '../../view_model/schemesViewModel/application_details_view_model.dart';

class ApplicantDetails extends StatefulWidget {
  const ApplicantDetails({super.key});

  @override
  State<ApplicantDetails> createState() => _ApplicantDetailsState();
}

class _ApplicantDetailsState extends State<ApplicantDetails> {
  TextEditingController _applicantName = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _aadhaarno = TextEditingController();
  TextEditingController _rationCardNo = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();
  TextEditingController occupation = TextEditingController();
  List<Occupations?> occupationList = [];
  Occupations? selectedOccupation;
  List<Gender> gendersList = [];
  List<Caste> casteList = [];
  String? selectedGender = null;
  String? selectedCaste = null;
  bool homeFlag = false;
  bool rationFlag = false;
  ApplicantdetailsEdit? applicantdetailsEdit;
  PersonalDtlsMdl? applicantDetails;
  List<Districts?> districtList = [];
  List<Districts?> mandalList = [];
  List<Districts?> panchaayatList = [];
  List<Districts?> municipalityList = [];
  bool mandalflag = false;
  bool panchayatflag = false;
  bool municipalityflag = false;
  Districts? selectedDistrict;
  Districts? selectedMandal;
  Districts? selectedPanchayat;
  Districts? selectedMunicipality;
  TextEditingController _houseNo = TextEditingController();
  AddressdetailsEdit? EditFlags;
  ValidLoginDetailsResponse? loginResponse;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final applicationDetailsProvider =
          Provider.of<ApplicantDetailsViewModel>(context, listen: false);
      applicationDetailsProvider.selectedRationNumnber = '';
      final dashboardViewmodel =
          Provider.of<DashboardViewModel>(context, listen: false);
      final loginViewModel =
          Provider.of<LoginViewModel>(context, listen: false);
      await loginViewModel.getLoginResponseDetails();
      setState(() {
        loginResponse = loginViewModel.getLoginDetails;
      });
      occupationList.insert(
          0,
          Occupations(
              occupatioNNAME: AppStrings.select_occupation_name, id: "0"));

      occupationList.addAll(dashboardViewmodel.getDbOccupationList ?? []);

      applicationDetailsProvider.getGenderData().then((value) {
        setState(() {
          gendersList = value;
        });
      });
      applicationDetailsProvider.getCasteData().then((value) {
        setState(() {
          casteList = value;
        });
      });
      applicationDetailsProvider.getConfigurableApplicantData().then((value) {
        setState(() {
          applicantdetailsEdit = value;
        });
      });
      applicationDetailsProvider.getAddressConfigurableFlags().then((value) {
        EditFlags = value;
      });
      applicationDetailsProvider.getApplicationDetails().then((value) async {
        applicantDetails = value;
        _applicantName.text = applicantDetails?.applicanTNAME ?? '';
        _dob.text = applicantDetails?.datEOFBIRTH ?? '';
        _aadhaarno.text = applicantDetails?.aadhaRNO ?? '';
        _rationCardNo.text = applicantDetails?.ratioNCARDNO ?? '';
        _mobileNo.text = applicantDetails?.mobilENO ?? '';
        occupation.text = applicantDetails?.occupation ?? '';
        selectedCaste = applicantDetails?.caste ?? '';
        selectedGender = applicantDetails?.gender ?? '';
        applicationDetailsProvider.wardNoController.text =
            applicantDetails?.warDNO ?? "";

        selectedOccupation = applicantDetails?.occupation != null
            ? occupationList.firstWhere(
                (element) =>
                    element?.occupatioNNAME == applicantDetails?.occupation,
                orElse: () => occupationList.firstWhere(
                    (element) => element?.id == "7",
                    orElse: () => occupationList.first))
            : occupationList.first;
        districtList.insert(
            0,
            Districts(
                districtname: AppStrings.select_dist_name,
                districtid: "0",
                mandalid: "0",
                panchayatid: "0",
                panchayatname: "",
                mandalname: ""));
        print("districtId::: ${applicantDetails?.districTID}");
        districtList.addAll(dashboardViewmodel.getDbDistrictList ?? []);
        _houseNo.text = applicantDetails?.housENO ?? "";
        selectedDistrict = districtList.firstWhere((element) =>
            element?.districtid == (applicantDetails?.districTID ?? "0"));

        applicationDetailsProvider.selectedGPOrMunicipality =
            applicantDetails?.gPMUN?[0] ?? "";
        if (applicantDetails?.gPMUN == "GP" || applicantDetails?.gPMUN == "G") {
          await dashboardViewmodel.getMandalDBDetails(
              selectedDistrict?.districtid ?? "",
              applicantDetails?.gPMUN ?? "");
          mandalList = [];
          mandalList.insert(
              0,
              Districts(
                  mandalname: AppStrings.select_mandal_name, mandalid: "0"));

          mandalList.addAll(dashboardViewmodel.getDbMandalList ?? []);
          mandalflag = true;
          selectedMandal = mandalList.firstWhere(
              (element) => element?.mandalid == applicantDetails?.mandaLID);
          await dashboardViewmodel.getPunchayitDBDetails(
              selectedDistrict?.districtid ?? "", selectedMandal?.mandalid);
          panchaayatList = [];
          panchaayatList.insert(
              0,
              Districts(
                  panchayatname: AppStrings.select_pan_name, panchayatid: "0"));

          panchaayatList.addAll(dashboardViewmodel.getDbPanchayatList ?? []);
          panchayatflag = true;
          selectedPanchayat = panchaayatList.firstWhere((element) =>
              element?.panchayatid == applicantDetails?.panchayaTID);
          municipalityflag = false;
        } else {
          await dashboardViewmodel.getMunicipalityDBDetails(
              selectedDistrict?.districtid ?? "",
              applicantDetails?.gPMUN ?? "");
          municipalityList = [];
          municipalityList.insert(
              0,
              Districts(
                  mandalname: AppStrings.select_mandal_name, mandalid: ""));

          municipalityList
              .addAll(dashboardViewmodel.getDbMunicipalityList ?? []);
          municipalityflag = true;
          municipalityList.forEach((element) {
            print("element::: ${element?.ulBCODE}");
            print("muncipality name ::: ${element?.municipalitYNAME}");
          });
          print(
              "applicantDetails?.municipaLID ::: ${applicantDetails?.municipaLID}");
          selectedMunicipality = municipalityList.firstWhere(
              (element) => element?.ulBCODE == applicantDetails?.municipaLID);
          applicationDetailsProvider.wardNoController.text =
              applicantDetails?.warDNO ?? "";
          mandalflag = false;
          panchayatflag = false;
        }

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationDetailsProvider =
        Provider.of<ApplicantDetailsViewModel>(context);
    final dashboardViewmodel = Provider.of<DashboardViewModel>(context);
    final validateProvider =
        Provider.of<ValidateAadhaarRationViewModel>(context);
    final editableApplicantFlag =
        ModalRoute.of(context)?.settings.arguments as bool;
    print("editableApplicantFlag::: $editableApplicantFlag");
    print(
        "aadhar verify flag :: ${applicationDetailsProvider.aadharflags(validateProvider.aadharVerifyFlag, /* validateProvider.rationVerifyFlag, */ applicantDetails)}");
    return Stack(
      children: [
        PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop == false) {
              // // BackAlert().showAlert(context: context);
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            appBar: AppBarComponent(
              title: "APPLICANT DETAILS".tr(),
              onPressedHome: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(AppRoutes.applicantDashboard));
              },
              onPressedBack: () {
                // BackAlert().showAlert(context: context);
                Navigator.pop(context);
              },
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage(AppAssets.appBg),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ReusableComponents().ApplicationRationAndApplicantName(),
                    //ReusableComponents().officerNameAndApplicationNumber(),
                    /*  ReusableTextFormField(
                      controller: _applicantionNo,
                      labelText: "APPLICATION NUMBER".tr(),
                    ), */
                    ReusableTextFormField(
                      readOnly:
                          applicantdetailsEdit?.applicanTNAME?.toLowerCase() ==
                                  "y"
                              ? false
                              : true,
                      controller: _applicantName,
                      labelText:
                          "NAME OF THE APPLICANT (HEAD OF THE FAMILY)".tr(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: gendersList.length,
                          itemBuilder: (context, index) {
                            return buildGenderRadioButton(
                                gendersList[index].genderid!,
                                gendersList[index].gendername!,
                                applicantdetailsEdit?.gender?.toLowerCase() ==
                                        "y"
                                    ? true
                                    : false);
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: casteList.length,
                              itemBuilder: (context, index) {
                                return buildCasteRadioButton(
                                    casteList[index].castid!,
                                    casteList[index].castname!,
                                    applicantdetailsEdit?.caste
                                                ?.toLowerCase() ==
                                            "y"
                                        ? true
                                        : false);
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    datePickerComponent(
                      hintText: "DATE OF BIRTH".tr(),
                      nameController: _dob,
                      errorMessage: '',
                      obsecuretext: false,
                      editable:
                          applicantdetailsEdit?.datEOFBIRTH?.toLowerCase() ==
                                  "y"
                              ? true
                              : false,
                      // node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        //_node.nextFocus();
                      },
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ReusableTextFormField(
                            onChanged: (p0) {
                              _aadhaarno.text = p0;
                              setState(() {});
                            },
                            maxLength: applicantDetails?.aadharmaxl ?? 12,
                            readOnly: /* (applicantdetailsEdit?.aadhaRNO
                                        ?.toLowerCase() ==
                                    "y" /* ||
                                        editableApplicantFlag == true */
                                )
                                ? false
                                : true, */
                                applicantDetails?.aadharflg == "Y"
                                    ? false
                                    : true,
                            controller: _aadhaarno,
                            labelText: "AADHAAR NO".tr(),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 8),
                        applicantDetails?.aadharflg == 'Y'
                            ? Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    int districtId = int.tryParse(
                                            selectedDistrict?.districtid ??
                                                "") ??
                                        0;
                                    int pun_mun_id = int.tryParse(
                                            selectedPanchayat?.panchayatid ??
                                                "") ??
                                        0;
                                    print("aadhar::: $_aadhaarno.text");
                                    if (validateProvider.validateAadhar(
                                        _aadhaarno.text,
                                        context,
                                        applicantDetails)) {
                                      validateProvider.setIsLoadingStatus(true);
                                      validateProvider.getAadhaarValidVM(
                                          context,
                                          loginResponse?.data?.iMOBILENO ?? "",
                                          await GetDeviceId().getDeviceId() ??
                                              '',
                                          loginResponse?.data?.iTOKENID ?? "",
                                          loginResponse?.data?.vCDEVICEID ?? "",
                                          loginResponse?.data?.districtid ?? "",
                                          loginResponse?.data?.panchayatid ??
                                              "",
                                          await GetDeviceIpAddress().GetIp(),
                                          loginResponse?.data?.userid ?? "",
                                          loginResponse?.data?.iMPIN
                                                  .toString() ??
                                              "",
                                          loginResponse?.data?.iTOKENID ?? '',
                                          "",
                                          _aadhaarno.text,
                                          _rationCardNo.text,
                                          _mobileNo.text,
                                          _applicantName.text,
                                          "",
                                          "",
                                          districtId,
                                          pun_mun_id,
                                          int.tryParse(applicantDetails?.idd ??
                                                  '') ??
                                              0,
                                          "");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                    Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              child: Text("Is the Ration Card provided"),
                            ),
                            Radio(
                                value: 'Y',
                                groupValue: applicationDetailsProvider
                                    .selectedRationNumnber,
                                onChanged: (value) async {
                                  print("value is -------- $value -------");
                                  applicationDetailsProvider
                                      .selectedRationNumnber = value ?? '';
                                  rationFlag = true;
                                  setState(() {});
                                  /* applicationDetailsProvider
                                              .changeGPOrMunicipality(
                                                  value.toString());
                                          await dashboardViewmodel
                                              .getMandalDBDetails(
                                                  selectedDistrict?.districtid ??
                                                      "",
                                                  selectedDistrict?.type ?? "");
                                          mandalList = [];
                                          panchaayatList = [];
                                          mandalList.insert(
                                              0,
                                              Districts(
                                                  mandalname:
                                                      AppStrings.select_mandal_name,
                                                  mandalid: ""));
                            
                                          mandalList.addAll(
                                              dashboardViewmodel.getDbMandalList ??
                                                  []);
                                          selectedMandal = mandalList.firstWhere(
                                              (element) =>
                                                  element?.mandalid ==
                                                  applicantDetails?.mandaLID);
                                          setState(() {
                                            mandalflag = true;
                                            panchayatflag = false;
                                          }); */
                                }),
                            Text("Yes".tr()),
                            Radio(
                                value: 'N',
                                groupValue: applicationDetailsProvider
                                    .selectedRationNumnber,
                                onChanged: (value) async {
                                  print("value is -------- $value -------");
                                  applicationDetailsProvider
                                      .selectedRationNumnber = value ?? '';
                                  rationFlag = false;
                                  setState(() {});
                                  /* applicationDetailsProvider
                                              .changeGPOrMunicipality(
                                                  value.toString());
                                          await dashboardViewmodel
                                              .getMunicipalityDBDetails(
                                                  selectedDistrict?.districtid ??
                                                      "",
                                                  selectedDistrict?.type ?? "");
                                          municipalityList = [];
                                          municipalityList.insert(
                                              0,
                                              Districts(
                                                  mandalname:
                                                      AppStrings.select_mandal_name,
                                                  mandalid: ""));
                            
                                          municipalityList.addAll(dashboardViewmodel
                                                  .getDbMunicipalityList ??
                                              []);
                                          municipalityflag = true;
                                          selectedMunicipality = municipalityList
                                              .firstWhere((element) =>
                                                  element?.ulBCODE ==
                                                  applicantDetails?.municipaLID);
                                          applicationDetailsProvider
                                                  .wardNoController.text =
                                              applicantDetails?.warDNO ?? "";
                                          mandalflag = false;
                                          panchayatflag = false;
                                          setState(() {
                                            municipalityflag = true;
                                          }); */
                                }),
                            Text("No".tr()),
                          ],
                        ),
                        Visibility(
                          visible: rationFlag,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ReusableTextFormField(
                                  onChanged: (p0) {
                                    _rationCardNo.text = p0;
                                    setState(() {});
                                  },
                                  maxLength: applicantDetails?.rationmaxl ?? 12,
                                  readOnly: /* (applicantdetailsEdit?.ratioNCARDNO
                                          ?.toLowerCase() ==
                                      "y" /*  ||
                                          editableApplicantFlag == true */
                                  )
                                  ? false
                                  : true, */
                                      applicantDetails?.rationflg == "Y"
                                          ? false
                                          : true,
                                  controller: _rationCardNo,
                                  labelText: "RATION CARD NO".tr(),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 8),
                              applicantDetails?.rationflg == 'Y'
                                  ? Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          int districtId = int.tryParse(
                                                  selectedDistrict
                                                          ?.districtid ??
                                                      "") ??
                                              0;
                                          int pun_mun_id = int.tryParse(
                                                  selectedPanchayat
                                                          ?.panchayatid ??
                                                      "") ??
                                              0;
                                          if (validateProvider.validateRation(
                                              _rationCardNo.text,
                                              context,
                                              applicantDetails)) {
                                            validateProvider
                                                .setIsLoadingStatus(true);
                                            validateProvider.getRationValidVM(
                                                context,
                                                loginResponse?.data?.iMOBILENO ??
                                                    "",
                                                await GetDeviceId()
                                                    .getDeviceId(),
                                                loginResponse
                                                        ?.data?.iTOKENID ??
                                                    "",
                                                loginResponse
                                                        ?.data?.vCDEVICEID ??
                                                    "",
                                                loginResponse
                                                        ?.data?.districtid ??
                                                    "",
                                                loginResponse?.data?.panchayatid ??
                                                    "",
                                                await GetDeviceIpAddress()
                                                    .GetIp(),
                                                loginResponse
                                                        ?.data?.userid ??
                                                    "",
                                                loginResponse?.data?.iMPIN
                                                        .toString() ??
                                                    "",
                                                loginResponse?.data?.iTOKENID ??
                                                    "",
                                                "",
                                                _aadhaarno.text,
                                                _rationCardNo.text,
                                                _mobileNo.text,
                                                _applicantName.text,
                                                "",
                                                "",
                                                districtId,
                                                pun_mun_id,
                                                int.tryParse(
                                                        applicantDetails?.idd ??
                                                            '') ??
                                                    0,
                                                "");
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: Text(
                                          'Verify',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                      ],
                    ),

                    ReusableTextFormField(
                      controller: _mobileNo,
                      labelText: "MOBILE NO".tr(),
                      keyboardType: TextInputType.number,
                      readOnly:
                          applicantDetails?.mobileflg == "Y" ? false : true,
                      maxLength: 10,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: DropdownTextFormFieldComponent(
                          hintText: AppStrings.select_occupation_name,
                          labelText: AppStrings.select_occupation_name,
                          items: occupationList.map((Occupations? option) {
                            return DropdownMenuItem<Occupations>(
                              value: option,
                              child: Text(option?.occupatioNNAME ?? ''),
                            );
                          }).toList(),
                          onChanged:
                              applicantdetailsEdit?.mobilENO?.toLowerCase() ==
                                      "y"
                                  ? (Occupations? newValue) {
                                      setState(() {
                                        selectedOccupation = newValue;
                                        // grievanceSubIssueTypeData = newValue;
                                      });
                                    }
                                  : null,
                          value: selectedOccupation),
                    ),
                    if (selectedOccupation?.id == "7")
                      ReusableTextFormField(
                        controller: occupation,
                        labelText: "OCCUPATION".tr(),
                        readOnly:
                            applicantdetailsEdit?.occupation?.toLowerCase() ==
                                    "y"
                                ? false
                                : true,
                      ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    ReusableTextFormField(
                        controller: _houseNo,
                        labelText: "HOUSE NO. & STREET".tr(),
                        readOnly:
                            applicantDetails?.addressflg == 'Y' ? false : true
                        // (EditFlags?.housENO?.toLowerCase() == "y" ||
                        //         editableApplicantFlag == true)
                        //     ? false
                        //     : true,
                        ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    selectedDistrict != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 2.0),
                            child: DropdownTextFormFieldComponent(
                                hintText: AppStrings.select_dist_name,
                                labelText: AppStrings.select_dist_name,
                                items: districtList.map((Districts? option) {
                                  return DropdownMenuItem<Districts>(
                                    value: option,
                                    child: Text(option?.districtname ?? ''),
                                  );
                                }).toList(),
                                onChanged: EditFlags?.districTID
                                            ?.toLowerCase() ==
                                        "y"
                                    ? (Districts? newValue) async {
                                        setState(() {
                                          selectedDistrict = newValue;
                                        });
                                        await dashboardViewmodel
                                            .getMandalDBDetails(
                                                selectedDistrict?.districtid ??
                                                    "",
                                                selectedDistrict?.type ?? "");
                                        mandalList = [];
                                        mandalList.insert(
                                            0,
                                            Districts(
                                                mandalname: AppStrings
                                                    .select_mandal_name,
                                                mandalid: ""));

                                        mandalList.addAll(dashboardViewmodel
                                                .getDbMandalList ??
                                            []);
                                        mandalflag = true;
                                        setState(() {});
                                      }
                                    : null,
                                value: selectedDistrict),
                          )
                        : Container(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'G',
                              groupValue: applicationDetailsProvider
                                  .selectedGPOrMunicipality,
                              onChanged: EditFlags?.gPMUN?.toLowerCase() == "y"
                                  ? (value) async {
                                      applicationDetailsProvider
                                          .changeGPOrMunicipality(
                                              value.toString());
                                      await dashboardViewmodel
                                          .getMandalDBDetails(
                                              selectedDistrict?.districtid ??
                                                  "",
                                              selectedDistrict?.type ?? "");
                                      mandalList = [];
                                      panchaayatList = [];
                                      mandalList.insert(
                                          0,
                                          Districts(
                                              mandalname:
                                                  AppStrings.select_mandal_name,
                                              mandalid: ""));

                                      mandalList.addAll(
                                          dashboardViewmodel.getDbMandalList ??
                                              []);
                                      selectedMandal = mandalList.firstWhere(
                                          (element) =>
                                              element?.mandalid ==
                                              applicantDetails?.mandaLID);
                                      setState(() {
                                        mandalflag = true;
                                        panchayatflag = false;
                                      });
                                    }
                                  : null,
                            ),
                            Text("Gram Panchayat".tr()),
                            Radio(
                              value: 'M',
                              groupValue: applicationDetailsProvider
                                  .selectedGPOrMunicipality,
                              onChanged: EditFlags?.gPMUN?.toLowerCase() == "y"
                                  ? (value) async {
                                      applicationDetailsProvider
                                          .changeGPOrMunicipality(
                                              value.toString());
                                      await dashboardViewmodel
                                          .getMunicipalityDBDetails(
                                              selectedDistrict?.districtid ??
                                                  "",
                                              selectedDistrict?.type ?? "");
                                      municipalityList = [];
                                      municipalityList.insert(
                                          0,
                                          Districts(
                                              mandalname:
                                                  AppStrings.select_mandal_name,
                                              mandalid: ""));

                                      municipalityList.addAll(dashboardViewmodel
                                              .getDbMunicipalityList ??
                                          []);
                                      municipalityflag = true;
                                      selectedMunicipality = municipalityList
                                          .firstWhere((element) =>
                                              element?.ulBCODE ==
                                              applicantDetails?.municipaLID);
                                      applicationDetailsProvider
                                              .wardNoController.text =
                                          applicantDetails?.warDNO ?? "";
                                      mandalflag = false;
                                      panchayatflag = false;
                                      setState(() {
                                        municipalityflag = true;
                                      });
                                    }
                                  : null,
                            ),
                            Text("Municipality".tr()),
                          ],
                        ),
                        if (applicationDetailsProvider
                                    .selectedGPOrMunicipality ==
                                'GP' ||
                            applicationDetailsProvider
                                    .selectedGPOrMunicipality ==
                                'G')
                          Column(
                            children: [
                              //GP Mandal
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015),
                              Visibility(
                                visible: mandalflag,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownTextFormFieldComponent(
                                      hintText: AppStrings.select_mandal_name,
                                      labelText: AppStrings.select_mandal_name,
                                      items:
                                          mandalList.map((Districts? option) {
                                        return DropdownMenuItem<Districts>(
                                          value: option,
                                          child: Text(option?.mandalname ?? ''),
                                        );
                                      }).toList(),
                                      onChanged: EditFlags?.mandaLID
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? (Districts? newValue) async {
                                              setState(() {
                                                selectedMandal = newValue;
                                              });
                                              await dashboardViewmodel
                                                  .getPunchayitDBDetails(
                                                      selectedDistrict
                                                              ?.districtid ??
                                                          "",
                                                      selectedMandal?.mandalid);
                                              panchaayatList = [];
                                              panchaayatList.insert(
                                                  0,
                                                  Districts(
                                                      panchayatname: AppStrings
                                                          .select_pan_name,
                                                      panchayatid: "0"));

                                              panchaayatList.addAll(
                                                  dashboardViewmodel
                                                          .getDbPanchayatList ??
                                                      []);
                                              selectedPanchayat = panchaayatList
                                                  .firstWhere((element) =>
                                                      element?.panchayatid ==
                                                      (applicantDetails
                                                              ?.panchayaTID ??
                                                          "0"));
                                              panchayatflag = true;
                                              setState(() {});
                                            }
                                          : null,
                                      value: selectedMandal),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Visibility(
                                visible: panchayatflag,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: DropdownTextFormFieldComponent(
                                      hintText: AppStrings.select_pan_name,
                                      labelText: AppStrings.select_pan_name,
                                      items: panchaayatList
                                          .map((Districts? option) {
                                        return DropdownMenuItem<Districts>(
                                          value: option,
                                          child:
                                              Text(option?.panchayatname ?? ''),
                                        );
                                      }).toList(),
                                      onChanged: EditFlags?.panchayaTID
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? (Districts? newValue) async {
                                              setState(() {
                                                selectedPanchayat = newValue;
                                              });
                                            }
                                          : null,
                                      value: selectedPanchayat),
                                ),
                              ),
                            ],
                          ),
                        if (applicationDetailsProvider
                                .selectedGPOrMunicipality ==
                            'M')
                          Column(
                            children: [
                              //GP Mandal

                              Visibility(
                                visible: municipalityflag,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: DropdownTextFormFieldComponent(
                                      hintText:
                                          AppStrings.select_municipality_name,
                                      labelText:
                                          AppStrings.select_municipality_name,
                                      items: municipalityList
                                          .map((Districts? option) {
                                        return DropdownMenuItem<Districts>(
                                          value: option,
                                          child: Text(
                                              option?.municipalitYNAME ?? ''),
                                        );
                                      }).toList(),
                                      onChanged: EditFlags?.municipaLID
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? (Districts? newValue) {
                                              setState(() {
                                                selectedMunicipality = newValue;
                                              });
                                            }
                                          : null,
                                      value: selectedMunicipality),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              //Ward Number
                              ReusableTextFormField(
                                  controller: applicationDetailsProvider
                                      .wardNoController,
                                  readOnly:
                                      EditFlags?.warDNO?.toLowerCase() == "y"
                                          ? false
                                          : true,
                                  labelText: "wardNo".tr()),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),

                    if (applicationDetailsProvider.aadharflags(
                        validateProvider.aadharVerifyFlag,
                        //validateProvider.rationVerifyFlag,
                        applicantDetails)) ...{
                      ReusableButton(
                        onPressed: () async {
                          if (applicationDetailsProvider.validateFields(
                              context,
                              _mobileNo.text,
                              _houseNo.text,
                              applicantDetails,
                              _aadhaarno.text,
                              _rationCardNo.text)) {
                            await applicationDetailsProvider.onSaveClick(
                                context: context,
                                aadhaar: _aadhaarno.text,
                                onlineApplicationNo:
                                    applicantDetails?.onlinEAPPLICATIONNO ?? "",
                                offlineApplicationNo:
                                    applicantDetails?.offlinEAPPLICATIONNO ??
                                        "",
                                applicantName: _applicantName.text,
                                dob: _dob.text,
                                gender: selectedGender ?? "",
                                caste: selectedCaste ?? "",
                                mobileNo: _mobileNo.text,
                                occupation: occupation.text,
                                rationCardNo: _rationCardNo.text,
                                districtId: selectedDistrict?.districtid ?? "",
                                gpMunicipality: applicationDetailsProvider
                                    .selectedGPOrMunicipality,
                                houseNo: _houseNo.text,
                                mandalId: selectedMandal?.mandalid ?? "",
                                municipalId:
                                    selectedMunicipality?.ulBCODE ?? "",
                                panchayatId:
                                    selectedPanchayat?.panchayatid ?? "",
                                wardNo: applicationDetailsProvider
                                    .wardNoController.text,
                                departmenTCATAGORY:
                                    applicantDetails?.departmenTCATAGORY ?? "",
                                enablEAPPFAMILY:
                                    applicantDetails?.enablEAPPFAMILY ?? "",
                                enablESCHEMES:
                                    applicantDetails?.enablESCHEMES ?? "",
                                familyDtlsXML:
                                    applicantDetails?.familyDtlsXML ?? "",
                                gruhajyothi:
                                    applicantDetails?.gruhajyothi ?? "",
                                id: applicantDetails?.id ?? "",
                                idd: applicantDetails?.idd ?? "",
                                indirammAILLU:
                                    applicantDetails?.indirammAILLU ?? "",
                                iteCCATAGORY:
                                    applicantDetails?.iteCCATAGORY ?? "",
                                mHSCHEME: applicantDetails?.mHSCHEME ?? "",
                                passbookDtlsXML:
                                    applicantDetails?.passbookDtlsXML ?? "",
                                raithUBAROSA:
                                    applicantDetails?.raithUBAROSA ?? "",
                                remarks: "",
                                sadaramDtlsXML:
                                    applicantDetails?.sadaramDtlsXML ?? "",
                                surveyDtlsXML: applicantDetails?.surveyDtlsXML ?? "");
                            applicationDetailsProvider
                                .setIsLoadingStatus(false);
                            SuccessCustomCupertinoAlert().showAlert(
                                context: context,
                                title: "Data Saved Successfully".tr(),
                                onPressed: () {
                                  Navigator.popUntil(
                                    context,
                                    ModalRoute.withName(
                                        AppRoutes.applicantDashboard),
                                  );
                                  validateProvider.aadharVerifyFlag = false;
                                  validateProvider.rationVerifyFlag = false;
                                });
                          }
                        },
                        ButtonText: 'SAVE',
                      )
                    }
                  ],
                ),
              ),
            ),
          ),
        ),
        if (applicationDetailsProvider.getIsLoadingStatus) LoaderComponent()
      ],
    );
  }

  Widget buildCasteRadioButton(String value, String label, bool editable) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: selectedCaste,
          onChanged: editable
              ? (String? value) {
                  setState(() {
                    selectedCaste = value;
                  });
                }
              : null,
        ),
        Text(label),
      ],
    );
  }

  Widget buildGenderRadioButton(String value, String label, bool editable) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: selectedGender,
          onChanged: editable
              ? (String? value) {
                  setState(() {
                    selectedGender = value;
                  });
                }
              : null,
        ),
        Text(label),
      ],
    );
  }
}

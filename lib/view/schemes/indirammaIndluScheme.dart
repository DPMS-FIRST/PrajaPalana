import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/master_data/master_geograpics_response.dart';
import 'package:praja_palana/models/ps_masters_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/dropdown_resuable.dart';
import 'package:praja_palana/res/reusable_widgets/file_upload_component.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/schemesViewModel/application_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/family_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/indirammaIndluSchemeViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class IndirammaIndluScheme extends StatefulWidget {
  const IndirammaIndluScheme({super.key});

  @override
  State<IndirammaIndluScheme> createState() => _IndirammaIndluSchemeState();
}

class _IndirammaIndluSchemeState extends State<IndirammaIndluScheme> {
  InditammaEdit? editableFlags;
  IndirammaIndluMdl? indirammaIndluDetails;
  List<FamilyListMdl> members = [];
  FamilyListMdl? selectedFamilyMember;
  TextEditingController _relationName = TextEditingController();
  TextEditingController _plotArea = TextEditingController();
  TextEditingController _quaidiNumber = TextEditingController();
  TextEditingController _dateofimprisonment = TextEditingController();
  TextEditingController _dateofRelease = TextEditingController();
  ResidentiaLSTATUS? selectedResidentialStatus;
  List<ResidentiaLSTATUS?> residentialStatusList = [];
  List<Ownership?> ownershipStatusList = [];
  List<TypEROOF?> roofTypeList = [];

  PSData? selectedPSDataForMartyr;
  PSData? selectedPSDataForActivist;
  TextEditingController jailDistrict = TextEditingController();
  TextEditingController jailName = TextEditingController();
  TextEditingController _underTrialNumber = TextEditingController();
  /////////////////////////////////////////////////////
  TextEditingController _dateofSuicideofDeceased = TextEditingController();
  TextEditingController _yearofFIRMartyr = TextEditingController();

  TypEROOF? selectedTypeRoofStatus;
  Ownership? selectedOwnershipStatus;
  PSData? selectedPSData;
  Toddytapper? selectedToddyTapper;
  Singlewomen? selectedSingleWomen;
  PersonalDtlsMdl? applicantDetails;
  DateTime getFirstDate() {
    String dateString = _dateofimprisonment.text;
    if (dateString.isNotEmpty) {
      DateTime dateOfImprisonment = DateFormat('dd/MM/yyyy').parse(dateString);
      return dateOfImprisonment;
    } else {
      return DateTime.now();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //getInitialData();

      final indirammaIndluProvider =
          Provider.of<IndirammaIndluSchemeViewModel>(context, listen: false);
      final familyProvider =
          Provider.of<FamilyDetailsViewModel>(context, listen: false);
      final applicationDetailsProvider =
          Provider.of<ApplicantDetailsViewModel>(context, listen: false);

      setState(() {
        indirammaIndluProvider.selectedHousesiteonApplicantName = "";
        indirammaIndluProvider.selectedHavingHouseSite = '';
      });
      //indirammaIndluProvider.changeStatusOfHavingaHouseSite("");
      applicationDetailsProvider.getApplicationDetails().then((value) async {
        applicantDetails = value;
        print("applicantDetails ${applicantDetails?.gender}");
        setState(() {});
      });
      await familyProvider.getFamilyData().then((value) {
        setState(() {
          members
              .add(FamilyListMdl(id: 0, name: "Select Name of Family Member"));
          members.addAll(value);
        });
      });
      await indirammaIndluProvider.getResidentailData().then((value) {
        setState(() {
          residentialStatusList.add(ResidentiaLSTATUS(
              reSID: 0, reSNAME: "Select Residential Status"));
          residentialStatusList.addAll(value);
          // residentialStatusList = value;
        });
      });
      await indirammaIndluProvider.getOwnershipData().then((value) {
        setState(() {
          ownershipStatusList.add(Ownership(
              ownershiPID: 0, ownershiPNAME: "Select Ownership Status"));
          ownershipStatusList.addAll(value);
          // ownershipStatusList = value;
        });
      });
      await indirammaIndluProvider.getTypeRoofData().then((value) {
        setState(() {
          roofTypeList
              .add(TypEROOF(rooFID: 0, rooFNAME: "Select Type of Roof Status"));
          roofTypeList.addAll(value);
        });

        /* setState(() {
          roofTypeList = value;
        }); */
      });

      await indirammaIndluProvider.getConfigurableFlags().then((value) {
        setState(() {
          editableFlags = value;
        });
      });
      /*  await indirammaIndluProvider.getPSDetails(context).then((value) {
        indirammaIndluProvider.psMasterData
            ?.insert(0, PSData(pSID: 0, pSNAME: "Select Police Station"));
        selectedPSData = indirammaIndluProvider.psMasterData?[0];
      }); */
      await indirammaIndluProvider.getPSDetails(context).then((value) {
        indirammaIndluProvider.psMasterData
            ?.insert(0, PSData(pSID: 0, pSNAME: "Select Police Station"));
        selectedPSData = indirammaIndluProvider.psMasterData?[0];
      });

      await indirammaIndluProvider.getIndirammaIndluDetails().then((value) {
        indirammaIndluDetails = value;
        print("object ${jsonEncode(indirammaIndluDetails)}");

        setState(() {
          indirammaIndluProvider.selectedFinancialAssistanceForHouse =
              indirammaIndluDetails?.finhelPHOME == "Y" ? "Y" : "N";
          indirammaIndluProvider.selectedMartyrsFamilyType =
              indirammaIndluDetails?.martyrSFAMILY == "Y" ? "Y" : "N";
          indirammaIndluProvider.selectedTelanganaMovementType =
              indirammaIndluDetails?.activist == "Y" ? "Y" : "N";
          indirammaIndluProvider.selectedJailType =
              indirammaIndluDetails?.wenTTOJAIL == "Y" ? "Y" : "N";
          indirammaIndluProvider.martyrsNameController.text =
              indirammaIndluDetails?.martyrSNAME ?? "";
          indirammaIndluProvider.yearOfDeathController.text =
              indirammaIndluDetails?.martyrSDEATHDATE ?? "";
          indirammaIndluProvider.martyrfirNocontroller.text =
              indirammaIndluDetails?.martyrSFIRNO ?? "";
          indirammaIndluProvider.deathCertificateNocontroller.text =
              indirammaIndluDetails?.martyrSDEATHCERTIFICATENO ?? "";
          indirammaIndluProvider.telanganaMovemntfirNocontroller.text =
              indirammaIndluDetails?.activisTFIRNO ?? "";
          indirammaIndluProvider.telanganaMovemntfirYearcontroller.text =
              indirammaIndluDetails?.activisTFIRYEAR ?? "";
          indirammaIndluProvider.jailNameController.text =
              indirammaIndluDetails?.jaiLNAME ?? "";
          indirammaIndluProvider.jailPlaceController.text =
              indirammaIndluDetails?.jaiLPLACE ?? "";
          indirammaIndluProvider.jailNoOfYearsController.text =
              indirammaIndluDetails?.prisoNPERIODYEAR ?? "";
          indirammaIndluProvider.jailNoOfMonthsController.text =
              indirammaIndluDetails?.prisoNPERIODMONTH ?? "";
          indirammaIndluProvider.jailNoOfDaysController.text =
              indirammaIndluDetails?.prisoNPERIODDAYS ?? "";
          selectedResidentialStatus?.reSID =
              int.tryParse(indirammaIndluDetails?.prsnTRESIDENCSTATUS ?? '');
          selectedTypeRoofStatus?.rooFID =
              int.tryParse(indirammaIndluDetails?.typEROOF ?? '');
          _quaidiNumber.text = indirammaIndluDetails?.quaidINO ?? "";
          _dateofimprisonment.text =
              indirammaIndluDetails?.datEOFIMPRISONMENT ?? "";
          _dateofRelease.text = indirammaIndluDetails?.datEOFRELEASE ?? "";
        });
      });
      if (indirammaIndluProvider.isIndirammaIndluDetailsFlag == true) {
        // residential status
        (indirammaIndluDetails?.prsnTRESIDENCSTATUS == null ||
                indirammaIndluDetails?.prsnTRESIDENCSTATUS == '')
            ? selectedResidentialStatus = residentialStatusList[0]
            : selectedResidentialStatus = residentialStatusList.firstWhere(
                (element) =>
                    element?.reSID ==
                    int.tryParse(
                        indirammaIndluDetails?.prsnTRESIDENCSTATUS ?? ''));
        // type roof
        (indirammaIndluDetails?.typEROOF == null ||
                indirammaIndluDetails?.typEROOF == '')
            ? selectedTypeRoofStatus = roofTypeList[0]
            : selectedTypeRoofStatus = roofTypeList.firstWhere((element) =>
                element?.rooFID ==
                int.tryParse(indirammaIndluDetails?.typEROOF ?? ''));

        // having house site
        (indirammaIndluDetails?.housESITEAPPLICANT == null ||
                indirammaIndluDetails?.housESITEAPPLICANT == '')
            ? indirammaIndluProvider.selectedHavingHouseSite = ''
            : indirammaIndluProvider.selectedHavingHouseSite =
                indirammaIndluDetails?.housESITEAPPLICANT ?? "";

        // ownership
        (indirammaIndluDetails?.housESITE == null ||
                indirammaIndluDetails?.housESITE == '')
            ? selectedOwnershipStatus = ownershipStatusList[0]
            : selectedOwnershipStatus = ownershipStatusList.firstWhere(
                (element) =>
                    element?.ownershiPID ==
                    int.tryParse(indirammaIndluDetails?.naturEOWNERSHIP ?? ''));

        // house site in the name of
        (indirammaIndluDetails?.housESITE == null ||
                indirammaIndluDetails?.housESITE == '')
            ? indirammaIndluProvider.selectedHousesiteonApplicantName = ''
            : indirammaIndluProvider.selectedHousesiteonApplicantName =
                indirammaIndluDetails?.housESITE ?? "";

        // family member
        (indirammaIndluDetails?.indiraselecteDID == null ||
                indirammaIndluDetails?.indiraselecteDID == '')
            ? selectedFamilyMember = members[0]
            : selectedFamilyMember = members.firstWhere((element) =>
                element.id ==
                int.tryParse(indirammaIndluDetails?.indiraselecteDID ?? ''));
        // relation
        indirammaIndluDetails?.relationship == null
            ? _relationName.text = ''
            : _relationName.text = indirammaIndluDetails?.relationship ?? "";

        // plot area
        (indirammaIndluDetails?.ploTAREA == null ||
                indirammaIndluDetails?.ploTAREA == '')
            ? _plotArea.text = ''
            : _plotArea.text = indirammaIndluDetails?.ploTAREA ?? "";
        print("plot area ${_plotArea.text}");

        // martyr,s family
        (indirammaIndluDetails?.martyrSFAMILY == null ||
                indirammaIndluDetails?.martyrSFAMILY == '')
            ? indirammaIndluProvider.selectedMartyrsFamilyType = ''
            : indirammaIndluProvider.selectedMartyrsFamilyType =
                indirammaIndluDetails?.martyrSFAMILY ?? "";

        // death certificate num
        (indirammaIndluDetails?.martyrSDEATHCERTIFICATENO == null ||
                indirammaIndluDetails?.martyrSDEATHCERTIFICATENO == '')
            ? indirammaIndluProvider.deathCertificateNocontroller.text = ''
            : indirammaIndluProvider.deathCertificateNocontroller.text =
                indirammaIndluDetails?.martyrSDEATHCERTIFICATENO ?? "";

        // fir no for telangana movement
        (indirammaIndluDetails?.activisTFIRNO == null ||
                indirammaIndluDetails?.activisTFIRNO == '')
            ? indirammaIndluProvider.telanganaMovemntfirNocontroller.text = ''
            : indirammaIndluProvider.telanganaMovemntfirNocontroller.text =
                indirammaIndluDetails?.activisTFIRNO ?? "";

        // fir year for telangana movement
        (indirammaIndluDetails?.activisTFIRYEAR == null ||
                indirammaIndluDetails?.activisTFIRYEAR == '')
            ? indirammaIndluProvider.telanganaMovemntfirYearcontroller.text = ''
            : indirammaIndluProvider.telanganaMovemntfirYearcontroller.text =
                indirammaIndluDetails?.activisTFIRYEAR ?? "";

        // jail name
        (indirammaIndluDetails?.jaiLNAME == null ||
                indirammaIndluDetails?.jaiLNAME == '')
            ? indirammaIndluProvider.jailNameController.text = ''
            : indirammaIndluProvider.jailNameController.text =
                indirammaIndluDetails?.jaiLNAME ?? "";

        // jail place
        (indirammaIndluDetails?.jaiLPLACE == null ||
                indirammaIndluDetails?.jaiLPLACE == '')
            ? indirammaIndluProvider.jailPlaceController.text = ''
            : indirammaIndluProvider.jailPlaceController.text =
                indirammaIndluDetails?.jaiLPLACE ?? "";
        // quiadi number
        (indirammaIndluDetails?.quaidINO == null ||
                indirammaIndluDetails?.quaidINO == '')
            ? _quaidiNumber.text = ''
            : _quaidiNumber.text = indirammaIndluDetails?.quaidINO ?? "";
        // date of imprisonment
        (indirammaIndluDetails?.datEOFIMPRISONMENT == null ||
                indirammaIndluDetails?.datEOFIMPRISONMENT == '')
            ? _dateofimprisonment.text = ''
            : _dateofimprisonment.text =
                indirammaIndluDetails?.datEOFIMPRISONMENT ?? "";

        // date of release
        (indirammaIndluDetails?.datEOFRELEASE == null ||
                indirammaIndluDetails?.datEOFRELEASE == '')
            ? _dateofRelease.text = ''
            : _dateofRelease.text = indirammaIndluDetails?.datEOFRELEASE ?? "";

        //police stations
        (indirammaIndluDetails?.policestation == null ||
                indirammaIndluDetails?.policestation == '')
            ? selectedPSData = indirammaIndluProvider.psMasterData![0]
            : selectedPSData = indirammaIndluProvider.psMasterData?.firstWhere(
                (element) =>
                    element.pSID ==
                    int.tryParse(indirammaIndluDetails?.policestation ?? ''));

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final indirammaIndluProvider =
        Provider.of<IndirammaIndluSchemeViewModel>(context);

    final editableIndirammaFlag =
        ModalRoute.of(context)?.settings.arguments as bool;
    print("editableIndirammaFlag $editableIndirammaFlag");

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          Navigator.pop(context);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBarComponent(
              title: "indirammaIlluScheme".tr(),
              onPressedHome: () {
                Navigator.pushNamed(context, AppRoutes.applicantDashboard);
              },
              onPressedBack: () {
                Navigator.pop(context);
              },
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.appBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableComponents().ApplicationRationAndApplicantName(),
                      //ReusableComponents().officerNameAndApplicationNumber(),
                      Text("eligibleFamiliesNotOwningHouse".tr()),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("1.1. "),
                                Expanded(
                                    child:
                                        Text("houseFinancialAssistance".tr())),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Y',
                                  groupValue: indirammaIndluProvider
                                      .selectedFinancialAssistanceForHouse,
                                  onChanged: editableFlags?.finhelPHOME
                                              ?.toLowerCase() ==
                                          "y"
                                      ? (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfFinancialHouseAssistance(
                                                  value.toString());
                                        }
                                      : null,
                                ),
                                Text("Yes".tr()),
                                Radio(
                                  value: 'N',
                                  groupValue: indirammaIndluProvider
                                      .selectedFinancialAssistanceForHouse,
                                  onChanged: editableFlags?.finhelPHOME
                                              ?.toLowerCase() ==
                                          "y"
                                      ? (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfFinancialHouseAssistance(
                                                  value.toString());
                                        }
                                      : null,
                                ),
                                Text("No".tr()),
                              ],
                            ),
                            indirammaIndluProvider
                                        .selectedFinancialAssistanceForHouse ==
                                    "Y"
                                ? Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("1.2. "),
                                          Expanded(
                                            child: Text(
                                                "PRESENT RESIDENTIAL STATUS"),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0.0, right: 8.0, top: 8.0),
                                        child: DropdownTextFormFieldComponent<
                                                ResidentiaLSTATUS>(
                                            hintText:
                                                "Select Residential Status",
                                            labelText: "",
                                            items: residentialStatusList.map(
                                                (ResidentiaLSTATUS? option) {
                                              return DropdownMenuItem<
                                                  ResidentiaLSTATUS>(
                                                value: option,
                                                child: Text(
                                                    "${option?.reSNAME ?? ''}"),
                                              );
                                            }).toList(),
                                            onChanged:
                                                (ResidentiaLSTATUS? newValue) {
                                              selectedTypeRoofStatus = null;

                                              setState(() {
                                                selectedResidentialStatus =
                                                    newValue;
                                                selectedResidentialStatus
                                                    ?.reSID = newValue?.reSID;
                                              });
                                              print(
                                                  "on change of residential ${selectedResidentialStatus?.reSID}");
                                            },
                                            value: selectedResidentialStatus),
                                      ),
                                      Visibility(
                                        visible:
                                            selectedResidentialStatus?.reSID ==
                                                1,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0, right: 8.0, top: 8.0),
                                          child: DropdownTextFormFieldComponent<
                                                  TypEROOF>(
                                              hintText: "Select Type of Roof",
                                              labelText: "TYPE OF ROOF",
                                              items: roofTypeList
                                                  .map((TypEROOF? option) {
                                                return DropdownMenuItem<
                                                    TypEROOF>(
                                                  value: option,
                                                  child: Text(
                                                      option?.rooFNAME ?? ''),
                                                );
                                              }).toList(),
                                              onChanged: (TypEROOF? newValue) {
                                                setState(() {
                                                  selectedTypeRoofStatus =
                                                      newValue;
                                                });
                                              },
                                              value: selectedTypeRoofStatus),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("1.3. "),
                                          Expanded(
                                              child: Text(
                                                  "APPLICANT HAVING HOUSE SITE")),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                              value: 'Y',
                                              groupValue: indirammaIndluProvider
                                                  .selectedHavingHouseSite,
                                              onChanged: (value) {
                                                indirammaIndluProvider
                                                    .changeStatusOfHavingaHouseSite(
                                                        value.toString());
                                                indirammaIndluProvider
                                                    .changeStatusOfHouseSiteonApplicantName(
                                                        "");
                                                _plotArea.text = '';
                                                setState(() {});
                                              }),
                                          Text("Yes".tr()),
                                          Radio(
                                              value: 'N',
                                              groupValue: indirammaIndluProvider
                                                  .selectedHavingHouseSite,
                                              onChanged: (value) {
                                                indirammaIndluProvider
                                                    .changeStatusOfHavingaHouseSite(
                                                        value.toString());
                                                selectedOwnershipStatus = null;
                                                indirammaIndluProvider
                                                    .changeStatusOfHouseSiteonApplicantName(
                                                        "");
                                                _plotArea.text = '';
                                                setState(() {});
                                              }),
                                          Text("No".tr()),
                                        ],
                                      ),
                                      indirammaIndluProvider
                                                  .selectedHavingHouseSite ==
                                              "Y"
                                          ? FileUploadWidget(
                                              onImageSelected: (File? image) {
                                                // Handle the selected image file
                                                print('Image selected: $image');
                                                // Add your logic here
                                              },
                                              // isDocumentRequired: true,
                                              isImageRequired: true,
                                              onDocumentSelected: (File? doc) {
                                                print("doccccc ");
                                              },
                                            )
                                          : Container(),
                                      indirammaIndluProvider
                                                  .selectedHavingHouseSite ==
                                              "Y"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0,
                                                  right: 8.0,
                                                  top: 8.0),
                                              child: DropdownTextFormFieldComponent<
                                                      Ownership>(
                                                  hintText: "Select ",
                                                  labelText:
                                                      "NATURE OF OWNERSHIP OF THE PROPOSED SITE FOR CONSTRUCTION OF HOUSE",
                                                  items: ownershipStatusList
                                                      .map((Ownership? option) {
                                                    return DropdownMenuItem<
                                                        Ownership>(
                                                      value: option,
                                                      child: Text(option
                                                              ?.ownershiPNAME ??
                                                          ''),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (Ownership? newValue) {
                                                    setState(() {
                                                      selectedOwnershipStatus =
                                                          newValue;
                                                      indirammaIndluProvider
                                                          .changeStatusOfHouseSiteonApplicantName(
                                                              "");
                                                      _plotArea.text = '';
                                                    });
                                                  },
                                                  value:
                                                      selectedOwnershipStatus),
                                            )
                                          : Container(),
                                      indirammaIndluProvider
                                                  .selectedHavingHouseSite ==
                                              "Y"
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(""),
                                                Expanded(
                                                    child: Text(
                                                        "HOUSE SITE IS IN THE NAME OF APPLICANT")),
                                              ],
                                            )
                                          : Container(),
                                      indirammaIndluProvider
                                                      .selectedHavingHouseSite ==
                                                  "Y" &&
                                              indirammaIndluProvider
                                                      .selectedHavingHouseSite ==
                                                  "Y"
                                          ? Row(
                                              children: [
                                                Radio(
                                                    value: 'Y',
                                                    groupValue:
                                                        indirammaIndluProvider
                                                            .selectedHousesiteonApplicantName,
                                                    onChanged: (value) {
                                                      indirammaIndluProvider
                                                          .changeStatusOfHouseSiteonApplicantName(
                                                              value.toString());
                                                      _plotArea.text = '';
                                                      selectedFamilyMember =
                                                          null;
                                                      _relationName.text = '';
                                                      setState(() {});
                                                    }),
                                                Text("Yes".tr()),
                                                Radio(
                                                    value: 'N',
                                                    groupValue:
                                                        indirammaIndluProvider
                                                            .selectedHousesiteonApplicantName,
                                                    onChanged: (value) {
                                                      indirammaIndluProvider
                                                          .changeStatusOfHouseSiteonApplicantName(
                                                              value.toString());
                                                      _plotArea.text = '';
                                                      selectedFamilyMember =
                                                          null;
                                                      _relationName.text = '';

                                                      setState(() {});
                                                    }),
                                                Text("No".tr()),
                                              ],
                                            )
                                          : Container(),
                                      indirammaIndluProvider
                                                      .selectedHavingHouseSite ==
                                                  "Y" &&
                                              indirammaIndluProvider
                                                      .selectedHousesiteonApplicantName ==
                                                  "N"
                                          ? Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 8.0, top: 8.0),
                                                  child:
                                                      DropdownTextFormFieldComponent(
                                                          hintText:
                                                              "Select Name of Family Member",
                                                          labelText:
                                                              "NAME OF THE FAMILY MEMBER IN WHOSE NAME THE HOUSE SITE IS REGISTERED",
                                                          items: members.map(
                                                              (FamilyListMdl?
                                                                  option) {
                                                            return DropdownMenuItem<
                                                                FamilyListMdl>(
                                                              value: option,
                                                              child: Text(
                                                                  "${option?.name ?? ''}"),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (FamilyListMdl?
                                                                  newValue) {
                                                            setState(() {
                                                              selectedFamilyMember =
                                                                  newValue;
                                                              _relationName
                                                                      .text =
                                                                  selectedFamilyMember
                                                                          ?.relation ??
                                                                      "";
                                                            });
                                                          },
                                                          value:
                                                              selectedFamilyMember),
                                                ),
                                                ReusableTextFormField(
                                                  maxLength: 30,
                                                  left: 0.0,
                                                  right: 8.0,
                                                  readOnly: true,
                                                  controller: _relationName,
                                                  labelText:
                                                      "RELATIONSHIP WITH THE APPLICANT",
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      indirammaIndluProvider
                                                  .selectedHavingHouseSite ==
                                              "Y"
                                          ? ReusableTextFormField(
                                              maxLength: 30,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                  RegExp(r'^\d+\.?\d{0,2}$'),
                                                ),
                                              ],
                                              readOnly: false,
                                              controller: _plotArea,
                                              labelText:
                                                  "PLOT AREA IN SQUARE YARDS",
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("2. "),
                          Expanded(child: Text("martyrAndUdhyamaKaarulu".tr())),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("2.1. "),
                                Text("martyrfamily".tr()),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Y',
                                  groupValue: indirammaIndluProvider
                                      .selectedMartyrsFamilyType,
                                  onChanged: editableFlags?.martyrSFAMILY
                                              ?.toLowerCase() ==
                                          "y"
                                      ? (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfMartyrsFamily(
                                                  value.toString());
                                          indirammaIndluProvider
                                              .martyrfirNocontroller
                                              .clear();
                                          indirammaIndluProvider
                                              .deathCertificateNocontroller
                                              .clear();
                                        }
                                      : null,
                                ),
                                Text("Yes".tr()),
                                Radio(
                                  value: 'N',
                                  groupValue: indirammaIndluProvider
                                      .selectedMartyrsFamilyType,
                                  onChanged: editableFlags?.martyrSFAMILY
                                              ?.toLowerCase() ==
                                          "y"
                                      ? (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfMartyrsFamily(
                                                  value.toString());
                                          indirammaIndluProvider
                                              .martyrfirNocontroller
                                              .clear();
                                          indirammaIndluProvider
                                              .deathCertificateNocontroller
                                              .clear();
                                        }
                                      : null,
                                ),
                                Text("No".tr()),
                              ],
                            ),
                            if (indirammaIndluProvider
                                    .selectedMartyrsFamilyType ==
                                "Y")
                              //change this to Y
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8.0, right: 8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      child: TextFormField(
                                        readOnly: true,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _dateofSuicideofDeceased,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.calendar_month,
                                            color: Colors.black,
                                            size: 40,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                          ),
                                          labelText:
                                              "DATE OF SUICIDE OF DECEASED",
                                        ),
                                        onTap: () async {
                                          await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2014, 12, 31),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2014, 12, 31),
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              _dateofSuicideofDeceased.text =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(selectedDate);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  ReusableTextFormField(
                                      maxLength:
                                          applicantDetails?.firmaxl ?? 15,
                                      controller: indirammaIndluProvider
                                          .martyrfirNocontroller,
                                      readOnly: applicantDetails?.firflg == "Y"
                                          ? false
                                          : true,
                                      /*   editableFlags?.martyrSFIRNO
                                                      ?.toLowerCase() ==
                                                  "y" ||
                                              editableIndirammaFlag == true
                                          ? false
                                          : true, */
                                      labelText: "firNo".tr()),
                                  ReusableTextFormField(
                                      maxLength: 30,
                                      controller: indirammaIndluProvider
                                          .martyrsNameController,
                                      readOnly: editableFlags?.martyrSNAME
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? false
                                          : true,
                                      labelText: "martyrname".tr()),
                                  ReusableTextFormField(
                                    maxLength: 4,
                                    controller: _yearofFIRMartyr,
                                    readOnly: false,
                                    labelText: "YEAR OF FIR",
                                    keyboardType: TextInputType.number,
                                  ),
                                  ReusableTextFormField(
                                      maxLength: 30,
                                      controller: indirammaIndluProvider
                                          .yearOfDeathController,
                                      readOnly: editableFlags?.martyrSDEATHDATE
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? false
                                          : true,
                                      labelText: "yearOfDeath".tr()),
                                  ReusableTextFormField(
                                      maxLength:
                                          applicantDetails?.dodmaxl ?? 30,
                                      controller: indirammaIndluProvider
                                          .deathCertificateNocontroller,
                                      readOnly: applicantDetails?.dodflg == 'Y'
                                          ? false
                                          : true,
                                      labelText: "deathCertificateNo".tr()),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        /* right: 8.0, */ top: 8.0),
                                    child: DropdownTextFormFieldComponent<
                                            PSData>(
                                        hintText: "Select Police Station",
                                        labelText:
                                            "POLICE STATION WHERE THE FIR WAS REGISTERED",
                                        items: indirammaIndluProvider
                                                .psMasterData
                                                ?.map((PSData? option) {
                                              return DropdownMenuItem<PSData>(
                                                value: option,
                                                child: Text(
                                                    "${option?.pSNAME ?? ''}"),
                                              );
                                            }).toList() ??
                                            [],
                                        onChanged: (PSData? newValue) {
                                          setState(() {
                                            selectedPSDataForMartyr = newValue;
                                          });
                                        },
                                        value: selectedPSDataForMartyr),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, bottom: 5.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("2.2. "),
                                Expanded(
                                    child: Text(
                                        "telanganaMovementParticipation".tr())),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Y',
                                  groupValue: indirammaIndluProvider
                                      .selectedTelanganaMovementType,
                                  onChanged:
                                      editableFlags?.activist?.toLowerCase() ==
                                              "y"
                                          ? (value) {
                                              indirammaIndluProvider
                                                  .changeStatusOfMovementType(
                                                      value.toString());
                                              indirammaIndluProvider
                                                  .telanganaMovemntfirNocontroller
                                                  .clear();
                                            }
                                          : null,
                                ),
                                Text("Yes".tr()),
                                Radio(
                                  value: 'N',
                                  groupValue: indirammaIndluProvider
                                      .selectedTelanganaMovementType,
                                  onChanged:
                                      editableFlags?.activist?.toLowerCase() ==
                                              "y"
                                          ? (value) {
                                              indirammaIndluProvider
                                                  .changeStatusOfMovementType(
                                                      value.toString());
                                              indirammaIndluProvider
                                                  .telanganaMovemntfirNocontroller
                                                  .clear();
                                            }
                                          : null,
                                ),
                                Text("No".tr()),
                              ],
                            ),
                            if (indirammaIndluProvider
                                    .selectedTelanganaMovementType ==
                                "Y")
                              //change this to Y
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Text("2.2. "),
                                      Expanded(
                                          child: Text("WHETHER REMANDED?")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 'Y',
                                        groupValue: indirammaIndluProvider
                                            .selectedWhetherRemanded,
                                        onChanged: (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfRemanded(
                                                  value.toString());
                                        },
                                      ),
                                      Text("Yes".tr()),
                                      Radio(
                                        value: 'N',
                                        groupValue: indirammaIndluProvider
                                            .selectedWhetherRemanded,
                                        onChanged: (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfRemanded(
                                                  value.toString());
                                        },
                                      ),
                                      Text("No".tr()),
                                    ],
                                  ),
                                  ReusableTextFormField(
                                      maxLength:
                                          applicantDetails?.firmaxl ?? 15,
                                      controller: indirammaIndluProvider
                                          .telanganaMovemntfirNocontroller,
                                      readOnly: applicantDetails?.firflg == "Y"
                                          ? false
                                          : true,
                                      labelText: "firNo".tr()),
                                  ReusableTextFormField(
                                      maxLength: 30,
                                      controller: indirammaIndluProvider
                                          .telanganaMovemntfirYearcontroller,
                                      readOnly: editableFlags?.activisTFIRYEAR
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? false
                                          : true,
                                      labelText: "firYear".tr()),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        /* right: 8.0, */ top: 8.0),
                                    child: DropdownTextFormFieldComponent<
                                            PSData>(
                                        hintText: "Select Police Station",
                                        labelText:
                                            "POLICE STATION WHERE THE FIR WAS REGISTERED",
                                        items: indirammaIndluProvider
                                                .psMasterData
                                                ?.map((PSData? option) {
                                              return DropdownMenuItem<PSData>(
                                                value: option,
                                                child: Text(
                                                    "${option?.pSNAME ?? ''}"),
                                              );
                                            }).toList() ??
                                            [],
                                        onChanged: (PSData? newValue) {
                                          setState(() {
                                            selectedPSDataForActivist =
                                                newValue;
                                          });
                                        },
                                        value: selectedPSDataForActivist),
                                  ),
                                ],
                              ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("2.3. "),
                                Expanded(child: Text("jailTermtitle".tr())),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Y',
                                  groupValue:
                                      indirammaIndluProvider.selectedJailType,
                                  onChanged: editableFlags?.wenTTOJAIL
                                              ?.toLowerCase() ==
                                          "y"
                                      ? (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfjailType(
                                                  value.toString());
                                          _quaidiNumber.clear();
                                          _dateofimprisonment.clear();
                                          _dateofRelease.clear();
                                        }
                                      : null,
                                ),
                                Text("Yes".tr()),
                                Radio(
                                  value: 'N',
                                  groupValue:
                                      indirammaIndluProvider.selectedJailType,
                                  onChanged: editableFlags?.wenTTOJAIL
                                              ?.toLowerCase() ==
                                          "y"
                                      ? (value) {
                                          indirammaIndluProvider
                                              .changeStatusOfjailType(
                                                  value.toString());
                                          _quaidiNumber.clear();
                                          _dateofimprisonment.clear();
                                          _dateofRelease.clear();
                                        }
                                      : null,
                                ),
                                Text("No".tr()),
                              ],
                            ),
                            if (indirammaIndluProvider.selectedJailType == "Y")
                              //change this to Y
                              Column(
                                children: [
                                  ReusableTextFormField(
                                      maxLength: 30,
                                      controller: indirammaIndluProvider
                                          .jailNameController,
                                      readOnly: indirammaIndluProvider
                                              .jailNameController.text
                                              .trim()
                                              .isEmpty
                                          ? false
                                          : true,
                                      /* editableFlags?.jaiLNAME
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? false
                                          : true, */
                                      labelText: "jailname".tr()),
                                  ReusableTextFormField(
                                      maxLength: 30,
                                      controller: indirammaIndluProvider
                                          .jailPlaceController,
                                      readOnly: editableFlags?.jaiLPLACE
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? false
                                          : true,
                                      labelText: "place".tr()),
                                  ReusableTextFormField(
                                      maxLength: 30,
                                      controller: _underTrialNumber,
                                      /* keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'/^[0-9]'),
                                        ),
                                      ], */
                                      readOnly: false,
                                      labelText: "UNDER TRAIL(UT) NUMBER"),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Text(
                                              "${"imprisonmentdetails".tr()}(Imprisonment Period)")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ReusableTextFormField(
                                            maxLength: 30,
                                            controller: indirammaIndluProvider
                                                .jailNoOfYearsController,
                                            readOnly: editableFlags
                                                        ?.prisoNPERIODYEAR
                                                        ?.toLowerCase() ==
                                                    "y"
                                                ? false
                                                : true,
                                            labelText: "Years".tr()),
                                      ),
                                      Expanded(
                                        child: ReusableTextFormField(
                                            maxLength: 30,
                                            controller: indirammaIndluProvider
                                                .jailNoOfMonthsController,
                                            readOnly: editableFlags
                                                        ?.prisoNPERIODMONTH
                                                        ?.toLowerCase() ==
                                                    "y"
                                                ? false
                                                : true,
                                            labelText: "Months".tr()),
                                      ),
                                      Expanded(
                                        child: ReusableTextFormField(
                                            maxLength: 30,
                                            controller: indirammaIndluProvider
                                                .jailNoOfDaysController,
                                            readOnly: editableFlags
                                                        ?.prisoNPERIODDAYS
                                                        ?.toLowerCase() ==
                                                    "y"
                                                ? false
                                                : true,
                                            labelText: "Days".tr()),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            indirammaIndluProvider.selectedJailType == "Y"
                                ? Column(
                                    children: [
                                      /*  Padding(
                                        padding: EdgeInsets.only(
                                            /* right: 8.0, */ top: 8.0),
                                        child: DropdownTextFormFieldComponent<
                                                PSData>(
                                            hintText: "Select Police Station",
                                            labelText:
                                                "POLICE STATION WHERE THE FIR WAS REGISTERED",
                                            items: indirammaIndluProvider
                                                    .psMasterData
                                                    ?.map((PSData? option) {
                                                  return DropdownMenuItem<
                                                      PSData>(
                                                    value: option,
                                                    child: Text(
                                                        "${option?.pSNAME ?? ''}"),
                                                  );
                                                }).toList() ??
                                                [],
                                            onChanged: (PSData? newValue) {
                                              setState(() {
                                                selectedPSData = newValue;
                                              });
                                            },
                                            value: selectedPSData),
                                      ), */
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            /* left: 8.0, right: 8.0,  */ top:
                                                0.0),
                                        child: ReusableTextFormField(
                                            maxLength: 30,
                                            controller: _quaidiNumber,
                                            readOnly: false,
                                            labelText: "QUAIDI NUMBER"),
                                      ),
                                      /*     datePickerComponent(
                                        hintText: "The date of imprisonment",
                                        nameController: _dateofimprisonment,
                                        errorMessage: '',
                                        obsecuretext: false,
                                        action: TextInputAction.next,
                                      futureValuesDisable: true,
                                    
                                        onEditingComplete: () {
                                          if (_dateofimprisonment
                                              .text.isNotEmpty) {
                                            _dateofRelease.text =
                                                _dateofimprisonment.text;
                                               
                                          }
                                          print(
                                              "date of imprisonment ${_dateofimprisonment.text}");
                                          print(
                                              " ${DateFormat('dd/MM/yyyy').parse(_dateofimprisonment.text).year}");
                                          print(
                                              " ${DateFormat('dd/MM/yyyy').parse(_dateofimprisonment.text).month}");
                                          setState(() {
                                             
                                            _dateofimprisonment.text;
                                            print(
                                                "sajdasfhwvafhgsjeacjasvcjhavbsckBAscv");
                                            print(
                                                "date of imprisonment ${_dateofimprisonment.text}");
                                          });
                                        },
                                        suffixIcon: Icon(
                                          Icons.calendar_month,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                      ), */
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0, right: 8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.065,
                                          child: TextFormField(
                                              readOnly: true,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              controller: _dateofimprisonment,
                                              decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.black,
                                                  size: 40,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.red),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                labelText:
                                                    "THE DATE OF IMPRISONMENT",
                                              ),
                                              onTap: () async {
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                ).then((selectedDate) {
                                                  if (selectedDate != null) {
                                                    _dateofimprisonment.text =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(
                                                                selectedDate);
                                                    _dateofRelease.clear();
                                                  }
                                                });
                                              }),
                                        ),
                                      ),

                                      ///////////////////////////////////////////////////////
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0, right: 8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.065,
                                          child: TextFormField(
                                              readOnly: true,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              controller: _dateofRelease,
                                              decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.black,
                                                  size: 40,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.red),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                labelText: "DATE OF RELEASE",
                                              ),
                                              onTap: () async {
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: _dateofimprisonment
                                                          .text.isNotEmpty
                                                      ? DateTime(
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .parse(
                                                                  _dateofimprisonment
                                                                      .text)
                                                              .year,
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .parse(
                                                                  _dateofimprisonment
                                                                      .text)
                                                              .month,
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .parse(
                                                                  _dateofimprisonment
                                                                      .text)
                                                              .day)
                                                      : DateTime.now(),
                                                  lastDate: DateTime.now(),
                                                ).then((selectedDate) {
                                                  if (selectedDate != null) {
                                                    _dateofRelease.text =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(
                                                                selectedDate);
                                                  }
                                                });
                                              }),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),

                      ReusableButton(
                        onPressed: () async {
                          if (indirammaIndluProvider.validateFields(
                              context,
                              indirammaIndluProvider
                                  .selectedFinancialAssistanceForHouse,
                              selectedResidentialStatus,
                              selectedOwnershipStatus,
                              selectedTypeRoofStatus,
                              indirammaIndluProvider.selectedHavingHouseSite,
                              indirammaIndluProvider
                                  .selectedHousesiteonApplicantName,
                              selectedFamilyMember,
                              _plotArea.text,
                              selectedPSData,
                              _quaidiNumber.text,
                              _dateofimprisonment.text,
                              _dateofRelease.text,
                              applicantDetails,
                              _dateofSuicideofDeceased.text,
                              _yearofFIRMartyr.text,
                              selectedPSDataForMartyr,
                              selectedPSDataForActivist,
                              _underTrialNumber.text)) {
                            await indirammaIndluProvider.onSaveClick(
                              context: context,
                              selectedFinancialAssistanceForHouse:
                                  indirammaIndluProvider
                                      .selectedFinancialAssistanceForHouse,
                              selectedMartyrsFamilyType: indirammaIndluProvider
                                  .selectedMartyrsFamilyType,
                              selectedTelanganaMovementType:
                                  indirammaIndluProvider
                                      .selectedTelanganaMovementType,
                              selectedJailType:
                                  indirammaIndluProvider.selectedJailType,
                              martyrS250:
                                  indirammaIndluDetails?.martyrS250 ?? "",
                              martyrsName: indirammaIndluProvider
                                  .martyrsNameController.text,
                              yearOfDeath: indirammaIndluProvider
                                  .yearOfDeathController.text,
                              martyrfirNo: indirammaIndluProvider
                                  .martyrfirNocontroller.text,
                              deathCertificateNo: indirammaIndluProvider
                                  .deathCertificateNocontroller.text,
                              telanganaMovemntfirNo: indirammaIndluProvider
                                  .telanganaMovemntfirNocontroller.text,
                              telanganaMovemntfirYear: indirammaIndluProvider
                                  .telanganaMovemntfirYearcontroller.text,
                              remarks:
                                  indirammaIndluProvider.remarksController.text,
                              jailName: indirammaIndluProvider
                                  .jailNameController.text,
                              jailPlace: indirammaIndluProvider
                                  .jailPlaceController.text,
                              jailNoOfYears: indirammaIndluProvider
                                  .jailNoOfYearsController.text,
                              jailNoOfMonths: indirammaIndluProvider
                                  .jailNoOfMonthsController.text,
                              jailNoOfDays: indirammaIndluProvider
                                  .jailNoOfDaysController.text,
                              selectedResidentialStatus:
                                  selectedResidentialStatus?.reSID.toString() ??
                                      "",
                              plotArea: _plotArea.text,
                              selectedOwnershipStatus: selectedOwnershipStatus
                                      ?.ownershiPID
                                      .toString() ??
                                  "",
                              psName: selectedPSData?.pSID.toString() ?? "",
                              selectedFamilyMember:
                                  selectedFamilyMember?.id.toString() ?? "",
                              familyRelation: _relationName.text,
                              typeOfRoof:
                                  selectedTypeRoofStatus?.rooFID.toString() ??
                                      "",
                              houseSiteInTheNameOf: indirammaIndluProvider
                                  .selectedHousesiteonApplicantName,
                              selectedApplicantHavingHouseSite:
                                  indirammaIndluProvider
                                      .selectedHavingHouseSite,
                              quidino: _quaidiNumber.text,
                              dateofimprisonment: _dateofimprisonment.text,
                              dateofrelease: _dateofRelease.text,
                              dateofsuicide: _dateofSuicideofDeceased.text,
                              martyrfirYear: _yearofFIRMartyr.text,
                              selectedPSDataofMartyr:
                                  selectedPSDataForMartyr?.pSID.toString() ??
                                      "",
                              whetherRemanded: indirammaIndluProvider
                                  .selectedWhetherRemanded,
                              selectedPSDataoftelanganamovement:
                                  selectedPSDataForActivist?.pSID.toString() ??
                                      "",
                              underTrialNumber: _underTrialNumber.text,
                            );

                            indirammaIndluProvider.setIsLoadingStatus(false);

                            SuccessCustomCupertinoAlert().showAlert(
                                context: context,
                                title: "Data Saved Successfully".tr(),
                                onPressed: () {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          AppRoutes.applicantDashboard));
                                });
                          }
                          /*  if ((indirammaIndluProvider
                                      .selectedFinancialAssistanceForHouse ==
                                  "Y") &&
                              (indirammaIndluProvider.selectedJailType ==
                                  "Y")) {
                            if (selectedResidentialStatus?.reSID == null ||
                                selectedResidentialStatus?.reSID == 0) {
                              showCupertinoAlertDialog(context,
                                  "Please select residential status".tr());
                            } else if (selectedResidentialStatus?.reSID == 1 &&
                                (selectedTypeRoofStatus?.rooFID == null ||
                                    selectedTypeRoofStatus?.rooFID == 0)) {
                              showCupertinoAlertDialog(
                                  context, "Please select type of roof".tr());
                            } else if (indirammaIndluProvider
                                        .selectedHavingHouseSite ==
                                    "Y" &&
                                (selectedOwnershipStatus?.ownershiPID == null ||
                                    selectedOwnershipStatus?.ownershiPID ==
                                        0)) {
                              showCupertinoAlertDialog(context,
                                  "Please select ownership status".tr());
                            } else if (indirammaIndluProvider
                                        .selectedHavingHouseSite ==
                                    "Y" &&
                                indirammaIndluProvider
                                        .selectedHousesiteonApplicantName ==
                                    "") {
                              showCupertinoAlertDialog(context,
                                  "Please select house site whether in the name of applicant or not");
                            } else if (indirammaIndluProvider
                                        .selectedHavingHouseSite ==
                                    "Y" &&
                                indirammaIndluProvider
                                        .selectedHousesiteonApplicantName ==
                                    "N" &&
                                selectedFamilyMember == null) {
                              showCupertinoAlertDialog(
                                  context, "Please select family member".tr());
                            } else if (indirammaIndluProvider.selectedHavingHouseSite == "Y" && _plotArea.text == "") {
                              showCupertinoAlertDialog(
                                  context, "Please enter plot area".tr());
                            } else if (indirammaIndluProvider
                                        .selectedMartyrsFamilyType
                                        .toLowerCase() ==
                                    "y" &&
                                indirammaIndluProvider
                                    .martyrfirNocontroller.text.isEmpty) {
                              showCupertinoAlertDialog(context, "firno".tr());
                            } else if (indirammaIndluProvider
                                        .selectedMartyrsFamilyType
                                        .toLowerCase() ==
                                    "y" &&
                                indirammaIndluProvider
                                    .deathCertificateNocontroller
                                    .text
                                    .isEmpty) {
                              showCupertinoAlertDialog(
                                  context, "deathcertificateno".tr());
                            }
                            // telangana movement
                            else if (indirammaIndluProvider
                                        .selectedTelanganaMovementType
                                        .toLowerCase() ==
                                    "y" &&
                                indirammaIndluProvider
                                    .telanganaMovemntfirNocontroller
                                    .text
                                    .isEmpty) {
                              showCupertinoAlertDialog(
                                  context, "telanganaMovementfirno".tr());
                            }  else if (indirammaIndluProvider.selectedJailType == "Y" && selectedPSData == null) {
                              showCupertinoAlertDialog(
                                  context, "Please select police station".tr());
                            } else if (indirammaIndluProvider.selectedJailType == "Y" && _quaidiNumber.text == "") {
                              showCupertinoAlertDialog(
                                  context, "Please enter quaidi number".tr());
                            } else if (indirammaIndluProvider.selectedJailType == "Y" && _dateofimprisonment.text == "") {
                              showCupertinoAlertDialog(context,
                                  "Please enter date of imprisonment".tr());
                            } else if (indirammaIndluProvider.selectedJailType == "Y" &&_dateofRelease.text == "") {
                              showCupertinoAlertDialog(
                                  context, "Please enter date of release".tr());
                            } else {
                              indirammaIndluProvider.setIsLoadingStatus(false);

                              await indirammaIndluProvider.onSaveClick(
                                context: context,
                                selectedFinancialAssistanceForHouse:
                                    indirammaIndluProvider
                                        .selectedFinancialAssistanceForHouse,
                                selectedMartyrsFamilyType:
                                    indirammaIndluProvider
                                        .selectedMartyrsFamilyType,
                                selectedTelanganaMovementType:
                                    indirammaIndluProvider
                                        .selectedTelanganaMovementType,
                                selectedJailType:
                                    indirammaIndluProvider.selectedJailType,
                                martyrS250:
                                    indirammaIndluDetails?.martyrS250 ?? "",
                                martyrsName: indirammaIndluProvider
                                    .martyrsNameController.text,
                                yearOfDeath: indirammaIndluProvider
                                    .yearOfDeathController.text,
                                martyrfirNo: indirammaIndluProvider
                                    .martyrfirNocontroller.text,
                                deathCertificateNo: indirammaIndluProvider
                                    .deathCertificateNocontroller.text,
                                telanganaMovemntfirNo: indirammaIndluProvider
                                    .telanganaMovemntfirNocontroller.text,
                                telanganaMovemntfirYear: indirammaIndluProvider
                                    .telanganaMovemntfirYearcontroller.text,
                                remarks: indirammaIndluProvider
                                    .remarksController.text,
                                jailName: indirammaIndluProvider
                                    .jailNameController.text,
                                jailPlace: indirammaIndluProvider
                                    .jailPlaceController.text,
                                jailNoOfYears: indirammaIndluProvider
                                    .jailNoOfYearsController.text,
                                jailNoOfMonths: indirammaIndluProvider
                                    .jailNoOfMonthsController.text,
                                jailNoOfDays: indirammaIndluProvider
                                    .jailNoOfDaysController.text,
                                selectedResidentialStatus:
                                    selectedResidentialStatus?.reSID
                                            .toString() ??
                                        "",
                                plotArea: _plotArea.text,
                                selectedOwnershipStatus: selectedOwnershipStatus
                                        ?.ownershiPID
                                        .toString() ??
                                    "",
                                psName: selectedPSData?.pSID.toString() ?? "",
                                selectedFamilyMember:
                                    selectedFamilyMember?.id.toString() ?? "",
                                familyRelation: _relationName.text,
                                typeOfRoof:
                                    selectedTypeRoofStatus?.rooFID.toString() ??
                                        "",
                                houseSiteInTheNameOf: indirammaIndluProvider
                                    .selectedHousesiteonApplicantName,
                                selectedApplicantHavingHouseSite:
                                    indirammaIndluProvider
                                        .selectedHavingHouseSite,
                              );

                              indirammaIndluProvider.setIsLoadingStatus(false);

                              SuccessCustomCupertinoAlert().showAlert(
                                  context: context,
                                  title: "Data Saved Successfully".tr(),
                                  onPressed: () {
                                    Navigator.popUntil(
                                        context,
                                        ModalRoute.withName(
                                            AppRoutes.applicantDashboard));
                                    /* Navigator.pushNamed(
                                        context, AppRoutes.applicantDashboard); */
                                  });
                            }
                          } else if (indirammaIndluProvider
                                  .selectedFinancialAssistanceForHouse ==
                              "Y") {
                            if (selectedResidentialStatus?.reSID == null ||
                                selectedResidentialStatus?.reSID == 0) {
                              showCupertinoAlertDialog(context,
                                  "Please select residential status".tr());
                            } else if (selectedResidentialStatus?.reSID == 1 &&
                                (selectedTypeRoofStatus?.rooFID == null ||
                                    selectedTypeRoofStatus?.rooFID == 0)) {
                              showCupertinoAlertDialog(
                                  context, "Please select type of roof".tr());
                            } else if ((indirammaIndluProvider.selectedHavingHouseSite ==
                                '')) {
                              showCupertinoAlertDialog(
                                  context,
                                  "Please select having house site status"
                                      .tr());
                            } else if (indirammaIndluProvider.selectedHavingHouseSite == "Y" &&
                               ( selectedOwnershipStatus?.ownershiPID == null || selectedOwnershipStatus?.ownershiPID == 0)) {
                              showCupertinoAlertDialog(context,
                                  "Please select ownership status".tr());
                            } else if (indirammaIndluProvider.selectedHavingHouseSite == "Y" &&
                                indirammaIndluProvider.selectedHousesiteonApplicantName ==
                                    "") {
                              showCupertinoAlertDialog(context,
                                  "Please select house site whether in the name of applicant or not");
                            } else if (indirammaIndluProvider.selectedHavingHouseSite == "Y" &&
                                indirammaIndluProvider.selectedHousesiteonApplicantName ==
                                    "N" &&
                                (selectedFamilyMember?.name == null ||
                                    selectedFamilyMember?.id == 0)) {
                              showCupertinoAlertDialog(
                                  context, "Please select family member".tr());
                            } else if (indirammaIndluProvider.selectedMartyrsFamilyType == "Y" &&
                                indirammaIndluProvider
                                    .martyrfirNocontroller.text.isEmpty) {
                              showCupertinoAlertDialog(
                                  context, "Please enter FIR number".tr());
                            } else if (indirammaIndluProvider.selectedMartyrsFamilyType == "Y" &&
                                indirammaIndluProvider
                                    .deathCertificateNocontroller
                                    .text
                                    .isEmpty) {
                              showCupertinoAlertDialog(context,
                                  "Please enter death certificate number".tr());
                            } else if (indirammaIndluProvider.selectedTelanganaMovementType == "Y" &&
                                indirammaIndluProvider
                                    .telanganaMovemntfirNocontroller
                                    .text
                                    .isEmpty) {
                              showCupertinoAlertDialog(
                                  context, "telanganaMovementfirno".tr());
                            }  else if (indirammaIndluProvider.selectedHavingHouseSite == "Y" &&
                                _plotArea.text.isEmpty) {
                              showCupertinoAlertDialog(
                                  context, "Please enter plot area".tr());
                            } else if(indirammaIndluProvider.selectedJailType == "Y" && _quaidiNumber.text.isEmpty){
                               showCupertinoAlertDialog(
                                  context, "quidinumber".tr());
                            }
                            else if(indirammaIndluProvider.selectedJailType == "Y" && _dateofimprisonment.text.isEmpty){
                               showCupertinoAlertDialog(
                                  context, "dateOfiMPRISONMENT".tr());
                            }
                            else if(indirammaIndluProvider.selectedJailType == "Y" && _dateofRelease.text.isEmpty){
                               showCupertinoAlertDialog(
                                  context, "dateOfRelease".tr());
                            }
                            else {
                              indirammaIndluProvider.setIsLoadingStatus(false);
                              await indirammaIndluProvider.onSaveClick(
                                  context: context,
                                  selectedFinancialAssistanceForHouse:
                                      indirammaIndluProvider
                                          .selectedFinancialAssistanceForHouse,
                                  selectedMartyrsFamilyType:
                                      indirammaIndluProvider
                                          .selectedMartyrsFamilyType,
                                  selectedTelanganaMovementType:
                                      indirammaIndluProvider
                                          .selectedTelanganaMovementType,
                                  selectedJailType:
                                      indirammaIndluProvider.selectedJailType,
                                  martyrS250:
                                      indirammaIndluDetails?.martyrS250 ?? "",
                                  martyrsName: indirammaIndluProvider
                                      .martyrsNameController.text,
                                  yearOfDeath: indirammaIndluProvider
                                      .yearOfDeathController.text,
                                  martyrfirNo: indirammaIndluProvider
                                      .martyrfirNocontroller.text,
                                  deathCertificateNo: indirammaIndluProvider
                                      .deathCertificateNocontroller.text,
                                  telanganaMovemntfirNo: indirammaIndluProvider
                                      .telanganaMovemntfirNocontroller.text,
                                  telanganaMovemntfirYear: indirammaIndluProvider
                                      .telanganaMovemntfirYearcontroller.text,
                                  remarks: indirammaIndluProvider
                                      .remarksController.text,
                                  jailName: indirammaIndluProvider.jailNameController.text,
                                  jailPlace: indirammaIndluProvider.jailPlaceController.text,
                                  jailNoOfYears: indirammaIndluProvider.jailNoOfYearsController.text,
                                  jailNoOfMonths: indirammaIndluProvider.jailNoOfMonthsController.text,
                                  jailNoOfDays: indirammaIndluProvider.jailNoOfDaysController.text,
                                  selectedResidentialStatus: selectedResidentialStatus?.reSID.toString() ?? "",
                                  plotArea: _plotArea.text,
                                  selectedOwnershipStatus: selectedOwnershipStatus?.ownershiPID.toString() ?? "",
                                  psName: selectedPSData?.pSID.toString() ?? "",
                                  selectedFamilyMember: selectedFamilyMember?.id.toString() ?? "",
                                  familyRelation: _relationName.text,
                                  typeOfRoof: selectedTypeRoofStatus?.rooFID.toString() ?? "",
                                  houseSiteInTheNameOf: indirammaIndluProvider.selectedHousesiteonApplicantName,
                                  selectedApplicantHavingHouseSite: indirammaIndluProvider.selectedHavingHouseSite);

                              indirammaIndluProvider.setIsLoadingStatus(false);

                              SuccessCustomCupertinoAlert().showAlert(
                                  context: context,
                                  title: "Data Saved Successfully".tr(),
                                  onPressed: () {
                                    Navigator.popUntil(
                                        context,
                                        ModalRoute.withName(
                                            AppRoutes.applicantDashboard));
                                  });
                            }
                          } else if (indirammaIndluProvider.selectedJailType ==
                              "Y") {
                           /*  if (selectedPSData == null) {
                              showCupertinoAlertDialog(
                                  context, "Please select police station".tr());
                            } else */ if (_quaidiNumber.text == "") {
                              showCupertinoAlertDialog(
                                  context, "Please enter quaidi number".tr());
                            } else if (_dateofimprisonment.text == "") {
                              showCupertinoAlertDialog(context,
                                  "Please enter date of imprisonment".tr());
                            } else if (_dateofRelease.text == "") {
                              showCupertinoAlertDialog(
                                  context, "Please enter date of release".tr());
                            } else {
                              indirammaIndluProvider.setIsLoadingStatus(false);

                              await indirammaIndluProvider.onSaveClick(
                                  context: context,
                                  selectedFinancialAssistanceForHouse:
                                      indirammaIndluProvider
                                          .selectedFinancialAssistanceForHouse,
                                  selectedMartyrsFamilyType:
                                      indirammaIndluProvider
                                          .selectedMartyrsFamilyType,
                                  selectedTelanganaMovementType:
                                      indirammaIndluProvider
                                          .selectedTelanganaMovementType,
                                  selectedJailType:
                                      indirammaIndluProvider.selectedJailType,
                                  martyrS250:
                                      indirammaIndluDetails?.martyrS250 ?? "",
                                  martyrsName: indirammaIndluProvider
                                      .martyrsNameController.text,
                                  yearOfDeath: indirammaIndluProvider
                                      .yearOfDeathController.text,
                                  martyrfirNo: indirammaIndluProvider
                                      .martyrfirNocontroller.text,
                                  deathCertificateNo: indirammaIndluProvider
                                      .deathCertificateNocontroller.text,
                                  telanganaMovemntfirNo: indirammaIndluProvider
                                      .telanganaMovemntfirNocontroller.text,
                                  telanganaMovemntfirYear: indirammaIndluProvider
                                      .telanganaMovemntfirYearcontroller.text,
                                  remarks: indirammaIndluProvider
                                      .remarksController.text,
                                  jailName: indirammaIndluProvider.jailNameController.text,
                                  jailPlace: indirammaIndluProvider.jailPlaceController.text,
                                  jailNoOfYears: indirammaIndluProvider.jailNoOfYearsController.text,
                                  jailNoOfMonths: indirammaIndluProvider.jailNoOfMonthsController.text,
                                  jailNoOfDays: indirammaIndluProvider.jailNoOfDaysController.text,
                                  selectedResidentialStatus: selectedResidentialStatus?.reSID.toString() ?? "",
                                  plotArea: _plotArea.text,
                                  selectedOwnershipStatus: selectedOwnershipStatus?.ownershiPID.toString() ?? "",
                                  psName: selectedPSData?.pSID.toString() ?? "",
                                  selectedFamilyMember: selectedFamilyMember?.id.toString() ?? "",
                                  familyRelation: _relationName.text,
                                  typeOfRoof: selectedTypeRoofStatus?.rooFID.toString() ?? "",
                                  houseSiteInTheNameOf: indirammaIndluProvider.selectedHousesiteonApplicantName,
                                  selectedApplicantHavingHouseSite: indirammaIndluProvider.selectedHavingHouseSite);

                              indirammaIndluProvider.setIsLoadingStatus(false);

                              SuccessCustomCupertinoAlert().showAlert(
                                context: context,
                                title: "Data Saved Successfully".tr(),
                                onPressed: () {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          AppRoutes.applicantDashboard));
                                },
                              );
                            }
                          } */
                        },
                        ButtonText: 'SAVE',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (indirammaIndluProvider.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }

  void showCupertinoAlertDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context); // Close the alert
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

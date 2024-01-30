import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/cheyuta/cheyuta_submit_local.dart';
import 'package:praja_palana/models/cheyuta/table_info_cheyutha.dart';
import 'package:praja_palana/res/reusable_widgets/datepicker.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_button_wrapped_width.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:praja_palana/view_model/schemesViewModel/cheyuthaSchemeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../models/cheyuta/diyang_model.dart';
import '../../models/configurable_fields/configurable_fields_response.dart';
import '../../models/master_data/master_geograpics_response.dart';
import '../../res/CustomAlerts/alert_with_twobuttons.dart';
import '../../res/CustomAlerts/custom_success_alert.dart';
import '../../res/CustomAlerts/validation_ios_alert.dart';
import '../../res/constants/app_assets.dart';
import '../../res/constants/app_colors.dart';
import '../../res/constants/app_strings.dart';
import '../../res/reusable_widgets/appbar_component.dart';
import '../../res/reusable_widgets/dropdown_resuable.dart';
import '../../res/reusable_widgets/reusable_components.dart';
import '../../res/reusable_widgets/reusable_textfield.dart';
import '../../res/reusable_widgets/row_radio_component.dart';
import '../../res/reusable_widgets/cheyutha_reusable_table.dart';
import '../../routes/app_routes.dart';
import '../../view_model/schemesViewModel/application_details_view_model.dart';
import '../../view_model/schemesViewModel/family_details_view_model.dart';

class CheyuthaSchemeUpdated extends StatefulWidget {
  const CheyuthaSchemeUpdated({super.key});

  @override
  State<CheyuthaSchemeUpdated> createState() => _CheyuthaSchemeUpdatedState();
}

class _CheyuthaSchemeUpdatedState extends State<CheyuthaSchemeUpdated> {
  bool addSadaramCertificateNo = false;
  List<String> sadaramCertificateNoList = [];
  CheyuthaEdit? cheyuthaEdit;
  CheyuthaMdl? cheyuthaMdl;
  FamilyListMdl? familyListMdl;
  List<FamilyListMdl> familyList = [];
  List<FamilyListMdl> familyListBackup = [];
  TextEditingController sadaremIDController = TextEditingController();
  TextEditingController hubandDeathController = TextEditingController();
  TextEditingController deathDateController = TextEditingController();
  TextEditingController epfEnrollNumController = TextEditingController();
  TextEditingController epfEDateController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController licenceNoController = TextEditingController();
  TextEditingController licenseIssueDateController = TextEditingController();
  TextEditingController licensevalidDateController = TextEditingController();
  String? selectedApplicantWeaver = "";
  String? diyangselectedvalue, widowselectedValue, beediWorkerselectedValue;
  List<Singlewomen> singlewomenList = [];
  String? WomenRegID = "";
  List<Cheyutha> cheyuthaSubSchemes = [];
  /* Cheyutha(
      cschemEID: 1,
      cschemENAME: "Divyang",
    ),
    Cheyutha(
      cschemEID: 2,
      cschemENAME: "OLD AGE",
    ),
    Cheyutha(
      cschemEID: 3,
      cschemENAME: "TODDY TAPPER",
    ),
    Cheyutha(
      cschemEID: 4,
      cschemENAME: "DIALYSIS PATIENT",
    ),
    Cheyutha(
      cschemEID: 5,
      cschemENAME: "BEEDI WORKER",
    ),
    Cheyutha(
      cschemEID: 6,
      cschemENAME: "SINGLE WOMAN",
    ),
    Cheyutha(
      cschemEID: 7,
      cschemENAME: "WIDOW",
    ),
    Cheyutha(
      cschemEID: 8,
      cschemENAME: "WEAVER",
    ),
    Cheyutha(
      cschemEID: 9,
      cschemENAME: "HIV - AIDS PATIENT",
    ),
    Cheyutha(
      cschemEID: 10,
      cschemENAME: "FILARIA PATIENT",
    ),
    Cheyutha(
      cschemEID: 11,
      cschemENAME: "BEEDI TEKEDAR",
    ),
  ];*/
  List<Toddytapper> toddytappersList = [];
/*     Toddytapper(
      tTID: 1,
      tTNAME: "CORPORATIVE SOCIETY",
    ),
    Toddytapper(
      tTID: 2,
      tTNAME: "TREE FOR TAPPERS",
    )
  ]; */
  Cheyutha? selectedSubScheme;
  List<CheyuthaTableInfo> addedSchemeData = [];
  bool divyangVisibility = false;
  bool widowVisibility = false;
  bool beediWorkerVisibility = false;
  bool toddyTappersVisibility = false;
  bool weaversVisibility = false;
  bool dialysisVisibility = false;
  bool filariaVisibility = false;
  bool singleWomenVisibility = false;
  bool beediTekedarVisibility = false;
  bool oldageVisibility = false;
  bool hivAidsVisibility = false;
  bool saveDataFlag = false;
  Toddytapper? selectedToddyTapperType;
  List<Cheyutha> cheyuthaSubSchemesBackup = [];

  List<CheyutaSubmitLocalData> cheyutaList = [];
  List<CheyuthaTableInfo> cheyutaTableList = [];
  PersonalDtlsMdl? applicantDetails;
  // List<CheyutaSubmitLocalData> cheyutaOnBackList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cheyuthaSchemeViewModel =
          Provider.of<CheyuthaSchemeViewModel>(context, listen: false);
      final familyProvider =
          Provider.of<FamilyDetailsViewModel>(context, listen: false);
      final applicantDetailsProvider =
          Provider.of<ApplicantDetailsViewModel>(context, listen: false);
      await cheyuthaSchemeViewModel.getCheyuthaSchemeDetails(context);
      cheyuthaSubSchemes = [];
      applicantDetailsProvider.getApplicationDetails().then((value) async {
        applicantDetails = value;
      });
      cheyuthaSubSchemes.insert(
          0,
          Cheyutha(
              age: 1111,
              cschemEID: 0,
              cschemENAME: 'Select Cheyutha sub-scheme'));
      cheyuthaSubSchemes
          .addAll(cheyuthaSchemeViewModel.getCheyuthaSchemesList);
      /* cheyuthaSubSchemes.forEach((element) {
        print("cheyuthaSubSchemes:------------ ${jsonEncode(element)}");
      }); */
      await cheyuthaSchemeViewModel.getToddyTappersTypeDetails(context);

      toddytappersList = [];
      toddytappersList.insert(
          0, Toddytapper(tTID: 0, tTNAME: 'Select Toddy Tapper Type'));
      toddytappersList
          .addAll(cheyuthaSchemeViewModel.getToddyTappersTypeList);

      /* toddytappersList.forEach((element) {
        print("toddytappersList:------------ ${element.tTNAME}");
      }); */

      await cheyuthaSchemeViewModel.getCheyuthaTableInfoList();

      cheyutaTableList =
          await cheyuthaSchemeViewModel.getCheyuthaTableInfoList();

      /* cheyutaTableList.forEach((element) {
        /* print(
            "cheyutaTableList:------------ ${element.selectedCheyuthaSubScheme?.cschemENAME}"); */
      }); */

      await familyProvider.getFamilyData().then((value) async {
        setState(() {
          familyList.addAll(value);
          //print("familyList---- ${jsonEncode(familyList)}");
          familyListBackup.addAll(value);
          familyList.insert(
              0, FamilyListMdl(name: AppStrings.select_name, id: 0));
          familyListMdl = familyList[0];
        });
      });
      if (cheyutaTableList.length > 0) {
        print("true------ ${cheyutaTableList.length}");
        addedSchemeData = cheyutaTableList;
        addedSchemeData.forEach((tablist) {
          print(
              "addedSchemeData----- ${jsonEncode(tablist.selectedFamilyMember)}");
          print(
              "addedSchemeData selectedCheyuthaSubScheme----- ${jsonEncode(tablist.selectedCheyuthaSubScheme)}");
          List<FamilyListMdl> familyListCopy = List.from(familyList);

          familyListCopy.forEach((famlist) {
            print("familyList id ${famlist.id}");

            if (tablist.selectedFamilyMember?.name == famlist.name) {
              print("true-------");
              familyList.remove(famlist);
            }
          });
        });
      }

      if (cheyutaTableList.length > 0) {
        addedSchemeData = cheyutaTableList;
        addedSchemeData.forEach((tablist) {
          List<Cheyutha> cheyuthaSubSchemesCopy = List.from(cheyuthaSubSchemes);
          print("len----- ${cheyuthaSubSchemesCopy.length}");
          print(
              "cheyuthaschemes!!!!!!!!!!!!!!!!!! ${jsonEncode(cheyuthaSubSchemesCopy)}");
          print(
              "addschemedata table ------- ${jsonEncode(tablist.selectedCheyuthaSubScheme)}");
          cheyuthaSubSchemesCopy.forEach((cheySch) {
            if (cheySch.cschemEID == 1 ||
                cheySch.cschemEID == 5 ||
                cheySch.cschemEID == 7) {
              if (tablist.selectedCheyuthaSubScheme?.cschemEID ==
                  cheySch.cschemEID) {
                print("matched----");
                return;
                //cheyuthaSubSchemes = cheyuthaSubSchemes;
              }
            } else {
              if (tablist.selectedCheyuthaSubScheme?.cschemEID ==
                  cheySch.cschemEID) {
                print("matched----22222222");
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 2);
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 3);
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 4);
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 6);
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 8);
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 9);
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 10);
                cheyuthaSubSchemes
                    .removeWhere((element) => element.cschemEID == 11);

                print("after removing ${jsonEncode(cheyuthaSubSchemes)}");

                //cheyuthaSubSchemes.removeAt(cheySch.cschemEID ?? 10);
              }
            }
          });
        });
      }
      setState(() {});

      //

      /* if (!cheyuthaSubSchemes.any((element) => element.cschemEID == 7)) {
        // Find the element in cheyuthaSubSchemesBackup with ID 7
        var elementWithId7 = cheyuthaSubSchemesBackup
            .firstWhere((element) => element.cschemEID == 7);
        cheyuthaSubSchemes.add(elementWithId7);
      } */
// cheyutasubmit..

      await cheyuthaSchemeViewModel.getConfigurableCheyuthaData().then((value) {
        setState(() {
          cheyuthaEdit = value;
        });
      });
      await cheyuthaSchemeViewModel.getCheyuthaDetails().then((value) {
        cheyuthaMdl = value;
        setState(() {
          cheyuthaSchemeViewModel.selectedDivyang =
              cheyuthaMdl?.disabled == "0" ? 'Y' : 'N';
          sadaramCertificateNoList = cheyuthaMdl?.sadaramListMdl
                  ?.map((e) => e.sadaraMCERTIFICATENO ?? '')
                  .toList() ??
              [];
          cheyuthaSchemeViewModel.selectedOthers =
              cheyuthaMdl?.others == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedOldage =
              cheyuthaMdl?.vrudhapya == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedWidow =
              cheyuthaMdl?.vitantu == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedToddyTappers =
              cheyuthaMdl?.geetha == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedWeavers =
              cheyuthaMdl?.chenetha == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedDialysisPatients =
              cheyuthaMdl?.dailisis == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedHivAidsPatients =
              cheyuthaMdl?.aids == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedBeediWorkers =
              cheyuthaMdl?.beedi == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedFilariaPatients =
              cheyuthaMdl?.paileria == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedSingleWomen =
              cheyuthaMdl?.singlEWOMEN == "Y" ? 'Y' : 'N';
          cheyuthaSchemeViewModel.selectedBeediTekedar =
              cheyuthaMdl?.beedITEKEDARU == "Y" ? 'Y' : 'N';
          if (cheyuthaSchemeViewModel.selectedDivyang == 'Y') {
            for (int i = 0;
                i < (cheyuthaMdl?.sadaramListMdl?.length ?? 0);
                i++) {
              sadaramCertificateNoList.add(
                  cheyuthaMdl?.sadaramListMdl?[i].sadaraMCERTIFICATENO ?? '');
            }
          }
          selectedToddyTapperType = toddytappersList[0];
          selectedSubScheme = cheyuthaSubSchemes[0];
        });
      });
      await cheyuthaSchemeViewModel
          .getSingleWomenDetails(context)
          .then((value) {
        setState(() {
          cheyuthaSubSchemesBackup
              .addAll(cheyuthaSchemeViewModel.getCheyuthaSchemesList);
          cheyuthaSubSchemesBackup.insert(
              0,
              Cheyutha(
                  age: 1111,
                  cschemEID: 0,
                  cschemENAME: 'Select Cheyutha sub-scheme'));
          print(
              "object cheyuthaSubSchemesBackup.length ${cheyuthaSubSchemesBackup.length}");
          singlewomenList = cheyuthaSchemeViewModel.getSingleWomenData;
          singlewomenList.insert(
              0, Singlewomen(sWNAME: AppStrings.select_category, sWID: 0));
        });
      });
      final pref = await SharedPreferences.getInstance();
      final stringlist = await pref.getString(SharedPrefConstants.cheyutha);
      if (stringlist != null) {
        final List<dynamic> dynamicList = json.decode(stringlist);
        // cheyutaOnBackList = [];
        cheyutaList = dynamicList
            .map((item) => CheyutaSubmitLocalData.fromJson(item))
            .toList();
        print("fsds ${jsonEncode(cheyutaList)}");

        cheyuthaSchemeViewModel.getCheyutaBackLocalList(cheyutaList);
      }
    });
  }

  static Future<void> saveCheyuthaTableInfoList(
      List<CheyuthaTableInfo> cheyuthaTableInfoList) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonStringList =
        cheyuthaTableInfoList.map((info) => jsonEncode(info.toJson())).toList();
    prefs.setStringList("TableInfo", jsonStringList);
  }

  @override
  Widget build(BuildContext context) {
    final cheyuthaProvider = Provider.of<CheyuthaSchemeViewModel>(context);
/*     final editableCheyuthaFlag =
        ModalRoute.of(context)?.settings.arguments as bool; */
    //print("familyListMdl ${familyListMdl?.name}");
    /* print("editableCheyuthaFlag------ ${editableCheyuthaFlag}");
    print(
        "cheyuthaProvider.selectedOthers---- ${cheyuthaProvider.selectedOthers}"); */
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          /* BackAlert().showAlert(
            context: context,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(SharedPrefConstants.cheyuthaDetailsData);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ); */
          Navigator.pop(context);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBarComponent(
              title: "cheyuthaScheme".tr(),
              onPressedHome: () {
                Navigator.pushNamed(context, AppRoutes.applicantDashboard);
              },
              onPressedBack: () {
                /*  BackAlert().showAlert(
                  context: context,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.remove(SharedPrefConstants.cheyuthaDetailsData);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ); */
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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ReusableComponents().ApplicationRationAndApplicantName(),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownTextFormFieldComponent(
                              hintText: AppStrings.select_name,
                              labelText: AppStrings.select_name_label,
                              items: familyList.map((FamilyListMdl? option) {
                                return DropdownMenuItem<FamilyListMdl>(
                                  value: option,
                                  child: Text(option?.name ?? ''),
                                );
                              }).toList(),
                              onChanged: (FamilyListMdl? newValue) {
                                setAllVisibilityFalse();
                                familyListMdl = newValue;
                                selectedSubScheme = cheyuthaSubSchemes[0];
                                print(
                                    "selectedScheme is ${jsonEncode(selectedSubScheme)}");
                                print(
                                    "object BackupLength${cheyuthaSubSchemesBackup.length}");
                                if (familyListMdl?.gender == "M") {
                                  cheyuthaSubSchemes.removeWhere((element) =>
                                      element.cschemEID == 6 ||
                                      element.cschemEID == 7);
                                } else {
                                  print(
                                      "object${cheyuthaSubSchemesBackup.length}");
                                  print(
                                      "object2222${cheyuthaSubSchemes.length}");
                                  setSubSchemeData();

                                  if (!cheyuthaSubSchemes.any(
                                      (element) => element.cschemEID == 7)) {
                                    // Find the element in cheyuthaSubSchemesBackup with ID 7
                                    var elementWithId7 =
                                        cheyuthaSubSchemesBackup.firstWhere(
                                            (element) =>
                                                element.cschemEID == 7);
                                    cheyuthaSubSchemes.add(elementWithId7);
                                  }
                                }
                                setState(() {});
                              },
                              value: familyListMdl),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          DropdownTextFormFieldComponent(
                              hintText: AppStrings.select_sub_scheme,
                              labelText: AppStrings.cheyutha_sub_scheme,
                              items: cheyuthaSubSchemes.map((Cheyutha? option) {
                                return DropdownMenuItem<Cheyutha>(
                                  value: option,
                                  child: Text(option?.cschemENAME ?? ''),
                                );
                              }).toList(),
                              onChanged: (Cheyutha? newValue) {
                                setState(() {
                                  setAllVisibilityFalse();
                                  selectedSubScheme = newValue;
                                  if (selectedSubScheme?.cschemEID == 1) {
                                    divyangVisibility = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      2) {
                                    saveDataFlag = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      3) {
                                    toddyTappersVisibility = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      4) {
                                    saveDataFlag = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      5) {
                                    beediWorkerVisibility = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      6) {
                                    singleWomenVisibility = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      7) {
                                    widowVisibility = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      8) {
                                    weaversVisibility = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      9) {
                                    saveDataFlag = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      10) {
                                    saveDataFlag = true;
                                  } else if (selectedSubScheme?.cschemEID ==
                                      11) {
                                    beediTekedarVisibility = true;
                                  }
                                });
                              },
                              value: selectedSubScheme),
                        ],
                      ),
                      Visibility(
                        visible: saveDataFlag,
                        child: ReusableNoWidthButton(
                          ButtonText: "Save Data",
                          onPressed: () {
                            print("bdfbvb");
                            if (familyListMdl?.id == null ||
                                familyListMdl?.id == 0) {
                              ValidationIoSAlert().showAlert(context,
                                  description: "Please select family member");
                            } else if (selectedSubScheme?.cschemEID == null ||
                                selectedSubScheme?.cschemEID == 0) {
                              ValidationIoSAlert().showAlert(context,
                                  description: "Please select sub scheme");
                            } else {
                              if (selectedSubScheme?.age != null &&
                                  selectedSubScheme?.age != 0) {
                                DateTime specificDate = DateFormat('dd/MM/yyyy')
                                    .parse(familyListMdl?.datEOFBIRTH ?? '');
                                DateTime now = DateTime.now();
                                int age = now.year - specificDate.year;
                                if (age >= (selectedSubScheme?.age ?? 0)) {
                                  setState(() {
                                    setAllVisibilityFalse();

                                    addedSchemeData.add(CheyuthaTableInfo(
                                        selectedFamilyMember: familyListMdl,
                                        selectedCheyuthaSubScheme:
                                            selectedSubScheme,
                                        schemeInfo: "-"));
                                    clearAllControllers();
                                    familyList.removeWhere(
                                        (item) => item.id == familyListMdl?.id);
                                    familyListMdl = familyList[0];
                                    setSubSchemeData();
                                  });
                                } else {
                                  ValidationIoSAlert().showAlert(context,
                                      description:
                                          "The Applicant is not eligible for this scheme as the age limit is not valid");
                                }
                              } else {
                                setAllVisibilityFalse();

                                setState(() {
                                  CheyutaSubmitLocalData cheyutaData =
                                      CheyutaSubmitLocalData();
                                  if (cheyutaData.familyID != 0 ||
                                      cheyutaData.familyID != null) {
                                    cheyutaData.familyID =
                                        familyListMdl?.id.toString();
                                    cheyutaData.schemeID =
                                        selectedSubScheme?.cschemEID.toString();
                                    cheyutaData.divyangulaSadaramID = "";
                                    cheyutaData.widowDeathCertificateNumber =
                                        "";
                                    cheyutaData.widowDateofDeath = "";
                                    cheyutaData.toddyTapperRegistrationType =
                                        "";
                                    cheyutaData.weaverCooperativeSociety = "";
                                    cheyutaData.beediWorkerEPFEnrollmentNumber =
                                        "";
                                    cheyutaData.beediWorkerEnrollemntDate = "";
                                    cheyutaData.singleWomenCatgory = "";
                                    cheyutaData.singleWomenDocuments = "";
                                    cheyutaData.beediThekadarIndustryName = "";
                                    cheyutaData.beediThekadarLicenseNumber = "";
                                    cheyutaData.beediThekadarLicenceIssuedDate =
                                        "";
                                    cheyutaData.beediThekadarValidUpto = "";
                                    cheyutaData.enableFlag = "Y";
                                    cheyutaList.add(cheyutaData);
                                  }

                                  addedSchemeData.add(CheyuthaTableInfo(
                                      selectedFamilyMember: familyListMdl,
                                      selectedCheyuthaSubScheme:
                                          selectedSubScheme,
                                      schemeInfo: "-"));
                                  clearAllControllers();
                                  familyList.removeWhere(
                                      (item) => item.id == familyListMdl?.id);
                                  familyListMdl = familyList[0];
                                  setSubSchemeData();
                                });
                              }
                            }
                          },
                        ),
                      ),
                      // New Requirement
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Visibility(
                        visible: divyangVisibility,
                        child: Card(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Divyang".tr()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ReusableTextFormField(
                                  maxLength:
                                      applicantDetails?.sadarammaxl ?? 17,
                                  controller: sadaremIDController,
                                  keyboardType: TextInputType.phone,
                                  labelText: "Enter SADAREM ID".tr()),
                            ),
                            ReusableNoWidthButton(
                              ButtonText: "Save Data",
                              onPressed: () {
                                if (familyListMdl?.id == null ||
                                    familyListMdl?.id == 0) {
                                  ValidationIoSAlert().showAlert(context,
                                      description:
                                          "Please select family member");
                                } else if (sadaremIDController
                                        .text.isNotEmpty &&
                                    sadaremIDController.text.length >=
                                        (applicantDetails?.sadarammaxl ?? 17)) {
                                  DiyvangModel diyvangModel = DiyvangModel();

                                  diyvangModel.sadaramId =
                                      sadaremIDController.text.toString();
                                  CheyutaSubmitLocalData cheyutaData =
                                      CheyutaSubmitLocalData();
                                  if (cheyutaData.familyID != 0 ||
                                      cheyutaData.familyID != null) {
                                    cheyutaData.familyID =
                                        familyListMdl?.id.toString();
                                    cheyutaData.schemeID =
                                        selectedSubScheme?.cschemEID.toString();
                                    cheyutaData.divyangulaSadaramID =
                                        sadaremIDController.text.toString();
                                    cheyutaData.widowDeathCertificateNumber =
                                        "";
                                    cheyutaData.widowDateofDeath = "";
                                    cheyutaData.toddyTapperRegistrationType =
                                        "";
                                    cheyutaData.weaverCooperativeSociety = "";
                                    cheyutaData.beediWorkerEPFEnrollmentNumber =
                                        "";
                                    cheyutaData.beediWorkerEnrollemntDate = "";
                                    cheyutaData.singleWomenCatgory = "";
                                    cheyutaData.singleWomenDocuments = "";
                                    cheyutaData.beediThekadarIndustryName = "";
                                    cheyutaData.beediThekadarLicenseNumber = "";
                                    cheyutaData.beediThekadarLicenceIssuedDate =
                                        "";
                                    cheyutaData.beediThekadarValidUpto = "";
                                    cheyutaData.enableFlag = "N";
                                    cheyutaList.add(cheyutaData);
                                  }
                                  print(
                                      "cheyutaListDivang${cheyutaList.length}");

                                  if (selectedSubScheme?.age != null &&
                                      selectedSubScheme?.age != 0) {
                                    DateTime specificDate =
                                        DateFormat('dd/MM/yyyy').parse(
                                            familyListMdl?.datEOFBIRTH ?? '');
                                    DateTime now = DateTime.now();
                                    int age = now.year - specificDate.year;
                                    if (age >= (selectedSubScheme?.age ?? 0)) {
                                      DiyvangModel diyvangModel =
                                          DiyvangModel();
                                      diyvangModel.sadaramId =
                                          sadaremIDController.text.toString();
                                      setState(() {
                                        setAllVisibilityFalse();
                                        addedSchemeData.add(CheyuthaTableInfo(
                                            selectedFamilyMember: familyListMdl,
                                            selectedCheyuthaSubScheme:
                                                selectedSubScheme,
                                            schemeInfo:
                                                "Sadarem Certificate No: ${sadaremIDController.text}"));
                                        clearAllControllers();
                                        familyList.removeWhere((item) =>
                                            item.id == familyListMdl?.id);
                                        familyListMdl = familyList[0];
                                        setSubSchemeData();
                                      });
                                    } else {
                                      ValidationIoSAlert().showAlert(context,
                                          description:
                                              "The Applicant is not eligible for this scheme as the age limit is not valid");
                                    }
                                  } else {
                                    DiyvangModel diyvangModel = DiyvangModel();
                                    diyvangModel.sadaramId =
                                        sadaremIDController.text.toString();
                                    setState(() {
                                      setAllVisibilityFalse();
                                      addedSchemeData.add(CheyuthaTableInfo(
                                          selectedFamilyMember: familyListMdl,
                                          selectedCheyuthaSubScheme:
                                              selectedSubScheme,
                                          schemeInfo:
                                              "Sadarem Certificate No: ${sadaremIDController.text}"));
                                      clearAllControllers();
                                      familyList.removeWhere((item) =>
                                          item.id == familyListMdl?.id);
                                      familyListMdl = familyList[0];
                                      setSubSchemeData();
                                    });
                                  }
                                } else {
                                  if (sadaremIDController.text.isEmpty) {
                                    ValidationIoSAlert().showAlert(context,
                                        description: "Please enter SADAREM ID");
                                  } else {
                                    ValidationIoSAlert().showAlert(context,
                                        description:
                                            "Please enter valid SADAREM ID");
                                  }
                                }
                              },
                            )
                          ]),
                        ),
                      ),
                      Visibility(
                        visible: widowVisibility,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Widow".tr()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableTextFormField(
                                        maxLength: 17,
                                        controller: hubandDeathController,
                                        keyboardType: TextInputType.phone,
                                        labelText:
                                            "Enter Husband 's Death Certificate Number"
                                                .tr()),
                                    datePickerComponent(
                                      hintText: "Date of Death of Husband ",
                                      nameController: deathDateController,
                                      errorMessage: '',
                                      obsecuretext: false,
                                      editable: true,
                                      futureValuesDisable: true,
                                      onTap: () {},

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
                                  ],
                                ),
                              ),
                              ReusableNoWidthButton(
                                ButtonText: "Save Data",
                                onPressed: () {
                                  if (familyListMdl?.id == null ||
                                      familyListMdl?.id == 0) {
                                    ValidationIoSAlert().showAlert(context,
                                        description:
                                            "Please select family member");
                                  } else if (hubandDeathController
                                          .text.isNotEmpty &&
                                      deathDateController.text.isNotEmpty) {
                                    if (selectedSubScheme?.age != null &&
                                        selectedSubScheme?.age != 0) {
                                      DateTime specificDate =
                                          DateFormat('dd/MM/yyyy').parse(
                                              familyListMdl?.datEOFBIRTH ?? '');
                                      DateTime now = DateTime.now();
                                      int age = now.year - specificDate.year;
                                      if (age >=
                                          (selectedSubScheme?.age ?? 0)) {
                                        setState(() {
                                          setAllVisibilityFalse();
                                          CheyutaSubmitLocalData cheyutaData =
                                              CheyutaSubmitLocalData();
                                          if (cheyutaData.familyID != 0 ||
                                              cheyutaData.familyID != null) {
                                            cheyutaData.familyID =
                                                familyListMdl?.id.toString();
                                            cheyutaData.schemeID =
                                                selectedSubScheme?.cschemEID
                                                    .toString();
                                            cheyutaData.divyangulaSadaramID =
                                                "";
                                            cheyutaData
                                                    .widowDeathCertificateNumber =
                                                hubandDeathController.text
                                                    .toString();
                                            cheyutaData.widowDateofDeath =
                                                deathDateController.text
                                                    .toString();

                                            cheyutaData
                                                .toddyTapperRegistrationType = "";
                                            cheyutaData
                                                .weaverCooperativeSociety = "";
                                            cheyutaData
                                                .beediWorkerEPFEnrollmentNumber = "";
                                            cheyutaData
                                                .beediWorkerEnrollemntDate = "";
                                            cheyutaData.singleWomenCatgory = "";
                                            cheyutaData.singleWomenDocuments =
                                                "";
                                            cheyutaData
                                                .beediThekadarIndustryName = "";
                                            cheyutaData
                                                .beediThekadarLicenseNumber = "";
                                            cheyutaData
                                                .beediThekadarLicenceIssuedDate = "";
                                            cheyutaData.beediThekadarValidUpto =
                                                "";
                                            cheyutaData.enableFlag = "N";
                                            cheyutaList.add(cheyutaData);
                                          }

                                          print(
                                              "cheyutaListWidow${cheyutaList.length}");
                                          addedSchemeData.add(CheyuthaTableInfo(
                                              selectedFamilyMember:
                                                  familyListMdl,
                                              selectedCheyuthaSubScheme:
                                                  selectedSubScheme,
                                              schemeInfo:
                                                  "Husband's Death Certificate No: ${hubandDeathController.text} \nDate of Death of Husband: ${deathDateController.text}"));
                                          clearAllControllers();
                                          familyList.removeWhere((item) =>
                                              item.id == familyListMdl?.id);
                                          familyListMdl = familyList[0];
                                          setSubSchemeData();
                                        });
                                      } else {
                                        ValidationIoSAlert().showAlert(context,
                                            description:
                                                "The Applicant is not eligible for this scheme as the age limit is not valid");
                                      }
                                    } else {
                                      setState(() {
                                        setAllVisibilityFalse();
                                        CheyutaSubmitLocalData cheyutaData =
                                            CheyutaSubmitLocalData();
                                        if (cheyutaData.familyID != 0 ||
                                            cheyutaData.familyID != null) {
                                          cheyutaData.familyID =
                                              familyListMdl?.id.toString();
                                          cheyutaData.schemeID =
                                              selectedSubScheme?.cschemEID
                                                  .toString();
                                          cheyutaData.divyangulaSadaramID = "";
                                          cheyutaData
                                                  .widowDeathCertificateNumber =
                                              hubandDeathController.text
                                                  .toString();
                                          cheyutaData.widowDateofDeath =
                                              deathDateController.text
                                                  .toString();

                                          cheyutaData
                                              .toddyTapperRegistrationType = "";
                                          cheyutaData.weaverCooperativeSociety =
                                              "";
                                          cheyutaData
                                              .beediWorkerEPFEnrollmentNumber = "";
                                          cheyutaData
                                              .beediWorkerEnrollemntDate = "";
                                          cheyutaData.singleWomenCatgory = "";
                                          cheyutaData.singleWomenDocuments = "";
                                          cheyutaData
                                              .beediThekadarIndustryName = "";
                                          cheyutaData
                                              .beediThekadarLicenseNumber = "";
                                          cheyutaData
                                              .beediThekadarLicenceIssuedDate = "";
                                          cheyutaData.beediThekadarValidUpto =
                                              "";
                                          cheyutaData.enableFlag = "N";
                                          cheyutaList.add(cheyutaData);
                                        }

                                        addedSchemeData.add(CheyuthaTableInfo(
                                            selectedFamilyMember: familyListMdl,
                                            selectedCheyuthaSubScheme:
                                                selectedSubScheme,
                                            schemeInfo:
                                                "Husband's Death Certificate No: ${hubandDeathController.text} \nDate of Death of Husband: ${deathDateController.text}"));
                                        clearAllControllers();
                                        familyList.removeWhere((item) =>
                                            item.id == familyListMdl?.id);
                                        familyListMdl = familyList[0];
                                        setSubSchemeData();
                                      });
                                    }
                                  } else {
                                    if (hubandDeathController.text.isEmpty) {
                                      ValidationIoSAlert().showAlert(context,
                                          description:
                                              "Please enter husband's death certificate number");
                                    } else if (deathDateController
                                        .text.isEmpty) {
                                      ValidationIoSAlert().showAlert(context,
                                          description:
                                              "Please select date of death of husband");
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: beediWorkerVisibility,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Beedi Worker".tr()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  ReusableTextFormField(
                                      maxLength: 17,
                                      controller: epfEnrollNumController,
                                      keyboardType: TextInputType.phone,
                                      labelText: "Enter EPF Enrollment Number"
                                          .tr()
                                          .tr()),
                                  datePickerComponent(
                                    hintText: "EPF Enrollment Date",
                                    nameController: epfEDateController,
                                    errorMessage: '',
                                    obsecuretext: false,
                                    editable: true,
                                    futureValuesDisable: true,
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
                                  ReusableNoWidthButton(
                                    ButtonText: "Save Data",
                                    onPressed: () {
                                      if (familyListMdl?.id == null ||
                                          familyListMdl?.id == 0) {
                                        ValidationIoSAlert().showAlert(context,
                                            description:
                                                "Please select family member");
                                      } else if (epfEnrollNumController
                                              .text.isNotEmpty &&
                                          epfEDateController.text.isNotEmpty) {
                                        if (selectedSubScheme?.age != null &&
                                            selectedSubScheme?.age != 0) {
                                          DateTime specificDate =
                                              DateFormat('dd/MM/yyyy').parse(
                                                  familyListMdl?.datEOFBIRTH ??
                                                      '');
                                          DateTime now = DateTime.now();
                                          int age =
                                              now.year - specificDate.year;
                                          if (age >=
                                              (selectedSubScheme?.age ?? 0)) {
                                            setState(() {
                                              setAllVisibilityFalse();

                                              CheyutaSubmitLocalData
                                                  cheyutaData =
                                                  CheyutaSubmitLocalData();
                                              if (cheyutaData.familyID != 0 ||
                                                  cheyutaData.familyID !=
                                                      null) {
                                                cheyutaData.familyID =
                                                    familyListMdl?.id
                                                        .toString();
                                                cheyutaData.schemeID =
                                                    selectedSubScheme?.cschemEID
                                                        .toString();
                                                cheyutaData
                                                    .divyangulaSadaramID = "";
                                                cheyutaData
                                                    .widowDeathCertificateNumber = "";
                                                cheyutaData.widowDateofDeath =
                                                    "";
                                                cheyutaData
                                                    .toddyTapperRegistrationType = "";
                                                cheyutaData
                                                    .weaverCooperativeSociety = "";
                                                cheyutaData
                                                        .beediWorkerEPFEnrollmentNumber =
                                                    epfEnrollNumController.text
                                                        .toString();
                                                cheyutaData
                                                        .beediWorkerEnrollemntDate =
                                                    epfEDateController.text
                                                        .toString();
                                                cheyutaData.singleWomenCatgory =
                                                    "";
                                                cheyutaData
                                                    .singleWomenDocuments = "";
                                                cheyutaData
                                                    .beediThekadarIndustryName = "";
                                                cheyutaData
                                                    .beediThekadarLicenseNumber = "";
                                                cheyutaData
                                                    .beediThekadarLicenceIssuedDate = "";
                                                cheyutaData
                                                    .beediThekadarValidUpto = "";
                                                cheyutaData.enableFlag = "N";
                                                cheyutaList.add(cheyutaData);

                                                print(
                                                    "CheyitaListBeedi Workerss${cheyutaList.length}");
                                              }

                                              addedSchemeData.add(
                                                CheyuthaTableInfo(
                                                  selectedFamilyMember:
                                                      familyListMdl,
                                                  selectedCheyuthaSubScheme:
                                                      selectedSubScheme,
                                                  schemeInfo:
                                                      "EPF Enrollment Number: ${epfEnrollNumController.text} \nEPF Enrollment Date: ${epfEDateController.text}",
                                                ),
                                              );
                                              clearAllControllers();
                                              familyList.removeWhere((item) =>
                                                  item.id == familyListMdl?.id);
                                              familyListMdl = familyList[0];
                                              setSubSchemeData();
                                            });
                                          } else {
                                            ValidationIoSAlert().showAlert(
                                                context,
                                                description:
                                                    "The Applicant is not eligible for this scheme as the age limit is not valid");
                                          }
                                        } else {
                                          setState(() {
                                            setAllVisibilityFalse();
                                            CheyutaSubmitLocalData cheyutaData =
                                                CheyutaSubmitLocalData();
                                            if (cheyutaData.familyID != 0 ||
                                                cheyutaData.familyID != null) {
                                              cheyutaData.familyID =
                                                  familyListMdl?.id.toString();
                                              cheyutaData.schemeID =
                                                  selectedSubScheme?.cschemEID
                                                      .toString();
                                              cheyutaData.divyangulaSadaramID =
                                                  "";
                                              cheyutaData
                                                  .widowDeathCertificateNumber = "";
                                              cheyutaData.widowDateofDeath = "";
                                              cheyutaData
                                                  .toddyTapperRegistrationType = "";
                                              cheyutaData
                                                  .weaverCooperativeSociety = "";
                                              cheyutaData
                                                      .beediWorkerEPFEnrollmentNumber =
                                                  epfEnrollNumController.text
                                                      .toString();
                                              cheyutaData
                                                      .beediWorkerEnrollemntDate =
                                                  epfEDateController.text
                                                      .toString();
                                              cheyutaData.singleWomenCatgory =
                                                  "";
                                              cheyutaData.singleWomenDocuments =
                                                  "";
                                              cheyutaData
                                                  .beediThekadarIndustryName = "";
                                              cheyutaData
                                                  .beediThekadarLicenseNumber = "";
                                              cheyutaData
                                                  .beediThekadarLicenceIssuedDate = "";
                                              cheyutaData
                                                  .beediThekadarValidUpto = "";
                                              cheyutaData.enableFlag = "N";
                                              cheyutaList.add(cheyutaData);
                                            }
                                            addedSchemeData.add(
                                              CheyuthaTableInfo(
                                                selectedFamilyMember:
                                                    familyListMdl,
                                                selectedCheyuthaSubScheme:
                                                    selectedSubScheme,
                                                schemeInfo:
                                                    "EPF Enrollment Number: ${epfEnrollNumController.text} \nEPF Enrollment Date: ${epfEDateController.text}",
                                              ),
                                            );
                                            clearAllControllers();
                                            familyList.removeWhere((item) =>
                                                item.id == familyListMdl?.id);
                                            familyListMdl = familyList[0];
                                            setSubSchemeData();
                                          });
                                        }
                                      } else {
                                        if (epfEnrollNumController
                                            .text.isEmpty) {
                                          ValidationIoSAlert().showAlert(
                                              context,
                                              description:
                                                  "Please enter EPF Enrollment Number");
                                        } else if (epfEDateController
                                            .text.isEmpty) {
                                          ValidationIoSAlert().showAlert(
                                              context,
                                              description:
                                                  "Please select EPF Enrollment Date");
                                        }
                                      }
                                    },
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: beediTekedarVisibility,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Beedi Thekadar".tr()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableTextFormField(
                                        maxLength: 17,
                                        controller: industryController,
                                        keyboardType: TextInputType.phone,
                                        labelText: "Industry Name".tr()),
                                    ReusableTextFormField(
                                        maxLength: 17,
                                        controller: licenceNoController,
                                        keyboardType: TextInputType.phone,
                                        labelText: "License Number".tr()),
                                    /* datePickerComponent(
                                      hintText: "License Issue Date",
                                      nameController:
                                          licenseIssueDateController,
                                      errorMessage: '',
                                      obsecuretext: false,
                                      editable: true,
                                       futureValuesDisable: true,
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
                                    ), */
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8.0, right: 8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.065,
                                        child: TextFormField(
                                            readOnly: true,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            controller:
                                                licenseIssueDateController,
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.calendar_month,
                                                color: Colors.black,
                                                size: 40,
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                              ),
                                              labelText: "License Issue Date",
                                            ),
                                            onTap: () async {
                                              await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              ).then((selectedDate) {
                                                if (selectedDate != null) {
                                                  licenseIssueDateController
                                                          .text =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(selectedDate);
                                                  licensevalidDateController
                                                      .clear();
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                    ///////////////////////////////////////////////////////////////
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8.0, right: 8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.065,
                                        child: TextFormField(
                                            readOnly: true,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            controller:
                                                licensevalidDateController,
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.calendar_month,
                                                color: Colors.black,
                                                size: 40,
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                              ),
                                              labelText:
                                                  "License Valid upto Date",
                                            ),
                                            onTap: () async {
                                              await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: licenseIssueDateController
                                                        .text.isNotEmpty
                                                    ? DateTime(
                                                        DateFormat('dd/MM/yyyy')
                                                            .parse(
                                                                licenseIssueDateController
                                                                    .text)
                                                            .year,
                                                        DateFormat('dd/MM/yyyy')
                                                            .parse(
                                                                licenseIssueDateController
                                                                    .text)
                                                            .month,
                                                        DateFormat('dd/MM/yyyy')
                                                            .parse(
                                                                licenseIssueDateController
                                                                    .text)
                                                            .day)
                                                    : DateTime.now(),
                                                lastDate: DateTime(3000),
                                              ).then((selectedDate) {
                                                if (selectedDate != null) {
                                                  licensevalidDateController
                                                          .text =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(selectedDate);
                                                }
                                              });
                                            }),
                                      ),
                                    ),

                                    /////////////////////////////////////////
                                    /*   datePickerComponent(
                                      hintText: "License Valid upto Date",
                                      nameController:
                                          licensevalidDateController,
                                      errorMessage: '',
                                      obsecuretext: false,
                                      editable: true,

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
                                    ), */
                                    ReusableNoWidthButton(
                                      ButtonText: "Save Data",
                                      onPressed: () {
                                        setState(() {
                                          if (familyListMdl?.id == null ||
                                              familyListMdl?.id == 0) {
                                            ValidationIoSAlert().showAlert(
                                                context,
                                                description:
                                                    "Please select family member");
                                          } else if (industryController
                                                  .text.isNotEmpty &&
                                              licenceNoController
                                                  .text.isNotEmpty &&
                                              licenseIssueDateController
                                                  .text.isNotEmpty &&
                                              licensevalidDateController
                                                  .text.isNotEmpty) {
                                            if (selectedSubScheme?.age !=
                                                    null &&
                                                selectedSubScheme?.age != 0) {
                                              DateTime specificDate =
                                                  DateFormat('dd/MM/yyyy')
                                                      .parse(familyListMdl
                                                              ?.datEOFBIRTH ??
                                                          '');
                                              DateTime now = DateTime.now();
                                              int age =
                                                  now.year - specificDate.year;
                                              if (age >=
                                                  (selectedSubScheme?.age ??
                                                      0)) {
                                                setState(() {
                                                  setAllVisibilityFalse();

                                                  CheyutaSubmitLocalData
                                                      cheyutaData =
                                                      CheyutaSubmitLocalData();
                                                  cheyutaData.familyID =
                                                      familyListMdl?.id
                                                          .toString();

                                                  cheyutaData.schemeID =
                                                      selectedSubScheme
                                                          ?.cschemEID
                                                          .toString();

                                                  cheyutaData
                                                      .divyangulaSadaramID = "";
                                                  cheyutaData
                                                      .widowDeathCertificateNumber = "";
                                                  cheyutaData.widowDateofDeath =
                                                      "";

                                                  cheyutaData
                                                      .toddyTapperRegistrationType = "";
                                                  cheyutaData
                                                      .weaverCooperativeSociety = "";
                                                  cheyutaData
                                                      .beediWorkerEPFEnrollmentNumber = "";
                                                  cheyutaData
                                                      .beediWorkerEnrollemntDate = "";
                                                  cheyutaData
                                                      .singleWomenCatgory = "";
                                                  cheyutaData
                                                      .singleWomenDocuments = "";
                                                  cheyutaData
                                                          .beediThekadarIndustryName =
                                                      industryController.text
                                                          .toString();
                                                  cheyutaData
                                                          .beediThekadarLicenseNumber =
                                                      licenceNoController.text
                                                          .toString();
                                                  cheyutaData
                                                          .beediThekadarLicenceIssuedDate =
                                                      licenseIssueDateController
                                                          .text
                                                          .toString();
                                                  cheyutaData
                                                          .beediThekadarValidUpto =
                                                      licensevalidDateController
                                                          .text
                                                          .toString();
                                                  cheyutaData.enableFlag = "Y";
                                                  cheyutaList.add(cheyutaData);
                                                  addedSchemeData.add(
                                                    CheyuthaTableInfo(
                                                      selectedFamilyMember:
                                                          familyListMdl,
                                                      selectedCheyuthaSubScheme:
                                                          selectedSubScheme,
                                                      schemeInfo:
                                                          "Industry name: ${industryController.text} \nLicense Number: ${licenceNoController.text} \nLicense Issue Date: ${licenseIssueDateController.text} \nLicense Valid upto Date: ${licensevalidDateController.text}",
                                                    ),
                                                  );
                                                  clearAllControllers();
                                                  familyList.removeWhere(
                                                      (item) =>
                                                          item.id ==
                                                          familyListMdl?.id);
                                                  familyListMdl = familyList[0];
                                                  setSubSchemeData();
                                                });
                                              } else {
                                                ValidationIoSAlert().showAlert(
                                                    context,
                                                    description:
                                                        "The Applicant is not eligible for this scheme as the age limit is not valid");
                                              }
                                            } else {
                                              setState(() {
                                                setAllVisibilityFalse();
                                                CheyutaSubmitLocalData
                                                    cheyutaData =
                                                    CheyutaSubmitLocalData();
                                                cheyutaData.familyID =
                                                    familyListMdl?.id
                                                        .toString();

                                                cheyutaData.schemeID =
                                                    selectedSubScheme?.cschemEID
                                                        .toString();

                                                cheyutaData
                                                    .divyangulaSadaramID = "";
                                                cheyutaData
                                                    .widowDeathCertificateNumber = "";
                                                cheyutaData.widowDateofDeath =
                                                    "";

                                                cheyutaData
                                                    .toddyTapperRegistrationType = "";
                                                cheyutaData
                                                    .weaverCooperativeSociety = "";
                                                cheyutaData
                                                    .beediWorkerEPFEnrollmentNumber = "";
                                                cheyutaData
                                                    .beediWorkerEnrollemntDate = "";
                                                cheyutaData.singleWomenCatgory =
                                                    "";
                                                cheyutaData
                                                    .singleWomenDocuments = "";
                                                cheyutaData
                                                        .beediThekadarIndustryName =
                                                    industryController.text
                                                        .toString();
                                                cheyutaData
                                                        .beediThekadarLicenseNumber =
                                                    licenceNoController.text
                                                        .toString();
                                                cheyutaData
                                                        .beediThekadarLicenceIssuedDate =
                                                    licenseIssueDateController
                                                        .text
                                                        .toString();
                                                cheyutaData
                                                        .beediThekadarValidUpto =
                                                    licensevalidDateController
                                                        .text
                                                        .toString();
                                                cheyutaData.enableFlag = "Y";
                                                cheyutaList.add(cheyutaData);

                                                addedSchemeData.add(
                                                  CheyuthaTableInfo(
                                                    selectedFamilyMember:
                                                        familyListMdl,
                                                    selectedCheyuthaSubScheme:
                                                        selectedSubScheme,
                                                    schemeInfo:
                                                        "Industry name: ${industryController.text} \nLicense Number: ${licenceNoController.text} \nLicense Issue Date: ${licenseIssueDateController.text} \nLicense Valid upto Date: ${licensevalidDateController.text}",
                                                  ),
                                                );
                                                clearAllControllers();
                                                familyList.removeWhere((item) =>
                                                    item.id ==
                                                    familyListMdl?.id);
                                                familyListMdl = familyList[0];
                                                setSubSchemeData();
                                              });
                                            }
                                          } else {
                                            if (industryController
                                                .text.isEmpty) {
                                              ValidationIoSAlert().showAlert(
                                                  context,
                                                  description:
                                                      "Please enter industry name");
                                            } else if (licenceNoController
                                                .text.isEmpty) {
                                              ValidationIoSAlert().showAlert(
                                                  context,
                                                  description:
                                                      "Please enter license number");
                                            } else if (licenseIssueDateController
                                                .text.isEmpty) {
                                              ValidationIoSAlert().showAlert(
                                                  context,
                                                  description:
                                                      "Please select license issue date");
                                            } else if (licensevalidDateController
                                                .text.isEmpty) {
                                              ValidationIoSAlert().showAlert(
                                                  context,
                                                  description:
                                                      "Please select license valid upto date");
                                            } else {
                                              CheyutaSubmitLocalData
                                                  cheyutaData =
                                                  CheyutaSubmitLocalData();
                                              cheyutaData.familyID =
                                                  familyListMdl?.id.toString();

                                              cheyutaData.schemeID =
                                                  selectedSubScheme?.cschemEID
                                                      .toString();

                                              cheyutaData.divyangulaSadaramID =
                                                  "";
                                              cheyutaData
                                                  .widowDeathCertificateNumber = "";
                                              cheyutaData.widowDateofDeath = "";

                                              cheyutaData
                                                  .toddyTapperRegistrationType = "";
                                              cheyutaData
                                                  .weaverCooperativeSociety = "";
                                              cheyutaData
                                                  .beediWorkerEPFEnrollmentNumber = "";
                                              cheyutaData
                                                  .beediWorkerEnrollemntDate = "";
                                              cheyutaData.singleWomenCatgory =
                                                  "";
                                              cheyutaData.singleWomenDocuments =
                                                  "";
                                              cheyutaData
                                                      .beediThekadarIndustryName =
                                                  industryController.text
                                                      .toString();
                                              cheyutaData
                                                      .beediThekadarLicenseNumber =
                                                  licenceNoController.text
                                                      .toString();
                                              cheyutaData
                                                      .beediThekadarLicenceIssuedDate =
                                                  licenseIssueDateController
                                                      .text
                                                      .toString();
                                              cheyutaData
                                                      .beediThekadarValidUpto =
                                                  licensevalidDateController
                                                      .text
                                                      .toString();
                                              cheyutaData.enableFlag = "Y";
                                              cheyutaList.add(cheyutaData);
                                            }
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: toddyTappersVisibility,
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Toddy Tappers".tr()),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: DropdownTextFormFieldComponent(
                                      hintText:
                                          AppStrings.select_toddy_tapper_type,
                                      labelText:
                                          AppStrings.select_ToddyTapper_label,
                                      items: toddytappersList
                                          .map((Toddytapper? option) {
                                        return DropdownMenuItem<Toddytapper>(
                                          value: option,
                                          child: Text(option?.tTNAME ?? ''),
                                        );
                                      }).toList(),
                                      onChanged: (Toddytapper? newValue) {
                                        setState(() {
                                          selectedToddyTapperType = newValue;
                                        });
                                      },
                                      value: selectedToddyTapperType),
                                ),
                                ReusableNoWidthButton(
                                  ButtonText: "Save Data",
                                  onPressed: () {
                                    setState(() {
                                      if (familyListMdl?.id == null ||
                                          familyListMdl?.id == 0) {
                                        ValidationIoSAlert().showAlert(context,
                                            description:
                                                "Please select family member");
                                      } else if (selectedToddyTapperType
                                                  ?.tTID !=
                                              0 &&
                                          selectedToddyTapperType?.tTID !=
                                              null) {
                                        CheyutaSubmitLocalData cheyutaData =
                                            CheyutaSubmitLocalData();
                                        if (cheyutaData.familyID != 0 ||
                                            cheyutaData.familyID != null) {
                                          cheyutaData.familyID =
                                              familyListMdl?.id.toString();
                                          cheyutaData.schemeID =
                                              selectedSubScheme?.cschemEID
                                                  .toString();
                                          cheyutaData.divyangulaSadaramID = "";
                                          cheyutaData
                                              .widowDeathCertificateNumber = "";
                                          cheyutaData.widowDateofDeath = "";
                                          cheyutaData
                                                  .toddyTapperRegistrationType =
                                              selectedToddyTapperType?.tTID
                                                  .toString();
                                          cheyutaData.weaverCooperativeSociety =
                                              "";
                                          cheyutaData
                                              .beediWorkerEPFEnrollmentNumber = "";
                                          cheyutaData
                                              .beediWorkerEnrollemntDate = "";
                                          cheyutaData.singleWomenCatgory = "";
                                          cheyutaData.singleWomenDocuments = "";
                                          cheyutaData
                                              .beediThekadarIndustryName = "";
                                          cheyutaData
                                              .beediThekadarLicenseNumber = "";
                                          cheyutaData
                                              .beediThekadarLicenceIssuedDate = "";
                                          cheyutaData.beediThekadarValidUpto =
                                              "";
                                          cheyutaData.enableFlag = "Y";
                                          cheyutaList.add(cheyutaData);
                                        }

                                        setState(() {
                                          addedSchemeData.add(
                                            CheyuthaTableInfo(
                                              selectedFamilyMember:
                                                  familyListMdl,
                                              selectedCheyuthaSubScheme:
                                                  selectedSubScheme,
                                              schemeInfo:
                                                  "Toddy Tapper Type: ${selectedToddyTapperType?.tTNAME}",
                                            ),
                                          );
                                          clearAllControllers();
                                          familyList.removeWhere((item) =>
                                              item.id == familyListMdl?.id);
                                          familyListMdl = familyList[0];
                                          selectedToddyTapperType =
                                              toddytappersList[0];
                                          setAllVisibilityFalse();
                                          setSubSchemeData();
                                        });
                                      } else {
                                        ValidationIoSAlert().showAlert(context,
                                            description:
                                                "Please select toddy tapper type");
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                          visible: weaversVisibility,
                          child: Card(
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Weavers".tr()),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: RowRadioComponent(
                                  title:
                                      "IS APPLICANT MEMBER OF WEAVER COOPERATIVE "
                                          .tr(),
                                  row: Row(
                                    children: [
                                      Radio(
                                        value: 'Y',
                                        groupValue: cheyuthaProvider
                                            .selectedApplicantCooperativeSociety,
                                        onChanged: (value) {
                                          cheyuthaProvider
                                              .changeStatusOfApplicantCooperativeSociety(
                                                  value.toString());
                                        },
                                      ),
                                      Text("Yes".tr()),
                                      Radio(
                                        value: 'N',
                                        groupValue: cheyuthaProvider
                                            .selectedApplicantCooperativeSociety,
                                        onChanged: (value) {
                                          cheyuthaProvider
                                              .changeStatusOfApplicantCooperativeSociety(
                                                  value.toString());
                                        },
                                      ),
                                      Text("No".tr()),
                                    ],
                                  ),
                                ),
                              ),
                              ReusableNoWidthButton(
                                ButtonText: "Save Data",
                                onPressed: () {
                                  if (familyListMdl?.id == null ||
                                      familyListMdl?.id == 0) {
                                    ValidationIoSAlert().showAlert(context,
                                        description:
                                            "Please select family member");
                                  } else if (cheyuthaProvider
                                              .selectedApplicantCooperativeSociety !=
                                          null &&
                                      cheyuthaProvider
                                              .selectedApplicantCooperativeSociety !=
                                          '') {
                                    CheyutaSubmitLocalData cheyutaData =
                                        CheyutaSubmitLocalData();
                                    if (cheyutaData.familyID != 0 ||
                                        cheyutaData.familyID != null) {
                                      cheyutaData.familyID =
                                          familyListMdl?.id.toString();

                                      cheyutaData.schemeID = selectedSubScheme
                                          ?.cschemEID
                                          .toString();
                                      cheyutaData.divyangulaSadaramID = "";
                                      cheyutaData.widowDeathCertificateNumber =
                                          "";
                                      cheyutaData.widowDateofDeath = "";
                                      cheyutaData.toddyTapperRegistrationType =
                                          "";
                                      cheyutaData.weaverCooperativeSociety =
                                          cheyuthaProvider
                                              .selectedApplicantCooperativeSociety;
                                      cheyutaData
                                          .beediWorkerEPFEnrollmentNumber = "";
                                      cheyutaData.beediWorkerEnrollemntDate =
                                          "";
                                      cheyutaData.singleWomenCatgory = "";
                                      cheyutaData.singleWomenDocuments = "";
                                      cheyutaData.beediThekadarIndustryName =
                                          "";
                                      cheyutaData.beediThekadarLicenseNumber =
                                          "";
                                      cheyutaData
                                          .beediThekadarLicenceIssuedDate = "";
                                      cheyutaData.beediThekadarValidUpto = "";
                                      cheyutaData.enableFlag = "Y";
                                      cheyutaList.add(cheyutaData);
                                    }
                                    if (selectedSubScheme?.age != null &&
                                        selectedSubScheme?.age != 0) {
                                      DateTime specificDate =
                                          DateFormat('dd/MM/yyyy').parse(
                                              familyListMdl?.datEOFBIRTH ?? '');
                                      DateTime now = DateTime.now();
                                      int age = now.year - specificDate.year;
                                      if (age >=
                                          (selectedSubScheme?.age ?? 0)) {
                                        setState(() {
                                          addedSchemeData.add(
                                            CheyuthaTableInfo(
                                              selectedFamilyMember:
                                                  familyListMdl,
                                              selectedCheyuthaSubScheme:
                                                  selectedSubScheme,
                                              schemeInfo:
                                                  "Is Applicant Member of Weaver Cooperative: ${cheyuthaProvider.selectedApplicantCooperativeSociety}",
                                            ),
                                          );
                                          familyList.removeWhere((item) =>
                                              item.id == familyListMdl?.id);
                                          familyListMdl = familyList[0];
                                          setSubSchemeData();
                                        });
                                      } else {
                                        ValidationIoSAlert().showAlert(context,
                                            description:
                                                "The Applicant is not eligible for this scheme as the age limit is not valid");
                                      }
                                    } else {
                                      setState(() {
                                        addedSchemeData.add(
                                          CheyuthaTableInfo(
                                            selectedFamilyMember: familyListMdl,
                                            selectedCheyuthaSubScheme:
                                                selectedSubScheme,
                                            schemeInfo:
                                                "Is Applicant Member of Weaver Cooperative: ${cheyuthaProvider.selectedApplicantCooperativeSociety}",
                                          ),
                                        );
                                        familyList.removeWhere((item) =>
                                            item.id == familyListMdl?.id);
                                        familyListMdl = familyList[0];

                                        setSubSchemeData();
                                      });
                                    }
                                  } else {
                                    ValidationIoSAlert().showAlert(context,
                                        description:
                                            "Please select an option if applicant member of weaver cooperative");
                                  }
                                },
                              ),
                            ]),
                          )),
                      Visibility(
                        visible: singleWomenVisibility,
                        child: Card(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Single Women".tr()),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  DropdownTextFormFieldComponent(
                                      hintText: AppStrings.select_category,
                                      labelText: AppStrings.select_category,
                                      items: singlewomenList
                                          .map((Singlewomen? option) {
                                        return DropdownMenuItem<Singlewomen>(
                                          value: option,
                                          child: Text(option?.sWNAME ?? ''),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        WomenRegID = newValue?.sWID.toString();
                                        setState(() {});
                                        cheyuthaProvider
                                            .changeSingleWomenCategory(
                                                newValue);
                                      },
                                      value: cheyuthaProvider
                                          .selectedSingleWomenCategory),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  RowRadioComponent(
                                    title:
                                        "LEAGAL DOCUMENTS AVAILABLE IN CASE OF MARRIED"
                                            .tr(),
                                    row: Row(
                                      children: [
                                        Radio(
                                          value: 'Y',
                                          groupValue: cheyuthaProvider
                                              .selectedLegalDocumentSingleWomen,
                                          onChanged: (value) {
                                            cheyuthaProvider
                                                .changeLeagalDocumentSingleWomen(
                                                    value.toString());
                                          },
                                        ),
                                        Text("Yes".tr()),
                                        Radio(
                                          value: 'N',
                                          groupValue: cheyuthaProvider
                                              .selectedLegalDocumentSingleWomen,
                                          onChanged: (value) {
                                            cheyuthaProvider
                                                .changeLeagalDocumentSingleWomen(
                                                    value.toString());
                                          },
                                        ),
                                        Text("No".tr()),
                                      ],
                                    ),
                                  ),
                                  ReusableNoWidthButton(
                                    ButtonText: "Save Data",
                                    onPressed: () {
                                      if (familyListMdl?.id == null ||
                                          familyListMdl?.id == 0) {
                                        ValidationIoSAlert().showAlert(context,
                                            description:
                                                "Please select family member");
                                      } else if (cheyuthaProvider
                                                  .selectedSingleWomenCategory
                                                  ?.sWID !=
                                              null &&
                                          cheyuthaProvider
                                                  .selectedSingleWomenCategory
                                                  ?.sWID !=
                                              0 &&
                                          cheyuthaProvider
                                                  .selectedLegalDocumentSingleWomen !=
                                              null &&
                                          cheyuthaProvider
                                                  .selectedLegalDocumentSingleWomen !=
                                              '') {
                                        if (cheyuthaProvider
                                                    .selectedSingleWomenCategory
                                                    ?.age !=
                                                null &&
                                            cheyuthaProvider
                                                    .selectedSingleWomenCategory
                                                    ?.age !=
                                                0) {
                                          DateTime specificDate =
                                              DateFormat('dd/MM/yyyy').parse(
                                                  familyListMdl?.datEOFBIRTH ??
                                                      '');
                                          DateTime now = DateTime.now();
                                          int age =
                                              now.year - specificDate.year;
                                          if (age >=
                                              (cheyuthaProvider
                                                      .selectedSingleWomenCategory
                                                      ?.age ??
                                                  0)) {
                                            CheyutaSubmitLocalData cheyutaData =
                                                CheyutaSubmitLocalData();
                                            if (cheyutaData.familyID != 0 ||
                                                cheyutaData.familyID != null) {
                                              cheyutaData.familyID =
                                                  familyListMdl?.id.toString();
                                              cheyutaData.schemeID =
                                                  selectedSubScheme?.cschemEID
                                                      .toString();
                                              cheyutaData.divyangulaSadaramID =
                                                  "";
                                              cheyutaData
                                                  .widowDeathCertificateNumber = "";
                                              cheyutaData.widowDateofDeath = "";
                                              cheyutaData
                                                  .toddyTapperRegistrationType = "";
                                              cheyutaData
                                                  .weaverCooperativeSociety = "";
                                              cheyutaData
                                                  .beediWorkerEPFEnrollmentNumber = "";
                                              cheyutaData
                                                  .beediWorkerEnrollemntDate = "";
                                              cheyutaData.singleWomenCatgory =
                                                  cheyuthaProvider
                                                      .selectedSingleWomenCategory
                                                      ?.sWID
                                                      .toString();
                                              cheyutaData.singleWomenDocuments =
                                                  cheyuthaProvider
                                                      .selectedLegalDocumentSingleWomen;
                                              cheyutaData
                                                  .beediThekadarIndustryName = "";
                                              cheyutaData
                                                  .beediThekadarLicenseNumber = "";
                                              cheyutaData
                                                  .beediThekadarLicenceIssuedDate = "";
                                              cheyutaData
                                                  .beediThekadarValidUpto = "";
                                              cheyutaData.enableFlag = "Y";
                                              cheyutaList.add(cheyutaData);
                                            }
                                            setState(() {
                                              addedSchemeData.add(
                                                CheyuthaTableInfo(
                                                  selectedFamilyMember:
                                                      familyListMdl,
                                                  selectedCheyuthaSubScheme:
                                                      selectedSubScheme,
                                                  schemeInfo:
                                                      "Category: ${cheyuthaProvider.selectedSingleWomenCategory?.sWNAME} \nLegal Documents: ${cheyuthaProvider.selectedLegalDocumentSingleWomen}",
                                                ),
                                              );
                                              clearAllControllers();
                                              familyList.removeWhere((item) =>
                                                  item.id == familyListMdl?.id);
                                              familyListMdl = familyList[0];
                                              setSubSchemeData();
                                            });
                                          } else {
                                            ValidationIoSAlert().showAlert(
                                                context,
                                                description:
                                                    "The Applicant is not eligible for this scheme as the age limit is not valid");
                                          }
                                        } else {
                                          setState(() {
                                            addedSchemeData.add(
                                              CheyuthaTableInfo(
                                                selectedFamilyMember:
                                                    familyListMdl,
                                                selectedCheyuthaSubScheme:
                                                    selectedSubScheme,
                                                schemeInfo:
                                                    "Category: ${cheyuthaProvider.selectedSingleWomenCategory?.sWNAME} \nLegal Documents: ${cheyuthaProvider.selectedLegalDocumentSingleWomen}",
                                              ),
                                            );
                                            clearAllControllers();
                                            familyList.removeWhere((item) =>
                                                item.id == familyListMdl?.id);
                                            familyListMdl = familyList[0];
                                            setSubSchemeData();
                                          });
                                        }
                                      } else {
                                        if (familyListMdl?.id == null ||
                                            familyListMdl?.id == 0) {
                                          ValidationIoSAlert().showAlert(
                                              context,
                                              description:
                                                  "Please select family member");
                                        } else if (cheyuthaProvider
                                                    .selectedSingleWomenCategory
                                                    ?.sWID ==
                                                null ||
                                            cheyuthaProvider
                                                    .selectedSingleWomenCategory
                                                    ?.sWID ==
                                                0) {
                                          ValidationIoSAlert().showAlert(
                                              context,
                                              description:
                                                  "Please select category");
                                        } else {
                                          ValidationIoSAlert().showAlert(
                                              context,
                                              description:
                                                  "Please select legal documents");
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Visibility(
                        visible: addedSchemeData.length > 0,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1.75,
                                child: TableCheyuthaColumnReusableNew(
                                  serialNumber: "S.No",
                                  entredField1: "Name",
                                  entredField2: "Aadhaar",
                                  entredField3: "Scheme",
                                  entredField4: "Scheme Info",
                                  /* ExtendFlag: false,
                                  iconFlag: false, */
                                  removeicons: Text(
                                    "Delete",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  cardcolor: Colors.grey[200],
                                  height: MediaQuery.of(context).size.height *
                                      0.074,
                                  ontap: () {},
                                  borderradius: BorderRadius.circular(0),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1.75,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: addedSchemeData.length,
                                  itemBuilder: (context, index) {
                                    print(
                                        " addedSchemeData[index] ${addedSchemeData[index].selectedFamilyMember?.name}");
                                    return TableCheyuthaColumnReusableNew(
                                      serialNumber: (index + 1).toString(),
                                      entredField1: addedSchemeData[index]
                                              .selectedFamilyMember
                                              ?.name ??
                                          "",
                                      entredField2: addedSchemeData[index]
                                              .selectedFamilyMember
                                              ?.aadhaRNO ??
                                          "",
                                      entredField3: addedSchemeData[index]
                                              .selectedCheyuthaSubScheme
                                              ?.cschemENAME ??
                                          "",
                                      entredField4:
                                          addedSchemeData[index].schemeInfo,
                                      // iconFlag: true,
                                      removeicons: Icon(Icons.delete),
                                      cardcolor: Colors.white,
                                      ontap: () {
                                        return showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return AlertDialog(
                                              title: Text(
                                                "Do you want to delete the data?",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Wrap(
                                                        children: [
                                                          Text(
                                                            "Applicant Name: ${addedSchemeData[index].selectedFamilyMember?.name}",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Scheme: ${addedSchemeData[index].selectedCheyuthaSubScheme?.cschemENAME}",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  addedSchemeData[index]
                                                              .schemeInfo !=
                                                          "-"
                                                      ? SizedBox(
                                                          height: 10,
                                                        )
                                                      : SizedBox(),
                                                  addedSchemeData[index]
                                                              .schemeInfo !=
                                                          "-"
                                                      ? Wrap(
                                                          children: [
                                                            Text(
                                                              "Scheme Info: \n${addedSchemeData[index].schemeInfo}",
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              maxLines: null,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          AppColors.appColor,
                                                        ),
                                                      ),
                                                      child: Text("Cancel",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          )),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            dialogContext);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          AppColors.appColor,
                                                        ),
                                                      ),
                                                      child: Text("Delete",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          )),
                                                      onPressed: () async {
                                                        if (cheyutaList
                                                            .isEmpty) {
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          await prefs.remove(
                                                              SharedPrefConstants
                                                                  .cheyutha);
                                                        } else {
                                                          cheyutaList.removeWhere(
                                                              (item) =>
                                                                  item.familyID ==
                                                                  addedSchemeData[
                                                                          index]
                                                                      .selectedFamilyMember
                                                                      ?.id);
                                                          setState(() {
                                                            setAllVisibilityFalse();
                                                            final famMemToAdd =
                                                                familyListBackup.firstWhere((element) =>
                                                                    element
                                                                        .name ==
                                                                    addedSchemeData[
                                                                            index]
                                                                        .selectedFamilyMember
                                                                        ?.name);
                                                            cheyutaList
                                                                .remove(index);

                                                            familyList.add(
                                                                famMemToAdd);

                                                            /* addedSchemeData
                                                              .removeAt(index); */

                                                            // print(
                                                            //     "cheyutaOnBackListdfghj${jsonEncode(cheyutaOnBackList)}}");
                                                            if (cheyuthaProvider
                                                                    .cheyuthaLocalBackList
                                                                    .length >
                                                                0) {
                                                              cheyuthaProvider
                                                                  .cheyuthaLocalBackList
                                                                  .removeWhere((item) =>
                                                                      int.tryParse(
                                                                          item.familyID ??
                                                                              "") ==
                                                                      addedSchemeData[
                                                                              index]
                                                                          .selectedFamilyMember
                                                                          ?.id);
                                                              addedSchemeData
                                                                  .removeAt(
                                                                      index);
                                                              // cheyutaOnBackList.removeWhere((item) =>
                                                              //     item.familyID ==
                                                              //     addedSchemeData[
                                                              //             index]
                                                              //         .selectedFamilyMember
                                                              //         ?.id);
                                                              setSubSchemeData();
                                                            } else {
                                                              if (addedSchemeData
                                                                      .length >
                                                                  0) {
                                                                addedSchemeData
                                                                    .removeAt(
                                                                        index);
                                                              }
                                                            }

                                                            /*  print(
                                                              "addedSchemeData list ---- ${addedSchemeData.length}");
                                                          print(
                                                              "cheyutaTableList list ---- ${cheyutaTableList.length}"); */
                                                          });
                                                          if (cheyutaList
                                                              .isEmpty) {
                                                            SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            await prefs.setBool(
                                                                SharedPrefConstants
                                                                    .isCheyuthaDetailsSaved,
                                                                false);
                                                          }
                                                          /* print(
                                                            "cheutha list ---- ${jsonEncode(cheyutaList)}"); */

                                                          if (addedSchemeData
                                                                  .length ==
                                                              0) {
                                                            print(
                                                                "0495u34898564564564567356756756----------");
                                                            cheyuthaProvider
                                                                .SetisCheyuthaDetailsFlag(
                                                                    false);
                                                          }

                                                          // await saveCheyuthaTableInfoList(
                                                          //     addedSchemeData);
                                                          setState(() {});
                                                          Navigator.pop(
                                                              dialogContext);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      borderradius: BorderRadius.circular(0),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ReusableButton(
                        onPressed: () async {
                          if (addedSchemeData.length > 0) {
                            cheyuthaProvider.setIsLoadingStatus(true);

                            CheyutaSubmitLocalModel cheyutaSubmitLocalModel =
                                CheyutaSubmitLocalModel();
                            if (cheyuthaProvider.cheyuthaLocalBackList.length >
                                0) {
                              cheyutaSubmitLocalModel.data =
                                  cheyuthaProvider.cheyuthaLocalBackList;
                            } else {
                              cheyutaSubmitLocalModel.data = cheyutaList;
                            }
                            print("finalonline${jsonEncode(cheyutaList)}");

                            await saveCheyuthaTableInfoList(addedSchemeData);
                            print(
                                "finalLocal${jsonEncode(cheyuthaProvider.cheyuthaLocalBackList)}");
                            //dvbvdhbvdhbvdhbvdhbvdhbvd

                            await cheyuthaProvider.onSaveClick(
                                cheyutaSubmitLocalModel:
                                    cheyutaSubmitLocalModel,
                                context: context,
                                cheyutaList: cheyutaSubmitLocalModel.data
                                // selectedDivyang: cheyuthaMdl?.disabled ?? "",
                                // sadaramCertificateNo:
                                //     cheyuthaMdl?.sadaramListMdl ?? [],
                                // selectedOthers: cheyuthaMdl?.others ?? "",
                                // selectedOldage: cheyuthaMdl?.vrudhapya ?? "",
                                // selectedWidow: cheyuthaMdl?.vitantu ?? "",
                                // selectedToddyTappers: cheyuthaMdl?.geetha ?? "",
                                // selectedWeavers: cheyuthaMdl?.chenetha ?? "",
                                // selectedDialysisPatients:
                                //     cheyuthaMdl?.dailisis ?? "",
                                // selectedHivAidsPatients:
                                //     cheyuthaMdl?.aids ?? "",
                                // selectedBeediWorkers: cheyuthaMdl?.beedi ?? "",
                                // selectedFilariaPatients:
                                //     cheyuthaMdl?.paileria ?? "",
                                // selectedSingleWomen:
                                //     cheyuthaMdl?.singlEWOMEN ?? "",
                                // selectedBeediTekedar:
                                //     cheyuthaMdl?.beedITEKEDARU ?? "",
                                // addedList: addedSchemeData)
                                );
                            cheyuthaProvider.setIsLoadingStatus(false);

                            //====================================

                            SuccessCustomCupertinoAlert().showAlert(
                                context: context,
                                title: "Data Saved Successfully".tr(),
                                onPressed: () {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          AppRoutes.applicantDashboard));
                                  // Navigator.pushNamed(
                                  //     context, AppRoutes.applicantDashboard);
                                });
                          } else {
                            //Added prompt to ask if user wants to proceed without scheme data because if the user deletes the list the save button should be visible
                            AlertwithTwoButtons().showAlert(
                                context: context,
                                message:
                                    "Currently, no scheme data is selected or present. Would you like to proceed without scheme data?",
                                onYesPressed: () async {
                                  cheyuthaProvider.setIsLoadingStatus(true);

                                  CheyutaSubmitLocalModel
                                      cheyutaSubmitLocalModel =
                                      CheyutaSubmitLocalModel();
                                  if (cheyuthaProvider
                                          .cheyuthaLocalBackList.length >
                                      0) {
                                    cheyutaSubmitLocalModel.data =
                                        cheyuthaProvider.cheyuthaLocalBackList;
                                  } else {
                                    cheyutaSubmitLocalModel.data = cheyutaList;
                                  }
                                  print(
                                      "finalonline${jsonEncode(cheyutaList)}");

                                  await saveCheyuthaTableInfoList(
                                      addedSchemeData);
                                  print(
                                      "finalLocal${jsonEncode(cheyuthaProvider.cheyuthaLocalBackList)}");

                                  await cheyuthaProvider.onSaveClick(
                                      cheyutaSubmitLocalModel:
                                          cheyutaSubmitLocalModel,
                                      context: context,
                                      cheyutaList:
                                          cheyutaSubmitLocalModel.data);
                                  cheyuthaProvider.setIsLoadingStatus(false);

                                  SuccessCustomCupertinoAlert().showAlert(
                                      context: context,
                                      title: "Data Saved Successfully".tr(),
                                      onPressed: () {
                                        Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(
                                                AppRoutes.applicantDashboard));
                                      });
                                },
                                onNoPressed: () {
                                  Navigator.pop(context);
                                });
                          }
                        },
                        ButtonText: 'SAVE',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (cheyuthaProvider.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }

  void setAllVisibilityFalse() {
    divyangVisibility = false;
    widowVisibility = false;
    beediWorkerVisibility = false;
    toddyTappersVisibility = false;
    weaversVisibility = false;
    dialysisVisibility = false;
    filariaVisibility = false;
    singleWomenVisibility = false;
    beediTekedarVisibility = false;
    oldageVisibility = false;
    hivAidsVisibility = false;
    saveDataFlag = false;
  }

  void clearAllControllers() {
    sadaremIDController.clear();
    hubandDeathController.clear();
    deathDateController.clear();
    epfEnrollNumController.clear();
    epfEDateController.clear();
    industryController.clear();
    licenceNoController.clear();
    licenseIssueDateController.clear();
    licensevalidDateController.clear();
  }

  setSubSchemeData() {
    List<int> allowedSchemeIds = [1, 5, 7];
    if (addedSchemeData.every((value) => allowedSchemeIds
        .contains(value.selectedCheyuthaSubScheme?.cschemEID))) {
      // If addedSchemeData only contains elements with IDs 1, 5, and 7, use the complete cheyuthaSubSchemesList
      print("object${cheyuthaSubSchemesBackup.length}");
      print("object schemeList${cheyuthaSubSchemes[0].cschemENAME}");
      cheyuthaSubSchemes.clear();
      cheyuthaSubSchemes.addAll(cheyuthaSubSchemesBackup);
      selectedSubScheme = cheyuthaSubSchemes[0];
    } else {
      // Otherwise, filter cheyuthaSubSchemesList to include only the elements with IDs 1, 5, and 7
      final filterSchemeList = cheyuthaSubSchemes
          .where((cheyutha) => allowedSchemeIds.contains(cheyutha.cschemEID))
          .toList();
      cheyuthaSubSchemes = filterSchemeList;
      cheyuthaSubSchemes.insert(
          0, Cheyutha(cschemEID: 0, cschemENAME: "Select Cheyutha sub-scheme"));
      selectedSubScheme = cheyuthaSubSchemes[0];
    }
  }
}

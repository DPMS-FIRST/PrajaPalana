/* import 'package:praja_palana/models/cheyuta/beedi_thekadar.dart';
import 'package:praja_palana/models/cheyuta/beedi_worker_model.dart';
import 'package:praja_palana/models/cheyuta/diyang_model.dart';
import 'package:praja_palana/models/cheyuta/widow_model.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/datepicker.dart';
import 'package:praja_palana/res/reusable_widgets/dropdown_resuable.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/res/reusable_widgets/row_radio_component.dart';
import 'package:praja_palana/res/reusable_widgets/table_fivecoloum.dart';
import 'package:praja_palana/res/reusable_widgets/table_four_columns_field.dart';
import 'package:praja_palana/res/reusable_widgets/table_two_coloumn.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/schemesViewModel/cheyuthaSchemeViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/view_model/schemesViewModel/family_details_view_model.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../models/master_data/master_geograpics_response.dart';
import '../../res/constants/app_assets.dart';
import '../../res/constants/app_colors.dart';
import '../../res/reusable_widgets/reusable_components.dart';
import '../../routes/app_routes.dart';

class CheyuthaScheme extends StatefulWidget {
  const CheyuthaScheme({super.key});

  @override
  State<CheyuthaScheme> createState() => _CheyuthaSchemeState();
}

class _CheyuthaSchemeState extends State<CheyuthaScheme> {
  bool addSadaramCertificateNo = false;
  List<String> sadaramCertificateNoList = [];
  CheyuthaEdit? cheyuthaEdit;
  CheyuthaMdl? cheyuthaMdl;
  FamilyListMdl? familyListMdl;
  FamilyListMdl? widowFamilyListMdl;
  FamilyListMdl? beediWorkerFamilyListMdl;
  FamilyListMdl? toddyTappersFamilyListMdl;
  FamilyListMdl? weaversFamilyListMdl;
  FamilyListMdl? dialysisFamilyListMdl;
  FamilyListMdl? filariaFamilyListMdl;
  FamilyListMdl? singleWomenFamilyListMdl;
  FamilyListMdl? beediTekederFamilyListMdl;
  List<FamilyListMdl> familyList = [];
  List<FamilyListMdl> widowfamilyList = [];
  List<FamilyListMdl> beedifamilyList = [];
  List<FamilyListMdl> toddyTappersfamilyList = [];
  List<FamilyListMdl> weaversfamilyList = [];
  List<FamilyListMdl> dialysisfamilyList = [];
  List<FamilyListMdl> filariafamilyList = [];
  List<FamilyListMdl> singleWomenfamilyList = [];
  TextEditingController sadaremIDController = TextEditingController();
  TextEditingController hubandDeathController = TextEditingController();
  TextEditingController deathDateController = TextEditingController();
  TextEditingController epfEnrollNumController = TextEditingController();
  TextEditingController epfEDateController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController licenceNoController = TextEditingController();
  TextEditingController licenseIssueDateController = TextEditingController();
  TextEditingController licensevalidDateController = TextEditingController();
  List<DiyvangModel> diyangList = [];
  List<BeediThekadarModel> beediThekedarList = [];
  List<WidowModel> widowList = [];
  List<BeediWorkerModel> beediWorkerList = [];
  String? selectedApplicantWeaver = "";

  int? diyangselectedID,
      widowselectedID,
      beediWorkerselectedID,
      toddyTappersselectedID,
      weaversselectedID,
      dialysisselectedID,
      filariaselectedID,
      singleWomenselectedID,
      beediTekederselectedID;
  String? diyangselectedvalue, widowselectedValue, beediWorkerselectedValue;
  TextEditingController registrationTypeController = TextEditingController();
  List<Singlewomen> singlewomenList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cheyuthaSchemeViewModel =
          Provider.of<CheyuthaSchemeViewModel>(context, listen: false);
      final familyProvider =
          Provider.of<FamilyDetailsViewModel>(context, listen: false);
      familyProvider.getFamilyData().then((value) async {
        setState(() {
          singleWomenfamilyList.addAll(value);
          singleWomenfamilyList.insert(
              0, FamilyListMdl(name: AppStrings.select_name, id: 0));
          singleWomenFamilyListMdl = singleWomenfamilyList[0];
          singleWomenselectedID = singleWomenfamilyList[0].id;
          // divyank
          familyList.addAll(value);
          familyList.insert(
              0, FamilyListMdl(name: AppStrings.select_name, id: 0));
          familyListMdl = familyList[0];
          diyangselectedID = familyList[0].id;
          // widow
          toddyTappersfamilyList.addAll(value);
          toddyTappersfamilyList.insert(
              0, FamilyListMdl(name: AppStrings.select_name, id: 0));
          toddyTappersFamilyListMdl = toddyTappersfamilyList[0];
          toddyTappersselectedID = toddyTappersfamilyList[0].id;

          // beediworkers
          weaversfamilyList.addAll(value);
          weaversfamilyList.insert(
              0, FamilyListMdl(name: AppStrings.select_name, id: 0));
          weaversFamilyListMdl = beedifamilyList[0];
          weaversselectedID = weaversfamilyList[0].id;

          // singlewomen
        });
      });
      cheyuthaSchemeViewModel.getConfigurableCheyuthaData().then((value) {
        setState(() {
          cheyuthaEdit = value;
        });
      });
      cheyuthaSchemeViewModel.getCheyuthaDetails().then((value) {
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
          /*   if (cheyuthaSchemeViewModel.selectedDivyang == 'Y') {
            for (int i = 0;
                i < (cheyuthaMdl?.sadaramListMdl?.length ?? 0);
                i++) {
              sadaramCertificateNoList.add(
                  cheyuthaMdl?.sadaramListMdl?[i].sadaraMCERTIFICATENO ?? '');
            }
          } */
        });
      });
      await cheyuthaSchemeViewModel.getSingleWomenDetails(context);
      setState(() {
        singlewomenList = cheyuthaSchemeViewModel.getSingleWomenData;
        singlewomenList.insert(
            0, Singlewomen(sWNAME: AppStrings.select_category, sWID: 0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cheyuthaProvider = Provider.of<CheyuthaSchemeViewModel>(context);
    // final familyProvider =
    //     Provider.of<FamilyDetailsViewModel>(context, listen: false);
    final editableCheyuthaFlag =
        ModalRoute.of(context)?.settings.arguments as bool;
    print("editableCheyuthaFlag------ ${editableCheyuthaFlag}");
    print(
        "cheyuthaProvider.selectedOthers---- ${cheyuthaProvider.selectedOthers}");
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
                      ReusableComponents()
                          .toodyTapperLayout(registrationTypeController),
                      ReusableComponents().weaverLayout(cheyuthaProvider),
                      ReusableComponents()
                          .singleWomenLayout(singlewomenList, cheyuthaProvider),
                      ReusableComponents().beediTekedarLayout(
                          cheyuthaProvider,
                          context,
                          industryController,
                          licenseIssueDateController,
                          licensevalidDateController,
                          licenceNoController,
                          familyListMdl,
                          beediThekedarList, () {
                        if (industryController.text.isNotEmpty) {
                          BeediThekadarModel beedThikedar =
                              BeediThekadarModel();
                          beedThikedar.industryName =
                              industryController.text.toString();
                          beedThikedar.licenseIssueDate =
                              licenseIssueDateController.text.toString();
                          beedThikedar.licenseNo =
                              licenceNoController.text.toString();
                          beedThikedar.licenseValid =
                              licensevalidDateController.text.toString();
                          beedThikedar.thekadarName = familyListMdl?.name ?? "";
                          industryController.text = "";
                          // familyList.removeWhere(
                          //     (item) => item.id == diyangselectedID);
                          // familyList.forEach((item) {
                          //   print(
                          //       'onclickckk${item.id}: ${item.name}');
                          // });
                          setState(() {
                            beediThekedarList.add(beedThikedar);
                            // familyList;
                            // familyListMdl = familyList[0];
                          });
                        } else {
                          ValidationIoSAlert().showAlert(context,
                              description: "Please enter industry name");
                        }
                      }),
                      //ReusableComponents().officerNameAndApplicationNumber(),

                      // New Requirement
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      //divyang new
                      RowRadioComponent(
                        title: "1. DIVYANG".tr(),
                        row: Row(
                          children: [
                            Radio(
                              value: 'Y',
                              groupValue: cheyuthaProvider.selectedDivyang,
                              onChanged: (value) {
                                cheyuthaProvider
                                    .changeStatusOfDivyang(value.toString());
                              },
                            ),
                            Text("Yes".tr()),
                            Radio(
                              value: 'N',
                              groupValue: cheyuthaProvider.selectedDivyang,
                              onChanged: (value) {
                                cheyuthaProvider
                                    .changeStatusOfDivyang(value.toString());
                                diyangList.clear();
                                print("familyListMdl${familyListMdl!.name}}");

                                familyList.add(FamilyListMdl(
                                    id: diyangselectedID,
                                    name: diyangselectedvalue ?? ""));
                                setState(() {
                                  familyList;
                                  diyangList.clear();
                                });
                              },
                            ),
                            Text("No".tr()),
                          ],
                        ),
                      ),
                      if (cheyuthaProvider.selectedDivyang == 'Y')
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DropdownTextFormFieldComponent(
                                    hintText: AppStrings.select_name,
                                    labelText: AppStrings.select_name,
                                    items:
                                        familyList.map((FamilyListMdl? option) {
                                      return DropdownMenuItem<FamilyListMdl>(
                                        value: option,
                                        child: Text(option?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (FamilyListMdl? newValue) {
                                      setState(() {
                                        familyListMdl = newValue;
                                        print("object${diyangselectedID}");
                                        diyangselectedID = familyListMdl?.id;
                                        diyangselectedvalue =
                                            familyListMdl?.name;
                                      });
                                    },
                                    value: familyListMdl),
                              ),
                            ],
                          ),
                        ),
                      if (diyangselectedID != 0)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ReusableTextFormField(
                                    maxLength: 17,
                                    controller: sadaremIDController,
                                    keyboardType: TextInputType.phone,
                                    labelText: "Enter SADAREM ID".tr()),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (sadaremIDController.text.isNotEmpty) {
                                      DiyvangModel diyvangModel =
                                          DiyvangModel();
                                      diyvangModel.sadaramId =
                                          sadaremIDController.text.toString();
                                      diyvangModel.diyangName =
                                          familyListMdl?.name ?? "";
                                      sadaremIDController.text = "";
                                      familyList.removeWhere((item) =>
                                          item.id == diyangselectedID);
                                      familyList.forEach((item) {
                                        print(
                                            'onclickckk${item.id}: ${item.name}');
                                      });
                                      setState(() {
                                        diyangList.add(diyvangModel);
                                        familyList;
                                        familyListMdl = familyList[0];
                                      });
                                    } else {
                                      ValidationIoSAlert().showAlert(context,
                                          description:
                                              "Please enter sadaram id");
                                    }
                                  },
                                  child: Text("Save")),
                            ],
                          ),
                        ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: diyangList.length,
                        itemBuilder: (context, index) {
                          return TablTwoColumnReusable(
                            serialNumber: (index + 1).toString(),
                            entredField1: diyangList[index].diyangName,
                            entredField2: diyangList[index].sadaramId,
                            removeicons: Icon(Icons.delete),
                            cardcolor: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.074,
                            ontap: () {
                              return showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Do you want to delete?",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("${diyangList[index].diyangName}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("${diyangList[index].sadaramId}")
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
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColors.appColor,
                                              ),
                                            ),
                                            child: Text("Delete",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                            onPressed: () {
                                              familyList.add(FamilyListMdl(
                                                  id: diyangselectedID,
                                                  name: diyangList[index]
                                                      .diyangName));
                                              setState(() {
                                                diyangList.removeAt(index);
                                                familyList;
                                                familyListMdl = familyList[0];
                                              });
                                              Navigator.pop(context);
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
                      //widow new

                      RowRadioComponent(
                        title: "2. WIDOW".tr(),
                        row: Row(
                          children: [
                            Radio(
                              value: 'Y',
                              groupValue: cheyuthaProvider.selectedWidow,
                              onChanged: (value) {
                                cheyuthaProvider
                                    .changeStatusOfWidow(value.toString());
                              },
                            ),
                            Text("Yes".tr()),
                            Radio(
                              value: 'N',
                              groupValue: cheyuthaProvider.selectedWidow,
                              onChanged: (value) {
                                cheyuthaProvider
                                    .changeStatusOfWidow(value.toString());
                                widowList.clear();
                                hubandDeathController.text = "";
                                deathDateController.text = "";
                                setState(() {
                                  familyList;
                                });
                              },
                            ),
                            Text("No".tr()),
                          ],
                        ),
                      ),
                      if (cheyuthaProvider.selectedWidow == 'Y')
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DropdownTextFormFieldComponent(
                                    hintText: AppStrings.select_name,
                                    labelText: AppStrings.select_name,
                                    items:
                                        familyList.map((FamilyListMdl? option) {
                                      return DropdownMenuItem<FamilyListMdl>(
                                        value: option,
                                        child: Text(option?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (FamilyListMdl? newValue) {
                                      setState(() {
                                        familyListMdl = newValue;
                                        widowselectedID = familyListMdl?.id;
                                      });
                                    },
                                    value: familyListMdl),
                              ),
                            ],
                          ),
                        ),

                      if (widowselectedID != 0 &&
                          cheyuthaProvider.selectedWidow == "Y")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: ReusableTextFormField(
                                        maxLength: 17,
                                        controller: hubandDeathController,
                                        keyboardType: TextInputType.phone,
                                        labelText:
                                            "Enter Husband 's Death Certificate"
                                                .tr()),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        if (hubandDeathController
                                            .text.isNotEmpty) {
                                          WidowModel widowModel = WidowModel();
                                          widowModel.deathCertificateNo =
                                              hubandDeathController.text
                                                  .toString();
                                          widowModel.widowName =
                                              familyListMdl?.name ?? "";

                                          widowModel.dateofDeath =
                                              deathDateController.text
                                                  .toString();

                                          hubandDeathController.text = "";
                                          deathDateController.text = "";

                                          familyList.removeWhere((item) =>
                                              item.id == widowselectedID);
                                          familyList.forEach((item) {
                                            print(
                                                'onclickckk${item.id}: ${item.name}');
                                          });
                                          setState(() {
                                            widowList.add(widowModel);
                                            widowList;
                                            familyListMdl = familyList[0];
                                          });
                                        } else {
                                          ValidationIoSAlert().showAlert(
                                              context,
                                              description:
                                                  "Please enter husband 's death certificate");
                                        }
                                      },
                                      child: Text("Save")),
                                ],
                              ),
                              datePickerComponent(
                                hintText: "Date of Death of Husband ",
                                nameController: deathDateController,
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
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widowList.length,
                                itemBuilder: (context, index) {
                                  return TableFourColumnReusable(
                                    serialNumber: (index + 1).toString(),
                                    entredField1: widowList[index].widowName,
                                    entredField2:
                                        widowList[index].deathCertificateNo,
                                    entredField3: widowList[index].dateofDeath,
                                    removeicons: Icon(Icons.delete),
                                    cardcolor: Colors.white,
                                    height: MediaQuery.of(context).size.height *
                                        0.074,
                                    ontap: () {
                                      return showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Do you want to delete?",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    "${widowList[index].widowName}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "${widowList[index].deathCertificateNo}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "${widowList[index].dateofDeath}")
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
                                                    child: Text("Delete",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        )),
                                                    onPressed: () {
                                                      setState(() {
                                                        familyList.add(FamilyListMdl(
                                                            id: widowselectedID,
                                                            name: widowList[
                                                                    index]
                                                                .widowName));
                                                        widowList
                                                            .removeAt(index);
                                                        familyList;
                                                        familyListMdl =
                                                            familyList[0];
                                                      });
                                                      Navigator.pop(context);
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
                            ],
                          ),
                        ),

                      RowRadioComponent(
                        title: "3. BEEDI WORKERS".tr(),
                        row: Row(
                          children: [
                            Radio(
                              value: 'Y',
                              groupValue: cheyuthaProvider.selectedBeediWorkers,
                              onChanged: (value) {
                                cheyuthaProvider.changeStatusOfBeediWorkers(
                                    value.toString());
                              },
                            ),
                            Text("Yes".tr()),
                            Radio(
                              value: 'N',
                              groupValue: cheyuthaProvider.selectedBeediWorkers,
                              onChanged: (value) {
                                cheyuthaProvider.changeStatusOfBeediWorkers(
                                    value.toString());
                                beediWorkerList.clear();
                                epfEDateController.text = "";
                                epfEnrollNumController.text = "";
                              },
                            ),
                            Text("No".tr()),
                          ],
                        ),
                      ),
                      if (cheyuthaProvider.selectedBeediWorkers == 'Y')
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DropdownTextFormFieldComponent(
                                    hintText: AppStrings.select_name,
                                    labelText: AppStrings.select_name,
                                    items:
                                        familyList.map((FamilyListMdl? option) {
                                      return DropdownMenuItem<FamilyListMdl>(
                                        value: option,
                                        child: Text(option?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (FamilyListMdl? newValue) {
                                      setState(() {
                                        familyListMdl = newValue;
                                        beediWorkerselectedID =
                                            familyListMdl?.id;
                                      });
                                    },
                                    value: familyListMdl),
                              ),
                            ],
                          ),
                        ),
                      if (beediWorkerselectedID != 0 &&
                          cheyuthaProvider.selectedBeediWorkers == "Y")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: ReusableTextFormField(
                                      maxLength: 17,
                                      controller: epfEnrollNumController,
                                      keyboardType: TextInputType.phone,
                                      labelText: "Enter EFP Enrollment Number"
                                          .tr()
                                          .tr()),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (epfEDateController.text.isNotEmpty) {
                                        BeediWorkerModel beediWorkModelModel =
                                            BeediWorkerModel();
                                        beediWorkModelModel.epf_enrollment_no =
                                            epfEnrollNumController.text
                                                .toString();
                                        beediWorkModelModel.beediworkerName =
                                            familyListMdl?.name ?? "";

                                        beediWorkModelModel
                                                .epf_enrollment_date =
                                            epfEDateController.text.toString();

                                        epfEnrollNumController.text = "";
                                        epfEDateController.text = "";
                                        familyList.removeWhere((item) =>
                                            item.id == beediWorkerselectedID);
                                        familyList.forEach((item) {
                                          print(
                                              'onclickckk${item.id}: ${item.name}');
                                        });

                                        setState(() {
                                          beediWorkerList
                                              .add(beediWorkModelModel);
                                          beediWorkerList;
                                          familyListMdl = familyList[0];
                                        });
                                      } else {
                                        ValidationIoSAlert().showAlert(context,
                                            description:
                                                "Please enter EFP Enrollment Number");
                                      }
                                    },
                                    child: Text("Save")),
                              ],
                            ),
                            datePickerComponent(
                              hintText: "EPF Enrollment Date",
                              nameController: epfEDateController,
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
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: beediWorkerList.length,
                              itemBuilder: (context, index) {
                                return TableFourColumnReusable(
                                  serialNumber: (index + 1).toString(),
                                  entredField1:
                                      beediWorkerList[index].beediworkerName,
                                  entredField2:
                                      beediWorkerList[index].epf_enrollment_no,
                                  entredField3: beediWorkerList[index]
                                      .epf_enrollment_date,
                                  removeicons: Icon(Icons.delete),
                                  cardcolor: Colors.white,
                                  height: MediaQuery.of(context).size.height *
                                      0.074,
                                  ontap: () {
                                    return showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Do you want to delete?",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  "${beediWorkerList[index].beediworkerName}"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  "${beediWorkerList[index].epf_enrollment_no}"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  "${beediWorkerList[index].epf_enrollment_date}")
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
                                                  child: Text("Delete",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  onPressed: () {
                                                    familyList.add(FamilyListMdl(
                                                        id:
                                                            beediWorkerselectedID,
                                                        name: beediWorkerList[
                                                                index]
                                                            .beediworkerName));
                                                    setState(() {
                                                      beediWorkerList
                                                          .removeAt(index);
                                                      familyList;
                                                      familyListMdl =
                                                          familyList[0];
                                                    });
                                                    Navigator.pop(context);
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
                          ]),
                        ),
                      if (cheyuthaProvider.selectedDivyang == 'N' &&
                          cheyuthaProvider.selectedBeediWorkers == "N" &&
                          cheyuthaProvider.selectedWidow == "N")
                        RowRadioComponent(
                          title: "4. TODDY TAPPER".tr(),
                          row: Row(
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue:
                                    cheyuthaProvider.selectedToddyTappers,
                                onChanged: (value) {
                                  cheyuthaProvider.changeStatusOfToddyTappers(
                                      value.toString());
                                },
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue:
                                    cheyuthaProvider.selectedToddyTappers,
                                onChanged: (value) {
                                  cheyuthaProvider.changeStatusOfToddyTappers(
                                      value.toString());
                                },
                              ),
                              Text("No".tr()),
                            ],
                          ),
                        ),
                      if (cheyuthaProvider.selectedToddyTappers == 'Y')
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DropdownTextFormFieldComponent(
                                    hintText: AppStrings.select_name,
                                    labelText: AppStrings.select_name,
                                    items: toddyTappersfamilyList
                                        .map((FamilyListMdl? option) {
                                      return DropdownMenuItem<FamilyListMdl>(
                                        value: option,
                                        child: Text(option?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (FamilyListMdl? newValue) {
                                      setState(() {
                                        toddyTappersFamilyListMdl = newValue;
                                        toddyTappersselectedID =
                                            toddyTappersFamilyListMdl?.id;
                                        weaversfamilyList.removeWhere((item) =>
                                            item.id == toddyTappersselectedID);
                                        weaversfamilyList;
                                        weaversFamilyListMdl =
                                            weaversfamilyList[0];
                                      });
                                    },
                                    value: toddyTappersFamilyListMdl),
                              ),
                            ],
                          ),
                        ),

                      if (cheyuthaProvider.selectedDivyang == 'N' &&
                          cheyuthaProvider.selectedBeediWorkers == "N" &&
                          cheyuthaProvider.selectedWidow == "N")
                        RowRadioComponent(
                          title: "5. WEAVER".tr(),
                          row: Row(
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue: cheyuthaProvider.selectedWeavers,
                                onChanged: (value) {
                                  cheyuthaProvider
                                      .changeStatusOfWeavers(value.toString());
                                },
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue: cheyuthaProvider.selectedWeavers,
                                onChanged: (value) {
                                  cheyuthaProvider
                                      .changeStatusOfWeavers(value.toString());
                                },
                              ),
                              Text("No".tr()),
                            ],
                          ),
                        ),
                      if (cheyuthaProvider.selectedWeavers == 'Y')
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DropdownTextFormFieldComponent(
                                    hintText: AppStrings.select_name,
                                    labelText: AppStrings.select_name,
                                    items: weaversfamilyList
                                        .map((FamilyListMdl? option) {
                                      return DropdownMenuItem<FamilyListMdl>(
                                        value: option,
                                        child: Text(option?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (FamilyListMdl? newValue) {
                                      weaversFamilyListMdl = newValue;
                                      weaversselectedID =
                                          weaversFamilyListMdl?.id;
                                      singleWomenfamilyList.removeWhere(
                                          (item) =>
                                              item.id == weaversselectedID);
                                      singleWomenfamilyList;

                                      setState(() {
                                        weaversselectedID;
                                        weaversFamilyListMdl;

                                        singleWomenFamilyListMdl =
                                            singleWomenfamilyList[0];
                                      });
                                    },
                                    value: weaversFamilyListMdl),
                              ),
                            ],
                          ),
                        ),
                      if (cheyuthaProvider.selectedWeavers == "Y")
                        RowRadioComponent(
                          title: "If Applicant applied for Weaver".tr(),
                          row: Row(
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue: selectedApplicantWeaver,
                                onChanged: (value) {
                                  setState(() {
                                    selectedApplicantWeaver = value.toString();
                                  });
                                },
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue: selectedApplicantWeaver,
                                onChanged: (value) {
                                  setState(() {
                                    selectedApplicantWeaver = value.toString();
                                  });
                                },
                              ),
                              Text("No".tr()),
                            ],
                          ),
                        ),

                      if (cheyuthaProvider.selectedDivyang == 'N' &&
                          cheyuthaProvider.selectedBeediWorkers == "N" &&
                          cheyuthaProvider.selectedWidow == "N")
                        RowRadioComponent(
                          title: "6. SINGLE WOMEN".tr(),
                          row: Row(
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue:
                                    cheyuthaProvider.selectedSingleWomen,
                                onChanged: (value) {
                                  cheyuthaProvider.changeStatusOfSingleWomen(
                                      value.toString());
                                },
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue:
                                    cheyuthaProvider.selectedSingleWomen,
                                onChanged: (value) {
                                  cheyuthaProvider.changeStatusOfSingleWomen(
                                      value.toString());
                                },
                              ),
                              Text("No".tr()),
                            ],
                          ),
                        ),
                      if (cheyuthaProvider.selectedSingleWomen == 'Y')
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DropdownTextFormFieldComponent(
                                    hintText: AppStrings.select_name,
                                    labelText: AppStrings.select_name,
                                    items: singleWomenfamilyList
                                        .map((FamilyListMdl? option) {
                                      return DropdownMenuItem<FamilyListMdl>(
                                        value: option,
                                        child: Text(option?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (FamilyListMdl? newValue) {
                                      setState(() {
                                        singleWomenFamilyListMdl = newValue;
                                        singleWomenselectedID =
                                            singleWomenFamilyListMdl?.id;
                                      });
                                    },
                                    value: singleWomenFamilyListMdl),
                              ),
                            ],
                          ),
                        ),

                      if (cheyuthaProvider.selectedDivyang == 'N' &&
                          cheyuthaProvider.selectedBeediWorkers == "N" &&
                          cheyuthaProvider.selectedWidow == "N")
                        RowRadioComponent(
                          title: "7. BEEDI THEKEDAR".tr(),
                          row: Row(
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue:
                                    cheyuthaProvider.selectedBeediTekedar,
                                onChanged: (value) {
                                  cheyuthaProvider.changeStatusOfBeediTekedar(
                                      value.toString());
                                },
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue:
                                    cheyuthaProvider.selectedBeediTekedar,
                                onChanged: (value) {
                                  cheyuthaProvider.changeStatusOfBeediTekedar(
                                      value.toString());
                                },
                              ),
                              Text("No".tr()),
                            ],
                          ),
                        ),
                      if (cheyuthaProvider.selectedBeediTekedar == 'Y')
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DropdownTextFormFieldComponent(
                                    hintText: AppStrings.select_name,
                                    labelText: AppStrings.select_name,
                                    items: singleWomenfamilyList
                                        .map((FamilyListMdl? option) {
                                      return DropdownMenuItem<FamilyListMdl>(
                                        value: option,
                                        child: Text(option?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (FamilyListMdl? newValue) {
                                      setState(() {
                                        singleWomenFamilyListMdl = newValue;
                                        singleWomenselectedID =
                                            singleWomenFamilyListMdl?.id;
                                      });
                                    },
                                    value: singleWomenFamilyListMdl),
                              ),
                            ],
                          ),
                        ),
                      if (cheyuthaProvider.selectedBeediTekedar == 'Y')
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: ReusableTextFormField(
                                        maxLength: 17,
                                        controller: industryController,
                                        keyboardType: TextInputType.phone,
                                        labelText: "Industry Name".tr()),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        if (industryController
                                            .text.isNotEmpty) {
                                          BeediThekadarModel beedThikedar =
                                              BeediThekadarModel();
                                          beedThikedar.industryName =
                                              industryController.text
                                                  .toString();
                                          beedThikedar.licenseIssueDate =
                                              licenseIssueDateController.text
                                                  .toString();
                                          beedThikedar.licenseNo =
                                              licenceNoController.text
                                                  .toString();
                                          beedThikedar.licenseValid =
                                              licensevalidDateController.text
                                                  .toString();
                                          beedThikedar.thekadarName =
                                              familyListMdl?.name ?? "";
                                          industryController.text = "";
                                          // familyList.removeWhere(
                                          //     (item) => item.id == diyangselectedID);
                                          // familyList.forEach((item) {
                                          //   print(
                                          //       'onclickckk${item.id}: ${item.name}');
                                          // });
                                          setState(() {
                                            beediThekedarList.add(beedThikedar);
                                            // familyList;
                                            // familyListMdl = familyList[0];
                                          });
                                        } else {
                                          ValidationIoSAlert().showAlert(
                                              context,
                                              description:
                                                  "Please enter industry name");
                                        }
                                      },
                                      child: Text("Save")),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReusableTextFormField(
                                    maxLength: 17,
                                    controller: licenceNoController,
                                    keyboardType: TextInputType.phone,
                                    labelText: "License Number".tr()),
                              ),
                              datePickerComponent(
                                hintText: "License Issue Date",
                                nameController: licenseIssueDateController,
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
                              ),
                              datePickerComponent(
                                hintText: "License Valid upto Date",
                                nameController: licensevalidDateController,
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
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: beediThekedarList.length,
                                itemBuilder: (context, index) {
                                  return TableFiveColumnReusable(
                                    serialNumber: (index + 1).toString(),
                                    entredField1:
                                        beediThekedarList[index].industryName,
                                    entredField2:
                                        beediThekedarList[index].industryName,
                                    entredField3:
                                        beediThekedarList[index].licenseNo,
                                    entredField4: beediThekedarList[index]
                                        .licenseIssueDate,
                                    entredField5:
                                        beediThekedarList[index].licenseValid,
                                    removeicons: Icon(Icons.delete),
                                    cardcolor: Colors.white,
                                    height: MediaQuery.of(context).size.height *
                                        0.074,
                                    ontap: () {
                                      return showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Do you want to delete?",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    "${beediThekedarList[index].industryName}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "${beediThekedarList[index].licenseNo}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "${beediThekedarList[index].licenseIssueDate}")
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
                                                    child: Text("Delete",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        )),
                                                    onPressed: () {
                                                      setState(() {
                                                        // familyList.add(FamilyListMdl(
                                                        //     id: widowselectedID,
                                                        //     name: widowList[
                                                        //             index]
                                                        //         .widowName));
                                                        // widowList
                                                        //     .removeAt(index);
                                                        // familyList;
                                                        // familyListMdl =
                                                        //     familyList[0];
                                                      });
                                                      Navigator.pop(context);
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
                            ],
                          ),
                        ),
                      ReusableButton(
                        onPressed: () {
                          // gruhaJyothiProvider.setIsLoadingStatus(false);
                          // gruhaJyothiProvider.onSaveClick(
                          //   context: context,
                          //   meterConnectionNo: gruhaJyothiProvider
                          //       .meterConnectionNoController.text,
                          //   selectedElectUnitId:
                          //       selectedElectUnit?.id ?? "0",
                          //   electricity200: gruhajyothiMdl?.electricitY200,
                          // );

                          // gruhaJyothiProvider.setIsLoadingStatus(false);
                          // SuccessCustomCupertinoAlert().showAlert(
                          //     context: context,
                          //     title: "Data Saved Successfully".tr(),
                          //     onPressed: () {
                          //       Navigator.pushNamed(
                          //           context, AppRoutes.applicantDashboard);
                          //     });
                        },
                        ButtonText: 'SAVE',
                      )

                      // if (cheyuthaProvider.selectedWeavers == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),

                      // if (cheyuthaProvider.selectedBeediWorkers == 'N')
                      //   RowRadioComponent(
                      //     title: "oldage".tr(),
                      //     row: Row(
                      //       children: [
                      //         Radio(
                      //           value: 'Y',
                      //           groupValue: cheyuthaProvider.selectedOldage,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfOldage(value.toString());
                      //           },
                      //         ),
                      //         Text("Yes".tr()),
                      //         Radio(
                      //           value: 'N',
                      //           groupValue: cheyuthaProvider.selectedOldage,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfOldage(value.toString());
                      //           },
                      //         ),
                      //         Text("No".tr()),
                      //       ],
                      //     ),
                      //   ),
                      // if (cheyuthaProvider.selectedOldage == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),
                      // if (cheyuthaProvider.selectedOldage == 'N')
                      //   RowRadioComponent(
                      //     title: "toddyTappers".tr(),
                      //     row: Row(
                      //       children: [
                      //         Radio(
                      //           value: 'Y',
                      //           groupValue:
                      //               cheyuthaProvider.selectedToddyTappers,
                      //           onChanged: (value) {
                      //             cheyuthaProvider.changeStatusOfToddyTappers(
                      //                 value.toString());
                      //           },
                      //         ),
                      //         Text("Yes".tr()),
                      //         Radio(
                      //           value: 'N',
                      //           groupValue:
                      //               cheyuthaProvider.selectedToddyTappers,
                      //           onChanged: (value) {
                      //             cheyuthaProvider.changeStatusOfToddyTappers(
                      //                 value.toString());
                      //           },
                      //         ),
                      //         Text("No".tr()),
                      //       ],
                      //     ),
                      //   ),
                      // if (cheyuthaProvider.selectedToddyTappers == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),
                      // if (cheyuthaProvider.selectedToddyTappers == 'N')
                      //   RowRadioComponent(
                      //     title: "weavers".tr(),
                      //     row: Row(
                      //       children: [
                      //         Radio(
                      //           value: 'Y',
                      //           groupValue: cheyuthaProvider.selectedWeavers,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfWeavers(value.toString());
                      //           },
                      //         ),
                      //         Text("Yes".tr()),
                      //         Radio(
                      //           value: 'N',
                      //           groupValue: cheyuthaProvider.selectedWeavers,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfWeavers(value.toString());
                      //           },
                      //         ),
                      //         Text("No".tr()),
                      //       ],
                      //     ),
                      //   ),
                      // if (cheyuthaProvider.selectedWeavers == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),
                      // if (cheyuthaProvider.selectedWeavers == 'N')
                      //   RowRadioComponent(
                      //     title: "dialysisPatients".tr(),
                      //     row: Row(
                      //       children: [
                      //         Radio(
                      //           value: 'Y',
                      //           groupValue:
                      //               cheyuthaProvider.selectedDialysisPatients,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfDialysisPatients(
                      //                     value.toString());
                      //           },
                      //         ),
                      //         Text("Yes".tr()),
                      //         Radio(
                      //           value: 'N',
                      //           groupValue:
                      //               cheyuthaProvider.selectedDialysisPatients,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfDialysisPatients(
                      //                     value.toString());
                      //           },
                      //         ),
                      //         Text("No".tr()),
                      //       ],
                      //     ),
                      //   ),
                      // if (cheyuthaProvider.selectedDialysisPatients == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),
                      // if (cheyuthaProvider.selectedDialysisPatients == 'N')
                      //   RowRadioComponent(
                      //     title: "filariaPatients".tr(),
                      //     row: Row(
                      //       children: [
                      //         Radio(
                      //           value: 'Y',
                      //           groupValue:
                      //               cheyuthaProvider.selectedFilariaPatients,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfFilariaPatients(
                      //                     value.toString());
                      //           },
                      //         ),
                      //         Text("Yes".tr()),
                      //         Radio(
                      //           value: 'N',
                      //           groupValue:
                      //               cheyuthaProvider.selectedFilariaPatients,
                      //           onChanged: (value) {
                      //             cheyuthaProvider
                      //                 .changeStatusOfFilariaPatients(
                      //                     value.toString());
                      //           },
                      //         ),
                      //         Text("No".tr()),
                      //       ],
                      //     ),
                      //   ),
                      // if (cheyuthaProvider.selectedFilariaPatients == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),
                      // if (cheyuthaProvider.selectedFilariaPatients == 'N')
                      //   RowRadioComponent(
                      //     title: "singleWomen".tr(),
                      //     row: Row(
                      //       children: [
                      //         Radio(
                      //           value: 'Y',
                      //           groupValue:
                      //               cheyuthaProvider.selectedSingleWomen,
                      //           onChanged: (value) {
                      //             cheyuthaProvider.changeStatusOfSingleWomen(
                      //                 value.toString());
                      //           },
                      //         ),
                      //         Text("Yes".tr()),
                      //         Radio(
                      //           value: 'N',
                      //           groupValue:
                      //               cheyuthaProvider.selectedSingleWomen,
                      //           onChanged: (value) {
                      //             cheyuthaProvider.changeStatusOfSingleWomen(
                      //                 value.toString());
                      //           },
                      //         ),
                      //         Text("No".tr()),
                      //       ],
                      //     ),
                      //   ),
                      // if (cheyuthaProvider.selectedSingleWomen == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),
                      // //BEEDI TEKEDAR
                      // if (cheyuthaProvider.selectedSingleWomen == 'N')
                      //   RowRadioComponent(
                      //     title: "beediTekedar".tr(),
                      //     row: Row(
                      //       children: [
                      //         Radio(
                      //           value: 'Y',
                      //           groupValue:
                      //               cheyuthaProvider.selectedBeediTekedar,
                      //           onChanged: (value) {
                      //             cheyuthaProvider.changeStatusOfBeediTekedar(
                      //                 value.toString());
                      //           },
                      //         ),
                      //         Text("Yes".tr()),
                      //         Radio(
                      //           value: 'N',
                      //           groupValue:
                      //               cheyuthaProvider.selectedBeediTekedar,
                      //           onChanged: (value) {
                      //             cheyuthaProvider.changeStatusOfBeediTekedar(
                      //                 value.toString());
                      //           },
                      //         ),
                      //         Text("No".tr()),
                      //       ],
                      //     ),
                      //   ),
                      // if (cheyuthaProvider.selectedBeediTekedar == 'Y')
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 8.0, right: 8.0, top: 16.0),
                      //     child: DropdownTextFormFieldComponent(
                      //         hintText: AppStrings.select_name,
                      //         labelText: AppStrings.select_name,
                      //         items: familyList.map((FamilyListMdl? option) {
                      //           return DropdownMenuItem<FamilyListMdl>(
                      //             value: option,
                      //             child: Text(option?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         onChanged: (FamilyListMdl? newValue) {
                      //           setState(() {
                      //             familyListMdl = newValue;
                      //             selectedID = familyListMdl?.id;
                      //           });
                      //         },
                      //         value: familyListMdl),
                      //   ),
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
}
 */
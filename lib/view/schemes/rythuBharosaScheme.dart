/* import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/res/reusable_widgets/table_four_columns_field.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/schemesViewModel/rythuBharosaSchemeViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../res/reusable_widgets/details_table_component.dart';
import '../../res/reusable_widgets/reusable_button_wrapped_width.dart';

class RythuBharosaScheme extends StatefulWidget {
  const RythuBharosaScheme({super.key});

  @override
  State<RythuBharosaScheme> createState() => _RythuBharosaSchemeState();
}

class _RythuBharosaSchemeState extends State<RythuBharosaScheme> {
  List<String> passbookList = [];
  List<String> surveyNoList = [];
  List<String?> areaAcresList = [];
  List<String?> areaGuntasList = [];

  RythubharosaEdit? editFlags;
  RaithubharosaMdl? rythuBarosaDetails;
  @override
  void initState() {
    super.initState();
    final rythuBharosaProvider =
        Provider.of<RythuBharosaSchemeViewModel>(context, listen: false);
    rythuBharosaProvider.getConfigurableFlags().then((value) async {
      setState(() {
        editFlags = value;
      });
    });
    rythuBharosaProvider.getRythuBarosaDetails().then((value) async {
      setState(() {
        rythuBarosaDetails = value;
        passbookList = rythuBarosaDetails?.passbookListMdl?.map((e) {
              return e.passbooKNO ?? "";
            }).toList() ??
            [];
        surveyNoList = rythuBarosaDetails?.surveyListMdl?.map((e) {
              return e.surveYNO ?? "";
            }).toList() ??
            [];
        areaAcresList = rythuBarosaDetails?.surveyListMdl?.map((e) {
              return e.area ?? "";
            }).toList() ??
            [];
        areaGuntasList = rythuBarosaDetails?.surveyListMdl?.map((e) {
              return e.guntas ?? "";
            }).toList() ??
            [];
        rythuBharosaProvider.selectedFarmerType =
            rythuBarosaDetails?.farmeR15000 ?? "";
        rythuBharosaProvider.selectedTenantFarmerType =
            rythuBarosaDetails?.koulURAITHU ?? "";
        rythuBharosaProvider.selectedFarmLabourType =
            rythuBarosaDetails?.cooliE12000 ?? "";
        rythuBharosaProvider.jobCardcontroller.text =
            rythuBarosaDetails?.jobcarDNO ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final rythuBharosaProvider =
        Provider.of<RythuBharosaSchemeViewModel>(context);
    final editableRythuFlag =
        ModalRoute.of(context)!.settings.arguments as bool;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          /* BackAlert().showAlert(
            context: context,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(SharedPrefConstants.rythuBharosaDetailsData);
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
              title: "rythuBharosaScheme".tr(),
              onPressedHome: () {
                Navigator.pushNamed(context, AppRoutes.applicantDashboard);
              },
              onPressedBack: () {
                /* BackAlert().showAlert(
                  context: context,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.remove(SharedPrefConstants.rythuBharosaDetailsData);
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
                      Text("everyYear15000perAcre".tr()),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  child: Text("1.1. "),
                                  width: 25,
                                ),
                                SizedBox(
                                  child: Text("farmers".tr()),
                                  width: 120,
                                ),
                                Radio(
                                  value: 'Y',
                                  groupValue:
                                      rythuBharosaProvider.selectedFarmerType,
                                  onChanged:
                                      editFlags?.farmeR15000?.toLowerCase() ==
                                              "y"
                                          ? (value) {
                                              rythuBharosaProvider
                                                  .changeStatusOfFarmerType(
                                                      value.toString());
                                            }
                                          : null,
                                ),
                                Text("Yes".tr()),
                                Radio(
                                  value: 'N',
                                  groupValue:
                                      rythuBharosaProvider.selectedFarmerType,
                                  onChanged:
                                      editFlags?.farmeR15000?.toLowerCase() ==
                                              "y"
                                          ? (value) {
                                              rythuBharosaProvider
                                                  .changeStatusOfFarmerType(
                                                      value.toString());
                                            }
                                          : null,
                                ),
                                Text("No".tr()),
                              ],
                            ),
                            //unable to pull changes
                            Row(children: [
                              SizedBox(
                                child: Text(" "),
                                width: 25,
                              ),
                              SizedBox(
                                child: Text("tenantFarmers".tr()),
                                width: 120,
                              ),
                              Radio(
                                value: 'Y',
                                groupValue: rythuBharosaProvider
                                    .selectedTenantFarmerType,
                                onChanged:
                                    editFlags?.koulURAITHU?.toLowerCase() == "y"
                                        ? (value) {
                                            rythuBharosaProvider
                                                .changeStatusOfTenantFarmerType(
                                                    value.toString());
                                          }
                                        : null,
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue: rythuBharosaProvider
                                    .selectedTenantFarmerType,
                                onChanged:
                                    editFlags?.koulURAITHU?.toLowerCase() == "y"
                                        ? (value) {
                                            rythuBharosaProvider
                                                .changeStatusOfTenantFarmerType(
                                                    value.toString());
                                          }
                                        : null,
                              ),
                              Text("No".tr()),
                            ]),
                            Row(
                              children: [
                                Text("1.2. "),
                                Text("detailsOfLand".tr()),
                              ],
                            ),
                            (editFlags?.passbooKNO?.toLowerCase() == "y" ||
                                    editableRythuFlag == true)
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: ReusableTextFormField(
                                            controller: rythuBharosaProvider
                                                .passbookController,
                                            keyboardType: TextInputType.text,
                                            maxLength: 45,
                                            labelText:
                                                "pattadharPassbookNumber".tr()),
                                      ),
                                      (editFlags?.passbooKNO?.toLowerCase() ==
                                                  "y" ||
                                              editableRythuFlag == true)
                                          ? ReusableNoWidthButton(
                                              ButtonText: "Add".tr(),
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (rythuBharosaProvider
                                                    .passbookController
                                                    .text
                                                    .isNotEmpty) {
                                                  passbookList.add(
                                                      rythuBharosaProvider
                                                          .passbookController
                                                          .text);
                                                  rythuBharosaProvider
                                                      .passbookController
                                                      .clear();
                                                } else {
                                                  ValidationIoSAlert()
                                                      .showAlert(
                                                    context,
                                                    description:
                                                        "Please enter passbook number",
                                                  );
                                                }
                                              })
                                          : SizedBox(),
                                    ],
                                  )
                                : SizedBox(),
                            (editFlags?.passbooKNO?.toLowerCase() == "y" ||
                                    editableRythuFlag == true)
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01)
                                : SizedBox(),
                            passbookList.length != 0
                                ? TableComponentReusable(
                                    serialNumber: "S.No".tr(),
                                    entredField: "Passbook No".tr(),
                                    removeicons: rythuBharosaProvider
                                                    .editData?.passbooKNO
                                                    ?.toLowerCase() ==
                                                "y" ||
                                            editableRythuFlag == true
                                        ? Text("Edit")
                                        : null,
                                    //Icon(Icons.remove_circle_outline),
                                    cardcolor: Colors.white,
                                    height: MediaQuery.of(context).size.height *
                                        0.074,
                                    ontap: () {},
                                    borderradius: BorderRadius.circular(0),
                                  )
                                : SizedBox(),
                            passbookList.length != 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: passbookList.length,
                                    itemBuilder: (context, index) {
                                      return TableComponentReusable(
                                        serialNumber: (index + 1).toString(),
                                        entredField: passbookList[index],
                                        removeicons: rythuBharosaProvider
                                                        .editData?.passbooKNO
                                                        ?.toLowerCase() ==
                                                    "y" ||
                                                editableRythuFlag == true
                                            ? Icon(Icons.edit_rounded)
                                            : null,
                                        cardcolor: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.074,
                                        ontap: () {
                                          /* AlertwithTwoButtons().showAlert(
                                                    context: context,
                                                    message:
                                                        "Are you sure you want to delete this passbook number?",
                                                    onYesPressed: () {
                                                      setState(() {
                                                        passbookList
                                                            .removeAt(index);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    onNoPressed: () {
                                                      Navigator.pop(context);
                                                    }); */
                                          rythuBharosaProvider
                                              .passbookController
                                              .text = passbookList[index];
                                          return showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Edit Passbook Number"),
                                                content: ReusableTextFormField(
                                                  controller:
                                                      rythuBharosaProvider
                                                          .passbookController,
                                                  labelText:
                                                      "Passbook Number".tr(),
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            AppColors.appColor,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "Save",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            passbookList[
                                                                    index] =
                                                                rythuBharosaProvider
                                                                    .passbookController
                                                                    .text;
                                                          });
                                                          Navigator.pop(
                                                              context);
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
                                    })
                                : SizedBox(),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Card(
                              elevation: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AppAssets.appBg),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      (editFlags?.surveYNO?.toLowerCase() ==
                                                  "y" ||
                                              editableRythuFlag == true)
                                          ? ReusableTextFormField(
                                              controller: rythuBharosaProvider
                                                  .surveyNoController,
                                              keyboardType: TextInputType.text,
                                              maxLength: 25,
                                              readOnly: editFlags?.surveYNO
                                                              ?.toLowerCase() ==
                                                          "y" ||
                                                      editableRythuFlag == true
                                                  ? false
                                                  : true,
                                              labelText: "surveyNo".tr())
                                          : SizedBox(),
                                      (editFlags?.area?.toLowerCase() == "y" ||
                                              editableRythuFlag == true)
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: ReusableTextFormField(
                                                      controller:
                                                          rythuBharosaProvider
                                                              .areaAcresController,
                                                      readOnly: editFlags?.area
                                                                      ?.toLowerCase() ==
                                                                  "y" ||
                                                              editableRythuFlag ==
                                                                  true
                                                          ? false
                                                          : true,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      labelText: "Acres".tr()),
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                Expanded(
                                                  child: ReusableTextFormField(
                                                      controller:
                                                          rythuBharosaProvider
                                                              .areaGuntasController,
                                                      readOnly: editFlags
                                                                      ?.guntas
                                                                      ?.toLowerCase() ==
                                                                  "y" ||
                                                              editableRythuFlag ==
                                                                  true
                                                          ? false
                                                          : true,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      labelText: "Guntas".tr()),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      editFlags?.surveYNO?.toLowerCase() ==
                                                  "y" ||
                                              editableRythuFlag == true
                                          ? ReusableNoWidthButton(
                                              ButtonText: "Add Land Details",
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (rythuBharosaProvider
                                                        .surveyNoController
                                                        .text
                                                        .isNotEmpty &&
                                                    rythuBharosaProvider
                                                        .areaAcresController
                                                        .text
                                                        .isNotEmpty &&
                                                    rythuBharosaProvider
                                                        .areaGuntasController
                                                        .text
                                                        .isNotEmpty) {
                                                  surveyNoList.add(
                                                      rythuBharosaProvider
                                                          .surveyNoController
                                                          .text);
                                                  areaAcresList.add(
                                                      rythuBharosaProvider
                                                          .areaAcresController
                                                          .text);
                                                  areaGuntasList.add(
                                                      rythuBharosaProvider
                                                          .areaGuntasController
                                                          .text);
                                                  rythuBharosaProvider
                                                      .surveyNoController
                                                      .clear();
                                                  rythuBharosaProvider
                                                      .areaAcresController
                                                      .clear();
                                                  rythuBharosaProvider
                                                      .areaGuntasController
                                                      .clear();
                                                } else {
                                                  ValidationIoSAlert()
                                                      .showAlert(
                                                    context,
                                                    description:
                                                        "Please enter all the fields",
                                                  );
                                                }
                                              },
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      surveyNoList.length != 0
                                          ? TableFourColumnReusable(
                                              serialNumber: "S.No".tr(),
                                              entredField1: "Survey No".tr(),
                                              entredField2: "Acres".tr(),
                                              entredField3: "Guntas".tr(),
                                              removeicons: editFlags?.surveYNO
                                                              ?.toLowerCase() ==
                                                          "y" ||
                                                      editableRythuFlag == true
                                                  ? Text("Edit")
                                                  : null,
                                              cardcolor: Colors.white,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.074,
                                              ontap: () {},
                                              borderradius:
                                                  BorderRadius.circular(0),
                                            )
                                          : SizedBox(),
                                      surveyNoList.length != 0
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: surveyNoList.length,
                                              itemBuilder: (context, index) {
                                                return TableFourColumnReusable(
                                                  serialNumber:
                                                      (index + 1).toString(),
                                                  entredField1:
                                                      surveyNoList[index],
                                                  entredField2:
                                                      areaAcresList[index] ??
                                                          "0",
                                                  entredField3:
                                                      areaGuntasList[index] ??
                                                          "0",
                                                  removeicons: editFlags
                                                                  ?.surveYNO
                                                                  ?.toLowerCase() ==
                                                              "y" ||
                                                          editableRythuFlag ==
                                                              true
                                                      ? Icon(Icons.edit_rounded)
                                                      : null,
                                                  cardcolor: Colors.white,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.074,
                                                  ontap: () {
                                                    /*  AlertwithTwoButtons()
                                                        .showAlert(
                                                            context: context,
                                                            message:
                                                                "Are you sure you want to delete this survey number?",
                                                            onYesPressed: () {
                                                              setState(() {
                                                                surveyNoList
                                                                    .removeAt(
                                                                        index);
                                                                areaAcresList
                                                                    .removeAt(
                                                                        index);
                                                                areaGuntasList
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            onNoPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }); */
                                                    rythuBharosaProvider
                                                            .surveyNoController
                                                            .text =
                                                        surveyNoList[index];
                                                    rythuBharosaProvider
                                                            .areaAcresController
                                                            .text =
                                                        areaAcresList[index] ??
                                                            '';
                                                    rythuBharosaProvider
                                                        .areaGuntasController
                                                        .text = areaGuntasList[
                                                            index] ??
                                                        '';
                                                    return showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text("Edit"),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              ReusableTextFormField(
                                                                controller:
                                                                    rythuBharosaProvider
                                                                        .surveyNoController,
                                                                labelText:
                                                                    "Survey Number"
                                                                        .tr(),
                                                              ),
                                                              ReusableTextFormField(
                                                                controller:
                                                                    rythuBharosaProvider
                                                                        .areaAcresController,
                                                                labelText:
                                                                    "Area".tr(),
                                                              ),
                                                              ReusableTextFormField(
                                                                controller:
                                                                    rythuBharosaProvider
                                                                        .areaGuntasController,
                                                                labelText:
                                                                    "Guntas"
                                                                        .tr(),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all<
                                                                            Color>(
                                                                      AppColors
                                                                          .appColor,
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Cancel",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all<
                                                                            Color>(
                                                                      AppColors
                                                                          .appColor,
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    "Save",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      surveyNoList[
                                                                              index] =
                                                                          rythuBharosaProvider
                                                                              .surveyNoController
                                                                              .text;
                                                                      areaAcresList[
                                                                              index] =
                                                                          rythuBharosaProvider
                                                                              .areaAcresController
                                                                              .text;
                                                                      areaGuntasList[
                                                                              index] =
                                                                          rythuBharosaProvider
                                                                              .areaGuntasController
                                                                              .text;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  borderradius:
                                                      BorderRadius.circular(0),
                                                );
                                              })
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("farmLabours12000".tr()),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 'Y',
                                  groupValue: rythuBharosaProvider
                                      .selectedFarmLabourType,
                                  onChanged:
                                      editFlags?.cooliE12000?.toLowerCase() ==
                                              "y"
                                          ? (value) {
                                              rythuBharosaProvider
                                                  .changeStatusOfFarmLabourType(
                                                      value.toString());
                                            }
                                          : null,
                                ),
                                Text("Yes".tr()),
                                Radio(
                                  value: 'N',
                                  groupValue: rythuBharosaProvider
                                      .selectedFarmLabourType,
                                  onChanged:
                                      editFlags?.cooliE12000?.toLowerCase() ==
                                              "y"
                                          ? (value) {
                                              rythuBharosaProvider
                                                  .changeStatusOfFarmLabourType(
                                                      value.toString());
                                            }
                                          : null,
                                ),
                                Text("No".tr()),
                              ],
                            ),
                            if (rythuBharosaProvider.selectedFarmLabourType ==
                                'Y')
                              ReusableTextFormField(
                                  controller:
                                      rythuBharosaProvider.jobCardcontroller,
                                  readOnly:
                                      editFlags?.jobcarDNO?.toLowerCase() ==
                                                  "y" ||
                                              editableRythuFlag == true
                                          ? false
                                          : true,
                                  labelText: "employmentJobCardNo".tr()),
                          ],
                        ),
                      ),
                      editableRythuFlag
                          ? Align(
                              alignment: Alignment.center,
                              child: ReusableButton(
                                onPressed: () async {
                                  rythuBharosaProvider
                                      .setIsLoadingStatus(false);
                                  final surveyListMdl = surveyNoList
                                      .map((e) => SurveyListMdl(
                                          area: areaAcresList[
                                              surveyNoList.indexOf(e)],
                                          guntas: areaGuntasList[
                                              surveyNoList.indexOf(e)],
                                          surveYNO: e))
                                      .toList();
                                  final passbookListMdl = passbookList
                                      .map(
                                        (e) => PassbookListMdl(
                                            passbooKNO: e,
                                            offlinEAPPLICATIONNO:
                                                rythuBarosaDetails
                                                    ?.passbookListMdl
                                                    ?.first
                                                    .offlinEAPPLICATIONNO,
                                            onlinEAPPLICATIONNO:
                                                rythuBarosaDetails
                                                    ?.passbookListMdl
                                                    ?.first
                                                    .onlinEAPPLICATIONNO),
                                      )
                                      .toList();
                                  await rythuBharosaProvider.onSaveClick(
                                      context: context,
                                      farmerType: rythuBharosaProvider
                                          .selectedFarmerType,
                                      farmer1500:
                                          rythuBarosaDetails?.raithu ?? "",
                                      tenantFarmerType: rythuBharosaProvider
                                          .selectedTenantFarmerType,
                                      farmLabourType: rythuBharosaProvider
                                          .selectedFarmLabourType,
                                      surveyListMdl: surveyListMdl,
                                      passbookListMdl: passbookListMdl,
                                      jobCard: rythuBharosaProvider
                                          .jobCardcontroller.text);

                                  rythuBharosaProvider
                                      .setIsLoadingStatus(false);
                                  SuccessCustomCupertinoAlert().showAlert(
                                      context: context,
                                      title: "Data Saved Successfully".tr(),
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            AppRoutes.applicantDashboard);
                                      });
                                },
                                ButtonText: 'SAVE',
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (rythuBharosaProvider.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }
}
 */
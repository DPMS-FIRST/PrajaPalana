import 'package:flutter/services.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/datepicker.dart';
import 'package:praja_palana/res/reusable_widgets/details_table_component.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/res/reusable_widgets/tableFiveColumnReusable.dart';
import 'package:praja_palana/res/reusable_widgets/tableTenColumnReusable.dart';
import 'package:praja_palana/res/reusable_widgets/table_four_columns_field.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/schemesViewModel/rythuBharosaSchemeNewViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../res/CustomAlerts/alert_with_twobuttons.dart';
import '../../res/reusable_widgets/reusable_button_wrapped_width.dart';
import '../../view_model/schemesViewModel/application_details_view_model.dart';

class RythuBharosaSchemeNew extends StatefulWidget {
  const RythuBharosaSchemeNew({super.key});

  @override
  State<RythuBharosaSchemeNew> createState() => _RythuBharosaSchemeState();
}

class _RythuBharosaSchemeState extends State<RythuBharosaSchemeNew> {
  List<String> passbookList = [];
  List<String> surveyNoList = [];
  List<String?> areaAcresList = [];
  List<String?> areaGuntasList = [];
  List<OwneRDTLS> passbokkSurveyNoList = [];
  List<OwneRDTLS> tenantSurveyNoList = [];
  List<OwneRDTLS> houseHoldWithAgricultureList = [];
  PersonalDtlsMdl? applicantDetails;
  RythubharosaEdit? editFlags;
  RaithubharosaMdl? rythuBarosaDetails;
  @override
  void initState() {
    super.initState();
    final rythuBharosaProvider =
        Provider.of<RythuBharosaSchemeNewViewModel>(context, listen: false);
    rythuBharosaProvider.getConfigurableFlags().then((value) async {
      setState(() {
        rythuBharosaProvider.selectedExistingRythuBandhuBenficiary = '';
        rythuBharosaProvider.selectedAnyHouseholdWithLandType = '';
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
        print("passbookList $passbookList");
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
        rythuBharosaProvider.selectedExistingRythuBandhuBenficiary =
            rythuBarosaDetails?.beneficiarYRAITHUBANDHU ?? "";
        rythuBharosaProvider.selectedAnyHouseholdWithLandType =
            rythuBarosaDetails?.householDAGRI ?? "";
        tenantSurveyNoList = rythuBarosaDetails?.tenenTDTLS?.map((e) {
              return OwneRDTLS(
                passbooKNO: e.passbooKNO ?? "",
                surveYNO: e.surveYNO ?? "",
                area: e.area ?? "",
                guntas: e.guntas ?? "",
                subDivion: e.subDivion ?? "",
                landOwnerName: e.landOwnerName ?? "",
                leaseDoc: e.leaseDoc ?? "",
                periodFrom: e.periodFrom ?? "",
                periodTo: e.periodTo ?? "",
              );
            }).toList() ??
            [];
        houseHoldWithAgricultureList =
            rythuBarosaDetails?.householDDTLS?.map((e) {
                  return OwneRDTLS(
                    passbooKNO: e.passbooKNO ?? "",
                    surveYNO: e.surveYNO ?? "",
                    area: e.area ?? "",
                    guntas: e.guntas ?? "",
                    subDivion: e.subDivion ?? "",
                    landOwnerName: e.landOwnerName ?? "",
                    leaseDoc: e.leaseDoc ?? "",
                    periodFrom: e.periodFrom ?? "",
                    periodTo: e.periodTo ?? "",
                  );
                }).toList() ??
                [];

        passbokkSurveyNoList = rythuBarosaDetails?.owneRDTLS?.map((e) {
              return OwneRDTLS(
                passbooKNO: e.passbooKNO ?? "",
                surveYNO: e.surveYNO ?? "",
                area: e.area ?? "",
                guntas: e.guntas ?? "",
                subDivion: e.subDivion ?? "",
                landOwnerName: e.landOwnerName ?? "",
                leaseDoc: e.leaseDoc ?? "",
                periodFrom: e.periodFrom ?? "",
                periodTo: e.periodTo ?? "",
              );
            }).toList() ??
            [];
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final applicantDetailsProvider =
          Provider.of<ApplicantDetailsViewModel>(context, listen: false);
      await applicantDetailsProvider.getApplicationDetails().then((value) {
        setState(() {
          applicantDetails = value;
        });
      });
    });
    //commit v1.2
  }

  @override
  Widget build(BuildContext context) {
    final rythuBharosaProvider =
        Provider.of<RythuBharosaSchemeNewViewModel>(context);
    print("job ::: ${rythuBharosaProvider.jobCardcontroller.text}");
    final editableRythuFlag =
        ModalRoute.of(context)!.settings.arguments as bool;
    print("editableRythuFlag $editableRythuFlag");
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
      child: Scaffold(
        appBar: AppBarComponent(
          title: "rythuBharosaScheme".tr(),
          onPressedHome: () {
            Navigator.pushNamed(context, AppRoutes.applicantDashboard);
          },
          onPressedBack: () {
            /*  BackAlert().showAlert(
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
              padding: const EdgeInsets.only(right: 8, left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableComponents().ApplicationRationAndApplicantName(),
                  // ReusableComponents().officerNameAndApplicationNumber(),
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
                                  editFlags?.farmeR15000?.toLowerCase() == "y"
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
                                  editFlags?.farmeR15000?.toLowerCase() == "y"
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
                        /* Row(
                          children: [
                            SizedBox(
                              child: Text(" "),
                              width: 25,
                            ),
                            SizedBox(
                              child: Text("existRythuBandhu".tr()),
                              width: 120,
                            ),
                            Radio(
                              value: 'Y',
                              groupValue:
                                  rythuBharosaProvider.selectedFarmerType,
                              onChanged:
                                  editFlags?.farmeR15000?.toLowerCase() == "y"
                                      ? (value) {
                                          rythuBharosaProvider
                                              .changeStatusOfFarmerRythuBandhuType(
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
                                  editFlags?.farmeR15000?.toLowerCase() == "y"
                                      ? (value) {
                                          rythuBharosaProvider
                                              .changeStatusOfFarmerRythuBandhuType(
                                                  value.toString());
                                        }
                                      : null,
                            ),
                            Text("No".tr()),
                          ],
                        ), */
                        Row(children: [
                          SizedBox(
                            child: Text("1.2"),
                            width: 25,
                          ),
                          SizedBox(
                            child: Text("existingRythuBandhuBenificiary".tr()),
                            width: 120,
                          ),
                          Radio(
                            value: 'Y',
                            groupValue: rythuBharosaProvider
                                .selectedExistingRythuBandhuBenficiary,
                            onChanged: (value) {
                              rythuBharosaProvider
                                  .changeExistingRythuBandhuBenficiary(
                                      value.toString());
                              setState(() {});
                            },
                          ),
                          Text("Yes".tr()),
                          Radio(
                            value: 'N',
                            groupValue: rythuBharosaProvider
                                .selectedExistingRythuBandhuBenficiary,
                            onChanged: (value) {
                              rythuBharosaProvider
                                  .changeExistingRythuBandhuBenficiary(
                                      value.toString());
                              setState(() {});
                            },
                          ),
                          Text("No".tr()),
                        ]),
                        Row(children: [
                          SizedBox(
                            child: Text("1.3"),
                            width: 25,
                          ),
                          SizedBox(
                            child: Text("tenantFarmers".tr()),
                            width: 120,
                          ),
                          Radio(
                            value: 'Y',
                            groupValue:
                                rythuBharosaProvider.selectedTenantFarmerType,
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
                            groupValue:
                                rythuBharosaProvider.selectedTenantFarmerType,
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
                            Text("1.4. "),
                            Text("detailsOfLand".tr()),
                          ],
                        ),
                        editFlags?.passbooKNO?.toLowerCase() == "y"
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01)
                            : SizedBox(),
                        passbookList.length != 0
                            ? TableComponentReusable(
                                serialNumber: "S.No".tr(),
                                entredField: "Passbook No".tr(),
                                removeicons: null,
                                cardcolor: Colors.grey[200],
                                height:
                                    MediaQuery.of(context).size.height * 0.074,
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
                                    removeicons: null,
                                    cardcolor: Colors.white,
                                    height: MediaQuery.of(context).size.height *
                                        0.074,
                                    ontap: () {},
                                    borderradius: BorderRadius.circular(0),
                                  );
                                })
                            : SizedBox(),
                        surveyNoList.length != 0
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01)
                            : SizedBox(),
                        surveyNoList.length != 0
                            ? TableFourColumnReusable(
                                serialNumber: "S.No".tr(),
                                entredField1: "Survey No".tr(),
                                entredField2: "Acres".tr(),
                                entredField3: "Guntas".tr(),
                                removeicons: null,
                                cardcolor: Colors.grey[200],
                                height:
                                    MediaQuery.of(context).size.height * 0.074,
                                ontap: () {},
                                borderradius: BorderRadius.circular(0),
                              )
                            : SizedBox(),
                        surveyNoList.length != 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: surveyNoList.length,
                                itemBuilder: (context, index) {
                                  return TableFourColumnReusable(
                                    serialNumber: (index + 1).toString(),
                                    entredField1: surveyNoList[index],
                                    entredField2: areaAcresList[index] ?? "0",
                                    entredField3: areaGuntasList[index] ?? "0",
                                    cardcolor: Colors.white,
                                    removeicons: null,
                                    height: MediaQuery.of(context).size.height *
                                        0.074,
                                    ontap: () {},
                                    borderradius: BorderRadius.circular(0),
                                  );
                                })
                            : SizedBox(),
                        (rythuBharosaProvider.selectedFarmerType == 'Y' ||
                                rythuBharosaProvider.selectedFarmerType == 'N')
                            ? Container()
                            : Column(
                                children: [
                                  rythuBharosaProvider.selectedFarmerType == 'Y'
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "1.4.1 ",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "farmers".tr(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ReusableTextFormField(
                                                      readOnly:
                                                          applicantDetails
                                                                      ?.passbookflg ==
                                                                  "Y"
                                                              ? false
                                                              : true,
                                                      onChanged: (p0) {
                                                        rythuBharosaProvider
                                                            .passbookController
                                                            .text = p0;
                                                        setState(() {});
                                                      },
                                                      maxLength:
                                                          rythuBharosaProvider
                                                                  .passbookController
                                                                  .text
                                                                  .startsWith(
                                                                      'R')
                                                              ? 16
                                                              : 12,
                                                      controller:
                                                          rythuBharosaProvider
                                                              .passbookController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      labelText:
                                                          "pattadharPassbookNumber"
                                                              .tr()),
                                                ),
                                                editFlags?.passbooKNO
                                                            ?.toLowerCase() ==
                                                        "y"
                                                    ? ReusableNoWidthButton(
                                                        ButtonText: "Add".tr(),
                                                        onPressed: () {
                                                          if (rythuBharosaProvider
                                                              .validateFields(
                                                                  context,
                                                                  rythuBharosaProvider
                                                                      .passbookController
                                                                      .text)) {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Column(
                                                                    children: [
                                                                      ReusableTextFormField(
                                                                        controller:
                                                                            rythuBharosaProvider.surveyNoController,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        readOnly: editFlags?.surveYNO?.toLowerCase() ==
                                                                                "y"
                                                                            ? false
                                                                            : true,
                                                                        labelText:
                                                                            "surveyNo".tr(),
                                                                        maxLength:
                                                                            50,
                                                                      ),
                                                                      ReusableTextFormField(
                                                                        controller:
                                                                            rythuBharosaProvider.subDivisionController,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        readOnly: editFlags?.surveYNO?.toLowerCase() ==
                                                                                "y"
                                                                            ? false
                                                                            : true,
                                                                        labelText:
                                                                            "Sub Division",
                                                                        maxLength:
                                                                            50,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: ReusableTextFormField(
                                                                                controller: rythuBharosaProvider.areaAcresController,
                                                                                readOnly: editFlags?.area?.toLowerCase() == "y" ? false : true,
                                                                                keyboardType: TextInputType.phone,
                                                                                maxLength: 3,
                                                                                labelText: "Acres".tr()),
                                                                          ),
                                                                          SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.01),
                                                                          Expanded(
                                                                            child: ReusableTextFormField(
                                                                                controller: rythuBharosaProvider.areaGuntasController,
                                                                                readOnly: editFlags?.guntas?.toLowerCase() == "y" ? false : true,
                                                                                keyboardType: TextInputType.phone,
                                                                                maxLength: 2,
                                                                                labelText: "Guntas".tr()),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      ReusableNoWidthButton(
                                                                        ButtonText:
                                                                            "Add Land Details ".tr(),
                                                                        onPressed:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          if (rythuBharosaProvider.surveyNoController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.subDivisionController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.areaAcresController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.areaGuntasController.text.isNotEmpty) {
                                                                            passbokkSurveyNoList.add(
                                                                              OwneRDTLS(
                                                                                passbooKNO: rythuBharosaProvider.passbookController.text.trim(),
                                                                                surveYNO: rythuBharosaProvider.surveyNoController.text.trim(),
                                                                                area: rythuBharosaProvider.areaAcresController.text.trim(),
                                                                                guntas: rythuBharosaProvider.areaGuntasController.text.trim(),
                                                                                subDivion: rythuBharosaProvider.subDivisionController.text.trim(),
                                                                              ),
                                                                            );
                                                                            rythuBharosaProvider.passbookController.clear();
                                                                            rythuBharosaProvider.surveyNoController.clear();
                                                                            rythuBharosaProvider.areaAcresController.clear();
                                                                            rythuBharosaProvider.areaGuntasController.clear();
                                                                            rythuBharosaProvider.subDivisionController.clear();

                                                                            Navigator.pop(context);
                                                                          } else {
                                                                            ValidationIoSAlert().showAlert(
                                                                              context,
                                                                              description: "Please enter all the fields",
                                                                            );
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        })
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  passbokkSurveyNoList.length != 0
                                      ? Card(
                                          elevation: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(AppAssets.appBg),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              physics: ScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  passbokkSurveyNoList.length !=
                                                          0
                                                      ? Column(
                                                          children: [
                                                            TableFiveColumnReusableNew(
                                                              serialNumber:
                                                                  "S.No".tr(),
                                                              entredField1:
                                                                  "Passbook No"
                                                                      .tr(),
                                                              entredField2:
                                                                  "Survey No"
                                                                      .tr(),
                                                              entredField3:
                                                                  "Sub Division"
                                                                      .tr(),
                                                              entredField4:
                                                                  "Extent".tr(),
                                                              //entredField5: "guntas".tr(),
                                                              ExtendFlag: false,
                                                              iconFlag: false,
                                                              //
                                                              //removeicons: Icon(Icons.remove_circle_outline),
                                                              cardcolor: Colors
                                                                  .grey[200],
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.074,
                                                              ontap: () {},
                                                              borderradius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                            TableFiveColumnReusableNew(
                                                              serialNumber:
                                                                  "".tr(),
                                                              entredField1:
                                                                  "".tr(),
                                                              entredField2:
                                                                  "".tr(),
                                                              entredField3:
                                                                  "".tr(),
                                                              entredField4:
                                                                  "acres".tr(),
                                                              entredField5:
                                                                  "guntas".tr(),
                                                              ExtendFlag: true,
                                                              iconFlag: false,
                                                              cardcolor: Colors
                                                                  .grey[200],
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.074,
                                                              ontap: () {},
                                                              borderradius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          6.0),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        1.75,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: passbokkSurveyNoList.length,
                                                                        itemBuilder: (context, index) {
                                                                          return TableFiveColumnReusableNew(
                                                                            ExtendFlag:
                                                                                true,
                                                                            iconFlag:
                                                                                true,
                                                                            serialNumber:
                                                                                (index + 1).toString(),
                                                                            entredField1:
                                                                                passbokkSurveyNoList[index].passbooKNO,
                                                                            entredField2:
                                                                                passbokkSurveyNoList[index].surveYNO,
                                                                            entredField3:
                                                                                passbokkSurveyNoList[index].subDivion,
                                                                            entredField4:
                                                                                passbokkSurveyNoList[index].area,
                                                                            entredField5:
                                                                                passbokkSurveyNoList[index].guntas,
                                                                            /* removeicons: Icon(Icons
                                                                      .remove_circle_outline), */
                                                                            cardcolor:
                                                                                Colors.white,
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.074,
                                                                            ontap:
                                                                                () {
                                                                              AlertwithTwoButtons().showAlert(
                                                                                  context: context,
                                                                                  message: "Are you sure you want to delete this survey number?",
                                                                                  onYesPressed: () {
                                                                                    setState(() {
                                                                                      passbokkSurveyNoList.removeAt(index);
                                                                                    });
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  onNoPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                            },
                                                                            borderradius:
                                                                                BorderRadius.circular(0),
                                                                          );
                                                                        }),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(""),
                                ],
                              ),

                        //Tenant details
                        (rythuBharosaProvider.selectedTenantFarmerType == 'Y' ||
                                rythuBharosaProvider.selectedTenantFarmerType ==
                                    'N')
                            ? Container()
                            : Column(
                                children: [
                                  rythuBharosaProvider
                                              .selectedTenantFarmerType ==
                                          'Y'
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("1.4.2  ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Expanded(
                                                    child: Text(
                                                      "Tenant farmer(Details of land taken for lease)",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ReusableTextFormField(
                                                      maxLength:
                                                          rythuBharosaProvider
                                                                  .passbookTenantController
                                                                  .text
                                                                  .startsWith(
                                                                      'R')
                                                              ? 16
                                                              : 12,
                                                      onChanged: (p0) {
                                                        rythuBharosaProvider
                                                            .passbookTenantController
                                                            .text = p0;
                                                        setState(() {});
                                                      },
                                                      controller:
                                                          rythuBharosaProvider
                                                              .passbookTenantController,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      readOnly: false,
                                                      labelText:
                                                          "pattadharPassbookNumber"
                                                              .tr()),
                                                ),

                                                ReusableNoWidthButton(
                                                  ButtonText: "Add".tr(),
                                                  onPressed: () {
                                                    if (rythuBharosaProvider
                                                        .validateFields(
                                                            context,
                                                            rythuBharosaProvider
                                                                .passbookTenantController
                                                                .text)) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext
                                                                    context,
                                                                void Function(
                                                                        void
                                                                            Function())
                                                                    setState) {
                                                              return AlertDialog(
                                                                content:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  child: Column(
                                                                    children: [
                                                                      ReusableTextFormField(
                                                                        controller:
                                                                            rythuBharosaProvider.landOwnerNameController,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        readOnly:
                                                                            false,
                                                                        labelText:
                                                                            "landOwnerName".tr(),
                                                                      ),
                                                                      datePickerComponent(
                                                                        editable:
                                                                            true,
                                                                        hintText:
                                                                            "periodFrom".tr(),
                                                                        nameController:
                                                                            rythuBharosaProvider.periodFromController,
                                                                        errorMessage:
                                                                            '',
                                                                        obsecuretext:
                                                                            false,
                                                                        action:
                                                                            TextInputAction.next,
                                                                        onEditingComplete:
                                                                            () {},
                                                                        suffixIcon:
                                                                            Icon(
                                                                          Icons
                                                                              .calendar_month,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                      datePickerComponent(
                                                                        editable:
                                                                            true,
                                                                        hintText:
                                                                            "periodTo".tr(),
                                                                        nameController:
                                                                            rythuBharosaProvider.periodToController,
                                                                        errorMessage:
                                                                            '',
                                                                        obsecuretext:
                                                                            false,
                                                                        action:
                                                                            TextInputAction.next,
                                                                        onEditingComplete:
                                                                            () {},
                                                                        suffixIcon:
                                                                            Icon(
                                                                          Icons
                                                                              .calendar_month,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                8,
                                                                            right:
                                                                                8),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "leaseDoc".tr(),
                                                                              style: TextStyle(fontSize: 15),
                                                                            ),
                                                                            Radio(
                                                                              value: 'Y',
                                                                              groupValue: rythuBharosaProvider.selectedLeaseDocType,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  rythuBharosaProvider.changeStatusOfLeaseDocType(value.toString());
                                                                                });
                                                                              },
                                                                            ),
                                                                            Text(
                                                                              "Yes".tr(),
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                            Radio(
                                                                              value: 'N',
                                                                              groupValue: rythuBharosaProvider.selectedLeaseDocType,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  rythuBharosaProvider.changeStatusOfLeaseDocType(value.toString());
                                                                                });
                                                                              },
                                                                            ),
                                                                            Text(
                                                                              "No".tr(),
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      ReusableTextFormField(
                                                                        controller:
                                                                            rythuBharosaProvider.surveyNoController,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        readOnly:
                                                                            false,
                                                                        labelText:
                                                                            "surveyNo".tr(),
                                                                        maxLength:
                                                                            50,
                                                                      ),
                                                                      ReusableTextFormField(
                                                                        controller:
                                                                            rythuBharosaProvider.subDivisionController,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        readOnly:
                                                                            false,
                                                                        labelText:
                                                                            "Sub Division",
                                                                        maxLength:
                                                                            50,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: ReusableTextFormField(
                                                                                controller: rythuBharosaProvider.areaAcresController,
                                                                                readOnly: false,
                                                                                keyboardType: TextInputType.phone,
                                                                                maxLength: 3,
                                                                                labelText: "Acres".tr()),
                                                                          ),
                                                                          SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.01),
                                                                          Expanded(
                                                                            child: ReusableTextFormField(
                                                                                controller: rythuBharosaProvider.areaGuntasController,
                                                                                readOnly: false,
                                                                                keyboardType: TextInputType.phone,
                                                                                maxLength: 2,
                                                                                labelText: "Guntas".tr()),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      ReusableNoWidthButton(
                                                                        ButtonText:
                                                                            "Add Land Details",
                                                                        onPressed:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          if (rythuBharosaProvider.surveyNoController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.subDivisionController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.areaAcresController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.areaGuntasController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.landOwnerNameController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.periodFromController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.periodToController.text.isNotEmpty &&
                                                                              rythuBharosaProvider.selectedLeaseDocType.isNotEmpty) {
                                                                            tenantSurveyNoList.add(
                                                                              OwneRDTLS(
                                                                                passbooKNO: rythuBharosaProvider.passbookTenantController.text.trim(),
                                                                                surveYNO: rythuBharosaProvider.surveyNoController.text.trim(),
                                                                                area: rythuBharosaProvider.areaAcresController.text.trim(),
                                                                                guntas: rythuBharosaProvider.areaGuntasController.text.trim(),
                                                                                subDivion: rythuBharosaProvider.subDivisionController.text.trim(),
                                                                                landOwnerName: rythuBharosaProvider.landOwnerNameController.text.trim(),
                                                                                leaseDoc: rythuBharosaProvider.selectedLeaseDocType.trim(),
                                                                                periodFrom: rythuBharosaProvider.periodFromController.text.trim(),
                                                                                periodTo: rythuBharosaProvider.periodToController.text.trim(),
                                                                              ),
                                                                            );
                                                                            rythuBharosaProvider.passbookTenantController.clear();
                                                                            rythuBharosaProvider.surveyNoController.clear();
                                                                            rythuBharosaProvider.areaAcresController.clear();
                                                                            rythuBharosaProvider.areaGuntasController.clear();
                                                                            rythuBharosaProvider.subDivisionController.clear();
                                                                            rythuBharosaProvider.passbookController.clear();
                                                                            rythuBharosaProvider.landOwnerNameController.clear();
                                                                            rythuBharosaProvider.changeStatusOfLeaseDocType("");
                                                                            rythuBharosaProvider.periodFromController.clear();
                                                                            rythuBharosaProvider.periodToController.clear();

                                                                            Navigator.pop(context);
                                                                          } else {
                                                                            ValidationIoSAlert().showAlert(
                                                                              context,
                                                                              description: "Please enter all the fields",
                                                                            );
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                )
                                                //: SizedBox(),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Card(
                                    elevation: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(AppAssets.appBg),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        physics: ScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          children: [
                                            tenantSurveyNoList.length != 0
                                                ? Column(
                                                    children: [
                                                      TableTenColumnReusableNew(
                                                        serialNumber:
                                                            "S.No".tr(),
                                                        passbook:
                                                            "Passbook No".tr(),
                                                        landownerName:
                                                            "landOwnerName"
                                                                .tr(),
                                                        leaseDoc:
                                                            "leaseDoc".tr(),
                                                        periodOfLease:
                                                            "periodOfLease"
                                                                .tr(),
                                                        surveyNo:
                                                            "Survey No".tr(),
                                                        subDivion:
                                                            "Sub Division".tr(),
                                                        extent: "extent".tr(),
                                                        ExtendFlag: false,
                                                        iconFlag: false,
                                                        periodLeaseFlag: false,
                                                        cardcolor: Colors.white,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.074,
                                                        ontap: () {},
                                                        borderradius:
                                                            BorderRadius
                                                                .circular(0),
                                                      ),
                                                      TableTenColumnReusableNew(
                                                        serialNumber: "".tr(),
                                                        passbook: "".tr(),
                                                        landownerName: "".tr(),
                                                        leaseDoc: "".tr(),
                                                        fromPeriod:
                                                            "periodFrom".tr(),
                                                        toPeriod:
                                                            "periodTo".tr(),
                                                        surveyNo: "".tr(),
                                                        subDivion: "".tr(),
                                                        acres: "acres".tr(),
                                                        guntas: "guntas".tr(),
                                                        ExtendFlag: true,
                                                        iconFlag: false,
                                                        periodLeaseFlag: true,
                                                        cardcolor: Colors.white,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.074,
                                                        ontap: () {},
                                                        borderradius:
                                                            BorderRadius
                                                                .circular(0),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 2.0),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  2.75,
                                                              child: ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          tenantSurveyNoList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return TableTenColumnReusableNew(
                                                                          ExtendFlag:
                                                                              true,
                                                                          iconFlag:
                                                                              true,
                                                                          serialNumber:
                                                                              (index + 1).toString(),
                                                                          passbook:
                                                                              tenantSurveyNoList[index].passbooKNO,
                                                                          landownerName:
                                                                              tenantSurveyNoList[index].landOwnerName,
                                                                          leaseDoc:
                                                                              tenantSurveyNoList[index].leaseDoc,
                                                                          fromPeriod:
                                                                              tenantSurveyNoList[index].periodFrom,
                                                                          toPeriod:
                                                                              tenantSurveyNoList[index].periodTo,
                                                                          surveyNo:
                                                                              tenantSurveyNoList[index].surveYNO,
                                                                          subDivion:
                                                                              tenantSurveyNoList[index].subDivion,
                                                                          acres:
                                                                              tenantSurveyNoList[index].area,
                                                                          guntas:
                                                                              tenantSurveyNoList[index].guntas,
                                                                          /* removeicons: Icon(Icons
                                                                      .remove_circle_outline), */
                                                                          cardcolor:
                                                                              Colors.white,
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.074,
                                                                          ontap:
                                                                              () {
                                                                            AlertwithTwoButtons().showAlert(
                                                                                context: context,
                                                                                message: "Are you sure you want to delete this survey number?",
                                                                                onYesPressed: () {
                                                                                  setState(() {
                                                                                    tenantSurveyNoList.removeAt(index);
                                                                                  });
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                onNoPressed: () {
                                                                                  Navigator.pop(context);
                                                                                });
                                                                          },
                                                                          borderradius:
                                                                              BorderRadius.circular(0),
                                                                        );
                                                                      }),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),

                  //Farm Labour
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
                              groupValue:
                                  rythuBharosaProvider.selectedFarmLabourType,
                              onChanged:
                                  editFlags?.cooliE12000?.toLowerCase() == "y"
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
                              groupValue:
                                  rythuBharosaProvider.selectedFarmLabourType,
                              onChanged:
                                  editFlags?.cooliE12000?.toLowerCase() == "y"
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

                        //House hold with any agriculture land
                        Text("houseHoldWithAgricultureLand".tr()),
                        Row(
                          children: [
                            Radio(
                              value: 'Y',
                              groupValue: rythuBharosaProvider
                                  .selectedAnyHouseholdWithLandType,
                              onChanged: (value) {
                                rythuBharosaProvider.changeAnyHouseholdWithLand(
                                    value.toString());
                                rythuBharosaProvider.passbookHouseholdController
                                    .clear();
                              },
                            ),
                            Text("Yes".tr()),
                            Radio(
                              value: 'N',
                              groupValue: rythuBharosaProvider
                                  .selectedAnyHouseholdWithLandType,
                              onChanged: (value) {
                                rythuBharosaProvider.changeAnyHouseholdWithLand(
                                    value.toString());
                                houseHoldWithAgricultureList = [];
                                setState(() {});
                              },
                            ),
                            Text("No".tr()),
                          ],
                        ),

                        //house hold having agriculture land
                        if (rythuBharosaProvider
                                .selectedAnyHouseholdWithLandType ==
                            'Y')
                          Row(
                            children: [
                              Expanded(
                                child: ReusableTextFormField(
                                    maxLength: rythuBharosaProvider
                                            .passbookHouseholdController.text
                                            .startsWith('R')
                                        ? 16
                                        : 12,
                                    onChanged: (p0) {
                                      rythuBharosaProvider
                                          .passbookHouseholdController
                                          .text = p0;
                                      setState(() {});
                                    },
                                    controller: rythuBharosaProvider
                                        .passbookHouseholdController,
                                    keyboardType: TextInputType.text,
                                    readOnly: false,
                                    labelText: "pattadharPassbookNumber".tr()),
                              ),

                              ReusableNoWidthButton(
                                ButtonText: "Add".tr(),
                                onPressed: () {
                                  if (rythuBharosaProvider.validateFields(
                                      context,
                                      rythuBharosaProvider
                                          .passbookHouseholdController.text)) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            return AlertDialog(
                                              content: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Column(
                                                  children: [
                                                    ReusableTextFormField(
                                                      controller:
                                                          rythuBharosaProvider
                                                              .surveyNoHouseholdController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      readOnly: false,
                                                      labelText:
                                                          "surveyNo".tr(),
                                                      maxLength: 50,
                                                    ),
                                                    ReusableTextFormField(
                                                      controller:
                                                          rythuBharosaProvider
                                                              .areaAcresHouseholdController,
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(r'^\d+(\.(3[0-9]|[0-2]?\d)?)?$')
),
                                                            /* RegExp(
                                                                r'^\d+\.?\d{0,2}') */ 
                                                               
                                                      ],
                                                      readOnly: false,
                                                      labelText: "Total Extent",
                                                      maxLength: 10,
                                                    ),
                                                    /*  Row(
                                                      children: [
                                                        Expanded(
                                                          child: ReusableTextFormField(
                                                              controller:
                                                                  rythuBharosaProvider
                                                                      .areaAcresHouseholdController,
                                                              readOnly: false,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .phone,
                                                              maxLength: 3,
                                                              labelText:
                                                                  "Acres".tr()),
                                                        ),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01),
                                                        Expanded(
                                                          child: ReusableTextFormField(
                                                              controller:
                                                                  rythuBharosaProvider
                                                                      .areaGuntasHouseholsController,
                                                              readOnly: false,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .phone,
                                                              maxLength: 2,
                                                              labelText:
                                                                  "Guntas"
                                                                      .tr()),
                                                        ),
                                                      ],
                                                    ), */
                                                    ReusableNoWidthButton(
                                                      ButtonText:
                                                          "Add Land Details",
                                                      onPressed: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        if (rythuBharosaProvider
                                                                .surveyNoHouseholdController
                                                                .text
                                                                .isNotEmpty &&
                                                            rythuBharosaProvider
                                                                .areaAcresHouseholdController
                                                                .text
                                                                .isNotEmpty) {
                                                          houseHoldWithAgricultureList
                                                              .add(
                                                            OwneRDTLS(
                                                              passbooKNO:
                                                                  rythuBharosaProvider
                                                                      .passbookHouseholdController
                                                                      .text
                                                                      .trim(),
                                                              surveYNO:
                                                                  rythuBharosaProvider
                                                                      .surveyNoHouseholdController
                                                                      .text
                                                                      .trim(),
                                                              area: rythuBharosaProvider
                                                                  .areaAcresHouseholdController
                                                                  .text
                                                                  .trim(),
                                                              guntas: rythuBharosaProvider
                                                                  .areaGuntasHouseholsController
                                                                  .text
                                                                  .trim(),
                                                              subDivion:
                                                                  rythuBharosaProvider
                                                                      .subDivisionHouseholdController
                                                                      .text
                                                                      .trim(),
                                                            ),
                                                          );
                                                          rythuBharosaProvider
                                                              .passbookHouseholdController
                                                              .clear();
                                                          rythuBharosaProvider
                                                              .surveyNoHouseholdController
                                                              .clear();
                                                          rythuBharosaProvider
                                                              .areaAcresHouseholdController
                                                              .clear();

                                                          Navigator.pop(
                                                              context);
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
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              )
                              //: SizedBox(),
                            ],
                          ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),

                        if (rythuBharosaProvider
                                .selectedAnyHouseholdWithLandType ==
                            'Y')
                          Card(
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppAssets.appBg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                children: [
                                  houseHoldWithAgricultureList.length != 0
                                      ? Column(
                                          children: [
                                            TableFourColumnReusable(
                                              serialNumber: "S.No".tr(),
                                              entredField1: "Passbook No".tr(),
                                              entredField2: "Survey No".tr(),
                                              entredField3: "Total Extent".tr(),
                                              removeicons: Text(""),
                                              cardcolor: Colors.grey[200],
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.074,
                                              ontap: () {},
                                              borderradius:
                                                  BorderRadius.circular(0),
                                            ),
                                            /*  TableFiveColumnReusableNew(
                                              serialNumber: "".tr(),
                                              entredField1: "".tr(),
                                              entredField2: "".tr(),
                                              entredField3: "".tr(),
                                              entredField4: "acres".tr(),
                                              entredField5: "guntas".tr(),
                                              ExtendFlag: true,
                                              iconFlag: false,
                                              //
                                              //removeicons: Icon(Icons.remove_circle_outline),
                                              cardcolor: Colors.grey[200],
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.074,
                                              ontap: () {},
                                              borderradius:
                                                  BorderRadius.circular(0),
                                            ), */
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1.75,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          houseHoldWithAgricultureList
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return TableFourColumnReusable(
                                                          serialNumber:
                                                              (index + 1)
                                                                  .toString(),
                                                          entredField1:
                                                              houseHoldWithAgricultureList[
                                                                          index]
                                                                      .passbooKNO ??
                                                                  "",
                                                          entredField2:
                                                              houseHoldWithAgricultureList[
                                                                          index]
                                                                      .surveYNO ??
                                                                  "",
                                                          entredField3:
                                                              houseHoldWithAgricultureList[
                                                                          index]
                                                                      .area ??
                                                                  "",
                                                          removeicons: Icon(
                                                            Icons
                                                                .remove_circle_outline,
                                                            color: Colors.red,
                                                          ),
                                                          cardcolor:
                                                              Colors.white,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.074,
                                                          ontap: () {
                                                            AlertwithTwoButtons()
                                                                .showAlert(
                                                                    context:
                                                                        context,
                                                                    message:
                                                                        "Are you sure you want to delete this passbook number?",
                                                                    onYesPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        houseHoldWithAgricultureList
                                                                            .removeAt(index);
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    onNoPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    });
                                                          },
                                                          borderradius:
                                                              BorderRadius
                                                                  .circular(0),
                                                        );
                                                        /* TableFiveColumnReusableNew(
                                                          ExtendFlag: true,
                                                          iconFlag: true,
                                                          serialNumber:
                                                              (index + 1)
                                                                  .toString(),
                                                          entredField1:
                                                              houseHoldWithAgricultureList[
                                                                      index]
                                                                  .passbooKNO,
                                                          entredField2:
                                                              houseHoldWithAgricultureList[
                                                                      index]
                                                                  .surveYNO,
                                                          entredField3:
                                                              houseHoldWithAgricultureList[
                                                                      index]
                                                                  .area,
                                                          entredField4:
                                                              houseHoldWithAgricultureList[
                                                                      index]
                                                                  .subDivion,
                                                          entredField5:
                                                              houseHoldWithAgricultureList[
                                                                      index]
                                                                  .guntas,
                                                          /* removeicons: Icon(Icons
                                                                  .remove_circle_outline), */
                                                          cardcolor:
                                                              Colors.white,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.074,
                                                          ontap: () {
                                                            AlertwithTwoButtons()
                                                                .showAlert(
                                                                    context:
                                                                        context,
                                                                    message:
                                                                        "Are you sure you want to delete this survey number?",
                                                                    onYesPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        houseHoldWithAgricultureList.removeAt(index);
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    onNoPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    });
                                                          },
                                                          borderradius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0),
                                                        ); */
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),

                        if (rythuBharosaProvider.selectedFarmLabourType == "Y")
                          Column(
                            children: [
                              ReusableTextFormField(
                                controller: rythuBharosaProvider
                                    .registeredWageSeekerController,
                                keyboardType: TextInputType.phone,
                                readOnly: false,
                                labelText: "registeredWageSeekers".tr(),
                                maxLength: 50 ,
                              ),
                              if (rythuBharosaProvider.selectedFarmLabourType ==
                                  'Y')
                                ReusableTextFormField(
                                  prefixText: rythuBharosaProvider.prefixText,
                                  prefixStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                  controller:
                                      rythuBharosaProvider.jobCardcontroller,
                                      
                                  maxLength:
                                      applicantDetails?.jobcardmaxl ?? 17,
                                  readOnly:
                                      (editFlags?.jobcarDNO?.toLowerCase() ==
                                                  "y" ||
                                              applicantDetails?.jobcardflg
                                                      ?.toLowerCase() !=
                                                  "y")
                                          ? true
                                          : false,
                                  labelText: "employmentJobCardNo".tr(),
                                  inputFormatters: [],
                                ),
                              ReusableTextFormField(
                                controller: rythuBharosaProvider
                                    .noOfWageSeekerController,
                                keyboardType: TextInputType.phone,
                                readOnly: false,
                                labelText:
                                    "noOfwageSeekersWorkedintheYaer".tr(),
                              ),
                              ReusableTextFormField(
                                controller: rythuBharosaProvider
                                    .totalDaysWorkedController,
                                keyboardType: TextInputType.phone,
                                readOnly: false,
                                labelText: "totaldaysworkedinTheFY".tr(),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  /*  editableRythuFlag == false
                      ? */
                  Align(
                    alignment: Alignment.center,
                    child: ReusableButton(
                      onPressed: () async {
                        if (rythuBharosaProvider.validatePassbook(
                            context,
                            editFlags,
                            rythuBharosaProvider.selectedFarmerType,
                            rythuBharosaProvider.selectedTenantFarmerType,
                            rythuBharosaProvider
                                .selectedAnyHouseholdWithLandType,
                            passbokkSurveyNoList,
                            tenantSurveyNoList,
                            houseHoldWithAgricultureList,
                            rythuBharosaProvider.jobCardcontroller.text,
                            rythuBharosaProvider.totalDaysWorkedController.text,
                            rythuBharosaProvider
                                .registeredWageSeekerController.text,
                            rythuBharosaProvider.noOfWageSeekerController.text,
                            rythuBharosaProvider
                                .selectedExistingRythuBandhuBenficiary,
                            rythuBharosaProvider.selectedFarmLabourType,
                            applicantDetails)) {
                          final surveyListMdl = surveyNoList
                              .map((e) => SurveyListMdl(
                                  area: areaAcresList[surveyNoList.indexOf(e)],
                                  guntas:
                                      areaGuntasList[surveyNoList.indexOf(e)],
                                  surveYNO: e))
                              .toList();
                          final passbookListMdl = passbookList
                              .map(
                                (e) => PassbookListMdl(
                                    passbooKNO: e,
                                    offlinEAPPLICATIONNO: rythuBarosaDetails
                                        ?.passbookListMdl
                                        ?.first
                                        .offlinEAPPLICATIONNO,
                                    onlinEAPPLICATIONNO: rythuBarosaDetails
                                        ?.passbookListMdl
                                        ?.first
                                        .onlinEAPPLICATIONNO),
                              )
                              .toList();

                          rythuBharosaProvider.setIsLoadingStatus(true);

                          await rythuBharosaProvider.onSaveClick(
                              context: context,
                              farmerType:
                                  rythuBharosaProvider.selectedFarmerType,
                              farmer1500:
                                  rythuBharosaProvider.selectedFarmerType,
                              tenantFarmerType:
                                  rythuBharosaProvider.selectedTenantFarmerType,
                              farmLabourType:
                                  rythuBharosaProvider.selectedFarmLabourType,
                              surveyListMdl: surveyListMdl,
                              passbookListMdl: passbookListMdl,
                              jobCardNumber:
                                  rythuBharosaProvider.jobCardcontroller.text,
                              passbokkSurveyNoList: passbokkSurveyNoList,
                              tenantSurveyNoList: tenantSurveyNoList,
                              existingRythuBandhuBenficiary:
                                  rythuBharosaProvider
                                      .selectedExistingRythuBandhuBenficiary,
                              anyHouseholdWithLandType: rythuBharosaProvider
                                  .selectedAnyHouseholdWithLandType,
                              registeredWageSeeker: rythuBharosaProvider
                                  .registeredWageSeekerController.text,
                              noOfWageSeeker: rythuBharosaProvider
                                  .noOfWageSeekerController.text,
                              totalDaysWorked: rythuBharosaProvider
                                  .totalDaysWorkedController.text,
                              houseHoldWithAgricultureList:
                                  houseHoldWithAgricultureList,
                              noOfWageSeekerFY: rythuBharosaProvider
                                  .noOfWageSeekerController.text,
                              registeredWageSeekerJobCard: rythuBharosaProvider
                                  .registeredWageSeekerController.text,
                              totalDaysWorkedFY: rythuBharosaProvider
                                  .totalDaysWorkedController.text);
                          rythuBharosaProvider.setIsLoadingStatus(false);
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
                        }
                      },
                      ButtonText: 'SAVE',
                    ),
                  )
                  //: SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

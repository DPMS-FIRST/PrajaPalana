import 'package:flutter/cupertino.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/models/master_data/master_geograpics_response.dart';
import 'package:praja_palana/res/CustomAlerts/alert_with_twobuttons.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/dropdown_resuable.dart';
import 'package:praja_palana/res/reusable_widgets/mahalaxmi_selected_family_table.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_button_wrapped_width.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/dashboard_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/application_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/family_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/mahaLakshmiSchemeViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class MahaLakshmiScheme extends StatefulWidget {
  const MahaLakshmiScheme({super.key});

  @override
  State<MahaLakshmiScheme> createState() => _MahaLakshmiSchemeState();
}

class _MahaLakshmiSchemeState extends State<MahaLakshmiScheme> {
  List<Gascompanies?> gasList = [];
  MahalakshmiEdit? editFalgs;
  MahalakshmiMdl? mahalakshmiDetails;
  Gascompanies? selectedGasCompanies;
  FamilyListMdl? familyListMdl;
  List<FamilyListMdl> familyList = [];
  List<FamilyListMdl> FemaleList = [];
  List<FamilyListMdl> NewList = [];
  bool nameFlag = false;
  //int? selectedID;
  // String? selectedName;

  @override
  Widget build(BuildContext context) {
    final mahaLakshmiProvider =
        Provider.of<MahaLakshmiSchemeViewModel>(context);
    final editableMahalakshmiFlag =
        ModalRoute.of(context)?.settings.arguments as bool;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          /*  BackAlert().showAlert(
            context: context,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(SharedPrefConstants.mahalakshmiDetailsData);
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
              title: "mahaLakshmiScheme".tr(),
              onPressedHome: () {
                Navigator.pushNamed(context, AppRoutes.applicantDashboard);
              },
              onPressedBack: () {
                /* BackAlert().showAlert(
                  context: context,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.remove(SharedPrefConstants.mahalakshmiDetailsData);
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ReusableComponents().ApplicationRationAndApplicantName(),
                      //ReusableComponents().officerNameAndApplicationNumber(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("financialAssistance".tr()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue: mahaLakshmiProvider
                                    .selectedMonthlyFinancialHelp,
                                onChanged:
                                    editFalgs?.finhelP2500?.toLowerCase() == "y"
                                        ? (value) {
                                            mahaLakshmiProvider
                                                .changeStatusOfMonthlyFinancialHelp(
                                                    value.toString());
                                          }
                                        : null,
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue: mahaLakshmiProvider
                                    .selectedMonthlyFinancialHelp,
                                onChanged:
                                    editFalgs?.finhelP2500?.toLowerCase() == "y"
                                        ? (value) {
                                            mahaLakshmiProvider
                                                .changeStatusOfMonthlyFinancialHelp(
                                                    value.toString());
                                          }
                                        : null,
                              ),
                              Text("No".tr()),
                            ],
                          ),
                          if (mahaLakshmiProvider
                                  .selectedMonthlyFinancialHelp ==
                              'Y')
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          "Is there any Pensioner Beneficiary"
                                              .toUpperCase())),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                        value: 'Y',
                                        groupValue: mahaLakshmiProvider
                                            .areYouGettingAsara,
                                        onChanged: (value) {
                                          mahaLakshmiProvider
                                              .changeStatusOfAreYouGettingAsara(
                                                  value.toString());
                                        }),
                                    Text("Yes".tr()),
                                    Radio(
                                      value: 'N',
                                      groupValue: mahaLakshmiProvider
                                          .areYouGettingAsara,
                                      onChanged: (value) {
                                        mahaLakshmiProvider
                                            .changeStatusOfAreYouGettingAsara(
                                                value.toString());
                                      },
                                    ),
                                    Text("No".tr()),
                                  ],
                                ),
                                if (mahaLakshmiProvider.areYouGettingAsara ==
                                    'Y')
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, top: 16.0),
                                        child: DropdownTextFormFieldComponent<
                                                Pension>(
                                            labelText: 'Type of pension',
                                            items: mahaLakshmiProvider
                                                .pensionList
                                                .map((Pension? option) {
                                              return DropdownMenuItem<Pension>(
                                                value: option,
                                                child: Text(
                                                    option?.pensioNNAME ?? ''),
                                              );
                                            }).toList(),
                                            onChanged: (Pension? newValue) {
                                              print(
                                                  "selected penison type ${newValue}");
                                              mahaLakshmiProvider
                                                  .changePensionType(
                                                      newValue ?? Pension());
                                            },
                                            value: mahaLakshmiProvider
                                                .selectedPensionType),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, top: 16.0),
                                        child: DropdownTextFormFieldComponent(
                                            labelText:
                                                'Select Family Member Getting Asara',
                                            items: FemaleList.map(
                                                (FamilyListMdl? option) {
                                              return DropdownMenuItem<
                                                  FamilyListMdl>(
                                                value: option,
                                                child: Text(option?.name ?? ''),
                                              );
                                            }).toList(),
                                            onChanged:
                                                (FamilyListMdl? newValue) {
                                              setState(() {
                                                familyListMdlPension = newValue;
                                                familyListMdlPension?.id == 0
                                                    ? nameFlag = false
                                                    : nameFlag = true;
                                              });
                                              print(
                                                  "selcted ${newValue?.relation}");
                                            },
                                            value: familyListMdlPension),
                                      ),

                                      // add button

                                      if (FemaleList.length > 1)
                                        ReusableNoWidthButton(
                                          ButtonText: "Add",
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            if (mahaLakshmiProvider.areYouGettingValidateFields(
                                                context,
                                                familyListMdlPension,
                                                mahaLakshmiProvider
                                                    .selectedPensionType,
                                                mahaLakshmiProvider
                                                    .areYouGettingAsara,
                                                FemaleList)) {
                                              if (familyListMdlPension?.name !=
                                                      "Select Family Member Name" &&
                                                  FemaleList.length > 1) {
                                                mahalaxmiSelectedFamilyMemberList
                                                    .add(
                                                  PensionsList(
                                                      familyName:
                                                          familyListMdlPension
                                                              ?.name,
                                                      aadharNo: maskNumber(int.tryParse(
                                                              familyListMdlPension
                                                                      ?.aadhaRNO
                                                                      .toString() ??
                                                                  "") ??
                                                          0),
                                                      familyID:
                                                          familyListMdlPension
                                                              ?.id
                                                              .toString(),
                                                      pensionID:
                                                          mahaLakshmiProvider
                                                              .selectedPensionType
                                                              ?.pensioNID
                                                              .toString()),
                                                );
                                                setState(() {
                                                  FemaleList.remove(
                                                      familyListMdlPension);
                                                  familyListMdlPension =
                                                      FemaleList[0];
                                                });
                                              } else {
                                                ValidationIoSAlert().showAlert(
                                                  context,
                                                  description:
                                                      "No members available to add",
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      if (FemaleList.length > 1)
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                      // table for mahalaxmi selected family member
                                      Card(
                                        elevation: 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:
                                                  AssetImage(AppAssets.appBg),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              mahalaxmiSelectedFamilyMemberList
                                                          .length !=
                                                      0
                                                  ? Column(
                                                      children: [
                                                        MahalaxmiSelectedFamilyTableColumnReusable(
                                                          serialNumber:
                                                              "S.No".tr(),
                                                          entredField1:
                                                              "Name".tr(),
                                                          entredField2:
                                                              "Aadhaar No".tr(),
                                                          removeicons: Text(""),
                                                          cardcolor:
                                                              Colors.grey[200],
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
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1.75,
                                                              child: ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount:
                                                                          mahalaxmiSelectedFamilyMemberList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return MahalaxmiSelectedFamilyTableColumnReusable(
                                                                          serialNumber:
                                                                              (index + 1).toString(),
                                                                          entredField1:
                                                                              mahalaxmiSelectedFamilyMemberList[index].familyName ?? "",
                                                                          entredField2:
                                                                              mahalaxmiSelectedFamilyMemberList[index].aadharNo ?? "",
                                                                          removeicons:
                                                                              Icon(
                                                                            Icons.remove_circle_outline,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                          cardcolor:
                                                                              Colors.white,
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.074,
                                                                          ontap:
                                                                              () {
                                                                            AlertwithTwoButtons().showAlert(
                                                                                context: context,
                                                                                message: "Are you sure you want to delete this member?",
                                                                                onYesPressed: () {
                                                                                  setState(() {
                                                                                    FemaleList.add(familyListBackup.firstWhere((element) => element.name == mahalaxmiSelectedFamilyMemberList[index].familyName));
                                                                                    mahalaxmiSelectedFamilyMemberList.removeAt(index);
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
                                                      ],
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (applicantDetails?.gender != 'F')
                                  /*  FemaleList.length > 1
                                      ? */
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 16.0),
                                    child: DropdownTextFormFieldComponent(
                                        labelText:
                                            'Select Family Member Name_label',
                                        items: NewList.map(
                                            (FamilyListMdl? option) {
                                          return DropdownMenuItem<
                                              FamilyListMdl>(
                                            value: option,
                                            child: Text(option?.name ?? ''),
                                          );
                                        }).toList(),
                                        onChanged: (FamilyListMdl? newValue) {
                                          setState(() {
                                            newfamilyListMdl = newValue;
                                            newfamilyListMdl?.id == 0
                                                ? nameFlag = false
                                                : nameFlag = true;
                                          });
                                          print(
                                              "selcted ${newValue?.relation}");
                                        },
                                        value: newfamilyListMdl),
                                  ),
                                //: Container(),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                (nameFlag && applicantDetails?.gender != 'F')
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                                "Name: ${newfamilyListMdl?.name}"),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            Text(

                                                //  "Aadhaar No: ${familyListMdl?.aadhaRNO}"),
                                                "Aadhaar No: ${maskNumber(int.tryParse(newfamilyListMdl?.aadhaRNO.toString() ?? "") ?? 0)}"),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                /*    if (familyListMdl?.id != 0 &&
                                    familyListMdl?.name == null) ...{
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      children: [
                                        Text("Name: ${familyListMdl?.name}"),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        Text(

                                            //  "Aadhaar No: ${familyListMdl?.aadhaRNO}"),
                                            "Aadhaar No: ${maskNumber(int.tryParse(familyListMdl?.aadhaRNO.toString() ?? "") ?? 0)}"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                }, */
                              ],
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("gasCylinder500".tr()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue: mahaLakshmiProvider
                                    .selectedGasCylinderFor500,
                                onChanged:
                                    editFalgs?.gaS500?.toLowerCase() == "y"
                                        ? (value) {
                                            mahaLakshmiProvider
                                                .changeStatusOfGasCylinder(
                                                    value.toString());
                                          }
                                        : null,
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue: mahaLakshmiProvider
                                    .selectedGasCylinderFor500,
                                onChanged:
                                    editFalgs?.gaS500?.toLowerCase() == "y"
                                        ? (value) {
                                            mahaLakshmiProvider
                                                .changeStatusOfGasCylinder(
                                                    value.toString());
                                          }
                                        : null,
                              ),
                              Text("No".tr()),
                            ],
                          ),
                          if (mahaLakshmiProvider.selectedGasCylinderFor500 ==
                              'Y')
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                children: [
                                  ReusableTextFormField(
                                      controller: mahaLakshmiProvider
                                          .gasConsumerNoController,
                                      keyboardType: TextInputType.phone,
                                      maxLength:
                                          applicantDetails?.gasmaxl ?? 50,
                                      readOnly: (editFalgs?.gaSCONNECTIONNO
                                                      ?.toLowerCase() ==
                                                  "y" ||
                                              editableMahalakshmiFlag ==
                                                  false ||
                                              applicantDetails?.gasflg == 'N')
                                          ? true
                                          : false,
                                      labelText: "gasConsumerNo".tr()),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: DropdownTextFormFieldComponent(
                                        hintText: AppStrings.select_gas_name,
                                        labelText:
                                            "2.2 Select Gas Company Name",
                                        items:
                                            gasList.map((Gascompanies? option) {
                                          return DropdownMenuItem<Gascompanies>(
                                            value: option,
                                            child: Text(option?.gasname ?? ''),
                                          );
                                        }).toList(),
                                        onChanged: (editFalgs?.gaSCOMPANYNAME
                                                        ?.toLowerCase() ==
                                                    "y" ||
                                                editableMahalakshmiFlag == true)
                                            ? null /* (Gascompanies? newValue) {
                                                setState(() {
                                                  selectedGasCompanies =
                                                      newValue;
                                                  // grievanceSubIssueTypeData = newValue;
                                                });
                                              } */
                                            : null,
                                        value: selectedGasCompanies),
                                  ),
                                  // ReusableTextFormField(
                                  //     controller: mahaLakshmiProvider
                                  //         .gasSupplyingCompanycontroller,
                                  //     labelText: "gasSupplyingAgency".tr()),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  ReusableTextFormField(
                                      controller: mahaLakshmiProvider
                                          .cylindersCountcontroller,
                                      readOnly: editFalgs?.nOOFCYLINDERS
                                                  ?.toLowerCase() ==
                                              "y"
                                          ? false
                                          : true,
                                      labelText: "noOfGasCylinders".tr())
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                            ),
                          // eligible and not eligible
                        ],
                      ),
                      mahaLakshmiProvider.selectedMonthlyFinancialHelp == "Y" ||
                              editableMahalakshmiFlag
                          ? ReusableButton(
                              onPressed: () async {
                                /*  PensionsList newData = PensionsList(
                                  familyID: familyListMdlPension?.id.toString(),
                                  pensionID: mahaLakshmiProvider
                                      .selectedPensionType?.pensioNID
                                      .toString(),
                                  familyName: familyListMdlPension?.name,
                                  aadharNo: familyListMdlPension?.aadhaRNO,
                                ); */
                                pensionList = mahalaxmiSelectedFamilyMemberList;
                                //print('Before adding to pensionList: $newData');
                                //pensionList.add(newData);
                                /*  print(
                                    'After adding to pensionList: $pensionList'); */
                                if (mahaLakshmiProvider.validateFinancialHelp(
                                        context,
                                        familyListMdl?.id ?? 0,
                                        applicantDetails?.gender,
                                        FemaleList.length) &&
                                    mahaLakshmiProvider.validateGasCylinder(
                                        context,
                                        selectedGasCompanies,
                                        applicantDetails)) {
                                  await mahaLakshmiProvider.onSaveClick(
                                      context: context,
                                      finhelP2500: mahaLakshmiProvider
                                          .selectedMonthlyFinancialHelp,
                                      gaS500: mahaLakshmiProvider
                                          .selectedGasCylinderFor500,
                                      gaSCOMPANYNAME:
                                          selectedGasCompanies?.gasname ?? '',
                                      gaSCOMPANYNAMEOTHER: mahaLakshmiProvider
                                          .gasSupplyingCompanycontroller.text,
                                      gaSCONNECTIONNO: mahaLakshmiProvider
                                          .gasConsumerNoController.text,
                                      nOOFCYLINDERS: mahaLakshmiProvider
                                          .cylindersCountcontroller.text,
                                      familyMemberId: newfamilyListMdl?.id ?? 0,
                                      pensionList: pensionList);
                                  // mahaLakshmiProvider.setIsLoadingStatus(false);
                                  SuccessCustomCupertinoAlert().showAlert(
                                      context: context,
                                      title: "Data Saved Successfully".tr(),
                                      onPressed: () {
                                        Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(
                                                AppRoutes.applicantDashboard));
                                        /*  Navigator.pushNamed(context,
                                              AppRoutes.applicantDashboard); */
                                      });
                                }
                              },
                              ButtonText: 'SAVE',
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (mahaLakshmiProvider.getIsLoadingStatus) LoaderComponent()
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

  String maskNumber(int number) {
    String numberString = number.toString();

    // Check if the number has more than two digits
    if (numberString.length > 4) {
      // Mask all digits except the last two
      String maskedPart = 'X' * (numberString.length - 4);

      // Extract the last two digits
      String lastTwoDigits = numberString.substring(numberString.length - 4);

      // Combine the masked part with the last two digits
      return maskedPart + lastTwoDigits;
    } else {
      // If the number has two or fewer digits, show the number as is
      return numberString;
    }
  }

  List<Cheyutha> cheyuthaSubSchemes = [];
  PersonalDtlsMdl? applicantDetails;

  List<FamilyListMdl> familyListBackup = [];
  List<PensionsList> mahalaxmiSelectedFamilyMemberList = [];

  FamilyListMdl? familyListMdlPension;
  FamilyListMdl? newfamilyListMdl;
  List<PensionsList> pensionList = [];
  @override
  void initState() {
    super.initState();
    //  selectedUnit = unitsList[0];
    print("@@@@");
    final dashboardViewmodel =
        Provider.of<DashboardViewModel>(context, listen: false);
    // final cheyuthaSchemeViewModel =
    //     Provider.of<CheyuthaSchemeViewModel>(context, listen: false);
    final mahalaskhmiProvider =
        Provider.of<MahaLakshmiSchemeViewModel>(context, listen: false);
    final familyProvider =
        Provider.of<FamilyDetailsViewModel>(context, listen: false);
    final applicationDetailsProvider =
        Provider.of<ApplicantDetailsViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await cheyuthaSchemeViewModel.getCheyuthaSchemeDetails(context);
      await mahalaskhmiProvider.getPensionDetails(context);
      gasList.insert(
          0, Gascompanies(gasname: AppStrings.select_gas_name, id: "0"));

      gasList.addAll(dashboardViewmodel.getDbGastList ?? []);
      mahalaskhmiProvider.getConfigurableFlags().then((value) async {
        setState(() {
          editFalgs = value;
        });
      });
      applicationDetailsProvider.getApplicationDetails().then((value) async {
        applicantDetails = value;
        print("applicantDetails ${applicantDetails?.gender}");
        setState(() {});
      });
      familyProvider.getFamilyData().then((value) async {
        setState(() {
          familyList.addAll(value);
          FemaleList =
              familyList.where((element) => element.gender == "F").toList();
          familyListBackup =
              familyList.where((element) => element.gender == "F").toList();

          FemaleList.insert(
              0, FamilyListMdl(name: AppStrings.select_name, id: 0));
          familyListBackup.insert(
              0, FamilyListMdl(name: AppStrings.select_name, id: 0));
          //familyListMdlPension = familyListBackup[0];
        });
        NewList = familyListBackup;
        newfamilyListMdl = NewList[0];

        familyListMdlPension = FemaleList[0];

        print("FemaleList len ${FemaleList.length}");
      });

      // if (mahalaskhmiProvider.isMahalakshmiDetailsFlag == true) {
      mahalaskhmiProvider.getMahalakshmiDetails().then((value) async {
        mahalakshmiDetails = value;
        print(
            "mahalakshmiDetails @@@@@@@@@@@@@@@@@@@@@@ ${mahalakshmiDetails?.toJson()}");
        setState(() {
          mahalaskhmiProvider.selectedMonthlyFinancialHelp =
              mahalakshmiDetails?.finhelP2500 ?? '';
          mahalaskhmiProvider.selectedGasCylinderFor500 =
              mahalakshmiDetails?.gaS500 ?? '';
          //Getting bad element state and previously selected values are not being set when this issue arises thus checking if empty and null and then setting the value
          if (mahalakshmiDetails?.gaSCOMPANYNAME != null &&
              mahalakshmiDetails?.gaSCOMPANYNAME != '' &&
              mahalakshmiDetails?.gaSCOMPANYNAME != '0') {
            selectedGasCompanies = gasList.firstWhere((element) =>
                element?.gasname == (mahalakshmiDetails?.gaSCOMPANYNAME));
          } else {
            selectedGasCompanies = gasList[0];
          }
          mahalaxmiSelectedFamilyMemberList =
              mahalakshmiDetails?.listPensions?.map((e) {
                    return PensionsList(
                        familyName: e.familyName,
                        aadharNo: e.aadharNo,
                        familyID: e.familyID,
                        pensionID: e.pensionID);
                  }).toList() ??
                  [];

          mahalaskhmiProvider.gasConsumerNoController.text =
              mahalakshmiDetails?.gaSCONNECTIONNO ?? '';
          mahalaskhmiProvider.gasSupplyingCompanycontroller.text =
              mahalakshmiDetails?.gaSCOMPANYNAME ?? '';
          mahalaskhmiProvider.cylindersCountcontroller.text =
              mahalakshmiDetails?.nOOFCYLINDERS ?? '';
          mahalaskhmiProvider.areYouGettingAsara =
              mahalakshmiDetails?.pensionType ?? '';
          mahalaskhmiProvider.addAsaraInitially(mahalakshmiDetails);
          mahalaskhmiProvider.addPensionDataInitially(mahalakshmiDetails);
          (mahalakshmiDetails?.selecteDUSERID == null ||
                  mahalakshmiDetails?.selecteDUSERID == '')
              ? familyListMdl = FemaleList[0]
              : familyListMdl = FemaleList.firstWhere(
                  (element) =>
                      element.id ==
                      int.tryParse(mahalakshmiDetails?.selecteDUSERID ?? ''),
                );
        });
      });

      setState(() {});
    });
  }
}

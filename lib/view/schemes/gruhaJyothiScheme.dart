import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/dropdown_resuable.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/dashboard_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/application_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/gruhaJyothiSchemeViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class GruhaJyothiScheme extends StatefulWidget {
  const GruhaJyothiScheme({super.key});

  @override
  State<GruhaJyothiScheme> createState() => _GruhaJyothiSchemeState();
}

class _GruhaJyothiSchemeState extends State<GruhaJyothiScheme> {
  List<Electricityunits?> unitsList = [];
  PersonalDtlsMdl? applicantDetails;
  Electricityunits? selectedElectUnit;
  GruhajyothiEdit? gruhajyothiEdit;
  GruhajyothiMdl? gruhajyothiMdl;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dashboardViewmodel =
          Provider.of<DashboardViewModel>(context, listen: false);
      final gruhaJyothiSchemeViewModel =
          Provider.of<GruhaJyothiSchemeViewModel>(context, listen: false);
      final applicantProvider =
          Provider.of<ApplicantDetailsViewModel>(context, listen: false);
      unitsList.insert(
          0, Electricityunits(unitsname: AppStrings.select_unit_name, id: "0"));

      unitsList.addAll(dashboardViewmodel.getDbElectricityList ?? []);
      setState(() {});
      gruhaJyothiSchemeViewModel.getConfigurableGruhaJyothiData().then((value) {
        setState(() {
          gruhajyothiEdit = value;
        });
      });
      gruhaJyothiSchemeViewModel.getGruhaJyothiDetails().then((value) {
        gruhajyothiMdl = value;
        setState(() {
          selectedElectUnit = unitsList.firstWhere((element) =>
              element?.id == gruhajyothiMdl?.electricitYCONSUMPTION);
          gruhaJyothiSchemeViewModel.meterConnectionNoController.text =
              gruhajyothiMdl?.meteRNO ?? "";
        });
      });
      applicantProvider.getApplicationDetails().then((value) {
        setState(() {
          applicantDetails = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final gruhaJyothiProvider =
        Provider.of<GruhaJyothiSchemeViewModel>(context);
    final editableGruhaFlag =
        ModalRoute.of(context)!.settings.arguments as bool;
    print(
        "gruhajyothiEdit?.meteRNO?.toLowerCase() ${gruhajyothiEdit?.meteRNO?.toLowerCase()}");
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          /* BackAlert().showAlert(
            context: context,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(SharedPrefConstants.gruhaJyothiDetailsData);
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
              title: "gruhaJyothiScheme".tr(),
              onPressedHome: () {
                Navigator.pushNamed(context, AppRoutes.applicantDashboard);
              },
              onPressedBack: () {
                /*  BackAlert().showAlert(
                  context: context,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.remove(SharedPrefConstants.gruhaJyothiDetailsData);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ); */
                Navigator.pop(context);
              },
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.appBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    ReusableComponents().ApplicationRationAndApplicantName(),
                    //ReusableComponents().officerNameAndApplicationNumber(),
                    Text("freeElectricityForHouseholds".tr()),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("1.1. "),
                              Expanded(
                                  child: Text(
                                      "monthlyHouseholdElectricityConsumption"
                                          .tr())),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 16.0),
                            child: DropdownTextFormFieldComponent(
                                hintText: AppStrings.select_unit_name,
                                labelText: AppStrings.select_unit_name,
                                items:
                                    unitsList.map((Electricityunits? option) {
                                  return DropdownMenuItem<Electricityunits>(
                                    value: option,
                                    child: Text(option?.unitsname ?? ''),
                                  );
                                }).toList(),
                                onChanged: /*  gruhajyothiEdit
                                                ?.electricitYCONSUMPTION
                                                ?.toLowerCase() ==
                                            "y" ||
                                        editableGruhaFlag == true ||
                                        applicantDetails?.gasflg
                                                ?.toLowerCase() ==
                                            "y"
                                    ? (Electricityunits? newValue) {
                                        setState(() {
                                          selectedElectUnit = newValue;
                                        });
                                      }
                                    : */
                                    null,
                                value: selectedElectUnit),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("1.2. "),
                              Expanded(
                                  child: Text(
                                      "householdElectricityMeterConnectionNo"
                                          .tr())),
                            ],
                          ),
                          ReusableTextFormField(
                              controller: gruhaJyothiProvider
                                  .meterConnectionNoController,
                              maxLength: applicantDetails?.metermaxl ?? 9,
                              readOnly: (gruhajyothiEdit?.meteRNO
                                              ?.toLowerCase() ==
                                          "y" ||
                                      applicantDetails?.gasflg?.toLowerCase() ==
                                          "y")
                                  ? false
                                  : true,
                              labelText: "meterConnectionNo".tr()),
                          /*  Row(
                            children: [
                              Radio(
                                value: 'Y',
                                groupValue: indirammaIndluProvider
                                    .selectedFinancialAssistanceForHouse,
                                onChanged: (value) {
                                  indirammaIndluProvider
                                      .changeStatusOfFinancialHouseAssistance(value!);
                                },
                              ),
                              Text("Yes".tr()),
                              Radio(
                                value: 'N',
                                groupValue: indirammaIndluProvider
                                    .selectedFinancialAssistanceForHouse,
                                onChanged: (value) {
                                  indirammaIndluProvider
                                      .changeStatusOfFinancialHouseAssistance(value!);
                                },
                              ),
                              Text("No".tr()),
                            ],
                          ) */
                        ],
                      ),
                    ),
                    editableGruhaFlag
                        ? ReusableButton(
                            onPressed: () async {
                              gruhaJyothiProvider.setIsLoadingStatus(false);
                              if (gruhaJyothiProvider.validateFields(
                                  context,
                                  selectedElectUnit,
                                  gruhaJyothiProvider
                                      .meterConnectionNoController.text,applicantDetails)) {
                                await gruhaJyothiProvider.onSaveClick(
                                  context: context,
                                  meterConnectionNo: gruhaJyothiProvider
                                      .meterConnectionNoController.text,
                                  selectedElectUnitId:
                                      selectedElectUnit?.id ?? "0",
                                  electricity200:
                                      gruhajyothiMdl?.electricitY200,
                                );

                                gruhaJyothiProvider.setIsLoadingStatus(false);
                                SuccessCustomCupertinoAlert().showAlert(
                                    context: context,
                                    title: "Data Saved Successfully".tr(),
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              AppRoutes.applicantDashboard));
                                      /*  Navigator.pushNamed(
                                        context, AppRoutes.applicantDashboard); */
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
          if (gruhaJyothiProvider.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }
}

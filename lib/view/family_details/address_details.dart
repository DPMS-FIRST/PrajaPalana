/* import 'package:praja_palana/models/applicant_details/applicant_details_response.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/family_details/statelist_model.dart';
import 'package:praja_palana/res/CustomAlerts/back_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/view_model/dashboard_view_model.dart';
import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/view_model/schemesViewModel/address_details_view_model.dart';

import 'package:provider/provider.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  List<Districts?>? districtList = [];
  List<Districts?>? mandalList = [];
  List<Districts?>? panchaayatList = [];
  List<Districts?>? municipalityList = [];
  bool mandalflag = false;
  bool panchayatflag = false;
  bool municipalityflag = false;
  Districts? selectedDistrict;
  Districts? selectedMandal;
  Districts? selectedPanchayat;
  Districts? selectedMunicipality;
  TextEditingController _houseNo = TextEditingController();
  AddressdetailsEdit? EditFlags;
  PersonalDtlsMdl? addressDetails;

  @override
  void initState() {
    super.initState();
    final dashboardViewmodel =
        Provider.of<DashboardViewModel>(context, listen: false);
    final flagProvider =
        Provider.of<AddressDetailsViewModel>(context, listen: false);
    districtList?.insert(
        0,
        Districts(
            districtname: AppStrings.select_dist_name,
            districtid: "0",
            mandalid: "0",
            panchayatid: "0",
            panchayatname: "",
            mandalname: ""));

    districtList?.addAll(dashboardViewmodel.getDbDistrictList ?? []);
    flagProvider.getConfigurableFlags().then((value) {
      EditFlags = value;
    });
    flagProvider.getAddressDetails().then((value) async {
      addressDetails = value;

      _houseNo.text = addressDetails?.housENO ?? "";
      selectedDistrict = districtList?.firstWhere(
          (element) => element?.districtid == addressDetails?.districTID);
      await dashboardViewmodel
          .getMandalDBDetails(selectedDistrict?.districtid ?? "");
      mandalList = [];
      mandalList?.insert(0,
          Districts(mandalname: AppStrings.select_mandal_name, mandalid: ""));

      mandalList?.addAll(dashboardViewmodel.getDbMandalList ?? []);
      mandalflag = true;
      flagProvider.selectedGPOrMunicipality = addressDetails?.gPMUN?[0] ?? "";
      if (addressDetails?.gPMUN == "GP" || addressDetails?.gPMUN == "G") {
        selectedMandal = mandalList?.firstWhere(
            (element) => element?.mandalid == addressDetails?.mandaLID);
        await dashboardViewmodel.getPunchayitDBDetails(
            selectedDistrict?.districtid ?? "", selectedMandal?.mandalid);
        panchaayatList = [];
        panchaayatList?.insert(
            0,
            Districts(
                panchayatname: AppStrings.select_pan_name, panchayatid: ""));

        panchaayatList?.addAll(dashboardViewmodel.getDbPanchayatList ?? []);
        panchayatflag = true;
        selectedPanchayat = panchaayatList?.firstWhere(
            (element) => element?.panchayatid == addressDetails?.panchayaTID);
        municipalityflag = false;
      } else {
        await dashboardViewmodel
            .getMunicipalityDBDetails(selectedDistrict?.districtid ?? "");
        municipalityList = [];
        municipalityList?.insert(0,
            Districts(mandalname: AppStrings.select_mandal_name, mandalid: ""));

        municipalityList
            ?.addAll(dashboardViewmodel.getDbMunicipalityList ?? []);
        municipalityflag = true;
        selectedMunicipality = municipalityList?.firstWhere(
            (element) => element?.ulBCODE == addressDetails?.municipaLID);
        flagProvider.wardNoController.text = addressDetails?.warDNO ?? "";
        mandalflag = false;
        panchayatflag = false;
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewmodel = Provider.of<DashboardViewModel>(context);
    final addressViewModel = Provider.of<AddressDetailsViewModel>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          // BackAlert().showAlert(context: context);
              Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBarComponent(
          title: 'ADDRESS DETAILS'.tr(),
          onPressedHome: () {
            Navigator.pushNamed(context, AppRoutes.applicantDashboard);
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
            child: Column(children: [
              ReusableComponents().officerNameAndApplicationNumber(),
              ReusableTextFormField(
                controller: _houseNo,
                labelText: "HOUSE NO. & STREET".tr(),
                readOnly:
                    EditFlags?.housENO?.toLowerCase() == "y" ? false : true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              selectedDistrict != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<Districts>(
                        value: selectedDistrict,
                        items: districtList?.map((Districts? option) {
                          return DropdownMenuItem<Districts>(
                            value: option,
                            child: Text(option?.districtname ?? ''),
                          );
                        }).toList(),
                        onChanged: EditFlags?.districTID?.toLowerCase() == "y"
                            ? (Districts? newValue) async {
                                setState(() {
                                  selectedDistrict = newValue;
                                });
                                await dashboardViewmodel.getMandalDBDetails(
                                    selectedDistrict?.districtid ?? "");
                                mandalList = [];
                                mandalList?.insert(
                                    0,
                                    Districts(
                                        mandalname:
                                            AppStrings.select_mandal_name,
                                        mandalid: ""));

                                mandalList?.addAll(
                                    dashboardViewmodel.getDbMandalList ?? []);
                                mandalflag = true;
                                setState(() {});
                              }
                            : null,
                        hint: Text(AppStrings.select_dist_name),
                        decoration: InputDecoration(
                          labelText: selectedDistrict?.districtname.toString(),
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    )
                  : Container(),

              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'G',
                        groupValue: addressViewModel.selectedGPOrMunicipality,
                        onChanged: EditFlags?.gPMUN?.toLowerCase() == "y"
                            ? (value) {
                                addressViewModel
                                    .changeGPOrMunicipality(value.toString());
                              }
                            : null,
                      ),
                      Text("Gram Panchayat".tr()),
                      Radio(
                        value: 'M',
                        groupValue: addressViewModel.selectedGPOrMunicipality,
                        onChanged: EditFlags?.gPMUN?.toLowerCase() == "y"
                            ? (value) {
                                addressViewModel
                                    .changeGPOrMunicipality(value.toString());
                                setState(() {
                                  municipalityflag = true;
                                });
                              }
                            : null,
                      ),
                      Text("Municipality".tr()),
                    ],
                  ),
                  if (addressViewModel.selectedGPOrMunicipality == 'GP' ||
                      addressViewModel.selectedGPOrMunicipality == 'G')
                    Column(
                      children: [
                        //GP Mandal
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015),
                        Visibility(
                          visible: mandalflag,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<Districts>(
                              value: selectedMandal,
                              items: mandalList?.map((Districts? option) {
                                return DropdownMenuItem<Districts>(
                                  value: option,
                                  child: Text(option?.mandalname ?? ''),
                                );
                              }).toList(),
                              onChanged: EditFlags?.mandaLID?.toLowerCase() ==
                                      "y"
                                  ? (Districts? newValue) async {
                                      setState(() {
                                        selectedMandal = newValue;
                                      });
                                      await dashboardViewmodel
                                          .getPunchayitDBDetails(
                                              selectedDistrict?.districtid ??
                                                  "",
                                              selectedMandal?.mandalid);
                                      panchaayatList = [];
                                      panchaayatList?.insert(
                                          0,
                                          Districts(
                                              panchayatname:
                                                  AppStrings.select_pan_name,
                                              panchayatid: ""));

                                      panchaayatList?.addAll(dashboardViewmodel
                                              .getDbPanchayatList ??
                                          []);
                                      panchayatflag = true;
                                      setState(() {});
                                    }
                                  : null,
                              hint: Text(AppStrings.select_mandal_name),
                              decoration: InputDecoration(
                                labelText:
                                    selectedMandal?.mandalname.toString(),
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: panchayatflag,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<Districts>(
                              value: selectedPanchayat,
                              items: panchaayatList?.map((Districts? option) {
                                return DropdownMenuItem<Districts>(
                                  value: option,
                                  child: Text(option?.panchayatname ?? ''),
                                );
                              }).toList(),
                              onChanged:
                                  EditFlags?.panchayaTID?.toLowerCase() == "y"
                                      ? (Districts? newValue) async {
                                          setState(() {
                                            selectedPanchayat = newValue;
                                          });
                                        }
                                      : null,
                              hint: Text(AppStrings.select_pan_name),
                              decoration: InputDecoration(
                                labelText:
                                    selectedPanchayat?.panchayatname.toString(),
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (addressViewModel.selectedGPOrMunicipality == 'M')
                    Column(
                      children: [
                        //GP Mandal
                        Visibility(
                          visible: municipalityflag,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<Districts>(
                              value: selectedMunicipality,
                              items: municipalityList?.map((Districts? option) {
                                return DropdownMenuItem<Districts>(
                                  value: option,
                                  child: Text(option?.municipalitYNAME ?? ''),
                                );
                              }).toList(),
                              onChanged:
                                  EditFlags?.municipaLID?.toLowerCase() == "y"
                                      ? (Districts? newValue) {
                                          setState(() {
                                            selectedMunicipality = newValue;
                                            // grievanceSubIssueTypeData = newValue;
                                          });
                                        }
                                      : null,
                              hint: Text(AppStrings.select_municipality_name),
                              decoration: InputDecoration(
                                labelText: "Municipality".tr(),
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),

                        //Ward Number
                        ReusableTextFormField(
                            controller: addressViewModel.wardNoController,
                            readOnly: EditFlags?.warDNO?.toLowerCase() == "y"
                                ? false
                                : true,
                            labelText: "wardNo".tr()),
                      ],
                    ),
                ],
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       "DISTRICT".tr(),
              //       style: TextStyle(
              //           color: AppColors.black, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // DropdownTextFormField<StatestList>(
              //   //label: "DISTRICT".tr(),
              //   items: statesList.map((StatestList district) {
              //     return DropdownMenuItem<StatestList>(
              //       value: district,
              //       child: Text(district.stateId.toString(),
              //           textAlign: TextAlign.left),
              //     );
              //   }).toList(),
              //   onChanged: (StatestList? newValue) {
              //     if (newValue != null) {
              //       setState(() {
              //         selectedState = newValue;
              //       });
              //     }
              //   },
              //   value: selectedState,
              //   isEnabled: selectedState != null,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       "GRAMA PANCHAYAT / MUNICIPALITY".tr(),
              //       style: TextStyle(
              //           color: AppColors.black, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // DropdownTextFormField<StatestList>(
              //   //label: "GRAMA PANCHAYAT / MUNICIPALITY".tr(),
              //   items: statesList.map((StatestList district) {
              //     return DropdownMenuItem<StatestList>(
              //       value: district,
              //       child: Text(district.stateId.toString(),
              //           textAlign: TextAlign.left),
              //     );
              //   }).toList(),
              //   onChanged: (StatestList? newValue) {
              //     if (newValue != null) {
              //       setState(() {
              //         selectedState = newValue;
              //       });
              //     }
              //   },
              //   value: selectedState,
              //   isEnabled: selectedState != null,
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       "WARD NO".tr(),
              //       style: TextStyle(
              //           color: AppColors.black, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // DropdownTextFormField<StatestList>(
              //   //label: "WARD NO".tr(),
              //   items: statesList.map((StatestList district) {
              //     return DropdownMenuItem<StatestList>(
              //       value: district,
              //       child: Text(district.stateId.toString(),
              //           textAlign: TextAlign.left),
              //     );
              //   }).toList(),
              //   onChanged: (StatestList? newValue) {
              //     if (newValue != null) {
              //       setState(() {
              //         selectedState = newValue;
              //       });
              //     }
              //   },
              //   value: selectedState,
              //   isEnabled: selectedState != null,
              // ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       "MANDAL".tr(),
              //       style: TextStyle(
              //           color: AppColors.black, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // DropdownTextFormField<StatestList>(
              //   //label: "MANDAL".tr(),
              //   items: statesList.map((StatestList district) {
              //     return DropdownMenuItem<StatestList>(
              //       value: district,
              //       child: Text(district.stateId.toString(),
              //           textAlign: TextAlign.left),
              //     );
              //   }).toList(),
              //   onChanged: (StatestList? newValue) {
              //     if (newValue != null) {
              //       setState(() {
              //         selectedState = newValue;
              //       });
              //     }
              //   },
              //   value: selectedState,
              //   isEnabled: selectedState != null,
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),

              ReusableButton(
                onPressed: () {},
                ButtonText: 'SAVE',
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
 */
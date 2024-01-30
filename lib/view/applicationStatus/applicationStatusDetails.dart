import 'package:flutter/material.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/card_reusable.dart';
import 'package:praja_palana/res/reusable_widgets/preview_text_component.dart';
import 'package:praja_palana/res/reusable_widgets/row_component.dart';
import 'package:provider/provider.dart';

import '../../view_model/applicationStatusViewModel/applicationStatusViewModel.dart';

class ApplicationStatusDetails extends StatefulWidget {
  const ApplicationStatusDetails({super.key});

  @override
  State<ApplicationStatusDetails> createState() =>
      _ApplicationStatusDetailsState();
}

class _ApplicationStatusDetailsState extends State<ApplicationStatusDetails> {
  //address details
  // AddressdetailsEdit? addressDetailsEdit;
  // PersonalDtlsMdl? addressDetails;

  String? mandal;
  String? district;

  //family details
  // FamilydetailsEdit? familyDetailsEdit;
  // List<FamilyListMdl>? familyDetails;
  String? familyName;
  String? familyRelation;
  String? familyDob;
  String? familyAadhaar;

  //mahalakshmi
  // MahalakshmiEdit? mahalakshmiEditFalgs;
  // MahalakshmiMdl? mahalakshmiDetails;
  String? selectedMonthlyFinancialHelp;
  String? selectedGasCylinderFor500;
  String? selectedGasCompanies;
  String? gasConsumerNo;
  String? gasSupplyingCompany;
  String? cylindersCount;

  //rythu bharosa
  // RythubharosaEdit? rythuBharosaEditFlags;
  // RaithubharosaMdl? rythuBarosaDetails;
  String? selectedFarmerType;
  String? selectedTenantFarmerType;
  String? selectedFarmLabourType;
  String? jobCardcontroller;

  //gruha jyothi
  // GruhajyothiEdit? gruhaJyothiEditFlags;
  // GruhajyothiMdl? gruhaJyothiDetails;
  String? selectedElectricityFor200;
  String? selectedElectricityConsumption;
  String? selectedMeterNo;

  //indiramma indlu
  // InditammaEdit? indirammaIndluEditFlags;
  // IndirammaIndluMdl? indirammaIndluDetails;

  //cheyutha
  // CheyuthaEdit? cheyuthaEditFlags;
  // CheyuthaMdl? cheyuthaDetails;
  String? selectedToddyTappers;
  String? selectedWeavers;
  String? selectedDialysisPatients;
  String? selectedHivAidsPatients;
  String? selectedBeediWorkers;
  String? selectedFilariaPatients;
  String? selectedSingleWomen;
  String? selectedBeediTekedar;
  String? selectedOthers = "Y";
  String? selectedOldage;
  String? selectedWidow;
  String? selectedCheyutha;
  String? selectedDisabled;
  @override
  Widget build(BuildContext context) {
    final applicationStatusProvider =
        Provider.of<ApplicationStatusViewModel>(context);
    return Scaffold(
      appBar: AppBarComponent(
        title: "Application Details",
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.appBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Applicant Details
              CardReusable(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.applicantDetails,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    RowComponent(
                      title: "Application Number",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.onlinEAPPLICATIONNO}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Name Of The Applicant",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.applicanTNAME}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Gender",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.gender}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Caste",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.caste}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Date Of Birth",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.datEOFBIRTH}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Aadhaar Number",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.aadhaRNO}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Ration Card Number",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.ratioNCARDNO}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Mobile Number",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.mobilENO}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Occupation",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.occupation}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                  ],
                ),
              ),
              //Family Details
              CardReusable(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.familyDetails,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return SizedBox();
                        // final family = familyDetails?[index];
                        // return Card(
                        //   surfaceTintColor: AppColors.white,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     side: BorderSide(
                        //       color: AppColors.appColor,
                        //       width: 1.0,
                        //     ),
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       RowComponent(
                        //         title: "Name",
                        //         value: "${family?.name}",
                        //         titleFlex: 2,
                        //         color: AppColors.appColor,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child: RowComponent(
                        //               title: "Relation",
                        //               value: "${family?.relation}",
                        //               color: AppColors.appColor,
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: RowComponent(
                        //               title: "DOB",
                        //               value: "${family?.datEOFBIRTH}",
                        //               color: AppColors.appColor,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child: RowComponent(
                        //               title: "Aadhaar",
                        //               value: "${family?.aadhaRNO}",
                        //               color: AppColors.appColor,
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: RowComponent(
                        //               title: "Gender",
                        //               value: "${family?.gender}",
                        //               color: AppColors.appColor,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ),

              //Adress Details
              CardReusable(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.addressDetails,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    RowComponent(
                      title: "House No. & Street",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.housENO}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Grama Panchayat/Municipality",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.gPMUN}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Ward No.",
                      value:
                          "${applicationStatusProvider.personalDtlsMdl?.warDNO}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Mandal",
                      value: "${mandal}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "District",
                      value: "${district}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                  ],
                ),
              ),
              //Mahalakshmi Scheme
              CardReusable(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.mahaLakshmiScheme,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextRowComponent(
                      title: "Financial Assistance Of Rs.2500 Per Month :",
                      value: "Yes",
                      color: AppColors.appColor,
                    ),
                    TextRowComponent(
                      title: "Gas Cylinders For Rs.500 :",
                      value: "Yes",
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "a. Consumer Number",
                      value: "123456",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "b. Supplying Company",
                      value: "123456",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "c. Consumed Per Year",
                      value: "123456",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                  ],
                ),
              ),
              //Rythu Bharosa
              CardReusable(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.rythuBharosaScheme,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      surfaceTintColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: AppColors.appColor,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RowComponent(
                                  title: "S.No",
                                  value: "Passbook Details",
                                  valueColor: AppColors.appColor,
                                  color: AppColors.appColor,
                                ),
                              ),
                              Expanded(
                                child: RowComponent(
                                  title: "Survey No",
                                  value: "Area(Acres/Guntas)",
                                  valueColor: AppColors.appColor,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: RowComponent(
                                      title: "${index + 1}",
                                      value: "",
                                      color: AppColors.appColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: RowComponent(
                                      title: "34",
                                      value: "20",
                                      color: AppColors.appColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Gruha Jyothi
              CardReusable(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.gruhaJyothiScheme,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextRowComponent(
                      title:
                          "200 Units Of Electricity For Households Per Month :",
                      value: "${selectedElectricityFor200}",
                      color: AppColors.appColor,
                    ),
                    TextRowComponent(
                      title: "Your Monthly Household Electricity Consumption :",
                      value: "${selectedElectricityConsumption}",
                      color: AppColors.appColor,
                    ),
                    RowComponent(
                      title: "Meter Connection No.",
                      value: "${selectedMeterNo}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                  ],
                ),
              ),

              //Cheyutha
              CardReusable(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.cheyuthaScheme,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    RowComponent(
                      title: "Divyang :",
                      value: "${selectedDisabled}",
                      color: AppColors.appColor,
                    ),
                    // (cheyuthaDetails?.sadaramListMdl?.length != 0 ||
                    //         cheyuthaDetails?.sadaramListMdl != [])
                    //     ?
                    Column(
                      children: [
                        RowComponent(
                          title: "Sadaram Certificate No :",
                          titleFlex: 2,
                          valueFlex: 2,
                          value: "",
                          color: AppColors.appColor,
                        ),
                        Card(
                          surfaceTintColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: AppColors.appColor,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              RowComponent(
                                title: "S.No",
                                value: "Certificate No",
                                color: AppColors.appColor,
                                valueColor: AppColors.appColor,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 1
                                //cheyuthaDetails
                                // ?.sadaramListMdl?.length,
                                ,
                                itemBuilder: (context, index) {
                                  return SizedBox();
                                  // final sadaramListMdl = cheyuthaDetails
                                  //     ?.sadaramListMdl?[index];
                                  // return RowComponent(
                                  //   title: "${index + 1}",
                                  //   value:
                                  //       "${sadaramListMdl?.sadaraMCERTIFICATENO}",
                                  //   color: AppColors.black,
                                  // );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    // : Container()
                    ,
                    RowComponent(
                      title: "Others :",
                      value: "${selectedOthers}",
                      titleFlex: 5,
                      color: AppColors.appColor,
                    ),
                    selectedOthers == "Y"
                        ? Card(
                            surfaceTintColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: AppColors.appColor,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: RowComponent(
                                        title: "S.No",
                                        value: "Category",
                                        color: AppColors.appColor,
                                        valueColor: AppColors.appColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Yes/No",
                                        style: TextStyle(
                                            color: AppColors.appColor),
                                      ),
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    List<String> values = [
                                      "OldAge",
                                      "Widow",
                                      "Toddy Tappers",
                                      "Weavers",
                                      "Dialysis Patients",
                                      "HIV-AIDS Patients",
                                      "Beedi Workers",
                                      "Filaria Patients",
                                      "Single Women",
                                      "Beedi Tekedar",
                                    ];
                                    String categories =
                                        values[index % values.length];
                                    List<String> selectedValues = [
                                      selectedOldage.toString(),
                                      selectedWidow.toString(),
                                      selectedToddyTappers.toString(),
                                      selectedWeavers.toString(),
                                      selectedDialysisPatients.toString(),
                                      selectedHivAidsPatients.toString(),
                                      selectedBeediWorkers.toString(),
                                      selectedFilariaPatients.toString(),
                                      selectedSingleWomen.toString(),
                                      selectedBeediTekedar.toString(),
                                    ];
                                    String selectedCategory = selectedValues[
                                        index % selectedValues.length];
                                    return Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: RowComponent(
                                            title: "${index + 1}",
                                            value: categories,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(selectedCategory),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

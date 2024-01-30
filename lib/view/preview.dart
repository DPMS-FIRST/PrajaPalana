import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/preview_text_component.dart';
import 'package:praja_palana/res/reusable_widgets/row_component.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/view_model/preview_view_model.dart';
import 'package:provider/provider.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  void initState() {
    super.initState();
    final previewViewModel =
        Provider.of<PreviewViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      previewViewModel.setIsLoading(true);
      //applicant details
      await previewViewModel.getApplicationDetails();
      //address details
      await previewViewModel.getAddressDetails();

      //family details
      await previewViewModel.getFamilyDetails();
      //maha lakshmi
      await previewViewModel.getMahalakshmiDetails();
      //rythu bharosa
      await previewViewModel.getRythuBarosaDetails();

      //gruha jyothi
      await previewViewModel.getGruhaJyothiDetails();

      //indiramma indlu
      await previewViewModel.getIndirammaIndluDetails();

      //cheyutha
      await previewViewModel.getCheyuthaDetails();

      previewViewModel.setIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final previewViewModel = Provider.of<PreviewViewModel>(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBarComponent(
            title: "Preview",
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
            child: ListView(
              children: [
                SizedBox(
                  height: 8,
                ),
                Card(
                  surfaceTintColor: AppColors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                            "${previewViewModel.applicantDetails?.onlinEAPPLICATIONNO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Name Of The Applicant",
                        value:
                            "${previewViewModel.applicantDetails?.applicanTNAME}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Gender",
                        value: previewViewModel.applicantDetails?.gender == "M"
                            ? "Male"
                            : previewViewModel.applicantDetails?.gender == "F"
                                ? "Female"
                                : "Others",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Caste",
                        value: "${previewViewModel.applicantDetails?.caste}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Date Of Birth",
                        value:
                            "${previewViewModel.applicantDetails?.datEOFBIRTH}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Aadhaar Number",
                        value: "${previewViewModel.applicantDetails?.aadhaRNO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Ration Card Number",
                        value:
                            "${previewViewModel.applicantDetails?.ratioNCARDNO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Mobile Number",
                        value: "${previewViewModel.applicantDetails?.mobilENO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Occupation",
                        value:
                            "${previewViewModel.applicantDetails?.occupation}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
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
                        value: "${previewViewModel.applicantDetails?.housENO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Grama Panchayat/Municipality",
                        value: "${previewViewModel.applicantDetails?.gPMUN}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Ward No.",
                        value: "${previewViewModel.applicantDetails?.warDNO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Mandal",
                        value: "${previewViewModel.applicantDetails?.mandaLID}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "District",
                        value:
                            "${previewViewModel.applicantDetails?.districTID}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                    ],
                  ),
                ),
                //Family Details
                Card(
                  surfaceTintColor: AppColors.white,
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
                                  flex: 6,
                                  child: RowComponent(
                                    title: "Name",
                                    value: "Relation",
                                    valueColor: AppColors.appColor,
                                    titleFlex: 5,
                                    fontSize: 11,
                                    valueFlex: 12,
                                    color: AppColors.appColor,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      "DOB",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.appColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: RowComponent(
                                    title: "Aadhaar",
                                    value: "Gender",
                                    titleFlex: 3,
                                    fontSize: 11,
                                    valueFlex: 3,
                                    valueColor: AppColors.appColor,
                                    color: AppColors.appColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Divider(
                          color: AppColors.appColor,
                          thickness: 1.0,
                        ),
                      ),
                      (previewViewModel.rythuBarosaDetails?.surveyListMdl
                                      ?.length !=
                                  0 &&
                              previewViewModel.rythuBarosaDetails?.surveyListMdl
                                      ?.length !=
                                  null)
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: previewViewModel.familyData.length,
                              itemBuilder: (context, index) {
                                final family =
                                    previewViewModel.familyData[index];
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: RowComponent(
                                        title: "${family.name}",
                                        value: "${family.relation}",
                                        titleFlex: 5,
                                        fontSize: 11,
                                        valueFlex: 12,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Text(
                                          "${family.datEOFBIRTH}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: RowComponent(
                                        title: "${family.aadhaRNO}",
                                        value: "${family.gender}",
                                        titleFlex: 3,
                                        fontSize: 11,
                                        valueFlex: 3,
                                        // color: AppColors.appColor,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                //Mahalakshmi Scheme
                Card(
                  surfaceTintColor: AppColors.white,
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
                        value:
                            "${previewViewModel.mahalakshmiDetails?.finhelP2500}",
                        color: AppColors.appColor,
                      ),
                      TextRowComponent(
                        title: "Gas Cylinders For Rs.500 :",
                        value: "${previewViewModel.mahalakshmiDetails?.gaS500}",
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "a. Consumer Number",
                        value:
                            "${previewViewModel.mahalakshmiDetails?.gaSCONNECTIONNO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "b. Supplying Company",
                        value:
                            "${previewViewModel.mahalakshmiDetails?.gaSCOMPANYNAME}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "c. Consumed Per Year",
                        value:
                            "${previewViewModel.mahalakshmiDetails?.nOOFCYLINDERS}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                    ],
                  ),
                ),
                //Rythu Bharosa
                Card(
                  surfaceTintColor: AppColors.white,
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
                                  flex: 6,
                                  child: RowComponent(
                                    title: "SNo",
                                    value: "Passbook Details",
                                    valueColor: AppColors.appColor,
                                    titleFlex: 5,
                                    fontSize: 11,
                                    valueFlex: 12,
                                    color: AppColors.appColor,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      "Survey Number",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.appColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: RowComponent(
                                    title: "Area Acres",
                                    value: "Area Guntas",
                                    titleFlex: 3,
                                    fontSize: 11,
                                    valueFlex: 3,
                                    valueColor: AppColors.appColor,
                                    color: AppColors.appColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Divider(
                                color: AppColors.appColor,
                                thickness: 1.0,
                              ),
                            ),
                            (previewViewModel.rythuBarosaDetails?.surveyListMdl
                                            ?.length !=
                                        0 &&
                                    previewViewModel.rythuBarosaDetails
                                            ?.surveyListMdl?.length !=
                                        null)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: previewViewModel
                                        .rythuBarosaDetails
                                        ?.surveyListMdl
                                        ?.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: RowComponent(
                                              title: "${index + 1}",
                                              titleFlex: 5,
                                              fontSize: 11,
                                              valueFlex: 12,
                                              value:
                                                  "${previewViewModel.rythuBarosaDetails?.passbookListMdl?[index].passbooKNO}",
                                              color: AppColors.appColor,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              child: Text(
                                                "${previewViewModel.rythuBarosaDetails?.surveyListMdl?[index].surveYNO}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: RowComponent(
                                              title:
                                                  "${previewViewModel.rythuBarosaDetails?.surveyListMdl?[index].area}",
                                              titleFlex: 3,
                                              fontSize: 11,
                                              valueFlex: 3,
                                              value:
                                                  "${previewViewModel.rythuBarosaDetails?.surveyListMdl?[index].guntas}",
                                              // color: AppColors.appColor,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Indiramma Indlu
                Card(
                  surfaceTintColor: AppColors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppConstants.indirammaIndluScheme,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text("eligibleFamiliesNotOwningHouse".tr()),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RowComponent(
                                    title: "houseFinancialAssistance".tr(),
                                    titleFlex: 10,
                                    value:
                                        "${previewViewModel.indirammaIndluDetails?.finhelPHOME}",
                                    color: AppColors.appColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                      "2. " + "martyrAndUdhyamaKaarulu".tr()),
                                )),
                              ],
                            ),
                            RowComponent(
                              title: "martyrfamily".tr(),
                              titleFlex: 10,
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.martyrSFAMILY}",
                              color: AppColors.appColor,
                            ),
                            RowComponent(
                              title: "Year of Death",
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.martyrSDEATHDATE}",
                              titleFlex: 10,
                              color: AppColors.appColor,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RowComponent(
                                    title:
                                        "telanganaMovementParticipation".tr(),
                                    titleFlex: 10,
                                    value:
                                        "${previewViewModel.indirammaIndluDetails?.activist}",
                                    color: AppColors.appColor,
                                  ),
                                ),
                              ],
                            ),
                            RowComponent(
                              title: "FIR Number",
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.activisTFIRNO}",
                              titleFlex: 10,
                              color: AppColors.appColor,
                            ),
                            RowComponent(
                              title: "FIR Year",
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.activisTFIRYEAR}",
                              titleFlex: 10,
                              color: AppColors.appColor,
                            ),
                            RowComponent(
                              title: "jailTermtitle".tr(),
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.wenTTOJAIL}",
                              titleFlex: 10,
                              color: AppColors.appColor,
                            ),
                            RowComponent(
                              title: "jailname".tr(),
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.jaiLNAME}",
                              titleFlex: 10,
                              color: AppColors.appColor,
                            ),
                            RowComponent(
                              title: "place".tr(),
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.jaiLPLACE}",
                              titleFlex: 10,
                              color: AppColors.appColor,
                            ),
                            RowComponent(
                              title: "imprisonmentdetails".tr(),
                              value:
                                  "${previewViewModel.indirammaIndluDetails?.prisoNPERIODYEAR} years ${previewViewModel.indirammaIndluDetails?.prisoNPERIODMONTH} months ${previewViewModel.indirammaIndluDetails?.prisoNPERIODDAYS} days",
                              titleFlex: 10,
                              color: AppColors.appColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //Gruha Jyothi
                Card(
                  surfaceTintColor: AppColors.white,
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
                        value:
                            "${previewViewModel.gruhaJyothiDetails?.electricitY200}",
                        color: AppColors.appColor,
                      ),
                      TextRowComponent(
                        title:
                            "Your Monthly Household Electricity Consumption :",
                        value:
                            "${previewViewModel.gruhaJyothiDetails?.electricitYCONSUMPTION}",
                        color: AppColors.appColor,
                      ),
                      RowComponent(
                        title: "Meter Connection No.",
                        value:
                            "${previewViewModel.gruhaJyothiDetails?.meteRNO}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                    ],
                  ),
                ),
                //Cheyutha
                Card(
                  surfaceTintColor: AppColors.white,
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
                        value: "${previewViewModel.cheyuthaDetails?.disabled}",
                        color: AppColors.appColor,
                      ),
                      (previewViewModel.cheyuthaDetails?.sadaramListMdl
                                      ?.length !=
                                  0 ||
                              previewViewModel
                                      .cheyuthaDetails?.sadaramListMdl !=
                                  [])
                          ? Column(
                              children: [
                                RowComponent(
                                  title: "Sadarem Certificate No :",
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
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Divider(
                                          color: AppColors.appColor,
                                          thickness: 1.0,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: previewViewModel
                                            .cheyuthaDetails
                                            ?.sadaramListMdl
                                            ?.length,
                                        itemBuilder: (context, index) {
                                          final sadaramListMdl =
                                              previewViewModel.cheyuthaDetails
                                                  ?.sadaramListMdl?[index];
                                          return RowComponent(
                                            title: "${index + 1}",
                                            value:
                                                "${sadaramListMdl?.sadaraMCERTIFICATENO}",
                                            color: AppColors.black,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      RowComponent(
                        title: "Others :",
                        value: "${previewViewModel.cheyuthaDetails?.others}",
                        titleFlex: 5,
                        color: AppColors.appColor,
                      ),
                      previewViewModel.cheyuthaDetails?.others == "Y"
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Divider(
                                      color: AppColors.appColor,
                                      thickness: 1.0,
                                    ),
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
                                        previewViewModel
                                                .cheyuthaDetails?.vrudhapya ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.vitantu ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.geetha ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.chenetha ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.dailisis ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.aids ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.beedi ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.paileria ??
                                            "",
                                        previewViewModel
                                                .cheyuthaDetails?.singlEWOMEN ??
                                            "",
                                        previewViewModel.cheyuthaDetails
                                                ?.beedITEKEDARU ??
                                            "",
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
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        if (previewViewModel.getIsLoading) LoaderComponent()
      ],
    );
  }
}
/* 
SingleChildScrollView(
              child: Column(
                children: [
              

                 
                 

                  
                  
                ],
              ),
            ),
          
 */
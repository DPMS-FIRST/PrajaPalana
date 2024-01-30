import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:praja_palana/view_model/applicant_dashboard_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/view_model/schemesViewModel/application_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/cheyuthaSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/family_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/gruhaJyothiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/indirammaIndluSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/mahaLakshmiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/rythuBharosaSchemeNewViewModel.dart';
import 'package:provider/provider.dart';
import 'package:praja_palana/models/application_search/application_search_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/remarks_model.dart';

class ApplicantDashboard extends StatefulWidget {
  const ApplicantDashboard({super.key});

  @override
  State<ApplicantDashboard> createState() => _ApplicantDashboardState();
}

class _ApplicantDashboardState extends State<ApplicantDashboard> {
  bool checked = false;
  TextEditingController remarks = TextEditingController();
  bool visibility = false;
  List<bool> flagTrue = [];
  List<RemarksData?> remarksList = [];
  RemarksData? selectedRemarks;
  int? selectedRemarksId;
  int? iddVal;
  bool enableControls = false;

  bool? cheyuthaFlag;

  @override
  void initState() {
    super.initState();
    ApplicationStatus? dashboardData = AppConstants.RemarksdDropdownList;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dashboardViewModel =
          Provider.of<ApplicantDashboardViewModel>(context, listen: false);
      /* final dashboardData =
          ModalRoute.of(context)?.settings.arguments as ApplicationStatus; */
      final rythuBharosaSchemeNewViewModel =
          Provider.of<RythuBharosaSchemeNewViewModel>(context, listen: false);
      final mahaLakshmiSchemeViewModel =
          Provider.of<MahaLakshmiSchemeViewModel>(context, listen: false);
      final applicantDetailsViewModel =
          Provider.of<ApplicantDetailsViewModel>(context, listen: false);
      final familyDetailsViewModel =
          Provider.of<FamilyDetailsViewModel>(context, listen: false);
      final gruhaJyothiViewModel =
          Provider.of<GruhaJyothiSchemeViewModel>(context, listen: false);
      final cheyuthaViewModel =
          Provider.of<CheyuthaSchemeViewModel>(context, listen: false);
      final indirammaIndluViewModel =
          Provider.of<IndirammaIndluSchemeViewModel>(context, listen: false);
      AppConstants.applicantNumber = dashboardData?.offlinEAPPLICATIONNO ?? "";
      AppConstants.applicantName = dashboardData?.applicanTNAME ?? "";
      AppConstants.rationNumber = dashboardData?.ratioNCARDNO ?? "";
      AppConstants.aadharNumber = dashboardData?.aadhaRNO ?? "";
      iddVal = dashboardData?.idd ?? 0;
      print("iddVal: ${iddVal}");
      await dashboardViewModel.configurableFieldsService(context);
      await dashboardViewModel.getApplicationDetails(context, iddVal ?? 0);
      await dashboardViewModel.getRemarks(context);
      setState(() {
        rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag = false;
        mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag = false;
        cheyuthaViewModel.isCheyuthaDetailsFlag = false;
        indirammaIndluViewModel.isIndirammaIndluDetailsFlag = false;
        gruhaJyothiViewModel.isGruhaJyothiDetailsFlag = false;
        applicantDetailsViewModel.isApplicantDetailsFlag = false;
        familyDetailsViewModel.isFamilyDetailsFlag = false;
        remarksList = dashboardViewModel.getRemarksList;
        remarksList.insert(
            0, RemarksData(iREMARKSID: 0, vCREMARKS: "Select Remarks"));
        selectedRemarks = remarksList[0];
        selectedRemarksId = remarksList[0]?.iREMARKSID;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final cheyutha = await prefs.getString(SharedPrefConstants.cheyutha);
      print("cheyutha: ${cheyutha}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel =
        Provider.of<ApplicantDashboardViewModel>(context);
    final rythuBharosaSchemeNewViewModel =
        Provider.of<RythuBharosaSchemeNewViewModel>(context);
    final mahaLakshmiSchemeViewModel =
        Provider.of<MahaLakshmiSchemeViewModel>(context);
    final applicantDetailsViewModel =
        Provider.of<ApplicantDetailsViewModel>(context);
    final familyDetailsViewModel = Provider.of<FamilyDetailsViewModel>(context);
    final gruhaJyothiViewModel =
        Provider.of<GruhaJyothiSchemeViewModel>(context);
    final cheyuthaViewModel = Provider.of<CheyuthaSchemeViewModel>(context);
    final indirammaIndluViewModel =
        Provider.of<IndirammaIndluSchemeViewModel>(context);
    final allFamilyEdit =
        dashboardViewModel.personalDtlsMdl?.enablEAPPFAMILY?.toLowerCase() ==
                "y"
            ? true
            : false;
    final allSchemeEdit =
        dashboardViewModel.personalDtlsMdl?.enablESCHEMES?.toLowerCase() == "y"
            ? true
            : false;
    // final dashboardData =
    //     ModalRoute.of(context)?.settings.arguments as ApplicationStatus;
    // AppConstants.applicantNumber = dashboardData;
    if (dashboardViewModel.personalDtlsMdl?.cheyutha?.toLowerCase() == "y") {
      cheyuthaFlag = true;
    } else {
      cheyuthaFlag = false;
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop == false) {
          //To show alert only when data is saved to local
          print(
              "applicant flag: ${applicantDetailsViewModel.isApplicantDetailsFlag}\n family flag: ${familyDetailsViewModel.isFamilyDetailsFlag}\n maha flag: ${mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag}\n rythu flag: ${rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag}\n indi flag: ${indirammaIndluViewModel.isIndirammaIndluDetailsFlag}\n gruha flag: ${gruhaJyothiViewModel.isGruhaJyothiDetailsFlag}\n cheyutha flag: ${cheyuthaViewModel.isCheyuthaDetailsFlag} ${cheyuthaFlag}");
          if (applicantDetailsViewModel.isApplicantDetailsFlag == true ||
              (gruhaJyothiViewModel.isGruhaJyothiDetailsFlag == true &&
                  dashboardViewModel.personalDtlsMdl?.gruhajyothi
                          ?.toLowerCase() ==
                      "y") ||
              (cheyuthaViewModel.isCheyuthaDetailsFlag == true &&
                  cheyuthaFlag == true) ||
              (indirammaIndluViewModel.isIndirammaIndluDetailsFlag == true &&
                  dashboardViewModel.personalDtlsMdl?.indirammAILLU
                          ?.toLowerCase() ==
                      "y") ||
              (mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag == true &&
                  dashboardViewModel.personalDtlsMdl?.mHSCHEME?.toLowerCase() ==
                      "y") ||
              (rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag ==
                      true &&
                  dashboardViewModel.personalDtlsMdl?.raithUBAROSA
                          ?.toLowerCase() ==
                      "y")) {
            dashboardViewModel.applicantDetailsClear(
                context,
                applicantDetailsViewModel,
                rythuBharosaSchemeNewViewModel,
                mahaLakshmiSchemeViewModel,
                familyDetailsViewModel,
                cheyuthaViewModel,
                indirammaIndluViewModel,
                gruhaJyothiViewModel);
          } else {
            Navigator.pop(context);
          }
        }
      },
      child: Stack(
        children: [
          Scaffold(
            //drawer: SideMenuView(),
            appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(
                color: AppColors.white,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async {
                  if (applicantDetailsViewModel.isApplicantDetailsFlag ==
                          true ||
                      (gruhaJyothiViewModel.isGruhaJyothiDetailsFlag == true &&
                          dashboardViewModel.personalDtlsMdl?.gruhajyothi
                                  ?.toLowerCase() ==
                              "y") ||
                      (cheyuthaViewModel.isCheyuthaDetailsFlag == true &&
                          cheyuthaFlag == true) ||
                      (indirammaIndluViewModel.isIndirammaIndluDetailsFlag ==
                              true &&
                          dashboardViewModel.personalDtlsMdl?.indirammAILLU
                                  ?.toLowerCase() ==
                              "y") ||
                      (mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag ==
                              true &&
                          dashboardViewModel.personalDtlsMdl?.mHSCHEME
                                  ?.toLowerCase() ==
                              "y") ||
                      (rythuBharosaSchemeNewViewModel
                                  .isRythuBharosaDetailsFlag ==
                              true &&
                          dashboardViewModel.personalDtlsMdl?.raithUBAROSA
                                  ?.toLowerCase() ==
                              "y")) {
                    dashboardViewModel.applicantDetailsClear(
                        context,
                        applicantDetailsViewModel,
                        rythuBharosaSchemeNewViewModel,
                        mahaLakshmiSchemeViewModel,
                        familyDetailsViewModel,
                        cheyuthaViewModel,
                        indirammaIndluViewModel,
                        gruhaJyothiViewModel);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              backgroundColor: AppColors.appColor,
              title: Text(
                "PRAJA PALANA",
                style: TextStyle(color: Colors.white),
              ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Applicant Data Correction",
                        style: TextStyle(
                            color: AppColors.appColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    ReusableComponents().ApplicationRationAndApplicantName(),
                    //ReusableComponents().officerNameAndApplicationNumber(),
                    //ReusableComponents().startSurveyButton(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ), */
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            List<String> cardTitles = [
                              "Applicant Details",
                              "Family Details",
                              "Mahalakshmi",
                              "Rythu Bharosa",
                              "Indiramma Indlu",
                              "Gruha Jyothi",
                              "Cheyutha"
                            ];
                            String cardTitle =
                                cardTitles[index % cardTitles.length];
                            List<Color?> backgroundColors = [
                              Color(0xFF1a487e),
                              Color(0xFF29c0b1),
                              Color(0xFFff5722),
                              Color(0xFFff9800),
                              Color(0xFF8bc34a),
                              Color.fromARGB(255, 198, 201, 62),
                              Color.fromARGB(199, 149, 97, 204),
                            ];
                            Color? cardColor = backgroundColors[
                                index % backgroundColors.length];
                            List<String> cardImages = [
                              AppAssets.applicant,
                              AppAssets.family,
                              AppAssets.mahalakshmi,
                              AppAssets.rythubarosa,
                              AppAssets.indirammaIndlu,
                              AppAssets.gruhaJyothi,
                              AppAssets.cheyutha,
                            ];
                            String cardImage =
                                cardImages[index % cardImages.length];
                            List<bool> itemFlags = [
                              applicantDetailsViewModel
                                      .isApplicantDetailsFlag ??
                                  false,
                              familyDetailsViewModel.isFamilyDetailsFlag ??
                                  false,
                              mahaLakshmiSchemeViewModel
                                      .isMahalakshmiDetailsFlag ??
                                  false,
                              rythuBharosaSchemeNewViewModel
                                      .isRythuBharosaDetailsFlag ??
                                  false,
                              indirammaIndluViewModel
                                      .isIndirammaIndluDetailsFlag ??
                                  false,
                              gruhaJyothiViewModel.isGruhaJyothiDetailsFlag ??
                                  false,
                              //AppConstants.isCheyuthaDetailsFlag ?? false
                              cheyuthaViewModel.isCheyuthaDetailsFlag
                            ];
                            Color itemColor =
                                itemFlags[index % itemFlags.length]
                                    ? Colors.green
                                    : Colors.white;
                            //print("colors dash :: ${itemColor}");
                            flagTrue = [
                              dashboardViewModel
                                          .personalDtlsMdl?.enablEAPPFAMILY
                                          ?.toLowerCase() ==
                                      "y"
                                  ? true
                                  : false,
                              true,
                              dashboardViewModel.personalDtlsMdl?.mHSCHEME
                                          ?.toLowerCase() ==
                                      "y"
                                  ? true
                                  : false,
                              dashboardViewModel.personalDtlsMdl?.raithUBAROSA
                                          ?.toLowerCase() ==
                                      "y"
                                  ? true
                                  : false,
                              dashboardViewModel.personalDtlsMdl?.indirammAILLU
                                          ?.toLowerCase() ==
                                      "y"
                                  ? true
                                  : false,
                              dashboardViewModel.personalDtlsMdl?.gruhajyothi
                                          ?.toLowerCase() ==
                                      "y"
                                  ? true
                                  : false,
                              dashboardViewModel.personalDtlsMdl?.cheyutha
                                          ?.toLowerCase() ==
                                      "y"
                                  ? true
                                  : false,
                            ];
                            bool flag = flagTrue[index % flagTrue.length];
                            //print("flags dashes: ${flag}, ${index}");
                            enableControls =
                                itemFlags.every((flag) => flag == true);

                            if (index == 0 && flag == false) {
                              //print("flags dashes1: ${flag}, ${index}");
                              print("in index 0 and applicant flag is false ");
                              applicantDetailsViewModel.isApplicantDetailsFlag =
                                  true;
                            } else if (index == 2 && flag == false) {
                              //print("flags dashes1: ${flag}, ${index}");
                              mahaLakshmiSchemeViewModel
                                  .isMahalakshmiDetailsFlag = true;
                            } else if (index == 3 && flag == false) {
                              //print("flags dashes2: ${flag}, ${index}");
                              rythuBharosaSchemeNewViewModel
                                  .isRythuBharosaDetailsFlag = true;
                            } else if (index == 4 && flag == false) {
                              //print("flags dashes3: ${flag}, ${index}");
                              indirammaIndluViewModel
                                  .isIndirammaIndluDetailsFlag = true;
                            } else if (index == 5 && flag == false) {
                              //print("flags dashes4: ${flag}, ${index}");
                              gruhaJyothiViewModel.isGruhaJyothiDetailsFlag =
                                  true;
                            } else if (index == 6 && flag == false) {
                              //print("flags dashes5: ${flag}, ${index}");
                              cheyuthaViewModel.isCheyuthaDetailsFlag = true;
                            }
                            // else {
                            //   mahaLakshmiSchemeViewModel
                            //       .isMahalakshmiDetailsFlag = false;
                            //   rythuBharosaSchemeNewViewModel
                            //       .isRythuBharosaDetailsFlag = false;
                            //   indirammaIndluViewModel
                            //       .isIndirammaIndluDetailsFlag = false;
                            //   cheyuthaViewModel.isCheyuthaDetailsFlag = false;
                            //   gruhaJyothiViewModel.isGruhaJyothiDetailsFlag =
                            //       false;
                            // }

                            return GestureDetector(
                              onTap: () {
                                dashboardViewModel.navigateTo(
                                    context: context,
                                    index: index,
                                    flag: (index == 0 &&
                                            dashboardViewModel.personalDtlsMdl
                                                    ?.enablEAPPFAMILY
                                                    ?.toLowerCase() ==
                                                "n")
                                        ? true
                                        : flag,
                                    editableFamilyFlag: allFamilyEdit,
                                    editableSchemeFlag: allSchemeEdit);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: CupertinoListTile(
                                  backgroundColor: cardColor,
                                  title: Text(
                                    '$cardTitle',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  trailing: Row(
                                    children: [
                                      ((index == 0) &&
                                              allFamilyEdit &&
                                              (dashboardViewModel
                                                          .personalDtlsMdl
                                                          ?.aadharflg
                                                          ?.toLowerCase() ==
                                                      "y" ||
                                                  dashboardViewModel
                                                          .personalDtlsMdl
                                                          ?.rationflg
                                                          ?.toLowerCase() ==
                                                      "y" ||
                                                  dashboardViewModel
                                                          .personalDtlsMdl
                                                          ?.mobileflg
                                                          ?.toLowerCase() ==
                                                      "y" ||
                                                  dashboardViewModel
                                                          .personalDtlsMdl
                                                          ?.addressflg
                                                          ?.toLowerCase() ==
                                                      "y"))
                                          ? Icon(
                                              Icons.edit,
                                              color: AppColors.white,
                                              size: 20.0,
                                            )
                                          : Container(),
                                      //: Text(""),
                                      ((index % cardImages.length != 1 &&
                                                  index % cardImages.length !=
                                                      0) &&
                                              allSchemeEdit &&
                                              flag)
                                          ? Icon(
                                              Icons.edit,
                                              color: AppColors.white,
                                              size: 20.0,
                                            )
                                          : Container(),
                                      // : Text(""),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      flag
                                          ? Center(
                                              child: Icon(
                                                CupertinoIcons
                                                    .checkmark_circle_fill,
                                                color: itemColor,
                                                size: 25,
                                              ),
                                            )
                                          : (index == 0 &&
                                                  dashboardViewModel
                                                          .personalDtlsMdl
                                                          ?.enablEAPPFAMILY
                                                          ?.toLowerCase() ==
                                                      "n")
                                              ? Center(
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .checkmark_circle_fill,
                                                    color: itemColor,
                                                    size: 25,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    // Set flag to true when Container is tapped
                                                    flag = true;
                                                    // Add any other logic you need to perform when Container is tapped
                                                  },
                                                  child: Container(),
                                                ),
                                    ],
                                  ),
                                  leading: Image.asset(
                                    cardImage,
                                    height: 25,
                                    width: 25,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        /* allFamilyEdit == false && allSchemeEdit == false
                            ?  */
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: false,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.shortFallColor),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.preview);
                                      },
                                      child: Text(
                                        "Preview",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //: Container(),
                        /* GestureDetector(
                            child: Container(
                          child: Text(
                              "printing Applicant  ${applicantDetailsViewModel.isApplicantDetailsFlag ?? false}  \n family ${familyDetailsViewModel.isFamilyDetailsFlag ?? false} \n  mh falg${mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag ?? false} \n  rytu ${rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag ?? false} \n indi  ${indirammaIndluViewModel.isIndirammaIndluDetailsFlag ?? false}  \n gruha ${gruhaJyothiViewModel.isGruhaJyothiDetailsFlag ?? false} \n chyta ${cheyuthaViewModel.isCheyuthaDetailsFlag ?? false}}"),
                        )), */

                        if (/* applicantDetailsViewModel.isApplicantDetailsFlag ==
                                true && */
                            /* familyDetailsViewModel.isFamilyDetailsFlag ==
                                true && */
                            gruhaJyothiViewModel.isGruhaJyothiDetailsFlag == true &&
                                (cheyuthaViewModel.isCheyuthaDetailsFlag ==
                                    true) &&
                                indirammaIndluViewModel
                                        .isIndirammaIndluDetailsFlag ==
                                    true &&
                                mahaLakshmiSchemeViewModel
                                        .isMahalakshmiDetailsFlag ==
                                    true &&
                                rythuBharosaSchemeNewViewModel
                                        .isRythuBharosaDetailsFlag ==
                                    true)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35.0),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.appBarColor,
                                            AppColors.appColor,
                                            Colors.blue.shade300,
                                            AppColors.appBarColor,
                                            AppColors.appBarColor,
                                            AppColors.appColor,
                                            Colors.blue.shade300,
                                            AppColors.appBarColor,
                                          ])),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.transparent,
                                    ),
                                    onPressed: () {
                                      /* if (checked == false) {
                                      WarningCustomCupertinoAlert().showAlert(
                                          context,
                                          message:
                                              "Please Select remarks and check the box to continue!",
                                          onPressed: () {
                                        Navigator.pop(context);
                                      });
                                    } else { */
                                      /* FinalSubmitAlert().showAlert(
                                        context: context,
                                        onCancel: () {
                                          applicantDetailsViewModel
                                              .setIsLoadingStatus(false);
                                          Navigator.pop(context);
                                        },
                                        onPressed: () {
                                          applicantDetailsViewModel
                                              .setIsLoadingStatus(false);
                                          Navigator.pop(context);
                                          dashboardViewModel.onUpdate(
                                              context, selectedRemarksId ?? 0);
                                        },
                                      ); */
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (BuildContext context1) {
                                          return CupertinoAlertDialog(
                                            title: Column(
                                              children: <Widget>[
                                                Icon(
                                                  CupertinoIcons.info,
                                                  size: 60.0,
                                                  color: CupertinoColors
                                                      .systemBlue,
                                                ),
                                                SizedBox(height: 8.0),
                                                Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            content: Text(
                                                'Are you sure you want submit the data?'),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: Text('CANCEL'),
                                                onPressed: () async {
                                                  Navigator.of(context1).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    applicantDetailsViewModel
                                                        .setIsLoadingStatus(
                                                            false);
                                                    Navigator.pop(context1);
                                                    dashboardViewModel.onUpdate(
                                                        context,
                                                        selectedRemarksId ?? 0);
                                                  }),
                                            ],
                                          );
                                        },
                                      );

                                      // dashboardViewModel.onUpdate(context, 0);
                                      //}

                                      //checkbox and remarks select validation
                                      /* dashboardViewModel.onUpdate(
                                        context, selectedRemarksId ?? 0); */
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Application data updated in field verification",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (dashboardViewModel.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }
}

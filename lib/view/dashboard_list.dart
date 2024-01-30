import 'package:flutter/cupertino.dart';
import 'package:praja_palana/models/application_search/application_search_response.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/reusable_widgets/row_component.dart';
import 'package:praja_palana/res/reusable_widgets/search_component.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:praja_palana/view_model/aplication_search_view_model.dart';
import 'package:praja_palana/view_model/applicant_dashboard_view_model.dart';
import 'package:praja_palana/view_model/dashboard_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/view_model/login_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/application_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/cheyuthaSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/family_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/gruhaJyothiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/indirammaIndluSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/mahaLakshmiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/rythuBharosaSchemeNewViewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardList extends StatefulWidget {
  DashboardList({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardListState createState() => new _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  List<ApplicationStatus>? verticalData;
  final int increment = 10;
  bool isLoadingVertical = false;
  bool onSearchFlag = false;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  ValidLoginDetailsResponse? loginResponse;
  List<ApplicationStatus>? searchGrievanceDetails;
  bool isSearch = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final dashboardListViewModel =
          Provider.of<DashboardListViewModel>(context, listen: false);
      final rythuBharosaSchemeNewViewModel =
          Provider.of<RythuBharosaSchemeNewViewModel>(context, listen: false);
      final dashboardViewModel =
          Provider.of<ApplicantDashboardViewModel>(context, listen: false);
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
      dashboardViewModel.flagsClearing(
          context,
          applicantDetailsViewModel,
          rythuBharosaSchemeNewViewModel,
          mahaLakshmiSchemeViewModel,
          familyDetailsViewModel,
          cheyuthaViewModel,
          indirammaIndluViewModel,
          gruhaJyothiViewModel);
      final loginViewModel =
          Provider.of<LoginViewModel>(context, listen: false);
      await loginViewModel.getLoginResponseDetails();
      setState(() {
        loginResponse = loginViewModel.getLoginDetails;
      });
      dashboardListViewModel.setIsLoadingStatus(true);
      await dashboardListViewModel.getApplicationListViewModel(
          context, loginResponse);
      setState(() {
        searchGrievanceDetails =
            dashboardListViewModel.getApplicationDetailsList;
        verticalData = searchGrievanceDetails;
        print("length list :: ${searchGrievanceDetails?.length}");
      });

      //Delete cheyutha shared prefs
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("TableInfo");
    });

    super.initState();
  }

  String maskNumber(int number) {
    String numberString = number.toString();
    if (numberString.length > 4) {
      String maskedPart = 'X' * (numberString.length - 4);
      String lastTwoDigits = numberString.substring(numberString.length - 4);
      return maskedPart + lastTwoDigits;
    } else {
      return numberString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboardListViewModel = Provider.of<DashboardListViewModel>(context);
    final applicationSearchViewModel =
        Provider.of<ApplicationSearchViewModel>(context);
    if (dashboardListViewModel.getIsLoadingStatus) {
      print("listv data ${dashboardListViewModel.getApplicationDetailsList}");
    }
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.appColor,
            iconTheme: IconThemeData(color: AppColors.white),
            title: Text(
              "PRAJA PALANA",
              style: TextStyle(color: AppColors.white),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: SearchComponent(
                      onCloseSearch: () {
                        setState(() {
                          searchController.text = "";
                          searchController.text;
                        });
                        FocusScope.of(context).requestFocus(focusNode);
                      },
                      crossIcon: Icons.close,
                      controller: searchController,
                      hintText: "Search by Aadhaar/RationNo/MobileNo",
                      onPressed: () async {
                        if (applicationSearchViewModel.validateFields(
                            context, searchController.text)) {
                          if (await InternetCheck()) {
                            applicationSearchViewModel.setIsLoadingStatus(true);
                            await applicationSearchViewModel
                                .getApplicationSearchViewModel(
                              context,
                              loginResponse,
                              searchController,
                            );
                       
                            setState(() {
                              searchGrievanceDetails =
                                  applicationSearchViewModel
                                      .getApplicationDetailsList;
                              onSearchFlag = true;
                            });
                          } else {
                            ValidationIoSAlert().showAlert(context,
                                description:
                                    "Please check your internet connection");
                          }
                        }
                      },
                    ),
                  ),
                  ((applicationSearchViewModel.getApplicationDetailsList ?? [])
                              .isNotEmpty &&
                          searchController.text != "" &&
                          applicationSearchViewModel
                                  .getApplicationDetailsList !=
                              [])
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: applicationSearchViewModel
                                .getApplicationDetailsList?.length,
                            itemBuilder: (context, position) {
                              final details = applicationSearchViewModel
                                  .getApplicationDetailsList?[position];

                              return GestureDetector(
                                onTap: () async {
                                  //_showAlert(context);

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool(
                                      SharedPrefConstants
                                          .isApplicantDetailsSaved,
                                      false);
                                  await prefs.setBool(
                                      SharedPrefConstants.isFamilyDetailsSaved,
                                      false);
                                  await prefs.setBool(
                                      SharedPrefConstants
                                          .isMahalakshmiDetailsSaved,
                                      false);
                                  await prefs.setBool(
                                      SharedPrefConstants
                                          .isRythuBharosaDetailsSaved,
                                      false);
                                  await prefs.setBool(
                                      SharedPrefConstants
                                          .isIndirammaIndluDetailsSaved,
                                      false);
                                  await prefs.setBool(
                                      SharedPrefConstants
                                          .isCheyuthaDetailsSaved,
                                      false);
                                  await prefs.setBool(
                                      SharedPrefConstants
                                          .isGruhaJyothiDetailsSaved,
                                      false);
                                  AppConstants.RemarksdDropdownList = details;
                                  Navigator.pushNamed(
                                      context, AppRoutes.applicantDashboard,
                                      arguments: details);
                                },
                                child: Card(
                                  surfaceTintColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        RowComponent(
                                          titleFlex: 3,
                                          valueFlex: 4,
                                          title: "Application Number",
                                          value:
                                              "${details?.offlinEAPPLICATIONNO ?? ""}",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        RowComponent(
                                          title: "Name",
                                          value:
                                              "${details?.applicanTNAME ?? ""}",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        RowComponent(
                                          title: "Aadhaar",
                                          //value: "${details?.aadhaRNO}",
                                          value:
                                              "${maskNumber(int.tryParse(details?.aadhaRNO ?? '') ?? 0)}",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        RowComponent(
                                          title: "Ration Card No",
                                          value:
                                              "${details?.ratioNCARDNO ?? " "}",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        RowComponent(
                                          title: "Mobile No",
                                          value: "${details?.mobilENO ?? " "}",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        RowComponent(
                                          title: "Tagged Application Count",
                                          titleFlex: 5,
                                          valueFlex: 2,
                                          value: details
                                                      ?.dDUPLICATEAPPPLICANTS !=
                                                  null
                                              ? "${details?.dDUPLICATEAPPPLICANTS ?? 0}"
                                              : "0",
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.appColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : (searchController.text.isEmpty)
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: verticalData?.length,
                                itemBuilder: (context, position) {
                                  final details = verticalData?[position];

                                  return GestureDetector(
                                    onTap: () async {
                                      // _showAlert(context);

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool(
                                          SharedPrefConstants
                                              .isApplicantDetailsSaved,
                                          false);
                                      await prefs.setBool(
                                          SharedPrefConstants
                                              .isFamilyDetailsSaved,
                                          false);
                                      await prefs.setBool(
                                          SharedPrefConstants
                                              .isMahalakshmiDetailsSaved,
                                          false);
                                      await prefs.setBool(
                                          SharedPrefConstants
                                              .isRythuBharosaDetailsSaved,
                                          false);
                                      await prefs.setBool(
                                          SharedPrefConstants
                                              .isIndirammaIndluDetailsSaved,
                                          false);
                                      await prefs.setBool(
                                          SharedPrefConstants
                                              .isCheyuthaDetailsSaved,
                                          false);
                                      await prefs.setBool(
                                          SharedPrefConstants
                                              .isGruhaJyothiDetailsSaved,
                                          false);
                                      AppConstants.RemarksdDropdownList =
                                          details;
                                      Navigator.pushNamed(
                                          context, AppRoutes.applicantDashboard,
                                          arguments: details);
                                    },
                                    child: Card(
                                      surfaceTintColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            RowComponent(
                                              titleFlex: 3,
                                              valueFlex: 4,
                                              title: "Application Number",
                                              value:
                                                  "${details?.offlinEAPPLICATIONNO ?? ""}",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            RowComponent(
                                              title: "Name",
                                              value:
                                                  "${details?.applicanTNAME ?? " "}",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            RowComponent(
                                              title: "Aadhaar",
                                              value:
                                                  "${maskNumber(int.tryParse(details?.aadhaRNO ?? '') ?? 0)}",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            RowComponent(
                                              title: "Ration Card No",
                                              value:
                                                  "${details?.ratioNCARDNO ?? " "}",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            RowComponent(
                                              title: "Mobile No",
                                              value:
                                                  "${details?.mobilENO ?? ""}",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            RowComponent(
                                              title: "Tagged Application Count",
                                              titleFlex: 5,
                                              valueFlex: 2,
                                              value: details
                                                          ?.dDUPLICATEAPPPLICANTS !=
                                                      null
                                                  ? "${details?.dDUPLICATEAPPPLICANTS ?? 0}"
                                                  : "0",
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container()
                ],
              )),
        ),
        if (dashboardListViewModel.getIsLoadingStatus) LoaderComponent()
      ],
    );
  }

  void showAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('List Alert'),
          content: Column(
            children: [
              Text('Choose an item:'),
              SizedBox(height: 10),
              _buildList(),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList() {
    return Container(
      child: ListView(
        children: [
          ListTile(
            title: Text('1233kkwkmskd'),
            onTap: () {
              // Handle item selection
              print('Item 1 selected');
            },
          ),
          ListTile(
            title: Text('qwfdgfhgnh'),
            onTap: () {
              // Handle item selection
              print('Item 2 selected');
            },
          ),
          ListTile(
            title: Text('adsfdgfghhmj'),
            onTap: () {
              // Handle item selection
              print('Item 3 selected');
            },
          )
          // Add more ListTiles as needed
        ],
      ),
    );
  }
}

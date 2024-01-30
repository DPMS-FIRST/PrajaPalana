import 'package:praja_palana/models/dashboard_abstract/dashboard_abstract_response.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/CustomAlerts/exit_app_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/reusable_widgets/footer_component.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/view/sidemenu_view.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import '../view_model/dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  ValidLoginDetailsResponse? loginResponse = ValidLoginDetailsResponse();
  List<DashboardAbstractData>? dashboardData = [];
  var totalcount;
  // int count = 0;
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardViewModel>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          ExitAppAlert().showAlert(context: context);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            drawer: SideMenuView(),
            appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(
                color: AppColors.white,
              ),
              backgroundColor: AppColors.appColor,
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
              child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Image.asset(
                        AppAssets.sixGuaranteeImage,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      Wrap(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppConstants.userName,
                                style: TextStyle(
                                    color: AppColors.appColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      /*  dashboardData?.length != 0
                          ? Text(
                              "${AppStrings.totalCount} : ${count}",
                              style: TextStyle(
                                  color: AppColors.appColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            )
                          : SizedBox(), */
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dashboardData?.length,
                          itemBuilder: (context, index) {
                            List<Color?> backgroundColors = [
                              Color(0xFF1a487e),
                              Color(0xFF29c0b1),
                              Color(0xFFff9800),
                              Color(0xFFff5722),
                            ];
                            Color? cardColor = backgroundColors[
                                index % backgroundColors.length];

                            final detailsList = dashboardData?[index];
                            /* setState(() {
                          count = count + (detailsList?.count ?? 0);
                        }); */
                            return GestureDetector(
                              onTap: () async {
                                if (detailsList?.name == "Search") {
                                 
                                  AppConstants.titleText =
                                      "${detailsList?.pTYPE}";
                                  Navigator.pushNamed(
                                      context, AppRoutes.searchView);
                                } else {
                                  AppConstants.titleText =
                                      "${detailsList?.pTYPE}";
                                  Navigator.pushNamed(
                                      context, AppRoutes.dashboardList);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 1.0,
                                    right: 1.0,
                                    top: 2.0,
                                    bottom: 2.0),
                                child: Container(
                                  color: cardColor,
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  child: Center(
                                      child: ListTile(
                                    leading: Icon(
                                      Icons.verified_user,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    title: Text(
                                      detailsList?.name == "total"
                                          ? "Search"
                                          : "${detailsList?.name?[0].toUpperCase()}${detailsList?.name?.substring(1)}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: detailsList?.count != null &&
                                            detailsList?.count != ""
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12,
                                              /*  decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ), */
                                              child: Center(
                                                child: Text(
                                                  (detailsList?.name !=
                                                          "Search")
                                                      ? "${detailsList?.count}"
                                                      : '',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomFooterContainer(),
          ),
          if (dashboardProvider.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }

  // List<Dashboard> dashboards = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dashboardProvider =
          Provider.of<DashboardViewModel>(context, listen: false);

      await dashboardProvider.checkDownloadMasterData(context);
      final loginViewModel =
          Provider.of<LoginViewModel>(context, listen: false);

      setState(() {
        loginResponse = loginViewModel.getLoginDetails;
      });
      await dashboardProvider.dashboardAbstractApiCall(context, loginResponse);

      dashboardData = dashboardProvider.getDashboardList;
      /*  dashboards = dashboardData!
          .toJson()
          .entries
          .map((entry) => Dashboard(title: entry.key, count: entry.value))
          .toList()
          .reversed
          .toList();
      print("dashboards: ${dashboards.length}"); */
      setState(() {});
    });
  }
}

/* class Dashboard {
  final String title;
  final int count;

  Dashboard({required this.title, required this.count});
} */

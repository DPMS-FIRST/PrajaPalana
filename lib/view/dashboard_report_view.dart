import 'package:flutter/material.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:provider/provider.dart';

import '../models/dashboard_report/dashboard_report_response.dart';
import '../models/login/validate_login_details_response.dart';
import '../res/constants/app_assets.dart';
import '../res/constants/app_colors.dart';
import '../res/constants/app_constants.dart';
import '../view_model/dashboard_report_view_model.dart';
import '../view_model/login_view_model.dart';

class DashboardReportView extends StatefulWidget {
  const DashboardReportView({super.key});

  @override
  State<DashboardReportView> createState() => _DashboardReportViewState();
}

class _DashboardReportViewState extends State<DashboardReportView> {
  ValidLoginDetailsResponse? loginResponse;
  List<ReportsData>? dashboardData = [];
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardReportsViewModel>(context);
    print("length:::${dashboardData?.length}");
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Dashboard Report"),
            iconTheme: IconThemeData(
              color: AppColors.white,
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
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Name: ${AppConstants.userName}",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Designation: ${loginResponse?.data?.vCDESIGNATION ?? ""}",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  (dashboardData?.length ?? 0) > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: (dashboardData?.length ?? 0) ~/ 3,
                          itemBuilder: (context, listIndex) {
                            List<Color> backgroundColors = [
                              Color.fromARGB(255, 240, 255, 221),
                              Color.fromARGB(255, 217, 192, 255),
                              Color.fromARGB(255, 255, 221, 195),
                            ];
                            int startIndex = listIndex * 3;
                            int endIndex = startIndex + 3;

                            List<ReportsData> listData = dashboardData!.sublist(
                              startIndex,
                              endIndex < dashboardData!.length
                                  ? endIndex
                                  : dashboardData!.length,
                            );
                            List<Color> colors = [
                              Color(0xffe6efdb),
                              Color(0xffe8e9fb),
                              Color(0xfffbe4d2),
                            ];
                            List<Color> darkerBgColors = [
                              Color.fromARGB(255, 175, 219, 117),
                              Color.fromARGB(255, 173, 143, 217),
                              Color.fromARGB(255, 201, 157, 123),
                            ];
                            // final title =
                            //     listData[0].name?.replaceAll('Total ', '') ??
                            //         "";
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      //color: colors[listIndex % 3],
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          darkerBgColors[listIndex % 3],
                                          colors[listIndex % 3],
                                          backgroundColors[listIndex % 3],
                                          darkerBgColors[listIndex % 3],
                                        ],
                                      ),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color:
                                            Colors.indigo[900] ?? Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      /*  boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 1),
                                        ),
                                      ], */
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            "${listData[0].name ?? ""}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1.0,
                                          ),
                                        ),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: listData.length,
                                          itemBuilder: (context, index) {
                                            final data = listData[index];
                                            print("data::::${data.name}");
                                            final dataName = index == 0
                                                ? "Total"
                                                : index == 1
                                                    ? "Insepected"
                                                    : "Pending";
                                            final count = index == 0
                                                ? "${listData[0].count ?? "0"}"
                                                : index == 1
                                                    ? "${listData[2].count ?? "0"}"
                                                    : "${listData[1].count ?? "0"}";
                                            return Container(
                                              decoration: index % 3 != 0
                                                  ? BoxDecoration(
                                                      border: Border(
                                                        left: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    )
                                                  : null,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "${dataName}",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      count,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 2.0,
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                darkerBgColors[listIndex % 3],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Percentage of completion:",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Text(
                                                  " ${((listData[2].count ?? 0) / (listData[0].count ?? 0) * 100).toStringAsFixed(2)}%",
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        if (dashboardProvider.getIsLoadingStatus) LoaderComponent()
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dashboardProvider =
          Provider.of<DashboardReportsViewModel>(context, listen: false);

      final loginViewModel =
          Provider.of<LoginViewModel>(context, listen: false);

      setState(() {
        loginResponse = loginViewModel.getLoginDetails;
      });
      await dashboardProvider.dashboardReportsApiCall(context, loginResponse);

      dashboardData = dashboardProvider.getDashboardReportsData;
      setState(() {});
    });
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final List<ReportsData> data;

  ReportCard({
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            for (var report in data)
              Column(
                children: [
                  Text(report.name ?? ""),
                  Text(report.count.toString()),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/card_reusable.dart';
import 'package:praja_palana/res/reusable_widgets/row_component.dart';
import 'package:praja_palana/res/reusable_widgets/search_component.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:praja_palana/view_model/applicationStatusViewModel/applicationStatusViewModel.dart';
import 'package:provider/provider.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({super.key});

  @override
  State<ApplicationStatus> createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final applicationStatusProvider =
        Provider.of<ApplicationStatusViewModel>(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBarComponent(
            title: AppStrings.application_status,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.appBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                    hintText: "Search",
                    onPressed: () async {
                      if (applicationStatusProvider.validateFields(
                          context, searchController.text)) {
                        if (await InternetCheck()) {
                          applicationStatusProvider.setIsLoadingStatus(true);
                          applicationStatusProvider
                              .getApplicationSearchViewModel(
                            context,
                            searchController.text,
                          );
                        } else {
                          ValidationIoSAlert().showAlert(context,
                              description:
                                  "Please check your internet connection");
                        }
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (applicationStatusProvider
                                  .applicationStatusDetails !=
                              null)
                            CardReusable(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RowComponent(
                                    title: "Application Number :",
                                    value: applicationStatusProvider
                                        .applicationStatusDetails
                                        ?.onlinEAPPLICATIONNO,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  RowComponent(
                                    title: "Name of the Applicant :",
                                    value: applicationStatusProvider
                                        .applicationStatusDetails
                                        ?.applicanTNAME,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  RowComponent(
                                    title: "Aadhaar No :",
                                    value: applicationStatusProvider
                                        .applicationStatusDetails?.aadhaRNO,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  RowComponent(
                                    title: "Ration Card No :",
                                    value: applicationStatusProvider
                                        .applicationStatusDetails?.ratioNCARDNO,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  RowComponent(
                                    title: "Mobile No :",
                                    value: applicationStatusProvider
                                        .applicationStatusDetails?.mobilENO,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  RowComponent(
                                    title: "Status :",
                                    value: applicationStatusProvider
                                        .applicationStatusDetails?.status,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  Center(
                                    child: ReusableButton(
                                      ButtonText: "VIEW DETAILS",
                                      width: 200,
                                      onPressed: () {
                                        applicationStatusProvider
                                            .getApplicationDetails(
                                                context,
                                                applicationStatusProvider
                                                        .applicationStatusDetails
                                                        ?.onlinEAPPLICATIONNO ??
                                                    "");
                                        // Navigator.pushNamed(context,
                                        //     AppRoutes.applicationstatusdetails);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (applicationStatusProvider.isLoading) LoaderComponent()
      ],
    );
  }
}

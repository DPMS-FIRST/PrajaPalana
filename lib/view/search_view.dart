import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/row_component.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/constants/app_constants.dart';
import '../res/reusable_widgets/reusable_textfield.dart';
import '../routes/app_routes.dart';
import '../utils/reusable_button.dart';
import '../utils/shared_pref_constants.dart';
import '../view_model/aplication_search_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController applicantNoController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController rationNocontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final searchProvider =
        Provider.of<ApplicationSearchViewModel>(context, listen: false);
    searchProvider.applicationDetailsList = [];
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<ApplicationSearchViewModel>(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBarComponent(
            title: 'Search',
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.appBg),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                ReusableTextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp(r'^[\d/]+$'),
                        allow: true),
                  ],
                  controller: applicantNoController,
                  labelText: "APPLICATION NUMBER".tr(),
                  keyboardType: TextInputType.phone,
                  maxLength: 16,
                ),
                ReusableTextFormField(
                    controller: mobileNoController,
                    labelText: "MOBILE NO".tr(),
                    keyboardType: TextInputType.number,
                    maxLength: 10),
                ReusableTextFormField(
                    controller: aadhaarController,
                    labelText: "AADHAAR NO".tr(),
                    keyboardType: TextInputType.number,
                    maxLength: 12),
                ReusableTextFormField(
                  controller: rationNocontroller,
                  labelText: "RATION CARD NO".tr(),
                  keyboardType: TextInputType.number,
                 maxLength: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                ReusableButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    searchProvider.validateAndNavigate(
                        context,
                        applicantNoController,
                        mobileNoController,
                        aadhaarController,
                        rationNocontroller);
                  },
                  ButtonText: 'SEARCH',
                ),
                if (searchProvider.getApplicationDetailsList != null &&
                    searchProvider.getApplicationDetailsList!.isNotEmpty)
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            searchProvider.getApplicationDetailsList?.length,
                        itemBuilder: (context, index) {
                          final applicationDetailsList =
                              searchProvider.getApplicationDetailsList?[index];
                          return GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool(
                                  SharedPrefConstants.isApplicantDetailsSaved,
                                  false);
                              await prefs.setBool(
                                  SharedPrefConstants.isFamilyDetailsSaved,
                                  false);
                              await prefs.setBool(
                                  SharedPrefConstants.isMahalakshmiDetailsSaved,
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
                                  SharedPrefConstants.isCheyuthaDetailsSaved,
                                  false);
                              await prefs.setBool(
                                  SharedPrefConstants.isGruhaJyothiDetailsSaved,
                                  false);
                              AppConstants.RemarksdDropdownList =
                                  applicationDetailsList;
                              Navigator.pushNamed(
                                  context, AppRoutes.applicantDashboard,
                                  arguments: applicationDetailsList);
                            },
                            child: Card(
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    /*  RowComponent(
                                      title: "Online Applicant Number",
                                      value:
                                          "${applicationDetailsList?.onlinEAPPLICATIONNO}",
                                      fontWeight: FontWeight.bold,
                                    ), */
                                    RowComponent(
                                      title: "Offline Application Number",
                                      value:
                                          "${applicationDetailsList?.offlinEAPPLICATIONNO}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RowComponent(
                                      title: "Name",
                                      value:
                                          "${applicationDetailsList?.applicanTNAME}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RowComponent(
                                      title: "Aadhaar",
                                      value:
                                          "${applicationDetailsList?.aadhaRNO}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RowComponent(
                                      title: "Ration Card No",
                                      value:
                                          "${applicationDetailsList?.ratioNCARDNO}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RowComponent(
                                      title: "Mobile No",
                                      value:
                                          "${applicationDetailsList?.mobilENO}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    /* 
                                                    "onlinE_APPLICATION_NO": "281122/00002",
                    "offlinE_APPLICATION_NO": "2191",
                    "applicanT_NAME": "braham",
                    "gender": "M",
                    "caste": "Gen",
                    "datE_OF_BIRTH": "04/17/1988 00:00:00",
                    "aadhaR_NO": "762549626511",
                    "ratioN_CARD_NO": "Rnil",
                    "mobilE_NO": "9414048326",
                    "occupation": "Software",
                                     */
                                    RowComponent(
                                      title: "Gender",
                                      value:
                                          "${applicationDetailsList?.gender}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RowComponent(
                                      title: "Caste",
                                      value: "${applicationDetailsList?.caste}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RowComponent(
                                      title: "Date of Birth",
                                      value:
                                          "${applicationDetailsList?.datEOFBIRTH}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RowComponent(
                                      title: "Occupation",
                                      value:
                                          "${applicationDetailsList?.occupation}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (searchProvider.getApplicationDetailsList!.isEmpty ||
                          searchProvider.getApplicationDetailsList == [])
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Data Available",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
        if (searchProvider.getIsLoadingStatus) LoaderComponent()
      ],
    );
  }
}

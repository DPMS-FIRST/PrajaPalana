import 'package:flutter/material.dart';
import 'package:praja_palana/data/database.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/view_model/download_masters_view_model.dart';
import 'package:provider/provider.dart';

class DownloadMastersView extends StatefulWidget {
  const DownloadMastersView({super.key});

  @override
  State<DownloadMastersView> createState() => _DownloadMastersViewState();
}

class _DownloadMastersViewState extends State<DownloadMastersView> {
  MaterialColor? _themeColor;
  var db = DatabaseClient();
  String? Auth_Token;
  int? TaskStatusLength;
  int? OfficeCoordinatesLength;
  int? WorkAreaDataLength;

  @override
  Widget build(BuildContext context) {
    final downloadMasterProvider =
        Provider.of<DownloadMastersViewModel>(context);
    print("Loader Status: ${downloadMasterProvider.getIsLoadingStatus}");
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false)
          downloadMasterProvider.NavigationToDashboard(context);
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBarComponent(
              title: AppStrings.downloadMasters,
              onPressedBack: () {
                downloadMasterProvider.NavigationToDashboard(context);
              },
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ), /*  side: BorderSide(color: Color(0xFF00BCD4)) */
                      ),
                      elevation: 8.0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(AppAssets.downloadMasters,
                                    width: 43.0,
                                    height: 43.0,
                                    color: _themeColor),
                                const SizedBox(
                                  height: 11.0,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Download Master for",
                                      style: TextStyle(
                                          color: AppColors.appColor,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "(Gender, Relation, Caste, Occupation, Districts, Gas Company & Electricity Units)",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 10.0,
                                  indent: 5.0,
                                  endIndent: 5.0,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                                onPressed: () async {
                                  await downloadMasterProvider
                                      .checkMasterData(context);
                                  if (downloadMasterProvider
                                          .getIsMasterDataDownloaded ==
                                      false) {
                                    await downloadMasterProvider
                                        .getDownloadMasters(context);
                                  } else {
                                    await downloadMasterProvider.deleteDbData();
                                    await downloadMasterProvider
                                        .getDownloadMasters(context);
                                  }
                                },
                                child: Text(
                                    (downloadMasterProvider
                                                .getIsMasterDataDownloaded ==
                                            false)
                                        ? "Download"
                                        : "Re-Download",
                                    style: TextStyle(
                                        color: (downloadMasterProvider
                                                    .getIsMasterDataDownloaded ==
                                                false)
                                            ? Colors.black87
                                            : Colors.green))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ), /*  side: BorderSide(color: Color(0xFF00BCD4)) */
                      ),
                      elevation: 8.0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(AppAssets.downloadMasters,
                                    width: 43.0,
                                    height: 43.0,
                                    color: _themeColor),
                                const SizedBox(
                                  height: 11.0,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Download Master for",
                                      style: TextStyle(
                                          color: AppColors.appColor,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "(Residential Status, Ownership, Roof type, Ownership, Cheyutha Sub-Schemes,Toddy Tapper, Single Women)",
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 10.0,
                                  indent: 5.0,
                                  endIndent: 5.0,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                                onPressed: () async {
                                  await downloadMasterProvider
                                      .checkisGeoGraphicsMasterData(context);
                                  if (downloadMasterProvider
                                          .getIsisGeoGraphicsMasterDataDownloaded ==
                                      false) {
                                    await downloadMasterProvider
                                        .getDownloadGeographicMasters(context);
                                  } else {
                                    await downloadMasterProvider.deleteSecndData();
                                    await downloadMasterProvider
                                        .getDownloadGeographicMasters(context);
                                  }
                                },
                                child: Text(
                                    (downloadMasterProvider
                                                .getIsisGeoGraphicsMasterDataDownloaded ==
                                            false)
                                        ? "Download"
                                        : "Re-Download",
                                    style: TextStyle(
                                        color: (downloadMasterProvider
                                                    .getIsisGeoGraphicsMasterDataDownloaded ==
                                                false)
                                            ? Colors.black87
                                            : Colors.green))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (downloadMasterProvider.getIsLoadingStatus) LoaderComponent(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final downloadMasterProvider =
          Provider.of<DownloadMastersViewModel>(context, listen: false);
      downloadMasterProvider.checkMasterData(context);
    });
  }
}

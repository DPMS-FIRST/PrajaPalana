import 'package:flutter/material.dart';
import 'package:praja_palana/data/database.dart';
import 'package:praja_palana/models/dashboard_abstract/dashboard_abstract_request.dart';
import 'package:praja_palana/models/dashboard_abstract/dashboard_abstract_response.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/repository/dashboard_repository.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/custom_warning_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/api_error_codes.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/view_model/download_masters_view_model.dart';
import 'package:provider/provider.dart';

class DashboardViewModel with ChangeNotifier {
  final databaseInstance = DatabaseClient();

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  List<DashboardAbstractData>? dashboardData = [];
  List<DashboardAbstractData>? get getDashboardList => dashboardData;
  List<Gascompanies?>? gasList = [];
  List<Electricityunits?>? electricityunitsList = [];
  List<Gender?>? genderList = [];
  List<Relationships?>? relationsList = [];
  List<Occupations?>? occupationList = [];
  List<Districts?>? districtList = [];
  List<Districts?>? mandalList = [];
  List<Districts?>? municipalityList = [];
  List<Districts?>? panchayatList = [];
  List<Caste?>? casteList = [];
  List<Gascompanies?>? get getDbGastList => gasList;
  List<Electricityunits?>? get getDbElectricityList => electricityunitsList;
  List<Gender?>? get getDbGenderList => genderList;
  List<Caste?>? get getDbCasteList => casteList;
  List<Relationships?>? get getDbRelationsList => relationsList;
  List<Occupations?>? get getDbOccupationList => occupationList;
  List<Districts?>? get getDbDistrictList => districtList;
  List<Districts?>? get getDbMandalList => mandalList;
  List<Districts?>? get getDbPanchayatList => panchayatList;
  List<Districts?>? get getDbMunicipalityList => municipalityList;

  checkDownloadMasterData(context) async {
    setIsLoadingStatus(true);
    final genderData = await databaseInstance.getGenderData();
    final casteData = await databaseInstance.getCasteData();
    final districtData = await databaseInstance.getDistrictsData();
    final electricityUnitsData =
        await databaseInstance.getElectricityUnitsData();

    final gasCompaniesData = await databaseInstance.getGasCompaniesData();

    final occupationData = await databaseInstance.getOccupationData();
    final relationshipData = await databaseInstance.getRelationshipData();
    electricityunitsList = electricityUnitsData;
    gasList = gasCompaniesData;
    genderList = genderData;
    casteList = casteData;
    relationsList = relationshipData;
    occupationList = occupationData;
    districtList = districtData;
    setIsLoadingStatus(true);
    final downloadMasterViewModel = Provider.of<DownloadMastersViewModel>(
      context,
      listen: false,
    );
    await downloadMasterViewModel.checkMasterData(context);
    await downloadMasterViewModel.checkisGeoGraphicsMasterData(context);
    notifyListeners();
    setIsLoadingStatus(false);
    if (downloadMasterViewModel.getIsisGeoGraphicsMasterDataDownloaded ==
            false ||
        downloadMasterViewModel.isMasterDataDownloaded == false) {
      WarningCustomCupertinoAlert().showAlert(context,
          message: 'Please Download Master Data', onPressed: () {
        Navigator.pushNamed(context, AppRoutes.downloadMasters);
      });
    }
  }

  getMandalDBDetails(String? distID, String? gpMun) async {
    mandalList = [];
    final mandalData =
        await databaseInstance.getMandalData(distID, gpMun ?? "");
    mandalList = mandalData;
    notifyListeners();
  }

  getMunicipalityDBDetails(String? distID, String? gpMun) async {
    municipalityList = [];
    final municipalityData =
        await databaseInstance.getMunicipalityData(distID, gpMun ?? "");
    municipalityList = municipalityData;
    notifyListeners();
  }

  getPunchayitDBDetails(String? distID, String? mandalID) async {
    panchayatList = [];
    final mandalData = await databaseInstance.getPanchayData(distID, mandalID);
    panchayatList = mandalData;
    notifyListeners();
  }

  getDasboardAbstract() {}
  dashboardAbstractApiCall(BuildContext context,
      ValidLoginDetailsResponse? loginDetailsResponse) async {
    if (await InternetCheck()) {
      setIsLoadingStatus(true);
      DashboardAbstractRequest dashboardAbstractRequest =
          DashboardAbstractRequest();
      print("userid=${loginDetailsResponse?.data?.userid}");
      dashboardAbstractRequest.userid = loginDetailsResponse?.data?.userid;
      dashboardAbstractRequest.iTOKENID = loginDetailsResponse?.data?.iTOKENID;
      dashboardAbstractRequest.dISTID = loginDetailsResponse?.data?.districtid;
      dashboardAbstractRequest.paNMUNID =
          int.tryParse(loginDetailsResponse?.data?.panchayatid ?? '0');

      DashboardAbstractResponse? response = await DashboardRepository()
          .getDashboardAbstractRepository(context, dashboardAbstractRequest);
      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          if (response.data != null) {
            dashboardData = response.data;
          }
          notifyListeners();

          setIsLoadingStatus(false);
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          setIsLoadingStatus(false);
          ErrorCustomCupertinoAlert().showAlert(
            context,
            message: response.statusMessage ?? "",
            onPressed: () async {
              Navigator.pop(context);
            },
          );
        } else if (response.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
          ErrorCustomCupertinoAlert().showAlert(context,
              message: response.statusMessage ?? '', onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
        } else {
          // EasyLoading.dismiss();
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
        }
      } else {
        InternetCheckAlert().showAlert(context);
      }
    }
  }
}

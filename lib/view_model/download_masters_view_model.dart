import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/data/database.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/internet.dart';
import '../repository/download_master_repository.dart';
import '../res/CustomAlerts/custom_error_alert.dart';
import '../utils/api_error_codes.dart';

class DownloadMastersViewModel with ChangeNotifier {
  final DownloadMastersRepository downloadMastersRepository =
      DownloadMastersRepository();
  final databaseInstance = DatabaseClient();

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

//Download Masters Api Call
  Future<void> getDownloadMasters(BuildContext context) async {
    if (await InternetCheck()) {
      setIsLoadingStatus(true);
      final response =
          await downloadMastersRepository.downloadMastersRepo(context);

      if (response != null) {
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          //DatabaseInsertion Code
          if (response.data != null) {
            try {
              response.data?.gender?.forEach((genderElement) async {
                await databaseInstance.insertGenderData(genderElement);
              });
              response.data?.caste?.forEach((casteElement) async {
                await databaseInstance.insertCasteData(casteElement);
              });
              response.data?.districts?.forEach((districtElement) async {
                await databaseInstance.insertDistrictsData(districtElement);
              });
              response.data?.electricityunits?.forEach((unitsElement) async {
                await databaseInstance.insertElectricityUnitsData(unitsElement);
              });
              response.data?.gascompanies?.forEach((gasElement) async {
                await databaseInstance.insertGasCompaniesData(gasElement);
              });
              response.data?.occupations?.forEach((occupationElement) async {
                await databaseInstance.insertOccupationData(occupationElement);
              });
              response.data?.relationships
                  ?.forEach((relationshipElement) async {
                await databaseInstance
                    .insertRelationshipData(relationshipElement);
              });
              await checkMasterData(context).then((value) {
                setIsLoadingStatus(false);
                if (value) {
                  if (getIsMasterDataDownloaded) {
                    SuccessCustomCupertinoAlert().showAlert(
                        context: context,
                        title: "Masters Downloaded Successfully",
                        onPressed: () {
                          if (getIsisGeoGraphicsMasterDataDownloaded == true &&
                              getIsMasterDataDownloaded == true) {
                            Navigator.pushNamed(context, AppRoutes.dashboard);
                          } else {
                            Navigator.pop(context);
                          }
                        });
                  }
                }
              });
            } catch (e) {
              setIsLoadingStatus(false);
              print(e);
            }
          } else {
            setIsLoadingStatus(false);
            ErrorCustomCupertinoAlert()
                .showAlert(context, message: "No Data Found");
          }
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          setIsLoadingStatus(false);
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
        } else {
          setIsLoadingStatus(false);
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
        }
      } else {
        setIsLoadingStatus(false);
        setIsLoadingStatus(false);
        ErrorCustomCupertinoAlert()
            .showAlert(context, message: response?.statusMessage ?? '');
      }
    } else {
      setIsLoadingStatus(false);
      setIsLoadingStatus(false);
      InternetCheckAlert().showAlert(context);
    }
    notifyListeners();
  }

  bool isMasterDataDownloaded = false;
  bool get getIsMasterDataDownloaded => isMasterDataDownloaded;
  checkMasterData(BuildContext context) async {
    setIsLoadingStatus(true);
    final genderData = await databaseInstance.getGenderData();
    final casteData = await databaseInstance.getCasteData();
    final districtData = await databaseInstance.getDistrictsData();
    final electricityUnitsData =
        await databaseInstance.getElectricityUnitsData();
    final gasCompaniesData = await databaseInstance.getGasCompaniesData();
    final occupationData = await databaseInstance.getOccupationData();
    final relationshipData = await databaseInstance.getRelationshipData();
    setIsLoadingStatus(false);
    if (genderData.isNotEmpty ||
        casteData.isNotEmpty ||
        districtData.isNotEmpty ||
        electricityUnitsData.isNotEmpty ||
        gasCompaniesData.isNotEmpty ||
        occupationData.isNotEmpty ||
        relationshipData.isNotEmpty) {
      isMasterDataDownloaded = true;
      notifyListeners();
    }
    print('genderData: $genderData');
    print('casteData: $casteData');
    print('districtData: $districtData');
    print('electricityUnitsData: $electricityUnitsData');
    print('gasCompaniesData: $gasCompaniesData');
    print('occupationData: $occupationData');
    print('relationshipData: $relationshipData');
    return isMasterDataDownloaded;
  }

  //Download GeoGraphicsMasters Api Call
  getDownloadGeographicMasters(BuildContext context) async {
    if (await InternetCheck()) {
      setIsLoadingStatus(true);
      final response = await downloadMastersRepository
          .downloadGeographicsMastersRepo(context);

      if (response != null) {
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          //DatabaseInsertion Code

          if (response.geoGrapicData != null) {
            try {
              response.geoGrapicData?.residentiaLSTATUS
                  ?.forEach((residentialElement) async {
                await databaseInstance
                    .insertResidentailData(residentialElement);
              });
              response.geoGrapicData?.ownership
                  ?.forEach((ownershipElement) async {
                await databaseInstance.insertOwnershipData(ownershipElement);
              });
              response.geoGrapicData?.typEROOF
                  ?.forEach((typeRoofElement) async {
                await databaseInstance.insertRoofTypeData(typeRoofElement);
              });
              response.geoGrapicData?.cheyutha?.forEach((cheyuthElement) async {
                await databaseInstance.insertCheyuthaData(cheyuthElement);
              });
              response.geoGrapicData?.toddytapper
                  ?.forEach((toddyTapperElement) async {
                await databaseInstance
                    .insertToddyTapperData(toddyTapperElement);
              });
              response.geoGrapicData?.singlewomen?.forEach((singleWomen) async {
                await databaseInstance.insertSingleWomenData(singleWomen);
              });
              response.geoGrapicData?.pension?.forEach((pension) async {
                await databaseInstance.insertPensionData(pension);
              });
              await checkisGeoGraphicsMasterData(context).then((value) {
                setIsLoadingStatus(false);
                if (value) {
                  if (getIsisGeoGraphicsMasterDataDownloaded) {
                    SuccessCustomCupertinoAlert().showAlert(
                        context: context,
                        title: "Geographics Masters Downloaded Successfully",
                        onPressed: () {
                          if (getIsisGeoGraphicsMasterDataDownloaded == true &&
                              getIsMasterDataDownloaded == true) {
                            Navigator.pushNamed(context, AppRoutes.dashboard);
                          } else {
                            Navigator.pop(context);
                          }
                        });
                  }
                }
              });
            } catch (e) {
              setIsLoadingStatus(false);
              print(e);
            }
          } else {
            setIsLoadingStatus(false);
            ErrorCustomCupertinoAlert()
                .showAlert(context, message: "No Data Found");
          }
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          setIsLoadingStatus(false);
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
        } else {
          setIsLoadingStatus(false);
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
        }
      } else {
        setIsLoadingStatus(false);
        setIsLoadingStatus(false);
        ErrorCustomCupertinoAlert()
            .showAlert(context, message: response?.statusMessage ?? '');
      }
    } else {
      setIsLoadingStatus(false);
      setIsLoadingStatus(false);
      InternetCheckAlert().showAlert(context);
    }
    notifyListeners();
  }

  bool isGeoGraphicsMasterDataDownloaded = false;
  bool get getIsisGeoGraphicsMasterDataDownloaded =>
      isGeoGraphicsMasterDataDownloaded;
  checkisGeoGraphicsMasterData(BuildContext context) async {
    setIsLoadingStatus(true);
    final residentialStatusData =
        await databaseInstance.getResidentailStatusData();
    final ownershipStatusData = await databaseInstance.getOwnerShipData();
    final typeRoofStatusData = await databaseInstance.getRoofTypeStatusData();
    final cheyuthaMaster = await databaseInstance.getcheyuthaData();
    final singleWomenMaster = await databaseInstance.getsingleWomenData();
     final pensionMaster = await databaseInstance.getPensionData();

    setIsLoadingStatus(false);
    if (residentialStatusData.isNotEmpty ||
        ownershipStatusData.isNotEmpty ||
        typeRoofStatusData.isNotEmpty ||
        cheyuthaMaster.isNotEmpty ||
        singleWomenMaster.isNotEmpty||
        pensionMaster.isNotEmpty ) {
      isGeoGraphicsMasterDataDownloaded = true;
      notifyListeners();
    }
    print('residentialStatusData11: $residentialStatusData');
     print('pensionMaster111: $pensionMaster');

    return isGeoGraphicsMasterDataDownloaded;
  }

  void NavigationToDashboard(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dashboard);
  }

  deleteDbData() async {
    await databaseInstance.deleteAllData();
  }

  deleteSecndData() async {
    await databaseInstance.deleteSecndData();
  }
}

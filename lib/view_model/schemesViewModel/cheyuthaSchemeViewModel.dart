import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/cheyuta/cheyuta_submit_local.dart';
import 'package:praja_palana/models/cheyuta/table_info_cheyutha.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/utils/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/database.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../models/master_data/master_geograpics_response.dart';

class CheyuthaSchemeViewModel extends ChangeNotifier {
  String selectedDivyang = '';
  String selectedOthers = '';
  String selectedOldage = '';
  String selectedWidow = '';
  String selectedToddyTappers = '';
  String selectedWeavers = '';
  String selectedDialysisPatients = '';
  String selectedHivAidsPatients = '';
  String selectedBeediWorkers = '';
  String selectedFilariaPatients = '';
  String selectedSingleWomen = '';
  String selectedBeediTekedar = '';
  String? selectedApplicantCooperativeSociety = '';
  String? selectedLegalDocumentSingleWomen = '';
  Singlewomen? selectedSingleWomenCategory;
  TextEditingController sadaramCertificateNoController =
      TextEditingController();
  TextEditingController sadaramCertificateNoEditController =
      TextEditingController();
  changeStatusOfDivyang(String val) {
    selectedDivyang = val;

    notifyListeners();
  }

  changeStatusOfOthers(String val) {
    selectedOthers = val;
    notifyListeners();
  }

  changeStatusOfOldage(String val) {
    selectedOldage = val;
    notifyListeners();
  }

  changeStatusOfWidow(String val) {
    selectedWidow = val;
    notifyListeners();
  }

  changeStatusOfToddyTappers(String val) {
    selectedToddyTappers = val;
    notifyListeners();
  }

  changeStatusOfWeavers(String val) {
    selectedWeavers = val;
    notifyListeners();
  }

  changeStatusOfDialysisPatients(String val) {
    selectedDialysisPatients = val;
    notifyListeners();
  }

  changeStatusOfHivAidsPatients(String val) {
    selectedHivAidsPatients = val;
    notifyListeners();
  }

  changeStatusOfBeediWorkers(String val) {
    selectedBeediWorkers = val;
    notifyListeners();
  }

  changeStatusOfFilariaPatients(String val) {
    selectedFilariaPatients = val;
    notifyListeners();
  }

  changeStatusOfSingleWomen(String val) {
    selectedSingleWomen = val;
    notifyListeners();
  }

  changeStatusOfBeediTekedar(String val) {
    selectedBeediTekedar = val;
    notifyListeners();
  }

  changeStatusOfApplicantCooperativeSociety(String val) {
    selectedApplicantCooperativeSociety = val;
    notifyListeners();
  }

  changeSingleWomenCategory(Singlewomen? val) {
    selectedSingleWomenCategory = val;
    notifyListeners();
  }

  changeLeagalDocumentSingleWomen(String val) {
    selectedLegalDocumentSingleWomen = val;
    notifyListeners();
  }

  final databaseInstance = DatabaseClient();
  List<Singlewomen> geoSingleData = [];
  List<Singlewomen> get getSingleWomenData => geoSingleData;
  getSingleWomenDetails(BuildContext context) async {
    final singleData = await databaseInstance.getsingleWomenData();
    geoSingleData = singleData;
  }

  List<Cheyutha> cheyuthaSchemesList = [];
  List<CheyutaSubmitLocalData> cheyuthaLocalBackList = [];
  List<Cheyutha> get getCheyuthaSchemesList => cheyuthaSchemesList;
  List<CheyutaSubmitLocalData> get getCheyuthaOnBAckList =>
      cheyuthaLocalBackList;
  getCheyuthaSchemeDetails(BuildContext context) async {
    cheyuthaSchemesList = [];

    final cheyuthaData = await databaseInstance.getcheyuthaData();
    cheyuthaSchemesList = cheyuthaData;
    notifyListeners();
  }

  List<Toddytapper> toddyTappersTypeList = [];
  List<Toddytapper> get getToddyTappersTypeList => toddyTappersTypeList;
  getToddyTappersTypeDetails(BuildContext context) async {
    final toddyTapperList = await databaseInstance.gettoddyTapperData();
    toddyTappersTypeList = toddyTapperList;
  }

  CheyuthaEdit? cheyuthaDetailsEdit;
  getConfigurableCheyuthaData() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist = await prefs.getString(SharedPrefConstants.cheyuthaFlag);
    final list = json.decode(Stringlist ?? "");
    cheyuthaDetailsEdit = (CheyuthaEdit.fromJson(list));
    return cheyuthaDetailsEdit;
  }

  List<CheyuthaTableInfo> cheyuthaTableInfo = [];
  Future<List<CheyuthaTableInfo>> getCheyuthaTableInfoList() async {
    cheyuthaTableInfo.clear();
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList("TableInfo");

    if (jsonStringList != null) {
      cheyuthaTableInfo = jsonStringList
          .map((jsonString) =>
              CheyuthaTableInfo.fromJson(jsonDecode(jsonString)))
          .toList();
      return cheyuthaTableInfo;
    } else {
      return [];
    }
  }

  CheyuthaMdl? cheyuthaDetails;
  getCheyuthaDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final Stringlist =
        await prefs.getString(SharedPrefConstants.cheyuthaDetailsData);
    final list = json.decode(Stringlist ?? "");
    cheyuthaDetails = (CheyuthaMdl.fromJson(list));
    return cheyuthaDetails;
  }

  getCheyutaBackLocalList(List<CheyutaSubmitLocalData> listt) {
    cheyuthaLocalBackList = listt;
    print("Listtttysty${jsonEncode(listt)}");
    notifyListeners();
  }

  removebacklist(
      List<CheyuthaTableInfo> addedschemelist, int tableIndex) {
    print("beforeraddSchema${jsonEncode(addedschemelist)}");
    print("tableIndex${tableIndex}");
    // cheyuthaLocalBackList.removeWhere((item) =>
    //     item.familyID == addedschemelist[tableIndex].selectedFamilyMember?.id);

        print('Before: ${cheyuthaLocalBackList.length}');
        print("afterraddSchema${jsonEncode(cheyuthaLocalBackList)}");
          print('BeforeFamiliyIDCh: ${addedschemelist[tableIndex].selectedFamilyMember?.id}');


cheyuthaLocalBackList.removeWhere((item) =>
    int.tryParse(item.familyID?? "") == addedschemelist[tableIndex].selectedFamilyMember?.id);
      notifyListeners();
print('After: ${cheyuthaLocalBackList.length}');
    // print("afterraddSchema${jsonEncode(addedschemelist)}");
    // print("afterremove${cheyuthaLocalBackList.length}");
   
  }

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  bool isCheyuthaDetailsFlag = false;
  SetisCheyuthaDetailsFlag(bool status) {
    isCheyuthaDetailsFlag = status;
    notifyListeners();
  }

  onSaveClick(
      {required CheyutaSubmitLocalModel cheyutaSubmitLocalModel,
      required BuildContext context,
      required List<CheyutaSubmitLocalData>? cheyutaList}) async {
    setIsLoadingStatus(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPrefConstants.cheyutha);
    // AppConstants.cheyutaSubmitLocalModelList
    //     ?.addAll(cheyutaSubmitLocalModel.data ?? []);
    //print("cheyutaSubmitLocalModelList--------- ${jsonEncode(AppConstants.cheyutaSubmitLocalModelList)}");

    // final editedCheyuthaString =
    //     jsonEncode(AppConstants.cheyutaSubmitLocalModelList);
    //
    // print("editedCheyuthaString--------- $editedCheyuthaString");
    // print(
    //     "cheyutha list length ::: ${AppConstants.cheyutaSubmitLocalModelList?.length}");

    List<CheyutaSubmitLocalData> data1 = [];
    data1.addAll(List<CheyutaSubmitLocalData>.from(json
        .decode(jsonEncode(cheyutaList))
        .map((x) => CheyutaSubmitLocalData.fromJson(x))));

    //getData.addAll(List<Users>.from(json.decode(response.body).map((x) => Users.fromJson(x))));

    /*  CheyutaSubmitLocalModel mood =
        CheyutaSubmitLocalModel.fromJson(jsonDecode(editedCheyuthaString ?? "")); */

    print("data1--------- ${jsonEncode(data1)}");

    await prefs
        .setString(SharedPrefConstants.cheyutha, jsonEncode(cheyutaList))
        .then((value) async {
      await prefs.setBool(SharedPrefConstants.isCheyuthaDetailsSaved, true);
      isCheyuthaDetailsFlag =
          prefs.getBool(SharedPrefConstants.isCheyuthaDetailsSaved) ?? false;
      setIsLoadingStatus(false);
    });
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:praja_palana/models/applicant_details/applicant_schemewise_details_response.dart';
import 'package:praja_palana/models/applicant_details/applicant_schemewise_payload.dart';
import 'package:praja_palana/models/cheyuta/cheyuta_submit_local.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_payload.dart';
import 'package:praja_palana/repository/aplicant_details_repository.dart';
import 'package:praja_palana/repository/application_final_submit_repository.dart';
import 'package:praja_palana/res/CustomAlerts/back_alert.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/view_model/schemesViewModel/application_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/cheyuthaSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/family_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/gruhaJyothiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/indirammaIndluSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/mahaLakshmiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/rythuBharosaSchemeNewViewModel.dart';
import 'package:praja_palana/view_model/validate_mpin_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/final_submit/application_final_submit_payload.dart';
import '../models/remarks_model.dart';
import '../repository/configurable_fields_repository.dart';
import '../res/CustomAlerts/custom_error_alert.dart';
import '../res/CustomAlerts/internet_check_alert.dart';
import '../utils/api_error_codes.dart';
import '../utils/get_device_address.dart';
import '../utils/internet.dart';
import '../utils/shared_pref_constants.dart';

class ApplicantDashboardViewModel extends ChangeNotifier {
 

  bool _isLoading = false;
  bool get getIsLoadingStatus => _isLoading;
  setIsLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }



  void NavigationsThroughIcons(navigatorApproute, BuildContext context) {
    Navigator.pushNamed(context, navigatorApproute);
  }

  void navigateTo(
      {required BuildContext context,
      required int index,
      required bool flag,
      required bool editableFamilyFlag,
      required bool editableSchemeFlag}) {
    if (flag == true) {
      if (index == 0) {
        Navigator.pushNamed(context, AppRoutes.ApplicantDetails,
            arguments: editableFamilyFlag);
      } else if (index == 1) {
        Navigator.pushNamed(context, AppRoutes.FamilyMembersDetails,
            arguments: editableFamilyFlag);
      } /* else if (index == 2) {
      Navigator.pushNamed(context, AppRoutes.AddressDetails);
    } */
      else if (index == 2) {
        Navigator.pushNamed(context, AppRoutes.mahaLakshmiScheme,
            arguments: editableSchemeFlag);
      } else if (index == 3) {
        Navigator.pushNamed(context, AppRoutes.rythuBharosaSchemeNew,
            arguments: editableSchemeFlag);
      } else if (index == 4) {
        Navigator.pushNamed(context, AppRoutes.indirammaIndluScheme,
            arguments: editableSchemeFlag);
      } else if (index == 5) {
        Navigator.pushNamed(context, AppRoutes.gruhaJyothiScheme,
            arguments: editableSchemeFlag);
      } else if (index == 6) {
        Navigator.pushNamed(context, AppRoutes.cheyuthaScheme,
            arguments: editableSchemeFlag);
      }
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text('Application is not submitted for this scheme'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  //Applicant Editable fields services
  configurableFieldsService(
    BuildContext context,
  ) async {
    if (await InternetCheck()) {
      final loginResponseProvider =
          Provider.of<ValidateMpinViewModel>(context, listen: false);
      final loginDetailsResponse = loginResponseProvider.getLoginDetails;
      setIsLoadingStatus(true);
      ConfigurableFieldsPayload payload = ConfigurableFieldsPayload(
        iTOKENID: loginDetailsResponse?.data?.iTOKENID,
        userid: loginDetailsResponse?.data?.userid,
        applType: AppConstants.titleText,
      );
      print("userid11=${loginDetailsResponse?.data?.userid}");

      final response = await ConfigurableFieldsRepository()
          .getConfigurableFieldsRepository(context, payload);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          if (response.applicantdetailsEdit != null) {
            String applicantsFields =
                json.encode(response.applicantdetailsEdit);
            await prefs.setString(
                SharedPrefConstants.applicantFlag, applicantsFields);
          }
          if (response.familydetailsEdit != null) {
            String familyFields = json.encode(response.familydetailsEdit);

            await prefs.setString(SharedPrefConstants.familyFlag, familyFields);
          }
          if (response.addressdetailsEdit != null) {
            String addressFields = json.encode(response.addressdetailsEdit);

            await prefs.setString(
                SharedPrefConstants.addressFlag, addressFields);
          }
          if (response.mahalakshmiEdit != null) {
            String mahalakshmiSchemeFields =
                json.encode(response.mahalakshmiEdit);

            await prefs.setString(
                SharedPrefConstants.mahalakshmiFlag, mahalakshmiSchemeFields);
          }
          if (response.rythubharosaEdit != null) {
            String rythuBharosaSchemeFields =
                json.encode(response.rythubharosaEdit);

            await prefs.setString(
                SharedPrefConstants.rythuBharosaFlag, rythuBharosaSchemeFields);
          }
          if (response.inditammaEdit != null) {
            String indirammaIndluSchemeFields =
                json.encode(response.inditammaEdit);

            await prefs.setString(SharedPrefConstants.indirammaIndluFlag,
                indirammaIndluSchemeFields);
          }
          if (response.gruhajyothiEdit != null) {
            String gruhaJyothiSchemeFields =
                json.encode(response.gruhajyothiEdit);

            await prefs.setString(
                SharedPrefConstants.gruhaJyothiFlag, gruhaJyothiSchemeFields);
          }
          if (response.cheyuthaEdit != null) {
            String cheyuthaSchemeFields = json.encode(response.cheyuthaEdit);

            await prefs.setString(
                SharedPrefConstants.cheyuthaFlag, cheyuthaSchemeFields);
          }
          notifyListeners();

          setIsLoadingStatus(false);
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          setIsLoadingStatus(false);
          // ErrorCustomCupertinoAlert().showAlert(
          //   context,
          //   message: response.statusMessage ?? "",
          //   onPressed: () async {
          //     Navigator.pop(context);
          //   },
          // );
        } else if (response.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
          // ErrorCustomCupertinoAlert().showAlert(context,
          //     message: response.statusMessage ?? '', onPressed: () {
          //   Navigator.pushReplacementNamed(context, AppRoutes.login);
          // });
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          // ErrorCustomCupertinoAlert()
          //     .showAlert(context, message: response.statusMessage ?? '');
        } else {
          // EasyLoading.dismiss();
          // ErrorCustomCupertinoAlert()
          //     .showAlert(context, message: response.statusMessage ?? '');
        }
      }
    } else {
      InternetCheckAlert().showAlert(context);
    }
  }

  PersonalDtlsMdl? personalDtlsMdl;
  //Applicant Details For All the forms
  getApplicationDetails(BuildContext context, int idd) async {
    if (await InternetCheck()) {
      final loginResponseProvider =
          Provider.of<ValidateMpinViewModel>(context, listen: false);
      final loginDetailsResponse = loginResponseProvider.getLoginDetails;
      setIsLoadingStatus(true);
      /* final payload = GetApplicantDetailsPayload(
        iTOKENID: loginDetailsResponse?.data?.iTOKENID,
        userid: loginDetailsResponse?.data?.userid,
        onlinEAPPLICATIONNO: applicationNo,
      ); */
      final payload = ApplicationSchemewisePayload(
          iTOKENID: loginDetailsResponse?.data?.iTOKENID,
          userid: loginDetailsResponse?.data?.userid,
          distid: int.parse(loginDetailsResponse?.data?.districtid ?? ""),
          idd: idd);
      print("userid22=${loginDetailsResponse?.data?.userid}");

      final response = await ApplicantDetailsRepository()
          .getApplicationSchemeRepository(context, payload);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          if (response.data?.personalDtlsMdl != null) {
            personalDtlsMdl = response.data?.personalDtlsMdl;
            notifyListeners();
            String applicantsDetailsData =
                json.encode(response.data?.personalDtlsMdl);

            await prefs.setString(SharedPrefConstants.applicantDetailsData,
                applicantsDetailsData);
          }
          if (response.data?.familyListMdl != null) {
            String familyDetailsData =
                json.encode(response.data?.familyListMdl);

            await prefs.setString(
                SharedPrefConstants.familyDetailsData, familyDetailsData);
          }
          if (response.data?.mahalakshmiMdl != null) {
            String mahalakshmiSchemeData =
                json.encode(response.data?.mahalakshmiMdl);

            await prefs.setString(SharedPrefConstants.mahalakshmiDetailsData,
                mahalakshmiSchemeData);
          }
          if (response.data?.raithubharosaMdl != null) {
            String rythuBharosaSchemeData =
                json.encode(response.data?.raithubharosaMdl);

            await prefs.setString(SharedPrefConstants.rythuBharosaDetailsData,
                rythuBharosaSchemeData);
          }
          if (response.data?.indirammaIndluMdl != null) {
            String indirammaIndluSchemeData =
                json.encode(response.data?.indirammaIndluMdl);

            await prefs.setString(SharedPrefConstants.indirammaIndluDetailsData,
                indirammaIndluSchemeData);
          }
          if (response.data?.gruhajyothiMdl != null) {
            String gruhaJyothiSchemeData =
                json.encode(response.data?.gruhajyothiMdl);

            await prefs.setString(SharedPrefConstants.gruhaJyothiDetailsData,
                gruhaJyothiSchemeData);
          }
          if (response.data?.cheyuthaMdl != null) {
            String cheyuthaSchemeData = json.encode(response.data?.cheyuthaMdl);

            await prefs.setString(
                SharedPrefConstants.cheyuthaDetailsData, cheyuthaSchemeData);
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
      }
    } else {
      InternetCheckAlert().showAlert(context);
    }
  }

  List<RemarksData> remarksList = [];
  List<RemarksData> get getRemarksList => remarksList;

  getRemarks(BuildContext context) async {
    final response =
        await ApplicantDetailsRepository().getRemarksRepository(context);
    if (response?.statusCode == ApiErrorCodes.SUCCESS) {
      remarksList = response?.data ?? [];
    } else if (response?.statusCode == ApiErrorCodes.BAD_REQUEST) {
      setIsLoadingStatus(false);
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: response?.statusMessage ?? "",
        onPressed: () async {
          Navigator.pop(context);
        },
      );
    } else if (response?.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
      ErrorCustomCupertinoAlert().showAlert(context,
          message: response?.statusMessage ?? '', onPressed: () {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    } else if (response?.statusCode == ApiErrorCodes.BAD_REQUEST) {
      ErrorCustomCupertinoAlert()
          .showAlert(context, message: response?.statusMessage ?? '');
    } else {
      ErrorCustomCupertinoAlert()
          .showAlert(context, message: response?.statusMessage ?? '');
    }
  }

  List<FamilyListMdl> familyData = [];
  //List<CheyutaSubmitLocalData> cheyuthaFinalData = [];
  List<ListCheyuthaMdl> cheyuthaFinalData = [];
  onUpdate(BuildContext context, int selectedRemarksId) async {
    //setIsLoadingStatus(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final cheess = await prefs.getString(SharedPrefConstants.cheyutha);

    final applicant =
        await prefs.getString(SharedPrefConstants.applicantDetailsData);
    final family = await prefs.getString(SharedPrefConstants.familyDetailsData);
    final mahalakshmi =
        await prefs.getString(SharedPrefConstants.mahalakshmiDetailsData);
    final rythuBharosa =
        await prefs.getString(SharedPrefConstants.rythuBharosaDetailsData);
    final indirammaIndlu =
        await prefs.getString(SharedPrefConstants.indirammaIndluDetailsData);
    final gruhaJyothi =
        await prefs.getString(SharedPrefConstants.gruhaJyothiDetailsData);
    /*  final cheyutha =
        await prefs.getString(SharedPrefConstants.cheyuthaDetailsData); */
    final cheyutha = await prefs.getString(SharedPrefConstants.cheyutha);

    List<CheyutaSubmitLocalData> data1 = [];
    if (cheyutha != null && cheyutha.isNotEmpty) {
      data1.addAll(List<CheyutaSubmitLocalData>.from(json
          .decode(cheyutha)
          .map((x) => CheyutaSubmitLocalData.fromJson(x))));
    }

    print("data1 ${jsonEncode(data1)}");

    List<ListCheyuthaMdl> listCheyuthaMdlPayload = [];

    data1.forEach((element) {
      listCheyuthaMdlPayload.add(ListCheyuthaMdl(
          beediThekadarIndustryName: element.beediThekadarIndustryName,
          beediThekadarLicenceIssuedDate:
              element.beediThekadarLicenceIssuedDate,
          beediThekadarLicenseNumber: element.beediThekadarLicenseNumber,
          beediThekadarValidUpto: element.beediThekadarValidUpto,
          beediWorkerEPFEnrollmentNumber:
              element.beediWorkerEPFEnrollmentNumber,
          beediWorkerEnrollemntDate: element.beediWorkerEnrollemntDate,
          divyangulaSadaramID: element.divyangulaSadaramID,
          eligibleFlag: element.enableFlag,
          familyID: element.familyID,
          schemeID: element.schemeID,
          singleWomenCatgory: element.singleWomenCatgory,
          singleWomenDocuments: element.singleWomenDocuments,
          toddyTapperRegistrationType: element.toddyTapperRegistrationType,
          weaverCooperativeSociety: element.weaverCooperativeSociety,
          widowDateofDeath: element.widowDateofDeath,
          widowDeathCertificateNumber: element.widowDeathCertificateNumber));
    });

    print(
        "listCheyuthaMdlPayload _______ ${jsonEncode(listCheyuthaMdlPayload)}");
    //getData.addAll(List<Users>.from(json.decode(response.body).map((x) => Users.fromJson(x))));

    /* CheyutaSubmitLocalModel mood =
        CheyutaSubmitLocalModel.fromJson(jsonDecode(cheyutha ?? ""));
    print("mood ::: ${mood.data?.length}"); */
    final deviceId = await GetDeviceId().getDeviceId();
    final loginResponseProvider =
        Provider.of<ValidateMpinViewModel>(context, listen: false);
    final loginDetailsResponse = loginResponseProvider.getLoginDetails;
    final ipAddress = await GetDeviceIpAddress().GetIp();
    final AppData = PersonalDtlsMdl.fromJson(json.decode(applicant ?? ""));
    AppData.createdDeviceID = deviceId;
    AppData.createdIP = ipAddress;
    AppData.createdBy = loginDetailsResponse?.data?.userid ?? "";
    AppData.tokenID = loginDetailsResponse?.data?.iTOKENID ?? "";
    AppData.remarks = selectedRemarksId.toString();

    final list = json.decode(family ?? "");
    familyData.clear();
    list.forEach((element) {
      print(element);

      familyData.add(FamilyListMdl.fromJson(element));
    });
    /* final cheyuthaList = json.decode(cheyutha ?? "");

    print("cheyutha list _____________ ${jsonEncode(cheyuthaList)}"); */
    /* cheyuthaList.forEach((element) {
      print(element);
      cheyuthaFinalData.data = element;
    }); */
    print("familyData.length=${familyData.length}");
    final MahalakshmiData =
        MahalakshmiMdl.fromJson(json.decode(mahalakshmi ?? ""));
    final RythuBharosaData =
        RaithubharosaMdl.fromJson(json.decode(rythuBharosa ?? ""));
    final IndirammaIndluData =
        IndirammaIndluMdl.fromJson(json.decode(indirammaIndlu ?? ""));
    final GruhaJyothiData =
        GruhajyothiMdl.fromJson(json.decode(gruhaJyothi ?? ""));
    /* final cheyuthaFinalData =
        CheyutaSubmitLocalData.fromJson(json.decode(cheyutha ?? "")); */
    /* final cheyuthaFinalData =
        CheyutaSubmitLocalModel.fromJson(jsonDecode(cheyutha ?? ""));
    print("cheyuthaFinalData${jsonEncode(cheyuthaFinalData)}"); */

    final finalPayload = ApplicationFinalSubmitPayload(
        personalDtlsMdl: PersonalDtlsMdlNew.fromJson(AppData.toJson()),
        familyListMdl: familyData
            .map((e) => FamilyListMdlNew.fromJson(e.toJson()))
            .toList(),
        //commit
        mahalakshmiMdl: MahalakshmiMdlNew.fromJson(MahalakshmiData.toJson()),
        raithubharosaMdl:
            RaithubharosaMdlNew.fromJson(RythuBharosaData.toJson()),
        indirammaIndluMdl:
            IndirammaIndluMdlNew.fromJson(IndirammaIndluData.toJson()),
        gruhajyothiMdl: GruhajyothiMdlNew.fromJson(GruhaJyothiData.toJson()),
        listCheyuthaMdl: listCheyuthaMdlPayload
        //listCheyuthaMdl:ListCheyuthaMdl.fromJson(cheyuthaFinalData.data.toJson()),
        );

    final response = await ApplicationFinalSubmitRepository()
        .getApplicationfinalSubmitRepo(context, finalPayload);
    setIsLoadingStatus(false);
    try {
      if (response?.statusCode == ApiErrorCodes.SUCCESS) {
        showCupertinoDialog(
      context: context,
      builder: (BuildContext context11) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                CupertinoIcons.checkmark_alt_circle,
                size: 60.0,
                color: CupertinoColors.systemGreen,
              ),
              SizedBox(height: 8.0),
              Text(
                AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text( response?.message ?? "",),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                AppStrings.ok,
              ),
              onPressed: () async {
                 SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove(SharedPrefConstants.applicantDetailsData);
            await prefs.remove(SharedPrefConstants.familyDetailsData);
            await prefs.remove(SharedPrefConstants.mahalakshmiDetailsData);
            await prefs.remove(SharedPrefConstants.rythuBharosaDetailsData);
            await prefs.remove(SharedPrefConstants.indirammaIndluDetailsData);
            await prefs.remove(SharedPrefConstants.gruhaJyothiDetailsData);
            await prefs.remove(SharedPrefConstants.cheyuthaDetailsData);
            await prefs.remove(SharedPrefConstants.cheyutha);
             //Navigator.pop(context11);
            /* final rythuBharosaSchemeNewViewModel =
                Provider.of<RythuBharosaSchemeNewViewModel>(context);
            final mahaLakshmiSchemeViewModel =
                Provider.of<MahaLakshmiSchemeViewModel>(context);
            final applicantDetailsViewModel =
                Provider.of<ApplicantDetailsViewModel>(context);
            final familyDetailsViewModel =
                Provider.of<FamilyDetailsViewModel>(context);
            final gruhaJyothiViewModel =
                Provider.of<GruhaJyothiSchemeViewModel>(context);
            final cheyuthaViewModel =
                Provider.of<CheyuthaSchemeViewModel>(context,);
            final indirammaIndluViewModel =
                Provider.of<IndirammaIndluSchemeViewModel>(context,listen: true);
            rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag = false;
            mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag = false;
            cheyuthaViewModel.isCheyuthaDetailsFlag = false;
            indirammaIndluViewModel.isIndirammaIndluDetailsFlag = false;
            gruhaJyothiViewModel.isGruhaJyothiDetailsFlag = false;
            applicantDetailsViewModel.isApplicantDetailsFlag = false;
            familyDetailsViewModel.isFamilyDetailsFlag = false; */
            //Navigator.pop(context);
         
           Navigator.pushReplacementNamed(context11, AppRoutes.dashboard);

              }
            ),
          ],
        );
      },
    );
      /*   SuccessCustomCupertinoAlert().showAlert(
          context: context,
          title: response?.message ?? "",
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove(SharedPrefConstants.applicantDetailsData);
            await prefs.remove(SharedPrefConstants.familyDetailsData);
            await prefs.remove(SharedPrefConstants.mahalakshmiDetailsData);
            await prefs.remove(SharedPrefConstants.rythuBharosaDetailsData);
            await prefs.remove(SharedPrefConstants.indirammaIndluDetailsData);
            await prefs.remove(SharedPrefConstants.gruhaJyothiDetailsData);
            await prefs.remove(SharedPrefConstants.cheyuthaDetailsData);
            await prefs.remove(SharedPrefConstants.cheyutha);
            final rythuBharosaSchemeNewViewModel =
                Provider.of<RythuBharosaSchemeNewViewModel>(context,);
            final mahaLakshmiSchemeViewModel =
                Provider.of<MahaLakshmiSchemeViewModel>(context);
            final applicantDetailsViewModel =
                Provider.of<ApplicantDetailsViewModel>(context);
            final familyDetailsViewModel =
                Provider.of<FamilyDetailsViewModel>(context);
            final gruhaJyothiViewModel =
                Provider.of<GruhaJyothiSchemeViewModel>(context);
            final cheyuthaViewModel =
                Provider.of<CheyuthaSchemeViewModel>(context);
            final indirammaIndluViewModel =
                Provider.of<IndirammaIndluSchemeViewModel>(context);
            rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag = false;
            mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag = false;
            cheyuthaViewModel.isCheyuthaDetailsFlag = false;
            indirammaIndluViewModel.isIndirammaIndluDetailsFlag = false;
            gruhaJyothiViewModel.isGruhaJyothiDetailsFlag = false;
            applicantDetailsViewModel.isApplicantDetailsFlag = false;
            familyDetailsViewModel.isFamilyDetailsFlag = false;
            //Navigator.pop(context);
          Navigator.pop(context);
            Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          },
        ); */
      } else if (response?.statusCode == ApiErrorCodes.BAD_REQUEST) {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response?.message ?? "",
          onPressed: () async {
            Navigator.pop(context);
          },
        );
      } else if (response?.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
        ErrorCustomCupertinoAlert().showAlert(context,
            message: response?.statusMessage ?? '', onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        });
      } else {
        ErrorCustomCupertinoAlert()
            .showAlert(context, message: response?.statusMessage ?? '');
      }
    } catch (e) {
      setIsLoadingStatus(false);
    }
  }

  applicantDetailsClear(
      BuildContext context,
      ApplicantDetailsViewModel applicantDetailsViewModel,
      RythuBharosaSchemeNewViewModel rythuBharosaSchemeNewViewModel,
      MahaLakshmiSchemeViewModel mahaLakshmiSchemeViewModel,
      FamilyDetailsViewModel familyDetailsViewModel,
      CheyuthaSchemeViewModel cheyuthaViewModel,
      IndirammaIndluSchemeViewModel indirammaIndluViewModel,
      GruhaJyothiSchemeViewModel gruhaJyothiViewModel) async {
    bool ApplicantDetails =
        applicantDetailsViewModel.isApplicantDetailsFlag ?? false;
    bool FamilyDetails = familyDetailsViewModel.isFamilyDetailsFlag ?? false;
    bool MahalakshmiDetails =
        mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag ?? false;
    bool RythuBharosaDetails =
        rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag ?? false;
    bool IndirammaIndluDetails =
        indirammaIndluViewModel.isIndirammaIndluDetailsFlag ?? false;
    bool GruhaJyothiDetails =
        gruhaJyothiViewModel.isGruhaJyothiDetailsFlag ?? false;
    bool CheyuthaDetails = cheyuthaViewModel.isCheyuthaDetailsFlag;
    if (ApplicantDetails ||
        FamilyDetails ||
        MahalakshmiDetails ||
        RythuBharosaDetails ||
        IndirammaIndluDetails ||
        GruhaJyothiDetails ||
        CheyuthaDetails) {
      BackAlert().showAlert(
        context: context,
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove(SharedPrefConstants.cheyuthaDetailsData);
          await prefs.remove(SharedPrefConstants.gruhaJyothiDetailsData);
          await prefs.remove(SharedPrefConstants.indirammaIndluDetailsData);
          await prefs.remove(SharedPrefConstants.mahalakshmiDetailsData);
          await prefs.remove(SharedPrefConstants.rythuBharosaDetailsData);
          await prefs.remove("TableInfo");
          AppConstants.cheyutaSubmitLocalModelList = [];
          applicantDetailsViewModel.isApplicantDetailsFlag = false;
          familyDetailsViewModel.isFamilyDetailsFlag = false;
          mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag = false;
          rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag = false;
          indirammaIndluViewModel.isIndirammaIndluDetailsFlag = false;
          gruhaJyothiViewModel.isGruhaJyothiDetailsFlag = false;
          cheyuthaViewModel.isCheyuthaDetailsFlag = false;
          rythuBharosaDetailsClear(rythuBharosaSchemeNewViewModel);
          notifyListeners();
          Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
        },
      );
    } else {
      Navigator.pop(context);
    }
  }

  rythuBharosaDetailsClear(
      RythuBharosaSchemeNewViewModel rythuBharosaSchemeNewViewModel) {
    rythuBharosaSchemeNewViewModel.selectedAnyHouseholdWithLandType = '';
    rythuBharosaSchemeNewViewModel.registeredWageSeekerController.text = '';
    rythuBharosaSchemeNewViewModel.noOfWageSeekerController.text = '';
    rythuBharosaSchemeNewViewModel.totalDaysWorkedController.text = '';
  }

  flagsClearing(
      BuildContext context,
      ApplicantDetailsViewModel applicantDetailsViewModel,
      RythuBharosaSchemeNewViewModel rythuBharosaSchemeNewViewModel,
      MahaLakshmiSchemeViewModel mahaLakshmiSchemeViewModel,
      FamilyDetailsViewModel familyDetailsViewModel,
      CheyuthaSchemeViewModel cheyuthaViewModel,
      IndirammaIndluSchemeViewModel indirammaIndluViewModel,
      GruhaJyothiSchemeViewModel gruhaJyothiViewModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPrefConstants.cheyuthaDetailsData);
    await prefs.remove(SharedPrefConstants.gruhaJyothiDetailsData);
    await prefs.remove(SharedPrefConstants.indirammaIndluDetailsData);
    await prefs.remove(SharedPrefConstants.mahalakshmiDetailsData);
    await prefs.remove(SharedPrefConstants.rythuBharosaDetailsData);
    await prefs.remove(SharedPrefConstants.cheyutha);
    await prefs.remove("TableInfo");
    AppConstants.cheyutaSubmitLocalModelList = [];
    applicantDetailsViewModel.isApplicantDetailsFlag = false;
    familyDetailsViewModel.isFamilyDetailsFlag = false;
    mahaLakshmiSchemeViewModel.isMahalakshmiDetailsFlag = false;
    rythuBharosaSchemeNewViewModel.isRythuBharosaDetailsFlag = false;
    indirammaIndluViewModel.isIndirammaIndluDetailsFlag = false;
    gruhaJyothiViewModel.isGruhaJyothiDetailsFlag = false;
    cheyuthaViewModel.isCheyuthaDetailsFlag = false;
    rythuBharosaDetailsClear(rythuBharosaSchemeNewViewModel);
    notifyListeners();
  }
}

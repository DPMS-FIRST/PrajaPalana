import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/routes/app_pages.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/view_model/aplication_search_view_model.dart';
import 'package:praja_palana/view_model/applicant_dashboard_view_model.dart';
import 'package:praja_palana/view_model/applicationStatusViewModel/applicationStatusViewModel.dart';
import 'package:praja_palana/view_model/dashboard_list_view_model.dart';
import 'package:praja_palana/view_model/dashboard_report_view_model.dart';
import 'package:praja_palana/view_model/dashboard_view_model.dart';
import 'package:praja_palana/view_model/download_masters_view_model.dart';
import 'package:praja_palana/view_model/login_view_model.dart';
import 'package:praja_palana/view_model/login_with_mobile_view_model.dart';
import 'package:praja_palana/view_model/otp_view_model.dart';
import 'package:praja_palana/view_model/preview_view_model.dart';
import 'package:praja_palana/view_model/reset_password_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/application_details_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/cheyuthaSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/gruhaJyothiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/indirammaIndluSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/mahaLakshmiSchemeViewModel.dart';
import 'package:praja_palana/view_model/schemesViewModel/rythuBharosaSchemeNewViewModel.dart';
import 'package:praja_palana/view_model/set_mpin_view_model.dart';
import 'package:praja_palana/view_model/valid_ration_aadhaar_viewmodel.dart';
import 'package:praja_palana/view_model/validate_mpin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'res/constants/app_strings.dart';
import 'view_model/schemesViewModel/family_details_view_model.dart';
import 'view_model/sidemenu_view_model.dart';
import 'view_model/splash_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError; */
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en', 'US'), Locale('te', 'IN')],
      path: 'assets/translation',
      startLocale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'))));
}

//-------- Main Dart---------------
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => LoginWithMobileViewModel()),
        ChangeNotifierProvider(create: (context) => SetMpinViewModel()),
        ChangeNotifierProvider(create: (context) => ValidateMpinViewModel()),
        ChangeNotifierProvider(create: (context) => OtpViewModel()),
        ChangeNotifierProvider(create: (context) => ResetPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => DashboardViewModel()),
        ChangeNotifierProvider(create: (context) => SideMenuViewModel()),
        ChangeNotifierProvider(
            create: (context) => MahaLakshmiSchemeViewModel()),
        /*  ChangeNotifierProvider(
            create: (context) => RythuBharosaSchemeViewModel()), */
        ChangeNotifierProvider(
            create: (context) => IndirammaIndluSchemeViewModel()),
        ChangeNotifierProvider(create: (context) => DashboardListViewModel()),
        ChangeNotifierProvider(
            create: (context) => GruhaJyothiSchemeViewModel()),
        ChangeNotifierProvider(create: (context) => CheyuthaSchemeViewModel()),
        ChangeNotifierProvider(
            create: (context) => ApplicationSearchViewModel()),
        ChangeNotifierProvider(create: (context) => DownloadMastersViewModel()),
        ChangeNotifierProvider(
            create: (context) => ApplicantDashboardViewModel()),
        ChangeNotifierProvider(
            create: (context) => ApplicantDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => FamilyDetailsViewModel()),
        // ChangeNotifierProvider(create: (context) => AddressDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => PreviewViewModel()),
        ChangeNotifierProvider(
            create: (context) => ApplicationStatusViewModel()),
        ChangeNotifierProvider(
            create: (context) => RythuBharosaSchemeNewViewModel()),
        ChangeNotifierProvider(
            create: (context) => ValidateAadhaarRationViewModel()),
        ChangeNotifierProvider(
            create: (context) => DashboardReportsViewModel()),
      ],
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        initialRoute: AppRoutes.initial,
        routes: AppPages.routes,
        theme: ThemeData(
            fontFamily: 'ElMessiri',
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primaryColorDark,
              foregroundColor: AppColors.white,
              titleTextStyle: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: AppColors.white,
              ),
            )),
        darkTheme: ThemeData(
            fontFamily: 'ElMessiri',
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primaryColorDark,
              foregroundColor: AppColors.white,
              titleTextStyle: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: AppColors.white,
              ),
            )),
        highContrastTheme: ThemeData(
          fontFamily: 'ElMessiri',
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: AppColors.primaryColorDark,
            foregroundColor: AppColors.white,
            titleTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
          ),
        ),
        highContrastDarkTheme: ThemeData(
          fontFamily: 'ElMessiri',
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primaryColorDark,
            foregroundColor: AppColors.white,
            titleTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

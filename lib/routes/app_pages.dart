import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/view/abstract.dart';
import 'package:praja_palana/view/applicationStatus/applicationStatus.dart';
import 'package:praja_palana/view/applicationStatus/applicationStatusDetails.dart';
import 'package:praja_palana/view/download_masters_view.dart';
import 'package:praja_palana/view/app_info.dart';
import 'package:praja_palana/view/applicant_dashboard.dart';
import 'package:praja_palana/view/dashboard.dart';
import 'package:praja_palana/view/dashboard_list.dart';
import 'package:praja_palana/view/family_details/applicant_details.dart';
import 'package:praja_palana/view/family_details/family_members_details.dart';
import 'package:praja_palana/view/forgot_password.dart';
import 'package:praja_palana/view/login.dart';
import 'package:praja_palana/view/otp.dart';
import 'package:praja_palana/view/preview.dart';
import 'package:praja_palana/view/privacy_policy.dart';
import 'package:praja_palana/view/schemes/gruhaJyothiScheme.dart';
import 'package:praja_palana/view/schemes/indirammaIndluScheme.dart';
import 'package:praja_palana/view/schemes/mahaLakshmiScheme.dart';
import 'package:praja_palana/view/schemes/rythuBharosaSchemeNew.dart';
import 'package:praja_palana/view/set_mpin.dart';
import 'package:praja_palana/view/table.dart';
import 'package:praja_palana/view/validate_mpin.dart';
import 'package:flutter/material.dart';
import '../view/dashboard_report_view.dart';
import '../view/schemes/cheyutha_scheme_new.dart';
import '../view/search_view.dart';
import '../view/splash_view.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.splash: (context) => SplashView(),
      AppRoutes.login: (context) => LoginScreen(),
      AppRoutes.setMpin: (context) => SetMPINPage(),
      AppRoutes.validateMpin: (context) => ValidateMpin(),
      AppRoutes.otp: (context) => Otp(),
      AppRoutes.resetPassword: (context) => ForgotPasswordPage(),
      AppRoutes.dashboard: (context) => DashboardView(),
      AppRoutes.privacy_policy: (context) => PrivacyPolicy(),
      AppRoutes.ApplicantDetails: (context) => ApplicantDetails(),
      AppRoutes.FamilyMembersDetails: (context) => FamilyMembersDetails(),
      // AppRoutes.AddressDetails: (context) => AddressDetails(),
      AppRoutes.mahaLakshmiScheme: (context) => MahaLakshmiScheme(),
      //AppRoutes.rythuBharosaScheme: (context) => RythuBharosaScheme(),
      AppRoutes.indirammaIndluScheme: (context) => IndirammaIndluScheme(),
      AppRoutes.applicantDashboard: (context) => ApplicantDashboard(),
      AppRoutes.dashboardList: (context) => DashboardList(),
      AppRoutes.appInfo: (context) => AppInfoView(),
      AppRoutes.gruhaJyothiScheme: (context) => GruhaJyothiScheme(),
      AppRoutes.cheyuthaScheme: (context) => CheyuthaSchemeUpdated(),
      AppRoutes.searchView: (context) => SearchView(),
      AppRoutes.preview: (context) => Preview(),
      AppRoutes.downloadMasters: (context) => DownloadMastersView(),
      AppRoutes.Abstract: (context) => Abstract(),
      AppRoutes.applicationstatus: (context) => ApplicationStatus(),
      AppRoutes.applicationstatusdetails: (context) =>
          ApplicationStatusDetails(),
      AppRoutes.rythuBharosaSchemeNew: (context) => RythuBharosaSchemeNew(),

      AppRoutes.ScrollableTableView: (context) => MyScrollableTableView(),
      AppRoutes.dashboardReport: (context) => DashboardReportView(),
    };
  }
}

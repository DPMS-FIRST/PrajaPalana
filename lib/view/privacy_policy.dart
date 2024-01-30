import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../res/constants/app_colors.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  WebViewController privacyPolicy_controller = WebViewController();
  WebViewController termsAndConditions_controller = WebViewController();
  WebViewController copyrights_controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop == false) Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.white),
          title: Text(
            "Privacy Policy",
            style: TextStyle(color: AppColors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appColor,
        ),
        body: Container(
          child: ContainedTabBarView(
            tabBarProperties: TabBarProperties(
                indicatorColor: AppColors.red, indicatorWeight: 3.0),
            tabs: [
              Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 14, color: AppColors.appColor),
              ),
              Text(
                "Terms and Conditions",
                style: TextStyle(fontSize: 14, color: AppColors.appColor),
                textAlign: TextAlign.center,
              ),
              Text(
                "Copyrights policy",
                style: TextStyle(fontSize: 14, color: AppColors.appColor),
              )
            ],
            views: [
              Container(
                child: WebViewWidget(
                  controller: privacyPolicy_controller
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0x00000000))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onWebResourceError: (WebResourceError error) {},
                      ),
                    )
                    ..loadRequest(Uri.parse(
                        'https://www.cgg.gov.in/mgov-privacy-policy/?depot_name=Centre%20for%20Good%20Governance%20(CGG),%20Govt.%20of%20Telangana')),
                  gestureRecognizers: Set()
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
                ),
              ),
              Container(
                child: WebViewWidget(
                  controller: termsAndConditions_controller
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0x00000000))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onWebResourceError: (WebResourceError error) {},
                      ),
                    )
                    ..loadRequest(Uri.parse(
                        'https://www.cgg.gov.in/mgov-terms-conditions/?depot_name=Centre%20for%20Good%20Governance%20(CGG),%20Govt.%20of%20Telangana&capital=Hyderabad,%20Telangana')),
                  gestureRecognizers: Set()
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
                ),
              ),
              Container(
                child: WebViewWidget(
                  controller: copyrights_controller
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0x00000000))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onWebResourceError: (WebResourceError error) {},
                      ),
                    )
                    ..loadRequest(Uri.parse(
                        'https://www.cgg.gov.in/mgov-copyright-policy/?depot_name=Centre%20for%20Good%20Governance%20(CGG),%20Govt.%20of%20Telangana&depot_email=info@cgg.gov.in')),
                  gestureRecognizers: Set()
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

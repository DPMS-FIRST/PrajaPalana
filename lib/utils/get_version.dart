import 'package:package_info_plus/package_info_plus.dart';

class getCurrentVersion {
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print("version :${packageInfo.version}");
    return packageInfo.version;
  }
}

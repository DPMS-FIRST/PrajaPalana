import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class GetDeviceId {
  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }
}

class GetDeviceIpAddress {
  GetIp() async {
    if (Platform.isIOS) {
      for (var interface in await NetworkInterface.list()) {
        if (interface.name == 'en0' || interface.name == 'en1') {
          for (var addr in interface.addresses) {
            if (addr.type == InternetAddressType.IPv4) {
              return "${addr.address}";
            }
          }
        }
      }
    } else if (Platform.isAndroid) {
      for (var interface in await NetworkInterface.list()) {
        print('== Interface: ${interface.name} ==');
        for (var addr in interface.addresses) {
          print(
              '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
          return "${addr.address}";
        }
      }
    }
    return null;
  }
}

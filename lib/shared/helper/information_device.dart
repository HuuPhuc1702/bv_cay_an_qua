import 'package:bv_cay_an_qua/app_config.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../../config/app_key.dart';
import '../../services/spref.dart';

getInfoDevice() async {
  try {
    var deviceId = await PlatformDeviceId.getDeviceId;
    // print("deviceId----- $deviceId");
    if (appConfig.appType == AppType.DOCTOR) {
      await SPref.instance.set(AppKey.deviceId, "${deviceId ?? ""}DOCTOR");
    } else {
      await SPref.instance.set(AppKey.deviceId, "${deviceId ?? ""}FARMER");
    }

    // print("deviceId-2 ${SPref.instance.get(AppKey.deviceId)}");
  } catch (error) {
    throw error;
  }
}

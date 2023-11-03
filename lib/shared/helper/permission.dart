

import 'package:permission_handler/permission_handler.dart';

permissionInit()async{

  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses = await [
    // Permission.locationWhenInUse,
    Permission.microphone,
    Permission.location,
    Permission.storage,
    Permission.camera,
    Permission.notification,
    Permission.photos,
  ].request();
  print(statuses[Permission.location]);

  // var status = await Permission.storage.status;
  // print("status-----------${status.isGranted}");
  // if (!status.isGranted) {
  //   await Permission.storage.request();
  // }
}
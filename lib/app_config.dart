
enum AppType { DOCTOR, FARMER }

class AppConfig {
  final String appName;
  final AppType appType;

  AppConfig({required this.appName,required this.appType});
}

AppConfig appConfig=AppConfig(appName: "",appType: AppType.FARMER);

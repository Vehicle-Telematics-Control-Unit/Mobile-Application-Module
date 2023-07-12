class ApiEndPoints {
  static const String baseUrl = 'https://vehicleplus.cloud';
  static const String loginUrl = '/authentication/mobile/login';
  static const String logout = '/authentication/mobile/logout';
  static const String resendCode = '/authentication/mobile/resendcode';
  static const String verifyMail = '/authentication/mobile/verifymail';
  static const String requestAccess =
      '/authentication/mobile/shareAccess/request';
  static const String submitAccess =
      '/authentication/mobile/shareAccess/submit';
  static const String wakeUpTCU = '/alerts/WakeUp';
  static const String changePassword = '/authentication/mobile/editPassword';
  static const String changeUsername = '/authentication/mobile/editUsername';
  static const String feature = '/OTA/mobile/features';
  static const String getTcuId = '/GPS/tcu';
  static const String getFeatureImage = "/OTA/mobile/features/images";
}

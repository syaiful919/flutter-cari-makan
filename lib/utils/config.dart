class ProjectConfig {
  static const String projectName = 'Cari Makan';

  static const bool useProd = true;

  static const String androidVersion = "1.0.0";
  static const String iosVersion = "1.0.0";

  static const String androidLink = "";

  static const String iosLink = "";
}

String callbackUrl() {
  if (ProjectConfig.useProd == true) {
    return 'foodmarket-backend.buildwithangga.id/';
  } else {
    return "secure-tor-45980.herokuapp.com/";
  }
}

String storageUrl() {
  if (ProjectConfig.useProd == true) {
    return 'http://foodmarket-backend.buildwithangga.id/storage/';
  } else {
    return "http://secure-tor-45980.herokuapp.com/storage/";
  }
}

String baseUrl() {
  if (ProjectConfig.useProd == true) {
    return 'https://foodmarket-backend.buildwithangga.id/api/';
  } else {
    return "http://secure-tor-45980.herokuapp.com/api/";
  }
}

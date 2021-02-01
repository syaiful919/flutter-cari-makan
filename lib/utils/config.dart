class ProjectConfig {
  static const String projectName = 'Cari Makan';

  static const bool useProd = true;

  static const String androidVersion = "1.0.0";
  static const String iosVersion = "1.0.0";

  static const String androidLink = "";

  static const String iosLink = "";
}

String baseUrl() {
  if (ProjectConfig.useProd == true) {
    return 'https://foodmarket-backend.buildwithangga.id/api/';
  } else {
    return "http://vast-tundra-16919.herokuapp.com/api/";
  }
}

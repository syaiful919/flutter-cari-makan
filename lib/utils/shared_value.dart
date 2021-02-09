class PlatformType {
  static const String android = 'android';
  static const String ios = 'ios';
  static const String browser = 'browser';
}

class Permissiontype {
  static const String guest = 'guest';
  static const String member = 'member';
}

class RequestMethod {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

enum AuthType {
  NO_AUTH,
  OAUTH1,
  BEARER,
  BASIC,
}

enum FoodType { new_food, popular, recommended }
enum TransactionStatus { delivered, on_delivery, pending, cancelled }

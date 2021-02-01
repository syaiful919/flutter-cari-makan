class CustomException implements Exception {
  final message;
  final _prefix;

  CustomException([this.message, this._prefix]);

  String toString() => "$_prefix$message";
}

class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class ServerErrorException extends CustomException {
  ServerErrorException([message]) : super(message, "Server Error: ");
}

class ForbiddenException extends CustomException {
  ForbiddenException([message]) : super(message, "Forbidden: ");
}

class CanceledException extends CustomException {
  CanceledException([message]) : super("Canceled by user", "Canceled: ");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "Not found: ");
}

class NotSupportedException extends CustomException {
  NotSupportedException([message]) : super(message, "Not supported: ");
}

/// Typed exceptions the app's UI layer can branch on, mapped from HTTP
/// status codes per the backend integration guide's error-handling table.
sealed class AppException implements Exception {
  final String message;
  final String userMessage;

  const AppException(this.message, this.userMessage);

  @override
  String toString() => message;
}

class BadRequestException extends AppException {
  BadRequestException([String? detail])
      : super(
          'Bad request: ${detail ?? ''}',
          detail?.isNotEmpty == true ? detail! : 'تحقق من البيانات المدخلة',
        );
}

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super('Unauthorized (401)', 'انتهت الجلسة، يرجى تسجيل الدخول مرة أخرى');
}

class ForbiddenException extends AppException {
  const ForbiddenException()
      : super('Forbidden (403)', 'ليس لديك صلاحية للقيام بهذا الإجراء');
}

class NotFoundException extends AppException {
  NotFoundException([String? detail])
      : super(
          'Not found: ${detail ?? ''}',
          detail?.isNotEmpty == true ? detail! : 'العنصر المطلوب غير موجود',
        );
}

class ServerException extends AppException {
  const ServerException()
      : super('Server error (5xx)', 'حدث خطأ في الخادم، حاول مرة أخرى لاحقاً');
}

class NetworkException extends AppException {
  const NetworkException([String reason = 'انقطع الاتصال بالإنترنت'])
      : super('Network error', reason);
}

class UnknownApiException extends AppException {
  const UnknownApiException([String detail = 'حدث خطأ غير متوقع'])
      : super('Unknown API error', detail);
}

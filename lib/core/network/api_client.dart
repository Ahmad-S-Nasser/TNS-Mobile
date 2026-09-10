import 'package:dio/dio.dart';
import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/core/services/secure_storage_service.dart';

/// Thin Dio wrapper: injects the bearer token, maps every failure to a typed
/// [AppException], and lets the app react to a 401 from anywhere (forced
/// logout) without every call site handling it individually.
///
/// [onUnauthorized] is set post-construction by the DI setup (service_locator)
/// once the auth session object exists, avoiding a circular dependency
/// between the network layer and the auth layer.
class ApiClient {
  final Dio _dio;
  final SecureStorageService _storage;

  void Function()? onUnauthorized;

  ApiClient({required SecureStorageService storage, Dio? dio})
      : _storage = storage,
        _dio = dio ??
            Dio(BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
              headers: {'Content-Type': 'application/json'},
            )) {
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final skipAuth = options.extra['skipAuth'] == true;
        if (!skipAuth) {
          final token = await _storage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        handler.next(options);
      }),
    );
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) =>
      _request(() => _dio.get(path, queryParameters: query));

  Future<dynamic> post(String path,
          {Map<String, dynamic>? body, bool skipAuth = false}) =>
      _request(() => _dio.post(path,
          data: body, options: Options(extra: {'skipAuth': skipAuth})));

  Future<dynamic> put(String path, {Map<String, dynamic>? body}) =>
      _request(() => _dio.put(path, data: body));

  Future<dynamic> patch(String path, {Map<String, dynamic>? body}) =>
      _request(() => _dio.patch(path, data: body));

  Future<dynamic> delete(String path) => _request(() => _dio.delete(path));

  Future<dynamic> _request(Future<Response> Function() call) async {
    try {
      final response = await call();
      return response.data;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  AppException _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException('انتهت مهلة الاتصال بالخادم');
      case DioExceptionType.connectionError:
        return const NetworkException();
      default:
        break;
    }

    final int? status = e.response?.statusCode;
    final data = e.response?.data;
    final message = data is Map ? (data['error'] ?? data['message']) : null;
    final userMessage = message?.toString();

    if (status == null) return const NetworkException();
    if (status == 400) return BadRequestException(userMessage);
    if (status == 401) {
      onUnauthorized?.call();
      return const UnauthorizedException();
    }
    if (status == 403) return const ForbiddenException();
    if (status == 404) return NotFoundException(userMessage);
    if (status >= 500) return const ServerException();
    return UnknownApiException(userMessage ?? 'HTTP $status');
  }
}

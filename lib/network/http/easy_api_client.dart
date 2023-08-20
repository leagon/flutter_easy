import 'package:dio/dio.dart';
import 'package:flutter_easy/network/cookie_manager/easy_cookie_manager.dart';
import 'package:rxdart/rxdart.dart';

enum HttpPermissionState { normal, notIn }

class EasyApiClient {
  static final Map<String, dynamic> _headers = {
    'Accept-Language': 'en-US',
    'Content-Type': 'application/json',
    'X-GLOBAL-VERSION': '-1',
    'X-APP': 'Mobile/Easy/1.0.0',
  };
  static const connectTimeout = 60000;
  static const receiveTimeout = 60000;

  // Subjects
  PublishSubject<HttpPermissionState> onPermission =
      PublishSubject<HttpPermissionState>();

  late Dio _dio;

  Dio get dio => _dio;

  final EasyCookieManager cookieManager;

  EasyApiClient(
    this.cookieManager,
    String baseUrl, {
    bool debugMode = false,
    String? origin,
  }) {
    Map<String, dynamic> header = _headers.map(
      (key, value) => MapEntry(key, value),
    );
    if (origin != null) header['Origin'] = origin;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: header,
        connectTimeout: const Duration(milliseconds: connectTimeout),
        receiveTimeout: const Duration(milliseconds: receiveTimeout),
        validateStatus: (status) {
          if (status != null) {
            return status < 500;
          } else {
            return false;
          }
        },
      ),
    );

    cookieManager.init().then((value) {
      _dio.interceptors.add(cookieManager.interceptor);
    });

    /// Recommended to check through DevTool network
    if (debugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: debugMode,
          responseHeader: debugMode,
          request: debugMode,
          requestBody: debugMode,
          requestHeader: debugMode,
        ),
      );
    }
  }

  void update({required String baseUrl, required String originHeader}) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Origin'] = originHeader;
  }

  void close() {
    onPermission.close();
  }
}

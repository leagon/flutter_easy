import 'dart:io';

import 'package:dio/dio.dart';

class MemoryCookieInterceptor extends Interceptor {
  final Map<String, List<Cookie>> _cookies = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var cookie = getCookies(options.uri.host);
    if (cookie.isNotEmpty) {
      options.headers[HttpHeaders.cookieHeader] = cookie;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _saveCookies(response)
        .then((_) => handler.next(response))
        .catchError((e, stackTrace) {
      var err = DioException(requestOptions: response.requestOptions, error: e);
      err = err.copyWith(stackTrace: stackTrace);
      handler.reject(err, true);
    });
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      _saveCookies(err.response!)
          .then((_) => handler.next(err))
          .catchError((e, stackTrace) {
        var err0 = DioException(
          requestOptions: err.response!.requestOptions,
          error: e,
        );
        err0 = err0.copyWith(stackTrace: stackTrace);
        handler.next(err0);
      });
    } else {
      handler.next(err);
    }
  }

  Future<void> _saveCookies(Response response) async {
    var cookies = response.headers[HttpHeaders.setCookieHeader];

    if (cookies != null) {
      _cookies[response.requestOptions.uri.host] =
          cookies.map((str) => Cookie.fromSetCookieValue(str)).toList();
    }
  }

  String getCookies(String host) {
    final cookies = _cookies[host] ?? [];
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }

  List<Cookie> loadCookies(Uri uri) => _cookies[uri.host] ?? [];
}

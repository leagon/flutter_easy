import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class EasyCookieInterceptor extends CookieManager {
  EasyCookieInterceptor(super.cookieJar);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.realUri.path.contains('temporary_login')) {
      handler.next(response);
      return;
    }
    super.onResponse(response, handler);
  }

  Future<bool> updateCookieToken(String token, String baseUrl) async {
    Future<void> _updateCookieToken(String baseUrl) async {
      try {
        final uri = Uri.parse(baseUrl);
        final cookies = await cookieJar.loadForRequest(uri);
        var cookie = Cookie('jwt', token);
        if (cookies.isNotEmpty) {
          cookie.path = cookies[0].path;
          cookie.domain = cookies[0].domain;
          cookie.expires = cookies[0].expires;
          cookie.httpOnly = cookies[0].httpOnly;
          cookie.maxAge = cookies[0].maxAge;
          cookie.secure = cookies[0].secure;
        }
        final dealerCookie = Cookie('user', 'dealer');
        await cookieJar.delete(uri);
        await cookieJar.saveFromResponse(uri, [cookie, dealerCookie]);
      } catch (e) {
        rethrow;
      }
    }

    try {
      await _updateCookieToken(baseUrl);
      return true;
    } catch (_) {
      return false;
    }
  }
}

import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:synchronized/synchronized.dart';

import 'easy_cookie_manager.dart';
import 'memory_cookie_interceptor.dart';

class MemoryCookieManager extends EasyCookieManager {
  MemoryCookieManager({required super.baseUrl});

  final _lock = Lock();
  bool _hasInit = false;

  final MemoryCookieInterceptor memoryInterceptor = MemoryCookieInterceptor();

  @override
  Future<void> init() async {
    await _lock.synchronized(() {
      if (_hasInit) return;
      cookieJar = CookieJar();
      _hasInit = true;
    });
  }

  @override
  Future<List<Cookie>> loadCookies() {
    return Future.value(memoryInterceptor.loadCookies(Uri.parse(baseUrl)));
  }
}

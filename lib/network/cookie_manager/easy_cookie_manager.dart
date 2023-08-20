import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:synchronized/synchronized.dart';

class EasyCookieManager {
  String _baseUrl;

  String get baseUrl => _baseUrl;

  EasyCookieManager({required String baseUrl}) : _baseUrl = baseUrl {
    init();
  }

  void update({required String baseUrl}) {
    _baseUrl = baseUrl;
  }

  void dispose() => onHasToken.close();

  // fist is hasCookie, second is dealer user or vision user
  final PublishSubject<bool> onHasToken = PublishSubject();

  late final CookieJar cookieJar;

  bool _hasInit = false;
  final _lock = Lock();

  Future<void> init() async {
    await _lock.synchronized(() async {
      if (_hasInit == false) {
        final path = await _persistCookiePath();

        if (path == null) {
          cookieJar = CookieJar();
        } else {
          cookieJar = PersistCookieJar(storage: FileStorage(path));
        }
        _hasInit = true;
        _checkToken();
      }
    });
  }

  Future<List<Cookie>> loadCookies() async {
    return await cookieJar.loadForRequest(Uri.parse(_baseUrl));
  }
}

extension TuringCookieManagerEx on EasyCookieManager {
  Future<String?> _persistCookiePath() async {
    const subPathCookie = '/cookies/';
    try {
      final dirForSup = await getApplicationSupportDirectory();
      final dirPathForSupCoo = dirForSup.path + subPathCookie;

      final dirForDoc = await getApplicationDocumentsDirectory();
      final dirPathForDocuCoo = dirForDoc.path + subPathCookie;

      final existed = await Directory(dirPathForDocuCoo).exists();

      // doc/cookies/ exist
      if (existed) {
        final cookieSubEntities = Directory(
          dirPathForDocuCoo,
        ).listSync(recursive: true);

        // cookies/ sub (dir or file) exis
        if (cookieSubEntities.isNotEmpty) {
          final entities = cookieSubEntities.where(
            (e) =>
                FileSystemEntity.typeSync(e.path) == FileSystemEntityType.file,
          );

          for (var entity in entities) {
            final resPath = entity.path.replaceAll(
              dirForDoc.path,
              dirForSup.path,
            );
            (entity as File).copy(resPath);
          }
        }

        await Directory(dirPathForDocuCoo).delete(recursive: true);
      }
      return dirPathForSupCoo;
    } catch (_) {
      return null;
    }
  }

  void _checkToken() async {
    try {
      final cookies = await cookieJar.loadForRequest(Uri.parse(_baseUrl));
      onHasToken.add(cookies.isNotEmpty);
    } catch (error) {
      onHasToken.add(false);
    }
  }
}

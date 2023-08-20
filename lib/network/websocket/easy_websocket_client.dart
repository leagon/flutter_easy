import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easy/flutter_easy.dart';
import 'package:flutter_easy/network/cookie_manager/easy_cookie_manager.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'websocket_error.dart';

class EasyWebsocketClient implements Disposable {
  Map<String, Completer> clientRequests = {};
  Map<String, Function> serverRequestHandlers = {};
  Map<String, Function> serverResponseHandlers = {};
  IOWebSocketChannel? channel;
  Map<String, String>? headers;

  String _websocketUrl;
  final EasyCookieManager cookieManager;
  final bool debugMode;

  @override
  void dispose() {
    cookieManager.dispose();
    channel?.sink.close(status.goingAway);
  }

  void update({required String websocketUrl}) {
    _websocketUrl = websocketUrl;
  }

  EasyWebsocketClient({
    required String websocketUrl,
    required this.cookieManager,
    this.debugMode = false,
  }) : _websocketUrl = websocketUrl {
    // This is the program's only call to loadCookies().
    // /// start stream
    // registerServerResponseHandler(
    //   cameraStartStreamValue.response(),
    //   onCameraStartStreamResponse,
    // );
    //
    // /// event2.version.changed
    // registerServerRequestHandler(
    //   event2VersionChangedValue,
    //   onEvent2VersionChangedResponse,
    // );
  }

  void registerServerResponseHandler(String act, Function handler) {
    serverResponseHandlers[act] = handler;
  }

  void registerServerRequestHandler(String act, Function handler) {
    serverRequestHandlers[act] = handler;
  }

  Future<void> connect({
    Map<String, String> headers = const {},
  }) async {
    try {
      final cookies = await cookieManager.loadCookies();

      StringBuffer sb = StringBuffer();

      for (Cookie cookie in cookies) {
        sb.write(cookie.toString());
        sb.write(";");
      }
      final Map<String, String> resMap = Map.from(headers);

      resMap.addAll({'Cookie': sb.toString()});

      this.headers = resMap;

      channel = IOWebSocketChannel.connect(
        _websocketUrl,
        headers: resMap,
        pingInterval: const Duration(seconds: 30),
      );
    } catch (err) {
      error(err.toString());
    }

    channel?.stream.listen((message) {
      if (message is String) onMessage(message);
    }, onDone: onDone, onError: onError, cancelOnError: false);
  }

  sendMessage(String message) async {
    await checkAndReconnect();
    if (debugMode) debug("message sent: $message");
    channel?.sink.add(message);
  }

  onMessage(String message) {
    if (debugMode) debug("message received: $message");

    final dict = json.decode(message);
    final id = dict['id'];
    final act = dict['act'];
    final err = dict['err'];
    final arg = dict['arg'];

    // check if message is request from server
    Function? serverRequestHandler = serverRequestHandlers[act];
    if (serverRequestHandler != null && arg != null) {
      serverRequestHandler(arg);
      return;
    }

    // if not request from server
    // check if message is response of clientRequest
    Completer? completer = clientRequests[id];
    if (completer != null) {
      // remove completer
      clientRequests.remove(id);

      // if error, handle error
      if (err['ec'] != 0) {
        completer.completeError(WebsocketError.fromJson(err));
        return;
      }

      // if operation success
      Function? serverResponseHandler = serverResponseHandlers[act];
      if (serverResponseHandler != null) {
        serverResponseHandler(completer, dict);
      } else {
        warning('response received but not handled: $message');
      }
      return;
    }

    // log unhandled message
    // debug('message received but not handled: $message');
  }

  onDone() {
    if (debugMode) debug("onDone");
  }

  onError(Object err, StackTrace stackTrace) {
    if (debugMode) error("onError: ${err.toString()}");
  }

  Future checkAndReconnect() async {
    if (channel == null ||
        channel?.closeCode != null ||
        channel?.innerWebSocket == null ||
        channel?.innerWebSocket?.readyState == WebSocket.closed) {
      final headers = this.headers;
      if (headers != null) {
        await connect();
      } else {
        error("Try to reconnect. headers is null");
      }
    }
  }

  /// parse response
  Map<String, dynamic> parseResponse(Map<String, dynamic> response) {
    if (!response.containsKey('err')) {
      throw WebsocketError.response();
    }

    final err = WebsocketError.fromJson(response['err']);
    if (err.ec != 0) {
      throw err;
    }

    if (response.containsKey('ret')) {
      final retJson = response['ret'];
      if (retJson is Map<String, dynamic>) return retJson;
    } else {
      return {};
    }

    throw WebsocketError.response();
  }

  /// event2.version.changed
// onEvent2VersionChangedResponse(Map<String, dynamic> response) {
//   try {
//     final data = EventVersionChangedSchema.fromJson(response);
//     onEventChanged.add(data);
//   } on WebsocketError catch (err) {
//     onEventChanged.addError(err);
//   } on TypeError catch (err) {
//     onEventChanged.addError(WebsocketError.response(message: err.toString()));
//   } catch (err) {
//     onEventChanged.addError(WebsocketError.unknown(err.toString()));
//   }
// }
}

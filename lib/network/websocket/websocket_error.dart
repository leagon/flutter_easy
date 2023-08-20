import 'package:flutter_easy/flutter_easy.dart';

class WebsocketError extends EasyError {
  const WebsocketError(super.ec, super.em, super.dm);

  @override
  WebsocketError copyWith({int? ec, String? em, String? dm}) =>
      WebsocketError(ec ?? this.ec, em ?? this.em, dm ?? this.dm);

  factory WebsocketError.fromJson(Map<String, dynamic> json) {
    int ec = json["ec"];
    String em = json["em"];
    String dm = json["dm"];
    return WebsocketError(ec, em, dm);
  }

  factory WebsocketError.unknown(String message) {
    return WebsocketError(ErrorCode.unknown, message, "WebsocketError");
  }

  factory WebsocketError.response({String? message}) {
    return WebsocketError(
        ErrorCode.badResponse, message ?? 'Response error', 'WebsocketError');
  }
}

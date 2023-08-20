import 'package:dio/dio.dart';

import 'api_error.dart';

void parseResponseVoid(Response response) =>
    parseResponseCommon(response, defaultValue: null);

Map<String, dynamic> parseResponse(Response response) =>
    parseResponseCommon(response, defaultValue: const {});

List parseResponseList(Response response) =>
    parseResponseCommon(response, defaultValue: const []);

String parseResponseString(Response response) =>
    parseResponseCommon(response, defaultValue: '');

double parseResponseDouble(Response response) =>
    parseResponseCommon(response, defaultValue: -1.0);

int parseResponseInt(Response response) =>
    parseResponseCommon(response, defaultValue: -1);

bool parseResponseBoolean(Response response) =>
    parseResponseCommon(response, defaultValue: false);

/// parse ('err', 'ret')
T parseResponseCommon<T>(
  Response response, {
  required T defaultValue,
}) {
  final data = response.data;

  if (data is! Map<String, dynamic>) {
    throw ApiError.response();
  }

  if (!data.containsKey('err')) {
    throw ApiError.response();
  }

  final errJson = data['err'];

  final err = ApiError.fromJson(errJson);

  if (err.ec != 0) {
    throw err;
  }

  final res = data['ret'];

  if (res != null) {
    return res;
  }

  return defaultValue;
}

/// parse 'results'
List<dynamic> parseResults(dynamic response) {
  final result = response['results'] ?? response['result'];

  if (result == null) {
    return [];
  }

  if (result is! List<dynamic>) {
    throw ApiError.response(message: 'parse results is not List');
  }

  return result;
}

/// parse 'data'
List<dynamic> parseData(dynamic response) {
  final data = response['data'];

  if (data == null) {
    return [];
  }

  if (data is! List<dynamic>) {
    throw ApiError.response(message: 'parse data is not List');
  }

  return data;
}

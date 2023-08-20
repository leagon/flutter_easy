import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easy/flutter_easy.dart';

import 'easy_api_client.dart';

extension ApiErrorEx on EasyApiClient {
  handleError(dynamic error) {
    if (error is DioException) {
      error = ApiError.fromDioException(error);
    }

    if (error is ApiError) {
      if (error.dm == "not_in" || error.dm == "agent") {
        onPermission.add(HttpPermissionState.notIn);
        cookieManager.cookieJar.deleteAll().catchError((_) {});
      }
      throw error;
    } else if (error is Exception) {
      throw ApiError.exception(error.toString());
    } else {
      throw ApiError.unknown(error.toString());
    }
  }
}

class ApiError extends EasyError {
  const ApiError(super.ec, super.em, super.dm);

  factory ApiError.fromJson(Map<String, dynamic> json) {
    int ec = json["ec"];
    String em = json["em"] ?? "";
    String dm = json["dm"] ?? "";
    return ApiError(ec, em, dm);
  }

  @override
  ApiError copyWith({int? ec, String? em, String? dm}) {
    return ApiError(ec ?? this.ec, em ?? this.em, dm ?? this.dm);
  }

  factory ApiError.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          ErrorCode.connectionTimeout,
          error.message ?? 'connectTimeout',
          'ApiError',
        );

      case DioExceptionType.sendTimeout:
        return ApiError(
          ErrorCode.sendTimeout,
          error.message ?? 'sendTimeout',
          'ApiError',
        );

      case DioExceptionType.receiveTimeout:
        return ApiError(
          ErrorCode.receiveTimeout,
          error.message ?? 'receiveTimeout',
          'ApiError',
        );

      case DioExceptionType.badCertificate:
        return ApiError(
          ErrorCode.badCertificate,
          error.message ?? 'badCertificate',
          'ApiError',
        );

      case DioExceptionType.badResponse:
        return ApiError(
          ErrorCode.badResponse,
          error.message ?? 'badResponse',
          'ApiError',
        );

      case DioExceptionType.cancel:
        return ApiError(
          ErrorCode.cancel,
          error.message ?? 'cancel',
          'ApiError',
        );

      case DioExceptionType.connectionError:
        return ApiError(
          ErrorCode.connectionError,
          error.message ?? 'Connection error',
          'ApiError',
        );

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiError(
            ErrorCode.socketException,
            error.message ?? 'SocketException',
            'ApiError',
          );
        } else {
          return ApiError(
            ErrorCode.apiUnknown,
            error.message ?? 'Unknown error',
            'ApiError',
          );
        }
    }
  }

  /// Exception Error
  factory ApiError.exception(String message) {
    return ApiError(
      ErrorCode.dartException,
      message,
      'ApiError',
    );
  }

  /// Other Error
  factory ApiError.other(String message) {
    return ApiError(ErrorCode.other, message, 'ApiError');
  }

  /// Other Error
  factory ApiError.unknown(String message) {
    return ApiError(ErrorCode.unknown, message, 'ApiError');
  }

  /// Response Error
  factory ApiError.response({String? message}) {
    return ApiError(
        ErrorCode.badResponse, message ?? 'BadResponse', 'ApiError');
  }
}

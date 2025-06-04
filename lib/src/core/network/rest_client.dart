import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:science_platform/src/core/exception/custom_exception.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/routes/app_pages.dart';

import 'endpoints.dart';
import 'pretty_dio_logger.dart';

class RestClient {
  late Dio _dio;

  RestClient() {
    BaseOptions options = BaseOptions(
      baseUrl: API.dev,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    _dio = Dio(options);
  }

  RestClient.dev() {
    BaseOptions options = BaseOptions(
      baseUrl: API.dev,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    _dio = Dio(options);
  }

  Future<Response<dynamic>> get(
    APIType apiType,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);

    return _dio
        .get(path, queryParameters: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> delete(
    APIType apiType,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);

    return _dio
        .delete(path, queryParameters: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> post(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .post(
          path,
          data: data,
          options: standardHeaders,
          queryParameters: queryParams,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  /// Supports media upload
  Future<Response<dynamic>> postFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll({
        'Content-Type': 'multipart/form-data',
      });
    }

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          options: standardHeaders,
          queryParameters: queryParams,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> put(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .put(
          path,
          data: data,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  /// Supports media upload
  Future<Response<dynamic>> putFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll({
        'Content-Type': 'multipart/form-data',
      });
    }
    data.addAll({
      '_method': 'PUT',
    });

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> putFormDataToUrl(
    String url, {
    dynamic body,
    int? length,
  }) async {
    return _dio
        .put(
          url,
          data: body,
          options: Options(
            headers: {
              'Content-Type': 'application/octet-stream',
              Headers.contentLengthHeader: length,
            },
          ),
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> downloadFile(
    String url,
    String savePath,
  ) async {
    return _dio
        .download(
          url,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              Log.info(
                  'Download progress: ${(received / total * 100).toStringAsFixed(0)}%');
            }
          },
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  dynamic _getDioException(error) {
    if (error is DioException) {
      Log.error(
          'DIO ERROR: ${error.type} ENDPOINT: ${error.requestOptions.baseUrl}${error.requestOptions.path}');
      final errorMessage = error.response?.data;
      switch (error.type) {
        case DioExceptionType.cancel:
          throw RequestCancelledException(
            001,
            'The request was cancelled. Please try again.',
          );
        case DioExceptionType.connectionTimeout:
          throw RequestTimeoutException(
            004,
            'Could not connect to the server. Please try again.',
          );
        case DioExceptionType.unknown:
          final message = errorMessage ?? '${error.response?.data['message']}';
          throw UnknownException(
            002,
            Get.snackbar(
              'Unknown Exception',
              message.toString(),
              snackPosition: SnackPosition.TOP,
            ),
          );
        case DioExceptionType.receiveTimeout:
          final message = errorMessage ?? '${error.response?.data['message']}';
          throw ReceiveTimeoutException(
            004,
            Get.snackbar(
              'Failed',
              message.toString(),
              snackPosition: SnackPosition.TOP,
            ),
          );
        case DioExceptionType.sendTimeout:
          final message = errorMessage ?? '${error.response?.data['message']}';
          throw RequestTimeoutException(
            004,
            Get.snackbar(
              'Failed',
              message.toString(),
              snackPosition: SnackPosition.TOP,
            ),
          );
        case DioExceptionType.badCertificate:
          throw BadRequestException(
            408,
            'Could not connect to the server.Please try again.',
          );
        case DioExceptionType.connectionError:
          final message = errorMessage ?? '${error.response?.data['message']}';
          throw RequestTimeoutException(
            522,
            Get.snackbar(
              'Failed',
              message.toString(),
              snackPosition: SnackPosition.TOP,
            ),
          );
        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case 400:
              // throw CustomException(400, jsonEncode(error.response?.data), ""); /// Before
              throw CustomException(
                400,
                error.response?.data["message"],
                "",
              );
            case 403:
              CacheService().dispose();
              getx.Get.offAllNamed(Routes.login);
              break;
            case 401:
              CacheService().dispose();
              getx.Get.offAllNamed(Routes.login);
              break;
            case 404:
              final message =
                  errorMessage ?? '${error.response?.data['message']}';
              throw NotFoundException(
                404,
                Get.snackbar(
                  'Failed',
                  message.toString(),
                  snackPosition: SnackPosition.TOP,
                ),
              );
            case 409:
              throw ConflictException(
                409,
                'Something went wrong. Please try again.',
              );
            case 408:
              final message =
                  errorMessage ?? '${error.response?.data['message']}';
              throw RequestTimeoutException(
                408,
                Get.snackbar(
                  'Failed',
                  message.toString(),
                  snackPosition: SnackPosition.TOP,
                ),
              );
            case 500:
              final message =
                  errorMessage ?? '${error.response?.data['message']}';
              throw InternalServerException(
                500,
                Get.snackbar(
                  'Failed',
                  message.toString(),
                  snackPosition: SnackPosition.TOP,
                ),
              );
            case 422:
              final message =
                  errorMessage ?? '${error.response?.data['message']}';
              throw UnprocessableEntityException(
                422,
                (message as Map).entries.first.value != null
                    ? Get.snackbar(
                        'Failed',
                        message.toString().replaceAll(RegExp('[{}]'), ''),
                        snackPosition: SnackPosition.TOP,
                      )
                    : null,
              );
            default:
              throw DefaultException(
                0002,
                errorMessage ?? 'Something went wrong. Please try again.',
              );
          }
      }
    } else {
      throw UnexpectedException(
        000,
        'Something went wrong. Please try again.',
      );
    }
  }

  void _setDioInterceptorList() {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode) {
      interceptorList.add(PrettyDioLogger());
    }
    _dio.interceptors.addAll(interceptorList);
  }

  Future<Options> _getOptions(APIType api) async {
    final box = GetStorage('Auth');
    final apiToken = await box.read(CacheKeys.token);

    switch (api) {
      case APIType.PUBLIC:
        return PublicApiOptions().options;

      case APIType.PROTECTED:
        return ProtectedApiOptions(apiToken).options;
    }
  }
}

abstract class ApiOptions {
  Options options = Options();
}

enum APIType { PUBLIC, PROTECTED }

class PublicApiOptions extends ApiOptions {
  PublicApiOptions() {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };
  }
}

class ProtectedApiOptions extends ApiOptions {
  ProtectedApiOptions(String apiToken) {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };
  }
}

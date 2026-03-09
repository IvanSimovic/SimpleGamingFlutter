import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _rawgBaseUrl = 'https://api.rawg.io/api/';
const _rawgApiKey = String.fromEnvironment('RAWG_API_KEY');

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: _rawgBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters['key'] = _rawgApiKey;
        handler.next(options);
      },
    ),
  );

  // Log requests in debug mode only
  assert(() {
    dio.interceptors.add(LogInterceptor(responseBody: false));
    return true;
  }());

  return dio;
});

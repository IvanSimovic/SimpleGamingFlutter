import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _rawgBaseUrl = 'https://api.rawg.io/api/';
// Hardcoded for this project. In production, use --dart-define=RAWG_API_KEY=...
// and read it with String.fromEnvironment('RAWG_API_KEY'). The key stays out
// of source control and lives in each developer's shell profile and CI secrets.
const _rawgApiKey = '4f38776b81314893a57a97b86af3eb90';

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

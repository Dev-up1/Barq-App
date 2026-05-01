import 'package:barq_recharge/core/config/app_env.dart';
import 'package:barq_recharge/core/errors/app_exception.dart';
import 'package:dio/dio.dart';

class AggregatorApiClient {
  AggregatorApiClient({
    Dio? dio,
    String? baseUrl,
    String? bearerToken,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl ?? AppEnv.aggregatorApiBaseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                sendTimeout: const Duration(seconds: 20),
                headers: <String, Object?>{
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    final token = bearerToken ?? AppEnv.aggregatorApiToken;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.baseUrl.isEmpty) {
            handler.reject(
              DioException(
                requestOptions: options,
                error: const ConfigurationException(
                  'Aggregator API base URL is missing.',
                ),
              ),
            );
            return;
          }

          if (token.isEmpty) {
            handler.reject(
              DioException(
                requestOptions: options,
                error: const ConfigurationException(
                  'Aggregator API token is missing.',
                ),
              ),
            );
            return;
          }

          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
      ),
    );
  }

  final Dio _dio;

  Dio get client => _dio;
}

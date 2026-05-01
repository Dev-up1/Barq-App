import 'package:barq_recharge/core/errors/app_exception.dart';
import 'package:barq_recharge/data/models/recharge_models.dart';
import 'package:dio/dio.dart';

class RechargeService {
  const RechargeService(this._dio);

  final Dio _dio;

  Future<RechargeResult> executeRecharge(ExecuteRechargeInput input) async {
    final payload = RechargePayloadDto(
      reference: input.localReference,
      targetIdentifier: input.targetIdentifier,
      psiCode: input.psiCode,
      baseAmountMinor: input.baseAmountMinor,
      taxAmountMinor: input.taxBreakdown.taxAmountMinor,
      totalAmountMinor: input.taxBreakdown.totalAmountMinor,
    );

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/recharge/execute',
        data: payload.toJson(),
      );

      return RechargeResult(
        reference: input.localReference,
        payload: payload,
        responseData: response.data ?? <String, dynamic>{},
      );
    } on DioException catch (error) {
      throw NetworkException(
        'Failed to execute recharge request.',
        code: 'recharge_request_failed',
        cause: error,
      );
    }
  }
}

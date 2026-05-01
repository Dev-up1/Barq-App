import 'package:barq_recharge/core/errors/app_exception.dart';
import 'package:dio/dio.dart';

class ArabicErrorMapper {
  const ArabicErrorMapper._();

  static String map(Object error) {
    if (error is ConfigurationException) {
      return 'إعدادات الربط غير مكتملة. تحقق من مفاتيح البيئة المطلوبة.';
    }

    if (error is PsiResolutionException) {
      return 'تعذر تحديد الخدمة المطلوبة حالياً. حاول تحديث البيانات لاحقاً.';
    }

    if (error is NetworkException) {
      return 'فشلت عملية الشحن بسبب مشكلة في الشبكة أو انتهاء المهلة.';
    }

    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        final code = data['code']?.toString();
        if (code == 'insufficient_balance') {
          return 'الرصيد غير كافٍ لإتمام العملية.';
        }
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';
      }

      return 'تعذر الاتصال بالخدمة حالياً.';
    }

    return 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
  }
}

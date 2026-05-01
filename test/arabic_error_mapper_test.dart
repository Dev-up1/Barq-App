import 'package:barq_recharge/core/errors/arabic_error_mapper.dart';
import 'package:barq_recharge/core/errors/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps configuration exception to arabic message', () {
    const error = ConfigurationException('missing config');

    expect(
      ArabicErrorMapper.map(error),
      contains('إعدادات الربط غير مكتملة'),
    );
  });
}

import 'package:barq_recharge/core/config/app_env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sms template contains expected placeholders by default', () {
    expect(AppEnv.aggregatorSmsTemplate, contains('{reference}'));
    expect(AppEnv.aggregatorSmsTemplate, contains('{psi_code}'));
    expect(AppEnv.aggregatorSmsTemplate, contains('{target}'));
    expect(AppEnv.aggregatorSmsTemplate, contains('{total_amount}'));
  });
}

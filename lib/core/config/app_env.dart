class AppEnv {
  const AppEnv._();

  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );
  static const aggregatorApiBaseUrl = String.fromEnvironment(
    'AGGREGATOR_API_BASE_URL',
  );
  static const aggregatorApiToken = String.fromEnvironment(
    'AGGREGATOR_API_TOKEN',
  );
  static const psiOverrideUrl = String.fromEnvironment('PSI_OVERRIDE_URL');
  static const aggregatorSmsNumber = String.fromEnvironment(
    'AGGREGATOR_SMS_NUMBER',
  );
  static const aggregatorSmsTemplate = String.fromEnvironment(
    'AGGREGATOR_SMS_TEMPLATE',
    defaultValue:
        'REF:{reference};PSI:{psi_code};TARGET:{target};AMOUNT:{base_amount};TAX:{tax_amount};TOTAL:{total_amount}',
  );
  static const whatsappSupportNumber = String.fromEnvironment(
    'WHATSAPP_SUPPORT_NUMBER',
  );
  static const whatsappSupportTemplate = String.fromEnvironment(
    'WHATSAPP_SUPPORT_TEMPLATE',
    defaultValue:
        'مرحباً، أحتاج دعماً بخصوص عملية فاشلة.\nالإصدار: {app_version}\nالمستخدم: {user_id}\nالمرجع: {transaction_reference}',
  );

  static bool get hasSupabaseConfig =>
      supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty;

  static bool get hasAggregatorConfig =>
      aggregatorApiBaseUrl.isNotEmpty && aggregatorApiToken.isNotEmpty;

  static bool get hasPsiOverrideUrl => psiOverrideUrl.isNotEmpty;

  static bool get hasSmsFallbackConfig => aggregatorSmsNumber.isNotEmpty;

  static bool get hasWhatsAppSupportConfig =>
      whatsappSupportNumber.isNotEmpty;
}

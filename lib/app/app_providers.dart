import 'package:barq_recharge/core/config/app_env.dart';
import 'package:barq_recharge/core/constants/mock_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppStage { splash, auth, home }

final appStageProvider = StateProvider<AppStage>((ref) => AppStage.splash);
final homeTabProvider = StateProvider<String>((ref) => 'home');
final serviceTabProvider =
    StateProvider<ServiceTab>((ref) => ServiceTab.services);
final isOfflineModeProvider = StateProvider<bool>((ref) => false);
final supabaseReadyProvider =
    Provider<bool>((ref) => AppEnv.hasSupabaseConfig);

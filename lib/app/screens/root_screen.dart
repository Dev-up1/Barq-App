import 'dart:async';

import 'package:barq_recharge/app/app_providers.dart';
import 'package:barq_recharge/features/auth/presentation/auth_screen.dart';
import 'package:barq_recharge/features/dashboard/presentation/dashboard_screen.dart';
import 'package:barq_recharge/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  Timer? _splashTimer;

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(
      const Duration(milliseconds: 2200),
      () => ref.read(appStageProvider.notifier).state = AppStage.auth,
    );
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stage = ref.watch(appStageProvider);

    return switch (stage) {
      AppStage.splash => const SplashScreen(),
      AppStage.auth => AuthScreen(
          onAuthenticated: () =>
              ref.read(appStageProvider.notifier).state = AppStage.home,
        ),
      AppStage.home => const DashboardScreen(),
    };
  }
}

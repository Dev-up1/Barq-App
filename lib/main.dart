import 'dart:io';

import 'package:barq_recharge/app/barq_app.dart';
import 'package:barq_recharge/bootstrap/bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

const _windowsMobileSize = Size(400, 800);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureWindowsMobileSimulation();

  await bootstrap(
    () => const ProviderScope(
      child: BarqApp(),
    ),
  );
}

Future<void> _configureWindowsMobileSimulation() async {
  if (kIsWeb || !Platform.isWindows) {
    return;
  }

  await windowManager.ensureInitialized();

  const options = WindowOptions(
    size: _windowsMobileSize,
    minimumSize: _windowsMobileSize,
    maximumSize: _windowsMobileSize,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  await windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.setResizable(false);
    await windowManager.setMaximizable(false);
    await windowManager.setMinimizable(true);
    await windowManager.setSize(_windowsMobileSize);
    await windowManager.setMinimumSize(_windowsMobileSize);
    await windowManager.setMaximumSize(_windowsMobileSize);
    await windowManager.center();
    await windowManager.show();
    await windowManager.focus();
  });
}

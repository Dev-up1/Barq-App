import 'package:barq_recharge/app/barq_app.dart';
import 'package:barq_recharge/bootstrap/bootstrap.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await bootstrap(
    () => const ProviderScope(
      child: BarqApp(),
    ),
  );
}

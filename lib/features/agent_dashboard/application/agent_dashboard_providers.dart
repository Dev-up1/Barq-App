import 'package:barq_recharge/app/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subAccountsListProvider = FutureProvider((ref) async {
  return ref.watch(subAccountsRepositoryProvider).fetchAll();
});

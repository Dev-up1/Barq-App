import 'package:barq_recharge/data/models/current_actor.dart';
import 'package:barq_recharge/data/models/limit_check_result.dart';
import 'package:barq_recharge/data/repositories/local_wallet_repository.dart';
import 'package:barq_recharge/data/repositories/transactions_repository.dart';

class SpendingLimitService {
  const SpendingLimitService({
    required LocalWalletRepository walletRepository,
    required TransactionsRepository transactionsRepository,
  })  : _walletRepository = walletRepository,
        _transactionsRepository = transactionsRepository;

  final LocalWalletRepository _walletRepository;
  final TransactionsRepository _transactionsRepository;

  Future<LimitCheckResult> evaluateRechargeLimit({
    required int transactionAmountMinor,
    required CurrentActor actor,
  }) async {
    final now = DateTime.now();
    final dayStart = DateTime(now.year, now.month, now.day);
    final monthStart = DateTime(now.year, now.month);
    final nextDay = dayStart.add(const Duration(days: 1));
    final nextMonth = DateTime(now.year, now.month + 1);

    final dailySpentMinor = await _transactionsRepository.sumTotalsForRange(
      start: dayStart,
      end: nextDay,
    );
    final monthlySpentMinor = await _transactionsRepository.sumTotalsForRange(
      start: monthStart,
      end: nextMonth,
    );

    final wallet = await _walletRepository.fetchCurrentWallet();
    final dailyLimit =
        actor.dailySpendingLimitMinor ?? wallet?.dailySpendingLimitMinor ?? 0;
    final monthlyLimit =
        actor.monthlySpendingLimitMinor ?? wallet?.monthlySpendingLimitMinor ?? 0;

    if (dailyLimit > 0 && dailySpentMinor + transactionAmountMinor > dailyLimit) {
      return LimitCheckResult(
        allowed: false,
        dailySpentMinor: dailySpentMinor,
        monthlySpentMinor: monthlySpentMinor,
        message: 'تم تجاوز الحد اليومي المسموح به لهذا الحساب.',
      );
    }

    if (monthlyLimit > 0 &&
        monthlySpentMinor + transactionAmountMinor > monthlyLimit) {
      return LimitCheckResult(
        allowed: false,
        dailySpentMinor: dailySpentMinor,
        monthlySpentMinor: monthlySpentMinor,
        message: 'تم تجاوز الحد الشهري المسموح به لهذا الحساب.',
      );
    }

    return LimitCheckResult(
      allowed: true,
      dailySpentMinor: dailySpentMinor,
      monthlySpentMinor: monthlySpentMinor,
    );
  }
}

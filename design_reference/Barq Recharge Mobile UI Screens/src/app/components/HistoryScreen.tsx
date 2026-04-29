import { motion } from "motion/react";
import { ArrowUpRight, ArrowDownLeft, Calendar, Filter } from "lucide-react";

const transactions = [
  { id: 1, type: "recharge", amount: 5000, recipient: "777 123 456", date: "2026-04-27", time: "14:30", status: "success" },
  { id: 2, type: "package", amount: 2500, recipient: "باقة 3 جيجا", date: "2026-04-26", time: "10:15", status: "success" },
  { id: 3, type: "transfer", amount: 1000, recipient: "733 456 789", date: "2026-04-25", time: "16:45", status: "success" },
  { id: 4, type: "bill", amount: 3000, recipient: "فاتورة كهرباء", date: "2026-04-24", time: "09:20", status: "pending" },
  { id: 5, type: "recharge", amount: 2000, recipient: "770 987 654", date: "2026-04-23", time: "12:00", status: "success" },
  { id: 6, type: "package", amount: 4000, recipient: "باقة 5 جيجا", date: "2026-04-22", time: "18:30", status: "failed" },
];

export function HistoryScreen() {
  const getTransactionIcon = (type: string) => {
    if (type === "recharge" || type === "package") return ArrowUpRight;
    return ArrowDownLeft;
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case "success": return "#10B981";
      case "pending": return "#F59E0B";
      case "failed": return "#EF4444";
      default: return "#717182";
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case "success": return "مكتملة";
      case "pending": return "قيد الانتظار";
      case "failed": return "فشلت";
      default: return "";
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 pb-24" dir="rtl">
      <div className="p-6">
        <div className="flex items-center justify-between mb-8">
          <h1 className="text-2xl text-foreground">سجل المعاملات</h1>
          <button
            className="p-2 rounded-xl backdrop-blur-xl"
            style={{
              background: "rgba(255, 255, 255, 0.6)",
              border: "1px solid rgba(255, 255, 255, 0.3)",
            }}
          >
            <Filter className="w-5 h-5 text-foreground" />
          </button>
        </div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-6 p-6 rounded-3xl backdrop-blur-xl"
          style={{
            background: "linear-gradient(135deg, rgba(165, 214, 243, 0.4) 0%, rgba(165, 214, 243, 0.2) 100%)",
            border: "1px solid rgba(255, 255, 255, 0.3)",
          }}
        >
          <p className="text-sm text-muted-foreground mb-2">إجمالي المعاملات هذا الشهر</p>
          <h2 className="text-3xl text-foreground mb-4">17,500 ريال</h2>
          <div className="flex gap-4 text-sm">
            <div>
              <p className="text-muted-foreground">الصادر</p>
              <p className="text-destructive">-12,000 ريال</p>
            </div>
            <div>
              <p className="text-muted-foreground">الوارد</p>
              <p className="text-primary">+5,500 ريال</p>
            </div>
          </div>
        </motion.div>

        <div className="mb-4 flex items-center gap-2 text-sm text-muted-foreground">
          <Calendar className="w-4 h-4" />
          <span>آخر 7 أيام</span>
        </div>

        <div className="space-y-3">
          {transactions.map((transaction, index) => {
            const Icon = getTransactionIcon(transaction.type);
            const statusColor = getStatusColor(transaction.status);

            return (
              <motion.div
                key={transaction.id}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.05 }}
                className="p-4 rounded-2xl backdrop-blur-xl"
                style={{
                  background: "rgba(255, 255, 255, 0.6)",
                  border: "1px solid rgba(255, 255, 255, 0.3)",
                }}
              >
                <div className="flex items-center gap-4">
                  <div
                    className="w-12 h-12 rounded-xl flex items-center justify-center"
                    style={{
                      background: transaction.type === "recharge" || transaction.type === "package"
                        ? "rgba(16, 185, 129, 0.1)"
                        : "rgba(239, 68, 68, 0.1)",
                    }}
                  >
                    <Icon
                      className="w-5 h-5"
                      style={{
                        color: transaction.type === "recharge" || transaction.type === "package"
                          ? "#10B981"
                          : "#EF4444",
                      }}
                    />
                  </div>

                  <div className="flex-1">
                    <p className="text-foreground mb-1">{transaction.recipient}</p>
                    <p className="text-xs text-muted-foreground">
                      {transaction.date} • {transaction.time}
                    </p>
                  </div>

                  <div className="text-left">
                    <p
                      className="mb-1"
                      style={{
                        color: transaction.type === "recharge" || transaction.type === "package"
                          ? "#10B981"
                          : "#EF4444",
                      }}
                    >
                      {transaction.type === "recharge" || transaction.type === "package" ? "+" : "-"}
                      {transaction.amount.toLocaleString()} ريال
                    </p>
                    <p
                      className="text-xs"
                      style={{ color: statusColor }}
                    >
                      {getStatusText(transaction.status)}
                    </p>
                  </div>
                </div>
              </motion.div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

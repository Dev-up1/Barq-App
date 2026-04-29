import { motion } from "motion/react";
import { Bell, Wifi, WifiOff, ChevronLeft, Smartphone, Phone, Wifi as WifiIcon, Droplet, Zap as Lightning } from "lucide-react";
import { useState } from "react";

interface DashboardProps {
  onNavigateToRecharge: () => void;
  isOffline?: boolean;
}

export function Dashboard({ onNavigateToRecharge, isOffline = false }: DashboardProps) {
  const [showNotification, setShowNotification] = useState(true);

  const services = [
    { id: "yemen-mobile", name: "يمن موبايل", icon: Smartphone, color: "#10B981" },
    { id: "you", name: "يو", icon: Phone, color: "#3B82F6" },
    { id: "sabafon", name: "سبافون", icon: Smartphone, color: "#EF4444" },
    { id: "y", name: "واي", icon: Phone, color: "#F59E0B" },
    { id: "yemen-net", name: "يمن نت", icon: WifiIcon, color: "#8B5CF6" },
    { id: "aden-net", name: "عدن نت", icon: WifiIcon, color: "#EC4899" },
    { id: "electricity", name: "الكهرباء", icon: Lightning, color: "#FBBF24" },
    { id: "water", name: "المياه", icon: Droplet, color: "#06B6D4" },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 pb-24" dir="rtl">
      <div className="p-6">
        <div className="flex items-center justify-between mb-8">
          <div>
            <h1 className="text-2xl text-foreground mb-1">مرحباً بك</h1>
            <p className="text-sm text-muted-foreground">برق للشحن الفوري</p>
          </div>
          <div className="flex items-center gap-3">
            {isOffline ? (
              <div className="p-2 rounded-xl bg-destructive/10">
                <WifiOff className="w-5 h-5 text-destructive" />
              </div>
            ) : (
              <div className="p-2 rounded-xl bg-primary/10">
                <Wifi className="w-5 h-5 text-primary" />
              </div>
            )}
            <button className="p-2 rounded-xl bg-secondary/30">
              <Bell className="w-5 h-5 text-foreground" />
            </button>
          </div>
        </div>

        {isOffline && (
          <motion.div
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            className="mb-6 p-4 rounded-2xl backdrop-blur-xl"
            style={{
              background: "rgba(239, 68, 68, 0.1)",
              border: "1px solid rgba(239, 68, 68, 0.2)",
            }}
          >
            <div className="flex items-center gap-3">
              <WifiOff className="w-5 h-5 text-destructive" />
              <div className="flex-1">
                <p className="text-sm text-destructive">وضع الرسائل النصية نشط</p>
                <p className="text-xs text-destructive/70 mt-1">سيتم إرسال العمليات عبر SMS</p>
              </div>
            </div>
          </motion.div>
        )}

        {showNotification && !isOffline && (
          <motion.div
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            className="mb-6 p-4 rounded-2xl backdrop-blur-xl cursor-pointer"
            style={{
              background: "rgba(16, 185, 129, 0.1)",
              border: "1px solid rgba(16, 185, 129, 0.2)",
            }}
            onClick={() => setShowNotification(false)}
          >
            <div className="flex items-start gap-3">
              <div className="p-2 rounded-xl bg-primary/20">
                <Bell className="w-4 h-4 text-primary" />
              </div>
              <div className="flex-1">
                <p className="text-sm text-foreground">باقة الإنترنت الخاصة بك تنتهي خلال يومين</p>
                <button className="text-xs text-primary mt-1 underline">اضغط للتجديد</button>
              </div>
            </div>
          </motion.div>
        )}

        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          className="p-6 rounded-3xl backdrop-blur-xl shadow-xl mb-8"
          style={{
            background: "linear-gradient(135deg, rgba(16, 185, 129, 0.9) 0%, rgba(16, 185, 129, 0.7) 100%)",
            border: "1px solid rgba(255, 255, 255, 0.3)",
          }}
        >
          <p className="text-white/80 text-sm mb-2">رصيدك الحالي</p>
          <h2 className="text-4xl text-white mb-4">12,500 ريال</h2>
          <div className="flex gap-3">
            <button
              onClick={onNavigateToRecharge}
              className="flex-1 py-3 rounded-xl bg-white/20 backdrop-blur-sm text-white transition-all hover:bg-white/30"
            >
              شحن رصيد
            </button>
            <button className="flex-1 py-3 rounded-xl bg-white/20 backdrop-blur-sm text-white transition-all hover:bg-white/30">
              تحويل رصيد
            </button>
          </div>
        </motion.div>

        <div className="mb-4">
          <h3 className="text-lg text-foreground mb-4">الخدمات</h3>
        </div>

        <div className="grid grid-cols-4 gap-4">
          {services.map((service, index) => {
            const Icon = service.icon;
            return (
              <motion.button
                key={service.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.05 }}
                onClick={onNavigateToRecharge}
                className="flex flex-col items-center gap-2 p-4 rounded-2xl backdrop-blur-xl transition-all active:scale-95"
                style={{
                  background: "rgba(255, 255, 255, 0.6)",
                  border: "1px solid rgba(255, 255, 255, 0.3)",
                }}
              >
                <div
                  className="w-12 h-12 rounded-xl flex items-center justify-center"
                  style={{ backgroundColor: `${service.color}20` }}
                >
                  <Icon className="w-6 h-6" style={{ color: service.color }} />
                </div>
                <span className="text-xs text-center text-foreground">{service.name}</span>
              </motion.button>
            );
          })}
        </div>
      </div>
    </div>
  );
}

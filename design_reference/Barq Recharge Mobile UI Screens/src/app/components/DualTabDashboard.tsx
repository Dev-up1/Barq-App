import { motion } from "motion/react";
import { useState } from "react";
import { Bell, Wifi, WifiOff, Smartphone, Phone, Wifi as WifiIcon, Droplet, Zap as Lightning, ChevronLeft } from "lucide-react";
import { NetworkBottomSheet } from "./NetworkBottomSheet";

interface DualTabDashboardProps {
  onNavigateToRecharge: (network: string, subdivision: string) => void;
  onNavigateToGamingProduct: (product: string) => void;
  isOffline?: boolean;
}

type TabMode = "services" | "gaming";

interface NetworkService {
  id: string;
  name: string;
  icon: any;
  color: string;
  subdivisions: string[];
}

export function DualTabDashboard({ onNavigateToRecharge, onNavigateToGamingProduct, isOffline = false }: DualTabDashboardProps) {
  const [activeTab, setActiveTab] = useState<TabMode>("services");
  const [showNotification, setShowNotification] = useState(true);
  const [selectedNetwork, setSelectedNetwork] = useState<NetworkService | null>(null);
  const [showBottomSheet, setShowBottomSheet] = useState(false);

  const networks: NetworkService[] = [
    { id: "yemen-mobile", name: "يمن موبايل", icon: Smartphone, color: "#10B981", subdivisions: ["باقات", "رصيد", "فواتير"] },
    { id: "you", name: "يو", icon: Phone, color: "#3B82F6", subdivisions: ["باقات", "رصيد", "فواتير"] },
    { id: "sabafon", name: "سبافون", icon: Smartphone, color: "#EF4444", subdivisions: ["باقات", "رصيد"] },
    { id: "y", name: "واي", icon: Phone, color: "#F59E0B", subdivisions: ["باقات", "رصيد"] },
    { id: "yemen-net", name: "يمن نت", icon: WifiIcon, color: "#8B5CF6", subdivisions: ["باقات", "فواتير"] },
    { id: "aden-net", name: "عدن نت", icon: WifiIcon, color: "#EC4899", subdivisions: ["باقات", "فواتير"] },
    { id: "electricity", name: "الكهرباء", icon: Lightning, color: "#FBBF24", subdivisions: ["فواتير"] },
    { id: "water", name: "المياه", icon: Droplet, color: "#06B6D4", subdivisions: ["فواتير"] },
  ];

  const gamingProducts = [
    { id: "pubg", name: "PUBG Mobile", subtitle: "UC شحن", image: "🎮", gradient: "from-orange-400 to-red-500" },
    { id: "freefire", name: "Free Fire", subtitle: "Diamonds", image: "💎", gradient: "from-blue-400 to-purple-500" },
    { id: "jawaker", name: "Jawaker", subtitle: "رصيد جواكر", image: "🎲", gradient: "from-green-400 to-emerald-500" },
    { id: "fortnite", name: "Fortnite", subtitle: "V-Bucks", image: "⚡", gradient: "from-purple-400 to-pink-500" },
    { id: "roblox", name: "Roblox", subtitle: "Robux", image: "🎯", gradient: "from-red-400 to-orange-500" },
    { id: "steam", name: "Steam", subtitle: "بطاقة رصيد", image: "🎮", gradient: "from-slate-600 to-slate-800" },
  ];

  const handleNetworkClick = (network: NetworkService) => {
    setSelectedNetwork(network);
    setShowBottomSheet(true);
  };

  const handleSubdivisionSelect = (subdivision: string) => {
    if (selectedNetwork) {
      setShowBottomSheet(false);
      onNavigateToRecharge(selectedNetwork.id, subdivision);
    }
  };

  return (
    <>
      <div className="min-h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 pb-24" dir="rtl">
        <div className="p-6">
          {/* Header */}
          <div className="flex items-center justify-between mb-6">
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

          {/* Offline Mode Banner */}
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

          {/* AI Notification */}
          {showNotification && !isOffline && activeTab === "services" && (
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

          {/* Segmented Control */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            className="mb-6 p-1.5 rounded-2xl backdrop-blur-xl"
            style={{
              background: "rgba(255, 255, 255, 0.5)",
              border: "1px solid rgba(255, 255, 255, 0.3)",
            }}
          >
            <div className="flex gap-1">
              <button
                onClick={() => setActiveTab("services")}
                className="flex-1 py-3 px-4 rounded-xl transition-all"
                style={{
                  background: activeTab === "services"
                    ? "linear-gradient(135deg, rgba(16, 185, 129, 0.9) 0%, rgba(16, 185, 129, 0.7) 100%)"
                    : "transparent",
                  color: activeTab === "services" ? "#ffffff" : "#717182",
                }}
              >
                الخدمات والشحن
              </button>
              <button
                onClick={() => setActiveTab("gaming")}
                className="flex-1 py-3 px-4 rounded-xl transition-all"
                style={{
                  background: activeTab === "gaming"
                    ? "linear-gradient(135deg, rgba(139, 92, 246, 0.9) 0%, rgba(139, 92, 246, 0.7) 100%)"
                    : "transparent",
                  color: activeTab === "gaming" ? "#ffffff" : "#717182",
                }}
              >
                الألعاب والاشتراكات
              </button>
            </div>
          </motion.div>

          {/* Services Tab Content */}
          {activeTab === "services" && (
            <>
              {/* Agent Balance Card */}
              <motion.div
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                className="p-6 rounded-3xl backdrop-blur-xl shadow-xl mb-8"
                style={{
                  background: "linear-gradient(135deg, rgba(16, 185, 129, 0.9) 0%, rgba(16, 185, 129, 0.7) 100%)",
                  border: "1px solid rgba(255, 255, 255, 0.3)",
                }}
              >
                <p className="text-white/80 text-sm mb-2">رصيد الوكيل</p>
                <h2 className="text-4xl text-white mb-1">12,500 ريال</h2>
                <p className="text-white/60 text-xs">Agent Balance</p>
              </motion.div>

              {/* Network Services Grid */}
              <div className="mb-4">
                <h3 className="text-lg text-foreground mb-4">اختر الخدمة</h3>
              </div>

              <div className="grid grid-cols-4 gap-4">
                {networks.map((network, index) => {
                  const Icon = network.icon;
                  return (
                    <motion.button
                      key={network.id}
                      initial={{ opacity: 0, y: 20 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: index * 0.05 }}
                      onClick={() => handleNetworkClick(network)}
                      className="flex flex-col items-center gap-2 p-4 rounded-2xl backdrop-blur-xl transition-all active:scale-95"
                      style={{
                        background: "rgba(255, 255, 255, 0.6)",
                        border: "1px solid rgba(255, 255, 255, 0.3)",
                      }}
                    >
                      <div
                        className="w-12 h-12 rounded-xl flex items-center justify-center"
                        style={{ backgroundColor: `${network.color}20` }}
                      >
                        <Icon className="w-6 h-6" style={{ color: network.color }} />
                      </div>
                      <span className="text-xs text-center text-foreground">{network.name}</span>
                    </motion.button>
                  );
                })}
              </div>
            </>
          )}

          {/* Gaming Tab Content */}
          {activeTab === "gaming" && (
            <>
              <div className="mb-4">
                <h3 className="text-lg text-foreground mb-2">الألعاب والبطاقات الرقمية</h3>
                <p className="text-sm text-muted-foreground">اشحن ألعابك المفضلة بسهولة</p>
              </div>

              <div className="grid grid-cols-2 gap-4">
                {gamingProducts.map((product, index) => (
                  <motion.button
                    key={product.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.05 }}
                    onClick={() => onNavigateToGamingProduct(product.id)}
                    className="relative overflow-hidden rounded-3xl backdrop-blur-xl transition-all active:scale-95 h-40"
                    style={{
                      background: "rgba(255, 255, 255, 0.6)",
                      border: "1px solid rgba(255, 255, 255, 0.3)",
                    }}
                  >
                    <div className={`absolute inset-0 bg-gradient-to-br ${product.gradient} opacity-20`}></div>
                    <div className="relative h-full flex flex-col items-center justify-center p-4">
                      <div className="text-5xl mb-3">{product.image}</div>
                      <h4 className="text-foreground mb-1">{product.name}</h4>
                      <p className="text-xs text-muted-foreground">{product.subtitle}</p>
                    </div>
                  </motion.button>
                ))}
              </div>
            </>
          )}
        </div>
      </div>

      {/* Network Bottom Sheet */}
      {showBottomSheet && selectedNetwork && (
        <NetworkBottomSheet
          network={selectedNetwork}
          onClose={() => setShowBottomSheet(false)}
          onSelect={handleSubdivisionSelect}
        />
      )}
    </>
  );
}

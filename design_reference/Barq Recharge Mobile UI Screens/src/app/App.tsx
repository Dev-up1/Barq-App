import { useState } from "react";
import { SplashScreen } from "./components/SplashScreen";
import { AuthScreen } from "./components/AuthScreen";
import { DualTabDashboard } from "./components/DualTabDashboard";
import { EnhancedRechargeScreen } from "./components/EnhancedRechargeScreen";
import { GamingProductScreen } from "./components/GamingProductScreen";
import { HistoryScreen } from "./components/HistoryScreen";
import { BottomNav } from "./components/BottomNav";

type Screen = "splash" | "auth" | "main";
type Tab = "home" | "history" | "insights" | "settings";
type FlowScreen = "dashboard" | "recharge" | "gaming";

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>("splash");
  const [activeTab, setActiveTab] = useState<Tab>("home");
  const [flowScreen, setFlowScreen] = useState<FlowScreen>("dashboard");
  const [selectedNetwork, setSelectedNetwork] = useState("");
  const [selectedSubdivision, setSelectedSubdivision] = useState("");
  const [selectedProduct, setSelectedProduct] = useState("");
  const [isOffline] = useState(false);

  if (currentScreen === "splash") {
    return <SplashScreen onComplete={() => setCurrentScreen("auth")} />;
  }

  if (currentScreen === "auth") {
    return <AuthScreen onAuth={() => setCurrentScreen("main")} />;
  }

  const handleNavigateToRecharge = (network: string, subdivision: string) => {
    setSelectedNetwork(network);
    setSelectedSubdivision(subdivision);
    setFlowScreen("recharge");
  };

  const handleNavigateToGaming = (productId: string) => {
    setSelectedProduct(productId);
    setFlowScreen("gaming");
  };

  return (
    <div className="size-full bg-background">
      {activeTab === "home" ? (
        <>
          {flowScreen === "dashboard" && (
            <DualTabDashboard
              onNavigateToRecharge={handleNavigateToRecharge}
              onNavigateToGamingProduct={handleNavigateToGaming}
              isOffline={isOffline}
            />
          )}
          {flowScreen === "recharge" && (
            <EnhancedRechargeScreen
              onBack={() => setFlowScreen("dashboard")}
              network={selectedNetwork}
              subdivision={selectedSubdivision}
            />
          )}
          {flowScreen === "gaming" && (
            <GamingProductScreen
              onBack={() => setFlowScreen("dashboard")}
              productId={selectedProduct}
            />
          )}
        </>
      ) : (
        <>
          {activeTab === "history" && <HistoryScreen />}
          {activeTab === "insights" && (
            <div className="min-h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 pb-24 flex items-center justify-center" dir="rtl">
              <p className="text-muted-foreground">الإحصائيات قريباً...</p>
            </div>
          )}
          {activeTab === "settings" && (
            <div className="min-h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 pb-24 p-6" dir="rtl">
              <h1 className="text-2xl text-foreground mb-8">الإعدادات</h1>
              <div className="space-y-3">
                {["الملف الشخصي", "الأمان", "الإشعارات", "اللغة", "حول التطبيق"].map((item, index) => (
                  <div
                    key={index}
                    className="p-4 rounded-2xl backdrop-blur-xl"
                    style={{
                      background: "rgba(255, 255, 255, 0.6)",
                      border: "1px solid rgba(255, 255, 255, 0.3)",
                    }}
                  >
                    <p className="text-foreground">{item}</p>
                  </div>
                ))}
              </div>
              <div className="mt-auto pt-8 text-center">
                <p className="text-xs text-muted-foreground">Designed by DevUp</p>
                <p className="text-xs text-muted-foreground mt-1">النسخة 1.0.0</p>
              </div>
            </div>
          )}
        </>
      )}
      <BottomNav
        activeTab={activeTab}
        onTabChange={(tab) => {
          setActiveTab(tab as Tab);
          if (tab === "home") setFlowScreen("dashboard");
        }}
      />
    </div>
  );
}
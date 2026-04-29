import { Home, History, TrendingUp, Settings } from "lucide-react";

interface BottomNavProps {
  activeTab: string;
  onTabChange: (tab: string) => void;
}

export function BottomNav({ activeTab, onTabChange }: BottomNavProps) {
  const tabs = [
    { id: "home", icon: Home, label: "الرئيسية" },
    { id: "history", icon: History, label: "السجل" },
    { id: "insights", icon: TrendingUp, label: "الإحصائيات" },
    { id: "settings", icon: Settings, label: "الإعدادات" },
  ];

  return (
    <div
      className="fixed bottom-0 left-0 right-0 h-20 backdrop-blur-xl border-t z-50"
      style={{
        background: "rgba(255, 255, 255, 0.8)",
        borderColor: "rgba(0, 0, 0, 0.1)",
      }}
      dir="rtl"
    >
      <div className="flex items-center justify-around h-full px-4">
        {tabs.map((tab) => {
          const Icon = tab.icon;
          const isActive = activeTab === tab.id;
          return (
            <button
              key={tab.id}
              onClick={() => onTabChange(tab.id)}
              className="flex flex-col items-center justify-center gap-1 px-4 py-2 rounded-xl transition-all"
              style={{
                color: isActive ? "#10B981" : "#717182",
              }}
            >
              <Icon
                className="w-6 h-6"
                strokeWidth={isActive ? 2.5 : 2}
              />
              <span className="text-xs">{tab.label}</span>
            </button>
          );
        })}
      </div>
    </div>
  );
}

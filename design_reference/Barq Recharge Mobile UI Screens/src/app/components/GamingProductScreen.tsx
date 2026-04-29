import { motion } from "motion/react";
import { useState } from "react";
import { ArrowRight, ChevronRight, Info } from "lucide-react";

interface GamingProductScreenProps {
  onBack: () => void;
  productId?: string;
}

export function GamingProductScreen({ onBack, productId = "pubg" }: GamingProductScreenProps) {
  const [playerId, setPlayerId] = useState("");
  const [selectedPackage, setSelectedPackage] = useState<string | null>(null);
  const [sliderValue, setSliderValue] = useState(0);

  const products: Record<string, any> = {
    pubg: {
      name: "PUBG Mobile",
      subtitle: "UC شحن",
      image: "🎮",
      gradient: "from-orange-400 to-red-500",
      packages: [
        { id: "60uc", amount: "60 UC", price: 2000, bonus: "" },
        { id: "325uc", amount: "325 UC", price: 9000, bonus: "+25 UC مجاناً" },
        { id: "660uc", amount: "660 UC", price: 18000, bonus: "+60 UC مجاناً" },
        { id: "1800uc", amount: "1800 UC", price: 45000, bonus: "+300 UC مجاناً" },
      ],
    },
    freefire: {
      name: "Free Fire",
      subtitle: "Diamonds شحن",
      image: "💎",
      gradient: "from-blue-400 to-purple-500",
      packages: [
        { id: "100d", amount: "100 Diamonds", price: 2500, bonus: "" },
        { id: "310d", amount: "310 Diamonds", price: 7500, bonus: "+31 مجاناً" },
        { id: "520d", amount: "520 Diamonds", price: 12500, bonus: "+52 مجاناً" },
        { id: "1060d", amount: "1060 Diamonds", price: 25000, bonus: "+106 مجاناً" },
      ],
    },
    jawaker: {
      name: "Jawaker",
      subtitle: "رصيد جواكر",
      image: "🎲",
      gradient: "from-green-400 to-emerald-500",
      packages: [
        { id: "10k", amount: "10,000 رصيد", price: 1500, bonus: "" },
        { id: "25k", amount: "25,000 رصيد", price: 3500, bonus: "+2,500 مجاناً" },
        { id: "50k", amount: "50,000 رصيد", price: 6500, bonus: "+5,000 مجاناً" },
        { id: "100k", amount: "100,000 رصيد", price: 12000, bonus: "+15,000 مجاناً" },
      ],
    },
  };

  const product = products[productId] || products.pubg;

  const handleSlideComplete = () => {
    if (sliderValue > 80 && playerId && selectedPackage) {
      alert("تم إرسال الطلب بنجاح!");
      setSliderValue(0);
    }
  };

  const selectedPkg = product.packages.find((p: any) => p.id === selectedPackage);

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 pb-24" dir="rtl">
      <div className="p-6">
        <div className="flex items-center gap-4 mb-6">
          <button
            onClick={onBack}
            className="p-2 rounded-xl backdrop-blur-xl"
            style={{
              background: "rgba(255, 255, 255, 0.6)",
              border: "1px solid rgba(255, 255, 255, 0.3)",
            }}
          >
            <ArrowRight className="w-6 h-6 text-foreground" />
          </button>
          <div className="flex items-center gap-3">
            <div className="text-4xl">{product.image}</div>
            <div>
              <h1 className="text-2xl text-foreground">{product.name}</h1>
              <p className="text-sm text-muted-foreground">{product.subtitle}</p>
            </div>
          </div>
        </div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-6"
        >
          <label className="block text-sm text-foreground mb-3">معرف اللاعب (Player ID)</label>
          <input
            type="text"
            inputMode="numeric"
            placeholder="أدخل معرف اللاعب"
            value={playerId}
            onChange={(e) => setPlayerId(e.target.value)}
            className="w-full px-6 py-4 rounded-2xl backdrop-blur-xl text-foreground text-center text-lg outline-none transition-all"
            style={{
              background: "rgba(255, 255, 255, 0.6)",
              border: "2px solid rgba(255, 255, 255, 0.3)",
            }}
            dir="ltr"
          />
          <div className="flex items-start gap-2 mt-2 p-3 rounded-xl bg-secondary/20">
            <Info className="w-4 h-4 text-muted-foreground mt-0.5" />
            <p className="text-xs text-muted-foreground">
              يمكنك العثور على معرف اللاعب في إعدادات اللعبة
            </p>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-8"
        >
          <label className="block text-sm text-foreground mb-3">اختر الباقة</label>
          <div className="space-y-3">
            {product.packages.map((pkg: any) => (
              <button
                key={pkg.id}
                onClick={() => setSelectedPackage(pkg.id)}
                className="w-full p-5 rounded-2xl backdrop-blur-xl transition-all relative overflow-hidden"
                style={{
                  background: selectedPackage === pkg.id
                    ? "linear-gradient(135deg, rgba(139, 92, 246, 0.3) 0%, rgba(139, 92, 246, 0.1) 100%)"
                    : "rgba(255, 255, 255, 0.6)",
                  border: `2px solid ${selectedPackage === pkg.id ? "#8B5CF6" : "rgba(255, 255, 255, 0.3)"}`,
                }}
              >
                {pkg.bonus && (
                  <div
                    className="absolute top-2 left-2 px-2 py-1 rounded-lg text-xs"
                    style={{
                      background: "linear-gradient(135deg, #10B981 0%, #059669 100%)",
                      color: "#ffffff",
                    }}
                  >
                    {pkg.bonus}
                  </div>
                )}
                <div className="flex items-center justify-between">
                  <div className="text-right">
                    <p className="text-lg text-foreground mb-1">{pkg.amount}</p>
                  </div>
                  <div className="text-left">
                    <p className="text-lg text-foreground">{pkg.price.toLocaleString()}</p>
                    <p className="text-xs text-muted-foreground">ريال</p>
                  </div>
                </div>
              </button>
            ))}
          </div>
        </motion.div>

        {playerId && selectedPackage && (
          <>
            <motion.div
              initial={{ opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              className="mb-6"
            >
              <label className="block text-sm text-foreground mb-3 text-center">اسحب للدفع</label>
              <div
                className="relative h-16 rounded-2xl backdrop-blur-xl overflow-hidden"
                style={{
                  background: "rgba(139, 92, 246, 0.1)",
                  border: "2px solid rgba(139, 92, 246, 0.3)",
                }}
              >
                <div
                  className="absolute inset-0 transition-all"
                  style={{
                    width: `${sliderValue}%`,
                    background: "linear-gradient(90deg, rgba(139, 92, 246, 0.3) 0%, rgba(139, 92, 246, 0.5) 100%)",
                  }}
                ></div>
                <input
                  type="range"
                  min="0"
                  max="100"
                  value={sliderValue}
                  onChange={(e) => setSliderValue(Number(e.target.value))}
                  onMouseUp={handleSlideComplete}
                  onTouchEnd={handleSlideComplete}
                  className="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10"
                />
                <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
                  <div className="flex items-center gap-2 text-foreground">
                    <ChevronRight className="w-5 h-5" />
                    <span className="text-sm">اسحب لتأكيد الدفع</span>
                    <ChevronRight className="w-5 h-5" />
                  </div>
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              className="p-4 rounded-2xl backdrop-blur-xl"
              style={{
                background: "rgba(255, 255, 255, 0.4)",
                border: "1px solid rgba(255, 255, 255, 0.3)",
              }}
            >
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm text-muted-foreground">المجموع</span>
                <span className="text-lg text-foreground">{selectedPkg?.price.toLocaleString()} ريال</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-muted-foreground">رصيدك بعد العملية</span>
                <span className="text-lg text-primary">
                  {(12500 - (selectedPkg?.price || 0)).toLocaleString()} ريال
                </span>
              </div>
            </motion.div>
          </>
        )}
      </div>
    </div>
  );
}

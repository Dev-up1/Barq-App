import { motion } from "motion/react";
import { useState } from "react";
import { ArrowRight, ChevronRight } from "lucide-react";

interface EnhancedRechargeScreenProps {
  onBack: () => void;
  network?: string;
  subdivision?: string;
}

export function EnhancedRechargeScreen({ onBack, network = "you", subdivision = "باقات" }: EnhancedRechargeScreenProps) {
  const [phoneNumber, setPhoneNumber] = useState("");
  const [selectedAmount, setSelectedAmount] = useState<number | null>(null);
  const [selectedPackage, setSelectedPackage] = useState<string | null>(null);
  const [sliderValue, setSliderValue] = useState(0);

  const networkNames: Record<string, string> = {
    "yemen-mobile": "يمن موبايل",
    "you": "يو",
    "sabafon": "سبافون",
    "y": "واي",
    "yemen-net": "يمن نت",
    "aden-net": "عدن نت",
    "electricity": "الكهرباء",
    "water": "المياه",
  };

  const amounts = [500, 1000, 2000, 5000, 10000];

  const youPackages = [
    { id: "you-smart-4g-20gb", name: "YOU Smart 4G 20GB", price: 9680, validity: "30 يوم", data: "20GB" },
    { id: "you-smart-4g-10gb", name: "YOU Smart 4G 10GB", price: 5280, validity: "30 يوم", data: "10GB" },
    { id: "you-smart-4g-5gb", name: "YOU Smart 4G 5GB", price: 2970, validity: "15 يوم", data: "5GB" },
    { id: "you-weekly-2gb", name: "YOU Weekly 2GB", price: 1210, validity: "7 أيام", data: "2GB" },
  ];

  const handleSlideComplete = () => {
    if (sliderValue > 80 && phoneNumber && (selectedAmount || selectedPackage)) {
      alert("تم إرسال الطلب بنجاح!");
      setSliderValue(0);
    }
  };

  const renderContent = () => {
    if (subdivision === "باقات") {
      return (
        <>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mb-6"
          >
            <label className="block text-sm text-foreground mb-3">رقم الهاتف</label>
            <input
              type="tel"
              inputMode="numeric"
              placeholder="777 123 456"
              value={phoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
              className="w-full px-6 py-4 rounded-2xl backdrop-blur-xl text-foreground text-center text-lg outline-none transition-all"
              style={{
                background: "rgba(255, 255, 255, 0.6)",
                border: "2px solid rgba(255, 255, 255, 0.3)",
              }}
              dir="ltr"
            />
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="mb-8"
          >
            <label className="block text-sm text-foreground mb-3">اختر الباقة</label>
            <div className="space-y-3">
              {youPackages.map((pkg) => (
                <button
                  key={pkg.id}
                  onClick={() => setSelectedPackage(pkg.id)}
                  className="w-full p-5 rounded-2xl backdrop-blur-xl transition-all"
                  style={{
                    background: selectedPackage === pkg.id
                      ? "linear-gradient(135deg, rgba(59, 130, 246, 0.4) 0%, rgba(59, 130, 246, 0.2) 100%)"
                      : "rgba(255, 255, 255, 0.6)",
                    border: `2px solid ${selectedPackage === pkg.id ? "#3B82F6" : "rgba(255, 255, 255, 0.3)"}`,
                  }}
                >
                  <div className="flex items-center justify-between">
                    <div className="text-right">
                      <p className="text-foreground mb-1">{pkg.name}</p>
                      <div className="flex items-center gap-3 text-xs text-muted-foreground">
                        <span>{pkg.data}</span>
                        <span>•</span>
                        <span>{pkg.validity}</span>
                      </div>
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
        </>
      );
    }

    if (subdivision === "رصيد") {
      return (
        <>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mb-6"
          >
            <label className="block text-sm text-foreground mb-3">رقم الهاتف</label>
            <input
              type="tel"
              inputMode="numeric"
              placeholder="777 123 456"
              value={phoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
              className="w-full px-6 py-4 rounded-2xl backdrop-blur-xl text-foreground text-center text-lg outline-none transition-all"
              style={{
                background: "rgba(255, 255, 255, 0.6)",
                border: "2px solid rgba(255, 255, 255, 0.3)",
              }}
              dir="ltr"
            />
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="mb-8"
          >
            <label className="block text-sm text-foreground mb-3">اختر المبلغ</label>
            <div className="grid grid-cols-3 gap-3">
              {amounts.map((amount) => (
                <button
                  key={amount}
                  onClick={() => setSelectedAmount(amount)}
                  className="px-6 py-4 rounded-xl transition-all backdrop-blur-xl"
                  style={{
                    background: selectedAmount === amount
                      ? "linear-gradient(135deg, rgba(16, 185, 129, 0.9) 0%, rgba(16, 185, 129, 0.7) 100%)"
                      : "rgba(255, 255, 255, 0.6)",
                    border: `1px solid ${selectedAmount === amount ? "rgba(255, 255, 255, 0.3)" : "rgba(255, 255, 255, 0.3)"}`,
                    color: selectedAmount === amount ? "#ffffff" : "#1A1A2E",
                  }}
                >
                  {amount.toLocaleString()}
                </button>
              ))}
            </div>
          </motion.div>
        </>
      );
    }

    if (subdivision === "فواتير") {
      return (
        <>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mb-6"
          >
            <label className="block text-sm text-foreground mb-3">رقم الحساب / الفاتورة</label>
            <input
              type="text"
              inputMode="numeric"
              placeholder="أدخل رقم الحساب"
              value={phoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
              className="w-full px-6 py-4 rounded-2xl backdrop-blur-xl text-foreground text-center text-lg outline-none transition-all"
              style={{
                background: "rgba(255, 255, 255, 0.6)",
                border: "2px solid rgba(255, 255, 255, 0.3)",
              }}
              dir="ltr"
            />
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="mb-8 p-6 rounded-2xl backdrop-blur-xl"
            style={{
              background: "rgba(255, 255, 255, 0.6)",
              border: "1px solid rgba(255, 255, 255, 0.3)",
            }}
          >
            <p className="text-sm text-muted-foreground mb-4">معلومات الفاتورة</p>
            <div className="space-y-3">
              <div className="flex justify-between">
                <span className="text-sm text-muted-foreground">المبلغ المستحق</span>
                <span className="text-foreground">4,500 ريال</span>
              </div>
              <div className="flex justify-between">
                <span className="text-sm text-muted-foreground">رسوم الخدمة</span>
                <span className="text-foreground">50 ريال</span>
              </div>
              <div className="h-px bg-border"></div>
              <div className="flex justify-between">
                <span className="text-foreground">الإجمالي</span>
                <span className="text-lg text-foreground">4,550 ريال</span>
              </div>
            </div>
          </motion.div>
        </>
      );
    }

    return null;
  };

  const getTotalAmount = () => {
    if (subdivision === "رصيد") return selectedAmount || 0;
    if (subdivision === "باقات") {
      const pkg = youPackages.find(p => p.id === selectedPackage);
      return pkg?.price || 0;
    }
    if (subdivision === "فواتير") return 4550;
    return 0;
  };

  const canProceed = phoneNumber && (selectedAmount || selectedPackage || subdivision === "فواتير");

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
          <div>
            <h1 className="text-2xl text-foreground">{networkNames[network]}</h1>
            <p className="text-sm text-muted-foreground">{subdivision}</p>
          </div>
        </div>

        {renderContent()}

        {canProceed && (
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
                  background: "rgba(16, 185, 129, 0.1)",
                  border: "2px solid rgba(16, 185, 129, 0.3)",
                }}
              >
                <div
                  className="absolute inset-0 bg-primary/20 transition-all"
                  style={{ width: `${sliderValue}%` }}
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
                <span className="text-lg text-foreground">{getTotalAmount().toLocaleString()} ريال</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-muted-foreground">رصيدك بعد العملية</span>
                <span className="text-lg text-primary">
                  {(12500 - getTotalAmount()).toLocaleString()} ريال
                </span>
              </div>
            </motion.div>
          </>
        )}
      </div>
    </div>
  );
}

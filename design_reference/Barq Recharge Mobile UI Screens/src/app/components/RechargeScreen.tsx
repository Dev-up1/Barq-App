import { motion } from "motion/react";
import { useState } from "react";
import { ArrowRight, ChevronDown, ChevronRight } from "lucide-react";

interface RechargeScreenProps {
  onBack: () => void;
}

export function RechargeScreen({ onBack }: RechargeScreenProps) {
  const [phoneNumber, setPhoneNumber] = useState("");
  const [selectedAmount, setSelectedAmount] = useState<number | null>(null);
  const [selectedPackage, setSelectedPackage] = useState<string | null>(null);
  const [sliderValue, setSliderValue] = useState(0);

  const amounts = [500, 1000, 2000, 5000, 10000];
  const packages = [
    { id: "1gb", name: "1 جيجا", price: 1000, validity: "7 أيام" },
    { id: "3gb", name: "3 جيجا", price: 2500, validity: "15 يوم" },
    { id: "5gb", name: "5 جيجا", price: 4000, validity: "30 يوم" },
    { id: "10gb", name: "10 جيجا", price: 7000, validity: "30 يوم" },
  ];

  const handleSlideComplete = () => {
    if (sliderValue > 80 && phoneNumber && (selectedAmount || selectedPackage)) {
      alert("تم إرسال الطلب بنجاح!");
      setSliderValue(0);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 pb-24" dir="rtl">
      <div className="p-6">
        <div className="flex items-center gap-4 mb-8">
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
          <h1 className="text-2xl text-foreground">شحن رصيد</h1>
        </div>

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
          className="mb-6"
        >
          <label className="block text-sm text-foreground mb-3">اختر المبلغ</label>
          <div className="flex gap-3 overflow-x-auto pb-2">
            {amounts.map((amount) => (
              <button
                key={amount}
                onClick={() => {
                  setSelectedAmount(amount);
                  setSelectedPackage(null);
                }}
                className="px-6 py-3 rounded-xl whitespace-nowrap transition-all backdrop-blur-xl"
                style={{
                  background: selectedAmount === amount
                    ? "linear-gradient(135deg, rgba(16, 185, 129, 0.9) 0%, rgba(16, 185, 129, 0.7) 100%)"
                    : "rgba(255, 255, 255, 0.6)",
                  border: `1px solid ${selectedAmount === amount ? "rgba(255, 255, 255, 0.3)" : "rgba(255, 255, 255, 0.3)"}`,
                  color: selectedAmount === amount ? "#ffffff" : "#1A1A2E",
                }}
              >
                {amount.toLocaleString()} ريال
              </button>
            ))}
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="mb-8"
        >
          <label className="block text-sm text-foreground mb-3">أو اختر باقة إنترنت</label>
          <div className="space-y-3">
            {packages.map((pkg) => (
              <button
                key={pkg.id}
                onClick={() => {
                  setSelectedPackage(pkg.id);
                  setSelectedAmount(null);
                }}
                className="w-full p-4 rounded-2xl backdrop-blur-xl transition-all flex items-center justify-between"
                style={{
                  background: selectedPackage === pkg.id
                    ? "linear-gradient(135deg, rgba(165, 214, 243, 0.4) 0%, rgba(165, 214, 243, 0.2) 100%)"
                    : "rgba(255, 255, 255, 0.6)",
                  border: `2px solid ${selectedPackage === pkg.id ? "#A5D6F3" : "rgba(255, 255, 255, 0.3)"}`,
                }}
              >
                <div className="text-right">
                  <p className="text-foreground">{pkg.name}</p>
                  <p className="text-xs text-muted-foreground mt-1">{pkg.validity}</p>
                </div>
                <div className="text-left">
                  <p className="text-foreground">{pkg.price.toLocaleString()} ريال</p>
                </div>
              </button>
            ))}
          </div>
        </motion.div>

        {(selectedAmount || selectedPackage) && phoneNumber && (
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
        )}

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.3 }}
          className="p-4 rounded-2xl backdrop-blur-xl"
          style={{
            background: "rgba(255, 255, 255, 0.4)",
            border: "1px solid rgba(255, 255, 255, 0.3)",
          }}
        >
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-muted-foreground">المجموع</span>
            <span className="text-lg text-foreground">
              {selectedAmount?.toLocaleString() || packages.find(p => p.id === selectedPackage)?.price.toLocaleString() || "0"} ريال
            </span>
          </div>
          <div className="flex items-center justify-between">
            <span className="text-sm text-muted-foreground">رصيدك بعد العملية</span>
            <span className="text-lg text-primary">
              {(12500 - (selectedAmount || packages.find(p => p.id === selectedPackage)?.price || 0)).toLocaleString()} ريال
            </span>
          </div>
        </motion.div>
      </div>
    </div>
  );
}

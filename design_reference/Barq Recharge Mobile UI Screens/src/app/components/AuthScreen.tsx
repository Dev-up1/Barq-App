import { useState } from "react";
import { motion } from "motion/react";
import { Zap, Lock } from "lucide-react";

interface AuthScreenProps {
  onAuth: () => void;
}

export function AuthScreen({ onAuth }: AuthScreenProps) {
  const [pin, setPin] = useState<string[]>(["", "", "", ""]);
  const [activeIndex, setActiveIndex] = useState(0);

  const handlePinInput = (index: number, value: string) => {
    if (value.length <= 1 && /^\d*$/.test(value)) {
      const newPin = [...pin];
      newPin[index] = value;
      setPin(newPin);

      if (value && index < 3) {
        setActiveIndex(index + 1);
      }

      if (newPin.every(digit => digit !== "") && newPin.join("").length === 4) {
        setTimeout(() => onAuth(), 500);
      }
    }
  };

  return (
    <div className="h-screen bg-gradient-to-br from-primary/10 via-background to-secondary/10 flex flex-col items-center justify-center p-6" dir="rtl">
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="flex flex-col items-center mb-12"
      >
        <div className="w-20 h-20 bg-gradient-to-br from-primary to-primary/70 rounded-2xl flex items-center justify-center shadow-lg mb-6">
          <Zap className="w-10 h-10 text-white" fill="white" />
        </div>
        <h2 className="text-2xl text-foreground mb-2">مرحباً بك</h2>
        <p className="text-muted-foreground text-center">أدخل رمز PIN الخاص بك</p>
      </motion.div>

      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ delay: 0.2 }}
        className="w-full max-w-sm"
      >
        <div
          className="p-8 rounded-3xl shadow-xl backdrop-blur-xl"
          style={{
            background: "rgba(255, 255, 255, 0.7)",
            border: "1px solid rgba(255, 255, 255, 0.3)",
          }}
        >
          <div className="flex items-center justify-center mb-6">
            <Lock className="w-6 h-6 text-primary" />
          </div>

          <div className="flex gap-4 justify-center mb-8" dir="ltr">
            {pin.map((digit, index) => (
              <input
                key={index}
                type="password"
                inputMode="numeric"
                maxLength={1}
                value={digit}
                onChange={(e) => handlePinInput(index, e.target.value)}
                onFocus={() => setActiveIndex(index)}
                className="w-14 h-14 text-center text-2xl rounded-xl bg-white/50 border-2 transition-all outline-none"
                style={{
                  borderColor: activeIndex === index ? "#10B981" : "rgba(0,0,0,0.1)",
                  boxShadow: activeIndex === index ? "0 0 0 3px rgba(16, 185, 129, 0.1)" : "none",
                }}
                autoFocus={index === 0}
              />
            ))}
          </div>

          <div className="flex justify-center">
            <button className="text-sm text-primary underline">نسيت رمز PIN؟</button>
          </div>
        </div>
      </motion.div>

      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.4 }}
        className="mt-8 text-center"
      >
        <p className="text-xs text-muted-foreground mb-2">تطبيق آمن ومعتمد</p>
        <p className="text-xs text-muted-foreground">لخدمة عملاء اليمن</p>
      </motion.div>
    </div>
  );
}

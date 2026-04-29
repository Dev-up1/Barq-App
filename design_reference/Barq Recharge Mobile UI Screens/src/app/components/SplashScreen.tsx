import { motion } from "motion/react";
import { Zap } from "lucide-react";
import { useEffect } from "react";

interface SplashScreenProps {
  onComplete: () => void;
}

export function SplashScreen({ onComplete }: SplashScreenProps) {
  useEffect(() => {
    const timer = setTimeout(() => {
      onComplete();
    }, 2500);
    return () => clearTimeout(timer);
  }, [onComplete]);

  return (
    <div className="h-screen bg-gradient-to-br from-primary/20 via-background to-secondary/20 flex flex-col items-center justify-center relative overflow-hidden" dir="rtl">
      <div className="absolute inset-0 opacity-30">
        <div className="absolute top-20 left-10 w-32 h-32 bg-primary/20 rounded-full blur-3xl"></div>
        <div className="absolute bottom-32 right-16 w-40 h-40 bg-secondary/30 rounded-full blur-3xl"></div>
      </div>

      <motion.div
        initial={{ scale: 0, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ duration: 0.6, ease: "easeOut" }}
        className="relative z-10 flex flex-col items-center"
      >
        <motion.div
          animate={{
            rotate: [0, 360],
            scale: [1, 1.1, 1],
          }}
          transition={{
            duration: 2,
            repeat: Infinity,
            ease: "easeInOut",
          }}
          className="w-24 h-24 bg-gradient-to-br from-primary to-primary/70 rounded-3xl flex items-center justify-center shadow-2xl"
        >
          <Zap className="w-12 h-12 text-white" fill="white" />
        </motion.div>

        <motion.h1
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ delay: 0.3, duration: 0.5 }}
          className="mt-8 text-4xl text-foreground"
        >
          برق للشحن الفوري
        </motion.h1>

        <motion.p
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ delay: 0.5, duration: 0.5 }}
          className="mt-2 text-muted-foreground"
        >
          Barq Recharge
        </motion.p>
      </motion.div>

      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1, duration: 0.5 }}
        className="absolute bottom-8 text-xs text-muted-foreground"
      >
        Designed by DevUp
      </motion.div>
    </div>
  );
}

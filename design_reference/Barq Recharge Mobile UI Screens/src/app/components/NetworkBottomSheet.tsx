import { motion, AnimatePresence } from "motion/react";
import { X, Package, Smartphone, FileText } from "lucide-react";

interface NetworkBottomSheetProps {
  network: {
    id: string;
    name: string;
    color: string;
    subdivisions: string[];
  };
  onClose: () => void;
  onSelect: (subdivision: string) => void;
}

export function NetworkBottomSheet({ network, onClose, onSelect }: NetworkBottomSheetProps) {
  const getSubdivisionIcon = (subdivision: string) => {
    switch (subdivision) {
      case "باقات":
        return Package;
      case "رصيد":
        return Smartphone;
      case "فواتير":
        return FileText;
      default:
        return Package;
    }
  };

  const getSubdivisionDescription = (subdivision: string) => {
    switch (subdivision) {
      case "باقات":
        return "اختر من باقات الإنترنت والمكالمات";
      case "رصيد":
        return "شحن رصيد مباشر";
      case "فواتير":
        return "دفع الفواتير المستحقة";
      default:
        return "";
    }
  };

  return (
    <AnimatePresence>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="fixed inset-0 bg-black/40 backdrop-blur-sm z-50"
        onClick={onClose}
        dir="rtl"
      >
        <motion.div
          initial={{ y: "100%" }}
          animate={{ y: 0 }}
          exit={{ y: "100%" }}
          transition={{ type: "spring", damping: 30, stiffness: 300 }}
          className="absolute bottom-0 left-0 right-0 rounded-t-3xl backdrop-blur-xl shadow-2xl"
          style={{
            background: "rgba(255, 255, 255, 0.95)",
            maxHeight: "70vh",
          }}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Handle Bar */}
          <div className="flex justify-center pt-3 pb-2">
            <div className="w-12 h-1.5 bg-muted-foreground/30 rounded-full"></div>
          </div>

          {/* Header */}
          <div className="px-6 py-4 border-b border-border/50">
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-xl text-foreground mb-1">{network.name}</h3>
                <p className="text-sm text-muted-foreground">اختر نوع الخدمة</p>
              </div>
              <button
                onClick={onClose}
                className="p-2 rounded-xl bg-secondary/30 hover:bg-secondary/50 transition-all"
              >
                <X className="w-5 h-5 text-foreground" />
              </button>
            </div>
          </div>

          {/* Subdivisions */}
          <div className="p-6 space-y-3">
            {network.subdivisions.map((subdivision, index) => {
              const Icon = getSubdivisionIcon(subdivision);
              return (
                <motion.button
                  key={subdivision}
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: index * 0.05 }}
                  onClick={() => onSelect(subdivision)}
                  className="w-full p-5 rounded-2xl backdrop-blur-xl transition-all active:scale-98 hover:shadow-lg"
                  style={{
                    background: "rgba(255, 255, 255, 0.7)",
                    border: "1px solid rgba(255, 255, 255, 0.5)",
                  }}
                >
                  <div className="flex items-center gap-4">
                    <div
                      className="w-14 h-14 rounded-xl flex items-center justify-center"
                      style={{ backgroundColor: `${network.color}20` }}
                    >
                      <Icon className="w-7 h-7" style={{ color: network.color }} />
                    </div>
                    <div className="flex-1 text-right">
                      <h4 className="text-foreground text-lg mb-1">{subdivision}</h4>
                      <p className="text-sm text-muted-foreground">
                        {getSubdivisionDescription(subdivision)}
                      </p>
                    </div>
                  </div>
                </motion.button>
              );
            })}
          </div>
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
}

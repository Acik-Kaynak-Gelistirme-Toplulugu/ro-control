import { ChevronRight } from "lucide-react";
import { Button } from "./ui/button";

interface InstallTabProps {
  onNavigateToExpert: () => void;
}

export function InstallTab({ onNavigateToExpert }: InstallTabProps) {
  return (
    <div className="flex-1 flex flex-col items-center justify-center p-8 space-y-8">
      <div className="flex flex-col items-center space-y-4 mb-8">
        <div className="w-20 h-20 rounded-full bg-gradient-to-br from-primary to-primary/60 flex items-center justify-center shadow-lg">
          <div className="w-16 h-16 rounded-full bg-card/80 backdrop-blur-xl flex items-center justify-center">
            <svg className="w-10 h-10 text-primary" viewBox="0 0 24 24" fill="none">
              <path d="M12 2L2 7L12 12L22 7L12 2Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" fill="currentColor" fillOpacity="0.2"/>
              <path d="M2 17L12 22L22 17" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              <path d="M2 12L12 17L22 12" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
            </svg>
          </div>
        </div>
        <div className="text-center">
          <h2 className="text-primary mb-2">Kurulum Tipini Seçin</h2>
          <p className="text-muted-foreground text-sm">Donanımınız için optimize edilmiş seçenekler.</p>
        </div>
      </div>

      <div className="w-full max-w-2xl space-y-3">
        <button className="w-full group relative overflow-hidden rounded-xl p-6 text-left transition-all hover:scale-[1.02] active:scale-[0.98]">
          <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50 backdrop-blur-xl border border-border/50 rounded-xl shadow-lg" />
          <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
          <div className="relative flex items-center gap-4">
            <div className="w-12 h-12 rounded-lg bg-secondary/80 backdrop-blur-sm flex items-center justify-center shrink-0 shadow-sm">
              <svg className="w-6 h-6" viewBox="0 0 24 24" fill="none">
                <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" fill="currentColor" fillOpacity="0.2"/>
              </svg>
            </div>
            <div className="flex-1">
              <h3 className="mb-1">Express Install (Recommended)</h3>
              <p className="text-sm text-muted-foreground">Automatically installs the latest stable NVIDIA v550 driver.</p>
            </div>
            <ChevronRight className="size-5 text-muted-foreground group-hover:text-foreground group-hover:translate-x-1 transition-all" />
          </div>
        </button>

        <button 
          onClick={onNavigateToExpert}
          className="w-full group relative overflow-hidden rounded-xl p-6 text-left transition-all hover:scale-[1.02] active:scale-[0.98]"
        >
          <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50 backdrop-blur-xl border border-border/50 rounded-xl shadow-lg" />
          <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
          <div className="relative flex items-center gap-4">
            <div className="w-12 h-12 rounded-lg bg-secondary/80 backdrop-blur-sm flex items-center justify-center shrink-0 shadow-sm">
              <svg className="w-6 h-6" viewBox="0 0 24 24" fill="none">
                <path d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" fill="currentColor" fillOpacity="0.1"/>
              </svg>
            </div>
            <div className="flex-1">
              <h3 className="mb-1">Custom Install (Expert)</h3>
              <p className="text-sm text-muted-foreground">Manually configure version, kernel type, and cleanup settings.</p>
            </div>
            <ChevronRight className="size-5 text-muted-foreground group-hover:text-foreground group-hover:translate-x-1 transition-all" />
          </div>
        </button>
      </div>
    </div>
  );
}
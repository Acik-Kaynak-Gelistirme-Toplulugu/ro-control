import { useState } from "react";
import { ThemeProvider } from "next-themes";
import { WindowControls } from "./components/WindowControls";
import { InstallTab } from "./components/InstallTab";
import { PerformanceTab } from "./components/PerformanceTab";
import { ExpertManagement } from "./components/ExpertManagement";

function AppContent() {
  const [activeTab, setActiveTab] = useState<"install" | "performance">("install");
  const [showExpertManagement, setShowExpertManagement] = useState(false);

  return (
    <div className="size-full flex flex-col bg-background">
      {/* MacOS Window */}
      <div className="w-full h-full flex flex-col overflow-hidden">
        {/* Window Controls */}
        <WindowControls />

        {/* Status Bar */}
        <div className="px-4 py-2 text-xs text-muted-foreground border-b border-border/50 backdrop-blur-xl bg-card/30">
          Aktif Sürücü: nouveau (Simulated) | Secure Boot: Devre Dışı
        </div>

        {/* Tab Navigation - Only show when not in Expert Management */}
        {!showExpertManagement && (
          <div className="flex items-center gap-2 px-4 py-3 border-b border-border/50 backdrop-blur-xl bg-card/30">
            <button
              onClick={() => setActiveTab("install")}
              className={`px-6 py-2 rounded-lg transition-all ${
                activeTab === "install"
                  ? "bg-secondary backdrop-blur-xl shadow-lg"
                  : "hover:bg-secondary/50 backdrop-blur-sm"
              }`}
            >
              Install
            </button>
            <button
              onClick={() => setActiveTab("performance")}
              className={`px-6 py-2 rounded-lg transition-all ${
                activeTab === "performance"
                  ? "bg-secondary backdrop-blur-xl shadow-lg"
                  : "hover:bg-secondary/50 backdrop-blur-sm"
              }`}
            >
              Performance
            </button>
          </div>
        )}

        {/* Content Area */}
        <div className="flex-1 overflow-hidden">
          {showExpertManagement ? (
            <ExpertManagement onBack={() => setShowExpertManagement(false)} />
          ) : activeTab === "install" ? (
            <InstallTab onNavigateToExpert={() => setShowExpertManagement(true)} />
          ) : (
            <PerformanceTab />
          )}
        </div>
      </div>
    </div>
  );
}

export default function App() {
  return (
    <ThemeProvider attribute="class" defaultTheme="dark" enableSystem={false}>
      <AppContent />
    </ThemeProvider>
  );
}
import { Minus, Square, X, Menu, Sun, Moon } from "lucide-react";
import { useTheme } from "next-themes";
import { useEffect, useState } from "react";

export function WindowControls() {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <div className="flex items-center justify-between w-full px-4 py-3 border-b border-border/50 backdrop-blur-xl bg-card/50">
      <div className="flex items-center gap-2">
        <button className="w-3 h-3 rounded-full bg-[#ff5f57] hover:bg-[#ff5f57]/80 transition-colors" aria-label="Close" />
        <button className="w-3 h-3 rounded-full bg-[#febc2e] hover:bg-[#febc2e]/80 transition-colors" aria-label="Minimize" />
        <button className="w-3 h-3 rounded-full bg-[#28c840] hover:bg-[#28c840]/80 transition-colors" aria-label="Maximize" />
      </div>
      
      <div className="flex items-center gap-2">
        {mounted && (
          <button
            onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
            className="w-8 h-8 rounded-lg bg-secondary/50 hover:bg-secondary transition-colors flex items-center justify-center backdrop-blur-sm"
            aria-label="Toggle theme"
          >
            {theme === "dark" ? <Sun className="size-4" /> : <Moon className="size-4" />}
          </button>
        )}
        <button className="w-8 h-8 rounded-lg bg-secondary/50 hover:bg-secondary transition-colors flex items-center justify-center backdrop-blur-sm">
          <Menu className="size-4" />
        </button>
      </div>
    </div>
  );
}
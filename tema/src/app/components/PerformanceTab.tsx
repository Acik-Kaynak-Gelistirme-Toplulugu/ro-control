import { RefreshCw, HelpCircle } from "lucide-react";
import { Button } from "./ui/button";
import { Switch } from "./ui/switch";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "./ui/select";

export function PerformanceTab() {
  return (
    <div className="flex-1 p-6 space-y-6 overflow-auto">
      {/* System Specs */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative p-6">
          <h3 className="mb-4">System Specs</h3>
          <div className="space-y-3">
            {[
              { label: "OS:", value: "macOS" },
              { label: "Kernel:", value: "25.2.0" },
              { label: "Processor (CPU):", value: "Apple Silicon (M-Series)" },
              { label: "Memory (RAM):", value: "16 GB (Simulated)" },
              { label: "Graphics Card:", value: "NVIDIA GeForce RTX 4060 (Simulated)" },
              { label: "Display Server:", value: "Unknown" }
            ].map((item, index) => (
              <div key={index} className="flex items-center gap-3">
                <div className="w-6 h-6 rounded-md bg-secondary/80 backdrop-blur-sm flex items-center justify-center shrink-0">
                  <div className="w-2 h-2 rounded-full bg-primary/60" />
                </div>
                <div className="flex items-baseline gap-2">
                  <span className="text-sm text-muted-foreground min-w-[140px]">{item.label}</span>
                  <span className="text-sm">{item.value}</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Live GPU Status */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative">
          <div className="flex items-center justify-between p-6 pb-4">
            <h3>Live GPU Status</h3>
            <Button variant="ghost" size="icon" className="rounded-lg bg-secondary/50 hover:bg-secondary">
              <RefreshCw className="size-4" />
            </Button>
          </div>
          <div className="px-6 pb-6 space-y-4">
            {[
              { label: "Temp:", value: "0°C", current: 0 },
              { label: "Load:", value: "0%", current: 0 },
              { label: "VRAM:", value: "0 / 1 MB", current: 0 }
            ].map((item, index) => (
              <div key={index} className="space-y-2">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{item.label}</span>
                  <span>{item.value}</span>
                </div>
                <div className="h-2 rounded-full bg-secondary/50 overflow-hidden backdrop-blur-sm">
                  <div 
                    className="h-full bg-gradient-to-r from-primary to-primary/60 transition-all duration-500"
                    style={{ width: `${item.current}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Live System Usage */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative p-6">
          <h3 className="mb-4">Live System Usage</h3>
          <div className="space-y-4">
            {[
              { label: "CPU Temp:", value: "--", current: 0 },
              { label: "CPU Load:", value: "0%", current: 0 },
              { label: "Memory (RAM)::", value: "0 / 0 MB", current: 0 }
            ].map((item, index) => (
              <div key={index} className="space-y-2">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{item.label}</span>
                  <span>{item.value}</span>
                </div>
                <div className="h-2 rounded-full bg-secondary/50 overflow-hidden backdrop-blur-sm">
                  <div 
                    className="h-full bg-gradient-to-r from-chart-2 to-chart-2/60 transition-all duration-500"
                    style={{ width: `${item.current}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Graphics Mode */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative p-6">
          <h3 className="mb-4">Graphics Mode (Hybrid / Mux)</h3>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <span className="text-sm">Select Mode:</span>
              <Select defaultValue="balanced">
                <SelectTrigger className="w-[200px] bg-secondary/50 backdrop-blur-sm border-border/50">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent className="bg-popover backdrop-blur-xl border-border/50">
                  <SelectItem value="balanced">Balanced (On-Demand)</SelectItem>
                  <SelectItem value="performance">Performance</SelectItem>
                  <SelectItem value="power-saving">Power Saving</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <Button className="w-full bg-primary hover:bg-primary/90 backdrop-blur-sm shadow-lg">
              Apply (Reboot Required)
            </Button>
            <div className="flex items-start gap-2 p-3 rounded-lg bg-destructive/10 backdrop-blur-sm border border-destructive/20">
              <div className="w-5 h-5 rounded bg-destructive/20 flex items-center justify-center shrink-0 mt-0.5">
                <span className="text-destructive">!</span>
              </div>
              <p className="text-xs text-destructive-foreground/80">
                This feature is not supported on your device (NVIDIA Optimus/Prime not found).
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Tools & Optimization */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative p-6">
          <div className="flex items-center gap-2 mb-4">
            <h3>Tools & Optimization</h3>
            <HelpCircle className="size-4 text-muted-foreground" />
          </div>
          <div className="flex items-center justify-between p-4 rounded-lg bg-secondary/30 backdrop-blur-sm">
            <div className="flex-1">
              <h4 className="text-sm mb-1">Game Mode (Feral GameMode):</h4>
            </div>
            <Switch />
          </div>
        </div>
      </div>
    </div>
  );
}

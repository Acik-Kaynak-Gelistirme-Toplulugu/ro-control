import { ArrowLeft, RefreshCw, ChevronRight, HelpCircle } from "lucide-react";
import { Button } from "./ui/button";
import { Checkbox } from "./ui/checkbox";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "./ui/select";

interface ExpertManagementProps {
  onBack: () => void;
}

export function ExpertManagement({ onBack }: ExpertManagementProps) {
  return (
    <div className="flex-1 p-6 space-y-6 overflow-auto">
      {/* Header */}
      <div className="flex items-center gap-3">
        <Button 
          variant="ghost" 
          size="icon" 
          onClick={onBack}
          className="rounded-lg bg-secondary/50 hover:bg-secondary"
        >
          <ArrowLeft className="size-4" />
        </Button>
        <Button 
          variant="ghost" 
          size="icon" 
          className="rounded-lg bg-secondary/50 hover:bg-secondary"
        >
          <RefreshCw className="size-4" />
        </Button>
        <h2 className="text-primary">Expert Driver Management</h2>
      </div>

      {/* Installation Settings */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative p-6 space-y-4">
          <h3>Installation Settings</h3>
          
          <div className="relative overflow-hidden rounded-lg backdrop-blur-xl border border-border/50">
            <div className="absolute inset-0 bg-gradient-to-br from-secondary/30 to-secondary/10" />
            <div className="relative p-4 space-y-3">
              <div className="flex items-center justify-between">
                <span className="text-sm text-muted-foreground">Target Driver Version:</span>
                <Select defaultValue="v550">
                  <SelectTrigger className="w-[140px] bg-secondary/50 backdrop-blur-sm border-border/50">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-popover backdrop-blur-xl border-border/50">
                    <SelectItem value="v550">NVIDIA v550</SelectItem>
                    <SelectItem value="v545">NVIDIA v545</SelectItem>
                    <SelectItem value="v535">NVIDIA v535</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="flex items-center gap-3 p-3 rounded-md bg-primary/10 backdrop-blur-sm border border-primary/20">
                <Checkbox id="deep-clean" defaultChecked className="data-[state=checked]:bg-primary" />
                <label htmlFor="deep-clean" className="text-sm cursor-pointer flex-1">
                  Deep Clean (Remove previous configs)
                </label>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Actions */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative p-6 space-y-3">
          <h3>Actions</h3>

          <button className="w-full group relative overflow-hidden rounded-xl p-6 text-left transition-all hover:scale-[1.02] active:scale-[0.98]">
            <div className="absolute inset-0 bg-gradient-to-br from-secondary/50 to-secondary/30 backdrop-blur-xl border border-border/50 rounded-xl" />
            <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
            <div className="relative flex items-center gap-4">
              <div className="w-10 h-10 rounded-lg bg-card/80 backdrop-blur-sm flex items-center justify-center shrink-0 shadow-sm">
                <svg className="w-5 h-5" viewBox="0 0 24 24" fill="none">
                  <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" fill="currentColor" fillOpacity="0.1"/>
                </svg>
              </div>
              <div className="flex-1">
                <h4 className="text-sm mb-0.5">Install Proprietary Driver</h4>
                <p className="text-xs text-muted-foreground">Installs the selected version (Closed Source).</p>
              </div>
              <ChevronRight className="size-5 text-muted-foreground group-hover:text-foreground group-hover:translate-x-1 transition-all" />
            </div>
          </button>

          <button className="w-full group relative overflow-hidden rounded-xl p-6 text-left transition-all hover:scale-[1.02] active:scale-[0.98]">
            <div className="absolute inset-0 bg-gradient-to-br from-secondary/50 to-secondary/30 backdrop-blur-xl border border-border/50 rounded-xl" />
            <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
            <div className="relative flex items-center gap-4">
              <div className="w-10 h-10 rounded-lg bg-card/80 backdrop-blur-sm flex items-center justify-center shrink-0 shadow-sm">
                <svg className="w-5 h-5" viewBox="0 0 24 24" fill="none">
                  <path d="M12 4v16m8-8H4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </div>
              <div className="flex-1">
                <h4 className="text-sm mb-0.5">Install Open Kernel Driver</h4>
                <p className="text-xs text-muted-foreground">Installs the selected version (Open Source Modules).</p>
              </div>
              <ChevronRight className="size-5 text-muted-foreground group-hover:text-foreground group-hover:translate-x-1 transition-all" />
            </div>
          </button>

          <button className="w-full group relative overflow-hidden rounded-xl p-6 text-left transition-all hover:scale-[1.02] active:scale-[0.98]">
            <div className="absolute inset-0 bg-gradient-to-br from-destructive/20 to-destructive/10 backdrop-blur-xl border border-destructive/30 rounded-xl" />
            <div className="absolute inset-0 bg-gradient-to-br from-destructive/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
            <div className="relative flex items-center gap-4">
              <div className="w-10 h-10 rounded-lg bg-destructive/20 backdrop-blur-sm flex items-center justify-center shrink-0">
                <svg className="w-5 h-5 text-destructive" viewBox="0 0 24 24" fill="none">
                  <path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </div>
              <div className="flex-1">
                <h4 className="text-sm text-destructive mb-0.5">Remove Drivers & Reset</h4>
                <p className="text-xs text-destructive/70">Reverts system to the default Nouveau driver.</p>
              </div>
              <ChevronRight className="size-5 text-destructive/60 group-hover:text-destructive group-hover:translate-x-1 transition-all" />
            </div>
          </button>
        </div>
      </div>

      {/* Extra Tools */}
      <div className="relative overflow-hidden rounded-xl backdrop-blur-xl border border-border/50 shadow-lg">
        <div className="absolute inset-0 bg-gradient-to-br from-card to-card/50" />
        <div className="relative p-6">
          <div className="flex items-center gap-2 mb-4">
            <h3>Extra Tools</h3>
            <HelpCircle className="size-4 text-muted-foreground" />
          </div>
          
          <div className="grid grid-cols-2 gap-3">
            <Button 
              variant="outline" 
              className="h-auto py-4 flex-col items-center gap-2 bg-secondary/30 hover:bg-secondary/50 backdrop-blur-xl"
            >
              <svg className="w-6 h-6" viewBox="0 0 24 24" fill="none">
                <path d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
              <span className="text-sm">Repo Fix</span>
            </Button>
            <Button 
              variant="outline" 
              className="h-auto py-4 flex-col items-center gap-2 bg-secondary/30 hover:bg-secondary/50 backdrop-blur-xl"
            >
              <svg className="w-6 h-6" viewBox="0 0 24 24" fill="none">
                <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
              <span className="text-sm">Test (glxgears)</span>
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}

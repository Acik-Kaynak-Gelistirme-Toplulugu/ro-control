import shutil
import logging
import multiprocessing
from src.utils.command_runner import CommandRunner

class SystemTweaks:
    def __init__(self):
        self.is_nvidia = False 
        self.logger = logging.getLogger("SystemTweaks")
        self.runner = CommandRunner()
        self.nvidia_smi_path = shutil.which("nvidia-smi")

    def get_gpu_stats(self):
        """
        NVIDIA GPU verilerini çeker.
        """
        stats = {"temp": 0, "load": 0, "mem_used": 0, "mem_total": 0}
        
        if self.nvidia_smi_path:
            try:
                # CommandRunner ile çalıştır
                res = self.runner.run(f"{self.nvidia_smi_path} --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits")
                if res:
                    parts = res.strip().split(', ')
                    if len(parts) >= 4:
                        stats["temp"] = int(parts[0])
                        stats["load"] = int(parts[1])
                        stats["mem_used"] = int(parts[2])
                        stats["mem_total"] = int(parts[3])
                        return stats
            except Exception as e:
                self.logger.error(f"GPU Stats okunamadı: {e}")
        
        return stats

    def get_system_stats(self):
        """
        Genel Sistem kaynak kullanımını (CPU, RAM, Temp) çeker.
        """
        sys_stats = {"cpu_load": 0, "ram_used": 0, "ram_total": 0, "ram_percent": 0, "cpu_temp": 0}
        
        try:
            # CPU Load (Basit ortalama)
            with open("/proc/loadavg", "r") as f:
                load_avg = float(f.read().split()[0])
                cores = multiprocessing.cpu_count()
                percent = (load_avg / cores) * 100
                sys_stats["cpu_load"] = min(int(percent), 100)

            # RAM
            mem_info = {}
            with open("/proc/meminfo", "r") as f:
                for line in f:
                    parts = line.split()
                    if len(parts) >= 2:
                        mem_info[parts[0].strip(":")] = int(parts[1]) # kB

            if "MemTotal" in mem_info and "MemAvailable" in mem_info:
                total_mb = mem_info["MemTotal"] // 1024
                avail_mb = mem_info["MemAvailable"] // 1024
                used_mb = total_mb - avail_mb
                sys_stats["ram_total"] = total_mb
                sys_stats["ram_used"] = used_mb
                sys_stats["ram_percent"] = int((used_mb / total_mb) * 100)

            # CPU Temp
            try:
                # Yaygın thermal zone (x86)
                with open("/sys/class/thermal/thermal_zone0/temp", "r") as f:
                    sys_stats["cpu_temp"] = int(int(f.read().strip()) / 1000)
            except:
                sys_stats["cpu_temp"] = 0 # Okunamazsa 0
                
        except Exception as e:
            self.logger.error(f"Sistem istatistikleri alınırken hata: {e}")
            pass
            
        return sys_stats

    def is_gamemode_active(self):
        """Feral GameMode yüklü mü kontrol eder."""
        return shutil.which("gamemoded") is not None

    def install_gamemode(self):
        """GameMode paketini kurar."""
        self.logger.info("GameMode kurulumu başlatılıyor...")
        # dpkg kilidini önlemek ve temiz kurulum için wrapper kullanıyoruz
        cmd = 'pkexec ro-control-root-task "apt-get install -y gamemode"'
        code, out, err = self.runner.run_full(cmd)
        
        if code != 0:
            msg = f"GameMode kurulum başarısız. Code: {code}, Err: {err}"
            self.logger.error(msg)
            return False, msg
        
        self.logger.info("GameMode başarıyla kuruldu.")
        return True, "GameMode başarıyla kuruldu."

    def is_prime_supported(self):
        """Sistemin NVIDIA Prime (Hybrid Graphics) destekleyip desteklemediğini kontrol eder."""
        return shutil.which("prime-select") is not None

    def get_prime_profile(self):
        """Mevcut Hybrid Graphics modunu döndürür (nvidia/intel/on-demand)."""
        if not shutil.which("prime-select"):
            return "unknown"
        
        res = self.runner.run("prime-select query")
        if res:
            return res.strip()
        return "unknown"

    def set_prime_profile(self, profile):
        """Hybrid modunu değiştirir (Reboot gerekir)."""
        self.logger.info(f"Prime profili değiştiriliyor: {profile}")
        cmd = f"pkexec prime-select {profile}"
        code, out, err = self.runner.run_full(cmd)
        
        if code != 0:
            self.logger.error(f"Prime değişim hatası: {err}")
            return False
            
        return True

    def repair_flatpak_permissions(self):
        """Flatpak NVIDIA runtime izinlerini düzeltmeye çalışır."""
        self.logger.info("Flatpak onarımı başlatılıyor...")
        
        # Komutları && (VE) ile birbirine bağlayarak tek seferde çalıştır
        # Böylece kullanıcı sadece 1 kere şifre girer.
        chained_cmd = "flatpak update -y && flatpak repair"
        
        self.logger.info(f"Toplu onarım komutu yürütülüyor: {chained_cmd}")
        # Tek pkexec çağrısı
        full_cmd = f'pkexec ro-control-root-task "{chained_cmd}"'
        
        code, out, err = self.runner.run_full(full_cmd)
        
        if code != 0:
            msg = f"Flatpak onarım hatası: {err}"
            self.logger.error(msg)
            return False, msg
            
        msg = f"Flatpak onarımı başarıyla tamamlandı.\n\nÇıktı:\n{out[:500]}..." # Çıktının başını göster
        self.logger.info("Flatpak onarımı başarıyla tamamlandı.")
        return True, msg

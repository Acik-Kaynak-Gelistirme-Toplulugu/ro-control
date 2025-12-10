import platform
import urllib.parse
import webbrowser
import logging
import json
from src.core.detector import SystemDetector

from src.config import AppConfig

# Raporların gönderileceği geliştirici adresi
DEVELOPER_EMAIL = AppConfig.DEVELOPER_EMAIL

class ErrorReporter:
    @staticmethod
    def collect_system_info():
        """Sistem özetini toplar."""
        info = {
            "OS": f"{platform.system()} {platform.release()}",
            "Arch": platform.machine(),
            "Python": platform.python_version()
        }
        
        try:
            import os
            info["Desktop"] = os.environ.get("XDG_CURRENT_DESKTOP", "-")
            
            detector = SystemDetector()
            gpu = detector.detect()
            info["GPU"] = f"{gpu.get('vendor')} {gpu.get('model')}"
            info["Driver"] = str(gpu.get('driver_in_use'))
        except:
            pass
            
        return info

    @staticmethod
    def prepare_mailto_link(error_message, system_info):
        """Mailto linkini oluşturur."""
        subject = f"Hata Raporu: {system_info.get('GPU', 'Generic')}"
        
        # JSON formatını okunabilir string'e çevir
        sys_str = "\n".join([f"- {k}: {v}" for k, v in system_info.items()])
        
        body = f"""Merhaba,

Uygulamayı kullanırken aşağıdaki hatayı aldım:

HATA MESAJI:
{error_message}

SİSTEM BİLGİLERİ:
{sys_str}

LOG KAYITLARI:
(Lütfen logları buraya yapıştırın - CTRL+V)

--------------------------------------------------
"""
        # URL encoding (Boşlukları %20 vb. yapma)
        params = {
            "to": DEVELOPER_EMAIL,
            "subject": subject,
            "body": body
        }
        
        # urllib.parse.urlencode 'to' parametresini desteklemez, manuel ekliyoruz
        query = urllib.parse.urlencode({"subject": subject, "body": body}, quote_via=urllib.parse.quote)
        return f"mailto:{DEVELOPER_EMAIL}?{query}"

    @staticmethod
    def send_report(error_message, log_content):
        """
        Mail istemcisini açar ve logu panoya kopyalar.
        Not: Pano işlemi UI thread'inde yapılmalıdır, burada sadece linki açıyoruz.
        """
        try:
            logging.info("Sistem bilgileri toplanıyor...")
            sys_info = ErrorReporter.collect_system_info()
            
            link = ErrorReporter.prepare_mailto_link(error_message, sys_info)
            
            logging.info("Mail istemcisi açılıyor...")
            logging.info("Mail istemcisi açılıyor...")
            
            try:
                webbrowser.open(link)
            except Exception:
                # Fallback: xdg-open veya sensible-browser
                import subprocess
                try:
                    subprocess.run(["xdg-open", link], check=False)
                except FileNotFoundError:
                    subprocess.run(["sensible-browser", link], check=False)

        except Exception as e:
            logging.error(f"Mail istemcisi açılamadı: {e}")
            return False

    @staticmethod
    def send_feedback():
        """Genel geri bildirim için mail istemcisini açar."""
        try:
            subject = "ro-Control Feedback"
            body = "\n\n\n--\nro-Control v{} - Linux Driver Manager".format(AppConfig.VERSION)
            
            query = urllib.parse.urlencode({"subject": subject, "body": body}, quote_via=urllib.parse.quote)
            link = f"mailto:{DEVELOPER_EMAIL}?{query}"
            
            logging.info("Geri bildirim maili açılıyor...")
            
            try:
                webbrowser.open(link)
            except Exception:
                import subprocess
                try:
                    subprocess.run(["xdg-open", link], check=False)
                except:
                    subprocess.run(["sensible-browser", link], check=False)
            return True
        except Exception as e:
            logging.error(f"Mail açma hatası: {e}")
            return False
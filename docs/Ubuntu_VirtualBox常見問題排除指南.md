# Ubuntu VirtualBox 常見問題排除指南

本指南整理本課程使用 **Ubuntu 22.04 LTS + VirtualBox + ROS 2 Humble + Gazebo / RViz** 時常見的環境問題。

> **遇到問題時，請先依照本指南檢查，不要直接重新安裝 Ubuntu。**
>
> 多數問題是虛擬機資源、顯示設定、磁碟空間或 Ubuntu 系統設定造成的。

---

## 1. 建議 VirtualBox 配置

若實體電腦具有至少 **16 GB RAM**，建議虛擬機設定如下：

| 項目 | 建議設定 |
|---|---|
| Ubuntu | 22.04 LTS |
| RAM | 8 GB（8192 MB） |
| CPU | 4～6 vCPU |
| Video Memory | 128 MB |
| Graphics Controller | VMSVGA |
| 3D Acceleration | Enable |
| Storage | 建議使用 SSD |
| Virtual Disk | 至少 60 GB |

若需要同時執行 Gazebo、RViz 與 ROS 2 節點，建議使用 **8 GB RAM + 6 vCPU**（主機硬體資源足夠的情況下）。

> 分配越多 CPU / RAM 不一定越快。Windows 主機本身也需要保留足夠資源，請勿將所有核心或記憶體全部分配給 VirtualBox。

---

## 2. Ubuntu 或 Gazebo 執行很卡

請先將 Ubuntu **完全關機**，不要使用 Saved State。

進入：

```text
VirtualBox → Ubuntu → Settings
```

確認以下設定：

```text
System
├── RAM：8192 MB
└── Processor：4～6 CPUs

Display
├── Video Memory：128 MB
├── Graphics Controller：VMSVGA
└── Enable 3D Acceleration：✓
```

如果 Ubuntu 桌面、RViz 或 Gazebo 的畫面特別卡，請優先確認 **Video Memory、VMSVGA 與 3D Acceleration**，因為問題不一定是 CPU 或 RAM 不足。

---

## 3. Terminal 點擊後沒有反應

正常情況下可使用：

```text
Ctrl + Alt + T
```

開啟 Terminal。

如果完全沒有反應，先不要重新安裝 Ubuntu，可以進入 Linux TTY 進行檢查。

按下：

```text
Ctrl + Alt + F3
```

應該會看到類似：

```text
Ubuntu 22.04.x LTS ubuntu tty3

ubuntu login:
```

這是正常的 Linux 文字模式，不代表 Ubuntu 損壞。

---

## 4. 登入 TTY

在：

```text
ubuntu login:
```

輸入 Ubuntu 的使用者名稱，例如：

```text
ubuntu login: vboxuser
Password:
```

接著輸入 Ubuntu 的登入密碼。

> **注意：** Linux TTY 輸入密碼時，畫面不會顯示 `*`，游標看起來也可能完全沒有變化。這是正常的安全設計，輸入完成後直接按 Enter。

成功登入後會看到類似：

```text
vboxuser@ubuntu:~$
```

---

## 5. 先確認系統資源

### 5.1 檢查磁碟

```bash
df -h
```

注意根目錄 `/` 的使用率，例如：

```text
Filesystem   Size  Used  Avail  Use%
/dev/sda2     59G   12G    44G   22%
```

如果 `/` 已接近 **90～100%**，可能造成 Ubuntu 或應用程式異常。

### 5.2 檢查 RAM

```bash
free -h
```

請注意 `available` 欄位。若仍有足夠可用記憶體，問題通常不是 RAM 用盡。

### 5.3 檢查失敗的系統服務

```bash
systemctl --failed
```

若沒有失敗服務，可能看到：

```text
0 loaded units listed.
```

---

## 6. 檢查 GNOME Terminal

在 TTY 輸入：

```bash
gnome-terminal
```

如果看到類似：

```text
Error constructing proxy for org.gnome.Terminal
Error calling StartServiceByName
Timeout was reached
```

接著執行：

```bash
systemctl --user status gnome-terminal-server.service
```

如果錯誤訊息包含：

```text
Non UTF-8 locale (...) is not supported.
Failed to start GNOME Terminal Server.
```

代表問題很可能不是 VirtualBox 效能，而是 **Ubuntu Locale（語系環境）設定錯誤**。

---

## 7. 修復 Non UTF-8 Locale

先查看目前 Locale：

```bash
locale
```

若 `LANG` 類似：

```text
LANG=en_US
```

而不是 UTF-8 Locale，可依照以下方式修復。

### Step 1：建立 UTF-8 Locale

```bash
sudo locale-gen en_US.UTF-8
```

正常會看到：

```text
Generating locales...
en_US.UTF-8... done
Generation complete.
```

### Step 2：更新系統 Locale

請輸入**完整的一行指令**：

```bash
sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en
```

不要拆成：

```bash
sudo update-locale
LANG=en_US.UTF-8
LANGUAGE=en_US:en
```

因為後兩行只會成為目前 Shell 的設定，不會正確修改系統 Locale。

### Step 3：確認設定

```bash
cat /etc/default/locale
```

至少應看到：

```text
LANG=en_US.UTF-8
LANGUAGE=en_US:en
```

其他 `LC_*` 項目可能仍保留台灣地區格式設定，這本身不一定有問題；關鍵是終端使用的字元編碼必須是 UTF-8。

### Step 4：重新啟動

```bash
sudo reboot
```

重新登入 Ubuntu 後，再使用：

```text
Ctrl + Alt + T
```

測試 Terminal。

---

## 8. Terminal 修好，但 Gazebo / RViz 還是很卡

這通常是另一個問題，不需要繼續修改 Locale。

安裝 OpenGL 檢查工具：

```bash
sudo apt update
sudo apt install -y mesa-utils
```

執行：

```bash
glxinfo -B
```

注意：

```text
direct rendering:
OpenGL renderer string:
```

如果 renderer 顯示：

```text
llvmpipe
```

表示 Ubuntu 可能正在使用 CPU 進行 software rendering，因此 Gazebo、RViz 與桌面圖形效能可能很差。

請再次確認：

```text
VirtualBox → Settings → Display

Graphics Controller：VMSVGA
Video Memory：128 MB
Enable 3D Acceleration：✓
```

也可以檢查 VirtualBox Guest Additions 相關核心模組：

```bash
lsmod | grep vbox
```

---

## 9. 快速排錯流程

```text
Ubuntu / VirtualBox 出現問題
          │
          ├── 整台 VM 很卡
          │      ↓
          │   檢查 RAM / CPU
          │      ↓
          │   VRAM = 128 MB
          │      ↓
          │   VMSVGA + 3D Acceleration
          │      ↓
          │   glxinfo -B
          │
          └── Terminal 打不開
                 ↓
          Ctrl + Alt + F3
                 ↓
              登入 TTY
                 ↓
            gnome-terminal
                 ↓
   systemctl --user status
   gnome-terminal-server.service
                 ↓
       Non UTF-8 locale？
            ↙          ↘
          YES           NO
           ↓             ↓
      修正 UTF-8      查看其他錯誤
           ↓
      sudo reboot
           ↓
     Ctrl + Alt + T
```

---

## 10. 本次實際案例

本次遇到的 Terminal 無法開啟，檢查後並不是：

```text
✗ CPU 不足
✗ RAM 不足
✗ 磁碟空間不足
✗ Ubuntu 安裝損壞
```

實際錯誤訊息為：

```text
Non UTF-8 locale (...) is not supported.
```

因此問題流程為：

```text
錯誤 Locale
    ↓
gnome-terminal-server 啟動失敗
    ↓
D-Bus StartServiceByName timeout
    ↓
GNOME Terminal 點擊後沒有反應
```

將系統 Locale 修正為：

```text
LANG=en_US.UTF-8
```

並重新啟動後，即可恢復正常。

---

## 問題仍未解決？

如果按照本指南仍無法解決，請保留**完整錯誤訊息或畫面截圖**。不要只回報「打不開」、「跑不動」或「有 error」，因為這些資訊不足以判斷問題來源。

建議至少提供：

```text
1. 發生問題前執行了什麼操作
2. 完整錯誤訊息
3. VirtualBox RAM / CPU / Display 設定
4. df -h
5. free -h
6. systemctl --failed
```

這些資訊通常可以大幅縮短排錯時間。

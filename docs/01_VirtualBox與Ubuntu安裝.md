# 01 — VirtualBox 與 Ubuntu 22.04 安裝

本章將建立後續整學期使用的 Ubuntu 虛擬機環境。

完成本章後，你的電腦應具備：

```text
Windows 10 / 11
└── Oracle VirtualBox
    └── Ubuntu 22.04.5 LTS 桌面版
        └── 後續安裝 ROS 2 Humble、Gazebo、RViz、TurtleBot3
```

> [!IMPORTANT]
> 請依照教材指定版本安裝。後續 ROS 2 Humble 與課程套件皆以 **Ubuntu 22.04** 為基準。

---

## 1. 安裝前確認

### 1.1 電腦基本需求

建議先確認自己的電腦符合以下條件：

| 項目 | 最低要求 | 建議 |
| --- | --- | --- |
| 主機作業系統 | Windows 10 / 11 64 位元 | Windows 11 64 位元 |
| 處理器 | Intel Core i5 / AMD Ryzen 5 等級 | 具備 12 個以上邏輯處理器 |
| 記憶體 | 16 GB | 32 GB |
| 可用磁碟空間 | 60 GB 以上 | 80 GB 以上 |
| 儲存裝置 | SSD | NVMe SSD |
| 顯示卡 | 支援 3D 硬體加速 | 近年 Intel/AMD 內顯或 NVIDIA/AMD 獨顯 |
| 硬體虛擬化 | Intel VT-x / AMD-V，必須啟用 | 同左 |

> [!WARNING]
> 本課程後續會使用 Gazebo 與 RViz。虛擬機的 CPU 與記憶體配置必須依實體電腦能力調整，不要把 Windows 主機本身需要的資源全部分配給虛擬機。

---

## 2. 下載 Oracle VirtualBox

請由 Oracle VirtualBox 官方網站下載：

**官方下載頁：**  
https://www.virtualbox.org/wiki/Downloads

Windows 使用者請找到：

```text
VirtualBox 平台套件（VirtualBox Platform Packages）
└── Windows 主機（Windows hosts）
```

點選 **Windows hosts** 下載安裝程式。

### 2.1 安裝 VirtualBox

1. 執行下載完成的 VirtualBox 安裝程式。
2. 一般情況下使用預設選項即可。
3. 安裝過程若 Windows 詢問是否允許安裝網路或系統元件，請允許安裝。
4. 安裝完成後啟動 **Oracle VirtualBox**。

### 完成檢查

如果可以正常開啟 VirtualBox 管理介面（VirtualBox Manager），並看到建立新虛擬機的功能，即完成此步驟。

> [!NOTE]
> 課程使用 VirtualBox 基本功能即可，不需要另外建立 VirtualBox 帳號。

---

## 3. 下載 Ubuntu 22.04.5 LTS

請從 Ubuntu 官方網站下載：

**Ubuntu 22.04.5 LTS（Jammy Jellyfish）：**  
https://releases.ubuntu.com/jammy/

請下載：

```text
ubuntu-22.04.5-desktop-amd64.iso
```

檔案大小約 4.4 GB。

### 請確認下載的是正確版本
<img width="1122" height="591" alt="image" src="https://github.com/user-attachments/assets/8f55fd0d-8cf2-4ce8-9bca-7bb729d93ac3" />

```text
✅ Ubuntu 22.04.5 LTS
✅ 桌面版（Desktop image）
✅ 64 位元 PC（AMD64）

❌ Ubuntu 24.04
❌ Ubuntu Server 伺服器版
❌ WSL 版本
```

> [!IMPORTANT]
> `.iso` 檔案下載完成後 **不需要解壓縮**。VirtualBox 會直接使用 ISO 作為 Ubuntu 安裝媒體。

---

## 4. 建立 Ubuntu 虛擬機

開啟 VirtualBox，點選：

```text
新增（New）
```

### 4.1 名稱與作業系統（Name and Operating System）

建議設定：

```text
名稱（Name）：Ubuntu 22.04
ISO 映像檔（ISO Image）：ubuntu-22.04.5-desktop-amd64.iso
類型 / 作業系統（Type / OS）：Linux
發行版本（Distribution）：Ubuntu
版本（Version）：Ubuntu 22.04 LTS (Jammy Jellyfish) (64-bit)
```

### 非常重要：取消自動安裝

如果畫面出現：

```text
進行無人值守安裝（Proceed with Unattended Installation）
```

請 **取消勾選**。

我們會使用 Ubuntu 標準安裝畫面完成安裝，這樣每位同學看到的流程會與教材一致。

> [!WARNING]
> VirtualBox 有時可能根據 ISO 自動判斷成錯誤的 Ubuntu 版本，例如 Ubuntu 22.10。即使 ISO 本身是 22.04.5，也請手動確認版本顯示為 **Ubuntu 22.04 LTS (Jammy Jellyfish) (64-bit)**。

---

## 5. 設定 CPU 與記憶體

### 課程建議虛擬機設定

如果實體電腦資源足夠，課程建議使用：

```text
CPU：    10 vCPU
記憶體：16384 MB（16 GB）
```

這組設定主要是讓後續 ROS 2、Gazebo、RViz 與 TurtleBot3 模擬有較充足的執行資源。

> [!WARNING]
> **不要為了符合 10 vCPU / 16 GB 而把實體電腦的資源全部分配給虛擬機。**
>
> 如果實體電腦只有 16 GB 記憶體，請降低虛擬機記憶體配置，例如使用 8 GB；如果 CPU 的邏輯處理器數量不足，也請適度降低 vCPU 數量。Windows 主機本身仍需要保留足夠資源正常運作。

### EFI

一般課程環境不需要特別開啟 EFI；若沒有特殊需求，維持預設設定即可。

---

## 6. 建立虛擬硬碟

建議：

```text
磁碟大小（Disk Size）：60 GB
磁碟類型（Disk Type）：VDI
```

如果畫面有以下選項：

```text
預先配置完整大小（Pre-allocate Full Size）
分割成每個 2 GB 的檔案（Split Disk Into 2 GB Parts）
```

兩者都維持 **未勾選**。

這樣建立的是動態配置的虛擬硬碟：設定 60 GB 代表虛擬硬碟最多可以成長到約 60 GB，而不是建立當下立即占滿 60 GB 實體空間。

### 虛擬機儲存位置

如果電腦有 C:、D: 等多個磁碟，建議選擇 **可用空間較大的 SSD** 存放虛擬機。

例如：

```text
D:\VirtualBox VMs\Ubuntu 22.04\
```

> [!IMPORTANT]
> 即使使用動態 VDI，實體磁碟仍必須保留足夠空間讓虛擬機後續成長。

---

## 7. 建立完成後檢查 VirtualBox 設定

建立虛擬機後，先不要急著開始安裝 Ubuntu。

選取：

```text
Ubuntu 22.04
└── 設定（Settings）
```

### 7.1 系統（System）

確認虛擬機的 CPU 與記憶體設定：

```text
記憶體（Memory）：16384 MB（16 GB）
處理器（Processors）：10
```

如果實體電腦資源不足，可以依照自己的硬體降低配置。重點是要讓 Windows 主機與 Ubuntu 虛擬機都保有足夠資源。

確認完成後即可繼續 Ubuntu 安裝。

---

## 8. 啟動 Ubuntu 安裝

確認 ISO、CPU、記憶體與磁碟設定後，點選：

```text
啟動（Start）
```

虛擬機會從 Ubuntu ISO 開機。

進入 Ubuntu 安裝畫面後，選擇安裝 Ubuntu。

不同小版本的安裝畫面文字可能略有差異，但整體流程大致如下：

```text
啟動 Ubuntu ISO
      ↓
試用或安裝 Ubuntu（Try or Install Ubuntu）
      ↓
安裝 Ubuntu（Install Ubuntu）
      ↓
鍵盤配置（Keyboard Layout）
      ↓
安裝選項（Installation Options）
      ↓
磁碟 / 安裝類型（Disk / Installation Type）
      ↓
時區（Time Zone）
      ↓
建立使用者帳號
      ↓
安裝（Install）
      ↓
重新啟動（Restart）
```

---

## 9. Ubuntu 安裝選項

### 9.1 鍵盤配置（Keyboard）

依照自己的鍵盤選擇即可。一般英文鍵盤可以使用預設的英文（美式）（English US）。

### 9.2 安裝模式

若安裝畫面提供一般安裝（Normal installation），建議使用一般桌面安裝選項。

如果有下載更新或第三方軟體選項，依當下網路環境決定即可；課程後續仍會統一使用 `apt` 更新與安裝必要套件。

### 9.3 安裝類型（Installation Type）

在虛擬機裡可能看到：

```text
清除磁碟並安裝 Ubuntu（Erase disk and install Ubuntu）
```

在本課程的 VirtualBox 虛擬機中可以選擇此項。

> [!CAUTION]
> 這裡的「清除磁碟」指的是 **VirtualBox 建立的虛擬硬碟（VDI）**，不是你的 Windows C: 或 D: 實體硬碟。前提是你現在確實是在 VirtualBox 虛擬機的 Ubuntu 安裝畫面內操作。

---

## 10. 建立 Ubuntu 帳號

依照 Ubuntu 安裝程式建立自己的：

```text
姓名（Name）
電腦名稱（Computer Name）
使用者名稱（Username）
密碼（Password）
```

### 請記住自己的密碼

後續安裝 ROS 2 與其他套件時會經常使用：

```bash
sudo
```

Ubuntu 會要求輸入目前使用者密碼。

> [!NOTE]
> 終端機輸入 `sudo` 密碼時，畫面不會顯示 `*` 或其他字元，這是 Linux 正常的安全設計。輸入完成後按 Enter 即可。

---

## 11. 完成安裝並重新啟動

安裝完成後選擇 **重新啟動（Restart）**。

若重新啟動時 Ubuntu 提示移除安裝媒體（installation medium），可以依畫面提示按 Enter；VirtualBox 通常會處理 ISO 啟動媒體。

重新開機後，應該可以進入 Ubuntu 22.04 桌面並登入剛才建立的帳號。

---

## 12. 第一次進入 Ubuntu

開啟終端機（Terminal）：

```text
Ctrl + Alt + T
```

先執行：

```bash
lsb_release -a
```

預期應看到 Ubuntu 22.04 / Jammy 相關資訊。

也可以執行：

```bash
uname -m
```

一般 x86-64 電腦應顯示：

```text
x86_64
```

### 更新系統

確認 Ubuntu 可以正常連上網路後執行：

```bash
sudo apt update
sudo apt upgrade -y
```

第一次更新可能需要一些時間。

完成後建議重新啟動：

```bash
sudo reboot
```

---

## 13. VirtualBox 客體附加元件（Guest Additions）（選做）

客體附加元件（Guest Additions）可以改善虛擬機的顯示整合、視窗解析度與其他功能。

Ubuntu 安裝完成後，在 VirtualBox 虛擬機視窗上方選單找到：

```text
裝置（Devices）
└── 插入 Guest Additions CD 映像檔（Insert Guest Additions CD Image...）
```

若 Guest Additions 安裝過程需要編譯核心模組（kernel module），可先安裝：

```bash
sudo apt update
sudo apt install -y build-essential dkms linux-headers-$(uname -r)
```

再依 Guest Additions 安裝畫面進行安裝。

完成後重新啟動：

```bash
sudo reboot
```

> [!NOTE]
> Guest Additions 的畫面可能因 VirtualBox 版本略有不同。若目前 Ubuntu 顯示與操作皆正常，也可以先完成本章，其餘顯示整合問題再依課堂說明處理。

---

## 14. 最終完成檢查

完成本章後，至少確認以下項目：

- [ ] VirtualBox 可以正常啟動
- [ ] Ubuntu 22.04.5 已完成安裝
- [ ] Ubuntu 可以正常登入
- [ ] Ubuntu 可以連上網路
- [ ] 終端機（Terminal）可以正常開啟
- [ ] `lsb_release -a` 顯示 Ubuntu 22.04
- [ ] 實體電腦資源足夠時，虛擬機使用 10 vCPU / 16 GB 記憶體
- [ ] 虛擬硬碟大小為 60 GB

如果以上皆完成，代表第一階段的 Ubuntu 虛擬機環境已建立完成。

---

## 15. 常見問題

### Q1：VirtualBox 找不到 64 位元 Ubuntu？

先確認 CPU 硬體虛擬化是否已啟用。Windows 工作管理員的 CPU 頁面通常可以看到「虛擬化（Virtualization）」狀態。

### Q2：Ubuntu ISO 顯示成 Ubuntu 22.10，怎麼辦？

先確認下載的 ISO 檔名確實是：

```text
ubuntu-22.04.5-desktop-amd64.iso
```

接著在建立虛擬機時手動將「版本（Version）」選成 Ubuntu 22.04 LTS (Jammy Jellyfish) (64-bit)。

### Q3：虛擬機很慢？

先確認實體電腦仍有足夠的 CPU 與記憶體可供 Windows 主機使用，並確認虛擬機存放在 SSD。分配越多 CPU 或記憶體不一定越快；如果把主機資源用盡，反而可能讓整台電腦變慢。

### Q4：60 GB 會立刻占滿我的硬碟嗎？

如果建立 VDI 時沒有勾選「預先配置完整大小（Pre-allocate Full Size）」，虛擬硬碟會隨實際使用量逐漸成長，而不是建立時立刻占滿 60 GB。

---

## 下一步

完成 Ubuntu 22.04 環境後，下一階段將進行：

```text
Linux 終端機基礎
      ↓
Git
      ↓
下載課程 Repository
      ↓
ROS 2 Humble
```

請先不要自行安裝其他 ROS 2 發行版本（distribution），以免後續環境與課程教材不一致。

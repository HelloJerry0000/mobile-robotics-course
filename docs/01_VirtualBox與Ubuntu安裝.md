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

### 5.1 先確認 Windows 主機規格

不同學生的筆電硬體不同，因此本課程 **不使用同一組 CPU / RAM 設定套用所有電腦**。

在 Windows 按：

```text
Ctrl + Shift + Esc
```

開啟：

```text
工作管理員
└── 效能（Performance）
    ├── 記憶體（Memory）
    └── CPU → 邏輯處理器（Logical processors）
```

請依照下面的表格設定 VirtualBox。

### 5.2 CPU / RAM 建議配置

本課程後續會使用 **ROS 2、Gazebo Classic、RViz2、TurtleBot3、Nav2 / SLAM Toolbox、VS Code**，因此 VM 不只需要能開啟 Ubuntu，也要保留足夠資源執行模擬與開發工具。

| 實體電腦規格 | VirtualBox VM 建議 | 適用情況 |
| --- | --- | --- |
| 16 GB RAM、約 8 threads | **8 GB RAM + 4 vCPU** | 最低可用配置 |
| 16 GB RAM、12 threads 以上 | **8 GB RAM + 6 vCPU** | 一般課程使用 |
| 24 GB RAM、12 threads 以上 | **12 GB RAM + 6～8 vCPU** | **推薦配置** |
| 32 GB RAM、16 threads 以上 | **12～16 GB RAM + 8 vCPU** | Gazebo / RViz 較充裕 |
| 32 GB 以上、高階多核心 CPU | **16 GB RAM + 8～10 vCPU** | 高規格主機，可視需求增加 |

> [!IMPORTANT]
> **不要把 CPU 與 RAM 全部分配給虛擬機。** Windows 主機仍需要資源執行 VirtualBox、瀏覽器與其他程式。

> [!NOTE]
> vCPU 與 RAM 並不是越多越快。若工作負載用不到額外核心，過多 vCPU 不一定帶來效能提升。對 Gazebo / RViz 而言，VirtualBox 的 **3D acceleration 與顯示設定**也非常重要。

### 5.3 本課程建議怎麼選？

```text
16 GB 主機 → VM：8 GB RAM + 4～6 vCPU
24 GB 主機 → VM：12 GB RAM + 6～8 vCPU
32 GB 主機 → VM：12～16 GB RAM + 8 vCPU
```

若 VirtualBox 的資源配置指示進入紅色區域，請降低 vCPU 或 RAM。

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

再次依照第 5 節確認 CPU 與記憶體。一般建議：

```text
16 GB 主機 → 8 GB RAM + 4～6 vCPU
24 GB 主機 → 12 GB RAM + 6～8 vCPU
32 GB 主機 → 12～16 GB RAM + 8 vCPU
```

若 VirtualBox 顯示資源配置進入紅色區域，請降低設定。

### 7.2 顯示（Display）

後續課程會使用 Gazebo 與 RViz，請確認：

```text
Video Memory：128 MB
Graphics Controller：VMSVGA
Enable 3D Acceleration：開啟
```

顯示記憶體過低或 3D 加速未正常工作，可能造成 Ubuntu 桌面、RViz 或 Gazebo 明顯卡頓。

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

安裝完成並重新啟動後，如果需要 Windows 與 Ubuntu 互相複製文字，可在 VirtualBox 虛擬機視窗選擇：

```text
裝置（Devices）
└── 共用剪貼簿（Shared Clipboard）
    └── 雙向（Bidirectional）
```

若「共用剪貼簿」已設為雙向但仍無法複製貼上，通常要先確認 Guest Additions 是否正常安裝；請參考 [Ubuntu VirtualBox 常見問題排除指南](Ubuntu_VirtualBox常見問題排除指南.md)。

> [!NOTE]
> Guest Additions 的畫面可能因 VirtualBox 版本略有不同。

---

## 14. 最終完成檢查

完成本章後，至少確認以下項目：

- [ ] VirtualBox 可以正常啟動
- [ ] Ubuntu 22.04.5 已完成安裝
- [ ] Ubuntu 可以正常登入
- [ ] Ubuntu 可以連上網路
- [ ] 終端機（Terminal）可以正常開啟
- [ ] `lsb_release -a` 顯示 Ubuntu 22.04
- [ ] 已依照主機 RAM 與 CPU 邏輯處理器數量設定 VM 資源
- [ ] 虛擬硬碟大小為 60 GB

如果以上皆完成，代表第一階段的 Ubuntu 虛擬機環境已建立完成。

# 移動式機器人課程

本 Repository 為 **移動式機器人（Mobile Robotics）課程**之學生教材、環境建置說明與後續實作程式。

本課程以實作為主，後續將使用 ROS 2、Gazebo、RViz 與 TurtleBot3 進行移動機器人模擬、感知、定位、建圖與導航。

---

## 課程統一環境

為避免版本差異造成套件相容性問題，本課程統一使用：

| 項目 | 課程版本 / 設定 |
| --- | --- |
| Host 作業系統 | Windows 10 / 11 64-bit |
| 虛擬機軟體 | Oracle VirtualBox |
| Guest 作業系統 | Ubuntu 22.04.5 LTS Desktop 64-bit |
| ROS | ROS 2 Humble |
| 模擬器 | Gazebo Classic / Gazebo 11 |
| 視覺化 | RViz2 |
| 機器人平台 | TurtleBot3 |

> [!IMPORTANT]
> 請勿自行改用 Ubuntu 24.04、其他 Ubuntu 版本或其他 ROS 2 distribution。課程教材與程式皆以 **Ubuntu 22.04 + ROS 2 Humble** 為基準。

---

## 第一次上課：環境建置

第一次使用本課程教材時，請依照下列順序進行：

1. 安裝 Oracle VirtualBox
2. 下載 Ubuntu 22.04.5 LTS Desktop ISO
3. 建立 Ubuntu 虛擬機
4. 完成 Ubuntu 安裝與基本設定
5. 學習基本 Linux Terminal 操作
6. 安裝與使用 Git
7. 安裝 ROS 2 Humble
8. 完成環境檢查

### Step 1：VirtualBox 與 Ubuntu 22.04

請先閱讀：

➡️ **[VirtualBox 與 Ubuntu 22.04 安裝教學](docs/01_VirtualBox與Ubuntu安裝.md)**

---

## 建議電腦規格

後續課程會同時執行 Windows、Ubuntu 虛擬機、ROS 2、Gazebo 與 RViz，因此請確認電腦具備足夠資源。

| 項目 | 最低要求 | 建議 |
| --- | --- | --- |
| CPU | Intel Core i5 / AMD Ryzen 5 等級，至少 4 核心 | 6 核心以上 |
| RAM | 16 GB | 24–32 GB |
| 可用磁碟空間 | 60 GB 以上 | 80 GB 以上 |
| 儲存裝置 | SSD | NVMe SSD |
| GPU | 可正常支援 3D Hardware Acceleration | 近年 Intel/AMD 內顯或 NVIDIA/AMD 獨顯 |
| CPU Virtualization | Intel VT-x / AMD-V，必須啟用 | 同左 |

> [!WARNING]
> 8 GB RAM 不建議使用。電腦效能不足可能直接影響 Gazebo、RViz、課堂實作與作業完成。

---

## Repository 使用方式

本 Repository 為公開的學生教材，下載教材不需要 GitHub 帳號。

Ubuntu 安裝完成並安裝 Git 後，可以使用：

```bash
git clone https://github.com/HelloJerry0000/mobile-robotics-course.git
```

進入教材：

```bash
cd mobile-robotics-course
```

之後課程教材更新時，在 Repository 目錄執行：

```bash
git pull
```

即可取得最新版本。

> [!NOTE]
> 第一階段不需要先學習 branch、merge 或 pull request。請先熟悉 `git clone`、`git pull` 與基本 Repository 操作即可。

---

## 教材目錄

目前教材將依課程進度逐步開放。

```text
mobile-robotics-course/
├── README.md
├── docs/
│   └── 01_VirtualBox與Ubuntu安裝.md
├── assignments/          # 後續作業
├── scripts/              # 環境檢查與輔助工具
└── labs/                 # 後續 ROS 2 / Mobile Robotics 實作
```

後續內容預計包含：

- Linux 基礎操作
- Git 基礎
- ROS 2 Humble
- ROS 2 Node / Topic / Publisher / Subscriber
- TurtleBot3
- `/cmd_vel` 與 `/odom`
- LiDAR `/scan`
- TF
- RViz
- State Estimation
- SLAM
- Localization
- Navigation / Nav2

---

## 遇到問題時

請先：

1. 確認 Ubuntu 與 ROS 2 版本是否與課程一致。
2. 重新閱讀該步驟的注意事項。
3. 記錄完整錯誤訊息，不要只截最後一行。
4. 記錄自己執行過的指令。

提供問題時，建議一併附上：

```text
1. 問題發生在哪一個步驟
2. 執行的指令
3. 完整錯誤訊息
4. 錯誤畫面截圖
```

這會大幅加快問題排除速度。

---

> 本 Repository 將依照課程進度持續更新，請上課前確認是否有最新教材。
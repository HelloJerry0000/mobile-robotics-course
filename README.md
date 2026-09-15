# 移動式機器人課程

本 Repository 為 **移動式機器人（Mobile Robotics）課程**的學生教材、課堂練習與作業入口。

本課程以實作為主，後續將使用 ROS 2、Gazebo、RViz 與 TurtleBot3，逐步學習機器人控制、感知、狀態估測、SLAM、定位與導航。

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
> 請勿自行改用 Ubuntu 24.04、其他 Ubuntu 版本或其他 ROS 2 distribution。課程教材與程式以 **Ubuntu 22.04 + ROS 2 Humble** 為基準。

---

# Week 00

Week 00 是正式移動式機器人實作開始前的基礎週。

本週流程：

```text
環境確認
   ↓
Linux Terminal
   ↓
Git clone / git pull
   ↓
ROS 2 Node / Topic
   ↓
Talker / Listener
   ↓
Turtlesim
   ↓
HW00：Turtlesim Motion Control
```

### Week 00 課堂頁面

➡️ **[Week 00 — 環境、Linux、Git 與 ROS 2 基礎](weeks/week00_ros2_basics/README.md)**

### Week 00 作業

➡️ **[HW00 — Turtlesim Motion Control](assignments/hw00_turtlesim_control/README.md)**

---

## 第一次使用本 Repository

### 1. VirtualBox 與 Ubuntu

➡️ [01 — VirtualBox 與 Ubuntu 22.04 安裝](docs/01_VirtualBox與Ubuntu安裝.md)

### 2. Linux 與 Git

➡️ [02 — Linux 與 Git 基礎](docs/02_Linux與Git基礎.md)

### 3. ROS 2 基礎

➡️ [03 — ROS 2 基礎](docs/03_ROS2基礎.md)

---

## Repository 使用方式

本 Repository 為公開的學生教材，下載教材不需要 GitHub 帳號。

第一次下載：

```bash
cd ~
git clone https://github.com/HelloJerry0000/mobile-robotics-course.git
cd mobile-robotics-course
```

之後更新教材：

```bash
cd ~/mobile-robotics-course
git pull
```

查看 Repository 狀態：

```bash
git status
```

> [!NOTE]
> Week 00 暫時只需要熟悉 `git clone`、`git pull` 與 `git status`。不需要先學 branch、merge、rebase 或 pull request。

---

## 環境檢查

Clone 完成後，可以執行：

```bash
cd ~/mobile-robotics-course
bash scripts/environment_check.sh
```

檢查：

- Ubuntu 版本
- Git
- Python 3
- ROS 2 指令
- ROS distribution

---

## Repository 結構

```text
mobile-robotics-course/
│
├── README.md
│
├── docs/
│   ├── 01_VirtualBox與Ubuntu安裝.md
│   ├── 02_Linux與Git基礎.md
│   └── 03_ROS2基礎.md
│
├── weeks/
│   └── week00_ros2_basics/
│       ├── README.md
│       └── examples/
│
├── assignments/
│   └── hw00_turtlesim_control/
│       ├── README.md
│       └── starter/
│
└── scripts/
    └── environment_check.sh
```

資料夾用途：

| 資料夾 | 用途 |
| --- | --- |
| `docs/` | 知識與環境教材 |
| `weeks/` | 每週課堂流程與課堂範例 |
| `assignments/` | 作業說明與 starter code |
| `scripts/` | 環境檢查與課程輔助工具 |

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
> 8 GB RAM 不建議使用。電腦效能不足可能影響 Gazebo、RViz、課堂實作與作業完成。

---

## 後續課程方向

Week 00 完成後，課程將逐步進入：

```text
Turtlesim
   ↓
TurtleBot3 / cmd_vel / odom
   ↓
LiDAR / scan / TF / RViz
   ↓
State Estimation
   ↓
SLAM
   ↓
Localization
   ↓
Navigation / Nav2
```

---

## 遇到問題時

請先確認：

1. Ubuntu 與 ROS 2 版本是否與課程一致。
2. 是否依照教材順序操作。
3. 執行了哪些指令。
4. 完整錯誤訊息是什麼。

詢問問題時建議附上：

```text
1. 發生問題的步驟
2. 執行的指令
3. 完整錯誤訊息
4. 錯誤畫面截圖
```

這會讓問題更容易被重現與排除。

---

> 本 Repository 將依照課程進度持續更新。請在每次上課前執行 `git pull` 取得最新教材。

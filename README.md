# 移動式機器人課程

本 Repository 為 **移動式機器人（Mobile Robotics）課程**的學生教材與課堂實作入口。

本課程以實作為主，使用 ROS 2、Gazebo、RViz 與 TurtleBot3，逐步學習機器人控制、感知、狀態估測、SLAM、定位與導航。

---

## 課程統一環境

| 項目 | 課程版本 / 設定 |
| --- | --- |
| Host 作業系統 | Windows 10 / 11 64-bit |
| 虛擬機軟體 | Oracle VirtualBox |
| Guest 作業系統 | Ubuntu 22.04.5 LTS Desktop 64-bit |
| Terminal | Ubuntu Terminal + Terminator |
| ROS | ROS 2 Humble |
| 模擬器 | Gazebo Classic / Gazebo 11 |
| 視覺化 | RViz2 |
| 機器人平台 | TurtleBot3 Burger |
| SLAM | SLAM Toolbox |
| Navigation | Navigation2 / Nav2 |

> [!IMPORTANT]
> 請勿自行改用 Ubuntu 24.04 或其他 ROS 2 distribution。教材以 **Ubuntu 22.04 + ROS 2 Humble** 為基準。

---

# 最重要的資料夾規則

整學期固定使用三個位置：

```text
~/
├── mobile-robotics-course/     ← 課程教材，只 clone / pull
├── turtlebot3_ws/              ← TurtleBot3 第三方環境
└── mobile_robotics_ws/         ← 學生自己的 ROS 2 Workspace
```

### 1. `~/mobile-robotics-course`

這是課程發布的 Public GitHub Repository。學生使用：

```bash
git pull
```

更新教材。**不要在這個資料夾建立自己的 ROS package 或個人專案。**

### 2. `~/turtlebot3_ws`

由環境安裝教材建立，存放 TurtleBot3、TurtleBot3 Simulation 等第三方 source packages。原則上不要放自己的程式。

### 3. `~/mobile_robotics_ws`

這是學生整學期真正工作的 ROS 2 Workspace：

```text
~/mobile_robotics_ws/
├── src/        ← 自己建立的 ROS 2 packages
├── build/
├── install/
└── log/
```

自己的 ROS 2 package 統一放在 `~/mobile_robotics_ws/src/`。

---

# Week 00

```text
Ubuntu 22.04
   ↓
Linux Terminal / Terminator
   ↓
Git clone / git pull
   ↓
ROS 2 Humble
   ↓
Gazebo / TurtleBot3 / SLAM Toolbox / Nav2
   ↓
建立 mobile_robotics_ws
   ↓
環境檢查
   ↓
ROS 2 Node / Topic / Message
   ↓
Publisher / Subscriber
   ↓
Talker / Listener
```

➡️ **[Week 00 — 環境、Linux、Git 與 ROS 2 基礎](weeks/week00_ros2_basics/README.md)**

---

## 第一次使用

請依序完成：

1. [01 — VirtualBox 與 Ubuntu 22.04 安裝](docs/01_VirtualBox與Ubuntu安裝.md)
2. [02 — Linux 與 Git 基礎](docs/02_Linux與Git基礎.md)
3. [03 — ROS 2 Humble 課程環境安裝](docs/03_ROS2_Humble環境安裝.md)
4. [04 — ROS 2 基礎](docs/04_ROS2基礎.md)

---

## 下載與更新教材

第一次下載：

```bash
cd ~
git clone https://github.com/HelloJerry0000/mobile-robotics-course.git
cd ~/mobile-robotics-course
```

如果已經下載過，**不要再次 `git clone`**。直接：

```bash
cd ~/mobile-robotics-course
git pull
```

如果看到：

```text
fatal: destination path 'mobile-robotics-course' already exists and is not an empty directory.
```

通常代表你已經 clone 過，請進入原本資料夾執行 `git pull`。

Week 00 暫時只需要熟悉 `git clone`、`git pull` 與 `git status`。

---

## 環境檢查

完成第 03 章後：

```bash
cd ~/mobile-robotics-course
git pull
bash scripts/environment_check.sh
```

會檢查 Ubuntu、Git、Python、Terminator、ROS 2 Humble、RViz2、Gazebo、Turtlesim、TurtleBot3、SLAM Toolbox、Nav2、`turtlebot3_ws`、`mobile_robotics_ws` 與課程 Repository 狀態。

---

## Repository 結構

```text
mobile-robotics-course/
├── README.md
├── docs/
│   ├── 01_VirtualBox與Ubuntu安裝.md
│   ├── 02_Linux與Git基礎.md
│   ├── 03_ROS2_Humble環境安裝.md
│   └── 04_ROS2基礎.md
├── weeks/
│   └── week00_ros2_basics/
│       ├── README.md
│       └── examples/
└── scripts/
    └── environment_check.sh
```
---

## 建議電腦規格

| 項目 | 最低要求 | 建議 |
| --- | --- | --- |
| CPU | Intel Core i5 / AMD Ryzen 5 等級，至少 6 核心 | 8 核心以上 |
| RAM | 16 GB | 24–32 GB |
| 可用磁碟空間 | 60 GB 以上 | 80 GB 以上 |
| 儲存裝置 | SSD | NVMe SSD |
| GPU | 支援 3D Hardware Acceleration | 近年內顯或獨顯 |
| CPU Virtualization | Intel VT-x / AMD-V，必須啟用 | 同左 |

VirtualBox VM 建議：

```text
CPU:     6 vCPU（Host 資源充足可使用 8 vCPU）
Memory:  8 GB
Disk:    60 GB dynamic VDI
Network: NAT
Display: VMSVGA / 128 MB / 3D Acceleration ON
```

請不要把 Host 所有 CPU 執行緒都分配給虛擬機。

---

## 後續課程方向

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

詢問問題請附上：

```text
1. 發生問題的教材步驟
2. 執行的完整指令
3. 完整錯誤訊息
4. 錯誤畫面截圖
```

> 本 Repository 將依課程進度持續更新。請在每次上課前執行 `git pull` 取得最新教材。

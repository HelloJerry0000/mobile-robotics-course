# 03 — ROS 2 Humble 課程環境安裝

本章會把後續移動式機器人課程需要的軟體環境準備好。

本課程統一使用 **Ubuntu 22.04 + ROS 2 Humble**，並預先準備 Gazebo Classic、RViz2、TurtleBot3、Navigation2、SLAM Toolbox 與學生自己的 ROS 2 Workspace。

> [!IMPORTANT]
> 請不要自行改用 Ubuntu 24.04、ROS 2 Jazzy 或其他主要版本。

---

## 0. 先理解本課程的三個資料夾

完成本章後，Home 目錄會有三個用途完全不同的位置：

```text
~/
├── mobile-robotics-course/     ← 老師教材 Git Repository
├── turtlebot3_ws/              ← TurtleBot3 第三方套件 Workspace
└── mobile_robotics_ws/         ← 學生自己的 ROS 2 Workspace
```

請記住：

| 路徑 | 用途 | 學生平常是否修改 |
| --- | --- | --- |
| `~/mobile-robotics-course` | 老師發布教材 | 不修改，只 `git pull` |
| `~/turtlebot3_ws` | TurtleBot3 source 與 simulation | 原則上不修改 |
| `~/mobile_robotics_ws` | HW、Lab、自己的 ROS 2 package | **主要工作區** |

另外，ROS 2 Humble 本身安裝在：

```text
/opt/ros/humble/
```

最後形成：

```text
/opt/ros/humble
       ↓
~/turtlebot3_ws
       ↓
~/mobile_robotics_ws
```

這三層會依序 source。

---

## 1. 確認 Ubuntu 版本

開啟 Terminal：

```text
Ctrl + Alt + T
```

執行：

```bash
lsb_release -a
uname -m
```

本課程應為：

```text
Ubuntu 22.04 / Jammy
x86_64
```

若不是 Ubuntu 22.04，請先停止並回到第 01 章確認虛擬機版本。

---

## 2. 更新 Ubuntu

```bash
sudo apt update
sudo apt upgrade -y
sudo reboot
```

重新登入後再繼續。

---

## 3. 安裝基本工具與 Terminator

```bash
sudo apt update
sudo apt install -y \
  git curl wget gnupg lsb-release software-properties-common \
  build-essential python3-pip python3-venv \
  tree htop terminator
```

本課程建議使用 **Terminator**，因為 ROS 2 常需要同時開啟多個 Terminal 執行不同 Node。

啟動：

```bash
terminator
```

> [!NOTE]
> Terminator 是方便操作的 Terminal 工具，不是 ROS 2 必要套件。Ubuntu 內建 Terminal 仍可正常使用。

確認：

```bash
git --version
python3 --version
terminator --version
```

---

## 4. 設定 UTF-8 Locale

```bash
sudo apt update
sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale
```

---

## 5. 啟用 Ubuntu Universe Repository

```bash
sudo add-apt-repository -y universe
sudo apt update
```

---

## 6. 加入 ROS 2 APT Repository

下載 repository key：

```bash
sudo curl -sSL \
  https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  -o /usr/share/keyrings/ros-archive-keyring.gpg
```

加入 ROS 2 repository：

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
  | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
```

---

## 7. 安裝 ROS 2 Humble Desktop 與開發工具

```bash
sudo apt install -y ros-humble-desktop
sudo apt install -y ros-dev-tools
sudo apt install -y \
  python3-colcon-common-extensions \
  python3-rosdep \
  python3-vcstool
```

Desktop 版本包含後續會使用的 ROS 2 CLI、RViz2 與 demo nodes。

---

## 8. 載入 ROS 2 環境

目前 Terminal：

```bash
source /opt/ros/humble/setup.bash
printenv ROS_DISTRO
```

應輸出：

```text
humble
```

加入 `~/.bashrc`：

```bash
grep -qxF 'source /opt/ros/humble/setup.bash' ~/.bashrc || \
  echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
```

> `source` 可以理解成「把環境設定載入目前 Terminal」。後面建立的 workspace 也需要 source。

---

## 9. 初始化 rosdep

第一次使用：

```bash
sudo rosdep init
rosdep update
```

若 `sudo rosdep init` 顯示 sources list 已存在，通常代表之前初始化過，可直接：

```bash
rosdep update
```

---

## 10. ROS 2 基本測試

```bash
ros2 --help
printenv ROS_DISTRO
which rviz2
```

Talker：

```bash
ros2 run demo_nodes_cpp talker
```

另一個 Terminal 執行 Listener：

```bash
ros2 run demo_nodes_py listener
```

能持續收到訊息即代表基本 ROS 2 通訊正常。使用 `Ctrl + C` 停止。

---

# 課程共用套件

## 11. 安裝 Gazebo Classic / Gazebo 11

```bash
sudo apt update
sudo apt install -y 'ros-humble-gazebo-*'
```

確認：

```bash
gazebo --version
```

Ubuntu 22.04 + ROS 2 Humble 的課程環境使用 Gazebo 11 系列。

---

## 12. 安裝 Turtlesim

HW00 會使用 Turtlesim：

```bash
sudo apt install -y ros-humble-turtlesim
```

只確認套件存在：

```bash
ros2 pkg list | grep turtlesim
```

這一章不提供 HW00 的控制方法。

---

## 13. 安裝 Navigation2 / Nav2

```bash
sudo apt install -y \
  ros-humble-navigation2 \
  ros-humble-nav2-bringup
```

確認：

```bash
ros2 pkg list | grep nav2_bringup
```

---

## 14. 安裝 SLAM Toolbox

```bash
sudo apt install -y ros-humble-slam-toolbox
```

確認：

```bash
ros2 pkg list | grep slam_toolbox
```

本課程 Mapping / SLAM 主線使用 SLAM Toolbox，因此 Week 00 不要求額外安裝 Cartographer。

---

# TurtleBot3 第三方環境

## 15. 建立 TurtleBot3 Workspace

TurtleBot3 不放進老師教材，也不和學生作業混在一起。本課程使用獨立 workspace：

```text
~/turtlebot3_ws
```

建立：

```bash
mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src
```

---

## 16. 下載 TurtleBot3 核心套件

```bash
git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git
```

確認：

```bash
ls ~/turtlebot3_ws/src
```

應至少看到：

```text
DynamixelSDK
turtlebot3
turtlebot3_msgs
```

---

## 17. 安裝 TurtleBot3 相依套件

```bash
cd ~/turtlebot3_ws
rosdep install --from-paths src --ignore-src -r -y
```

---

## 18. Build TurtleBot3 Workspace

```bash
cd ~/turtlebot3_ws
colcon build --symlink-install
```

成功後會出現：

```text
build/
install/
log/
src/
```

載入：

```bash
source ~/turtlebot3_ws/install/setup.bash
```

確認：

```bash
ros2 pkg list | grep turtlebot3
```

---

## 19. 安裝 TurtleBot3 Simulation

```bash
cd ~/turtlebot3_ws/src
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

cd ~/turtlebot3_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build --symlink-install
source ~/turtlebot3_ws/install/setup.bash
```

確認：

```bash
ros2 pkg list | grep turtlebot3_gazebo
```

應看到：

```text
turtlebot3_gazebo
```

---

## 20. 設定 TurtleBot3 環境

加入 `~/.bashrc`：

```bash
grep -qxF 'source ~/turtlebot3_ws/install/setup.bash' ~/.bashrc || \
  echo 'source ~/turtlebot3_ws/install/setup.bash' >> ~/.bashrc

grep -qxF 'export TURTLEBOT3_MODEL=burger' ~/.bashrc || \
  echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
```

> [!IMPORTANT]
> **只有在 `~/turtlebot3_ws/install/setup.bash` 已經存在後，才把這行加入 `.bashrc`。**
> 如果 workspace 尚未 build，就直接 source 這個檔案，會出現「沒有此一檔案或目錄」。

---

# 學生自己的 ROS 2 Workspace

## 21. 建立整學期唯一的學生 Workspace

學生的 HW、Lab 與自己撰寫的 ROS 2 package 統一放在：

```text
~/mobile_robotics_ws
```

建立：

```bash
mkdir -p ~/mobile_robotics_ws/src
cd ~/mobile_robotics_ws
```

第一次即使 `src/` 還是空的，也先建立 workspace：

```bash
colcon build --symlink-install
```

成功後：

```text
~/mobile_robotics_ws/
├── src/        ← 學生自己的 package 放這裡
├── build/
├── install/
└── log/
```

> [!IMPORTANT]
> 不要把 HW 或 Lab 寫在 `~/mobile-robotics-course`，也不要把自己的作業放進 `~/turtlebot3_ws/src`。

---

## 22. 設定學生 Workspace 自動載入

確認 setup file 已存在：

```bash
ls ~/mobile_robotics_ws/install/setup.bash
```

再加入 `.bashrc`：

```bash
grep -qxF 'source ~/mobile_robotics_ws/install/setup.bash' ~/.bashrc || \
  echo 'source ~/mobile_robotics_ws/install/setup.bash' >> ~/.bashrc
```

重新載入：

```bash
source ~/.bashrc
```

本課程希望 `.bashrc` 的 source 順序是：

```bash
source /opt/ros/humble/setup.bash
source ~/turtlebot3_ws/install/setup.bash
source ~/mobile_robotics_ws/install/setup.bash
export TURTLEBOT3_MODEL=burger
```

也就是：

```text
ROS 2 Humble 系統環境
        ↓
TurtleBot3 第三方環境
        ↓
學生自己的課程 Workspace
```

這樣學生自己的 package 可以使用 ROS 2 與 TurtleBot3 套件。

---

## 23. 啟動 TurtleBot3 Simulation 測試

開一個新的 Terminator / Terminal，確認：

```bash
printenv ROS_DISTRO
echo $TURTLEBOT3_MODEL
```

應分別看到：

```text
humble
burger
```

啟動：

```bash
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
```

第一次啟動 Gazebo 可能需要一些時間。完成確認後用 `Ctrl + C` 停止。

---

## 24. 課程環境完整檢查

```bash
cd ~/mobile-robotics-course
git pull
bash scripts/environment_check.sh
```

---

## 25. 完成後的完整目錄

學生 Home 應大致長這樣：

```text
~/
├── mobile-robotics-course/          ← 老師教材
│   ├── README.md
│   ├── docs/
│   ├── weeks/
│   └── scripts/
│
├── turtlebot3_ws/                   ← 第三方 TurtleBot3
│   ├── src/
│   │   ├── DynamixelSDK/
│   │   ├── turtlebot3_msgs/
│   │   ├── turtlebot3/
│   │   └── turtlebot3_simulations/
│   ├── build/
│   ├── install/
│   └── log/
│
└── mobile_robotics_ws/              ← 學生自己的 ROS 2 程式
    ├── src/
    │   ├── hw00_turtlesim/          ← 之後由學生建立
    │   ├── lab01_motion/            ← 之後課程使用
    │   └── ...
    ├── build/
    ├── install/
    └── log/
```

---

## 26. 手動檢查清單

- [ ] Ubuntu 22.04
- [ ] Terminator
- [ ] ROS 2 Humble
- [ ] RViz2
- [ ] Gazebo Classic / Gazebo 11
- [ ] Turtlesim
- [ ] `colcon`
- [ ] `rosdep`
- [ ] `~/turtlebot3_ws`
- [ ] TurtleBot3 core packages
- [ ] `turtlebot3_gazebo`
- [ ] SLAM Toolbox
- [ ] Navigation2 / Nav2
- [ ] `~/mobile_robotics_ws`
- [ ] `TURTLEBOT3_MODEL=burger`

快速確認：

```bash
terminator --version
printenv ROS_DISTRO
gazebo --version
which rviz2
ros2 pkg list | grep turtlesim
ros2 pkg list | grep turtlebot3_gazebo
ros2 pkg list | grep slam_toolbox
ros2 pkg list | grep nav2_bringup
echo $TURTLEBOT3_MODEL
ls ~/turtlebot3_ws/install/setup.bash
ls ~/mobile_robotics_ws/install/setup.bash
```

---

## 27. 常見問題

### Q1：`ros2: command not found`

```bash
source /opt/ros/humble/setup.bash
```

### Q2：`source ~/turtlebot3_ws/install/setup.bash` 顯示檔案不存在

代表 TurtleBot3 workspace 尚未成功 build，或路徑建立錯誤。先確認：

```bash
ls ~/turtlebot3_ws
```

再重新：

```bash
cd ~/turtlebot3_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build --symlink-install
```

成功後才執行：

```bash
source ~/turtlebot3_ws/install/setup.bash
```

### Q3：找不到 TurtleBot3 package

```bash
source /opt/ros/humble/setup.bash
source ~/turtlebot3_ws/install/setup.bash
ros2 pkg list | grep turtlebot3
```

### Q4：`mobile_robotics_ws` setup 不存在

先 build：

```bash
cd ~/mobile_robotics_ws
colcon build --symlink-install
```

再：

```bash
source ~/mobile_robotics_ws/install/setup.bash
```

### Q5：Gazebo 黑畫面或無法啟動

VirtualBox 請確認：

```text
Graphics Controller = VMSVGA
Video Memory = 128 MB
Enable 3D Acceleration = ON
```

並確認 Guest Additions 已安裝。

---

## 28. 為什麼不用一鍵安裝 Script？

本課程刻意讓學生親自使用：

```text
apt      → 安裝系統 / ROS 套件
source   → 載入 ROS 環境
rosdep   → 安裝 ROS package dependency
colcon   → build ROS 2 workspace
git      → 下載與更新程式碼
```

這些都是後續 ROS 2 開發會反覆使用的工具。

---

## 官方參考資料

- ROS 2 Humble — Ubuntu Debian package installation：<https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html>
- TurtleBot3 Quick Start：<https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/>
- TurtleBot3 Simulation：<https://emanual.robotis.com/docs/en/platform/turtlebot3/simulation/>
- Navigation2：<https://docs.nav2.org/>
- SLAM Toolbox：<https://docs.ros.org/en/humble/p/slam_toolbox/>

---

## 下一步

環境全部完成後，進入：

➡️ [04 — ROS 2 基礎](04_ROS2基礎.md)

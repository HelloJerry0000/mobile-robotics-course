# 03 — ROS 2 Humble 課程環境安裝

本章會把後續移動式機器人課程需要的軟體環境準備好。

本課程統一使用 **Ubuntu 22.04 + ROS 2 Humble**，並預先準備 Terminator、Gazebo Classic、RViz2、TurtleBot3、Navigation2、SLAM Toolbox 與學生自己的 ROS 2 Workspace。

> [!IMPORTANT]
> 請不要自行改用 Ubuntu 24.04、ROS 2 Jazzy 或其他主要版本。

---

## 0. 先理解本課程的三個資料夾

```text
~/
├── mobile-robotics-course/     ← 老師教材 Git Repository
├── turtlebot3_ws/              ← TurtleBot3 第三方套件 Workspace
└── mobile_robotics_ws/         ← 學生自己的 ROS 2 Workspace
```

| 路徑 | 用途 | 學生平常是否修改 |
| --- | --- | --- |
| `~/mobile-robotics-course` | 老師發布教材 | 不修改，只 `git pull` |
| `~/turtlebot3_ws` | TurtleBot3 source 與 simulation | 原則上不修改 |
| `~/mobile_robotics_ws` | HW、Lab、自己的 ROS 2 package | **主要工作區** |

ROS 2 Humble 本身安裝在 `/opt/ros/humble/`，最後形成：

```text
/opt/ros/humble
       ↓
~/turtlebot3_ws
       ↓
~/mobile_robototics_ws
```

---

## 1. 確認 Ubuntu 版本

```bash
lsb_release -a
uname -m
```

本課程應為 Ubuntu 22.04 / Jammy、`x86_64`。

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

ROS 2 常需要同時開啟多個 Terminal，因此本課程建議使用 **Terminator**。

```bash
terminator
```

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
sudo apt install -y software-properties-common
sudo add-apt-repository -y universe
```

---

## 6. 設定 ROS 2 APT Repository

目前 ROS 2 官方建議使用 **`ros2-apt-source` package** 管理 repository 與 signing key。本課程不再手動建立 `/etc/apt/sources.list.d/ros2.list`。

> [!IMPORTANT]
> 不要另外照舊教學手動建立 `ros2.list`。如果同時存在 `ros2.sources` 與另一份指向相同 ROS repository、但使用不同 `Signed-By` 的設定，`apt` 可能出現 `Conflicting values set for option Signed-By`。

### 6.1 先檢查是否已經有 ROS 2 repository

```bash
ls -l /etc/apt/sources.list.d/ros2.sources 2>/dev/null || true
dpkg -l | grep ros2-apt-source || true
```

如果已經看到 `ros2.sources`，而且 `ros2-apt-source` 已安裝，**不要再建立第二份 ROS repository**，直接進到第 6.3 節。

### 6.2 尚未安裝時，使用官方 ros2-apt-source

```bash
sudo apt update
sudo apt install -y curl

export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')

curl -L -o /tmp/ros2-apt-source.deb \
  "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"

sudo dpkg -i /tmp/ros2-apt-source.deb
```

### 6.3 確認 repository 後更新 APT

```bash
ls -l /etc/apt/sources.list.d/ros2.sources
sudo apt update
```

如果 `sudo apt update` 出現 `Signed-By` conflict，**先不要繼續安裝**。檢查重複來源：

```bash
grep -Rni "packages.ros.org/ros2/ubuntu" \
  /etc/apt/sources.list \
  /etc/apt/sources.list.d/ 2>/dev/null
```

若你曾依舊版教材建立 `/etc/apt/sources.list.d/ros2.list`，而系統同時已有由 `ros2-apt-source` 管理的 `ros2.sources`，請先向教師 / TA 確認後再移除舊的重複設定。

---

## 7. 安裝 ROS 2 Humble Desktop、Demo Nodes 與開發工具

```bash
sudo apt update
sudo apt install -y \
  ros-humble-desktop \
  ros-humble-demo-nodes-cpp \
  ros-humble-demo-nodes-py \
  ros-dev-tools \
  python3-colcon-common-extensions \
  python3-rosdep \
  python3-vcstool
```

本課程**明確安裝** `demo_nodes_cpp` 與 `demo_nodes_py`，因為 Week 00 會使用 C++ Talker 與 Python Listener 測試 ROS 2 Publisher / Subscriber 通訊。

確認：

```bash
ros2 pkg list 2>/dev/null | grep demo_nodes || true
dpkg -l | grep ros-humble-demo-nodes
```

---

## 8. 載入 ROS 2 環境

```bash
source /opt/ros/humble/setup.bash
printenv ROS_DISTRO
```

應輸出 `humble`。

加入 `~/.bashrc`：

```bash
grep -qxF 'source /opt/ros/humble/setup.bash' ~/.bashrc || \
  echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
```

---

## 9. 初始化 rosdep

```bash
sudo rosdep init
rosdep update
```

若顯示 sources list 已存在，通常代表之前初始化過，可直接執行 `rosdep update`。

---

## 10. ROS 2 基本測試

先確認兩個 demo package 都存在：

```bash
ros2 pkg list | grep demo_nodes
```

應至少看到：

```text
demo_nodes_cpp
demo_nodes_py
```

Terminator / Terminal 1：

```bash
ros2 run demo_nodes_cpp talker
```

Terminator / Terminal 2：

```bash
ros2 run demo_nodes_py listener
```

Listener 能持續收到 Talker 訊息，即代表 ROS 2 C++ / Python 基本通訊正常。使用 `Ctrl + C` 停止。

### 如果出現 `Package 'demo_nodes_py' not found`

先確認：

```bash
printenv ROS_DISTRO
ros2 pkg list | grep demo_nodes
dpkg -l | grep ros-humble-demo-nodes
```

若只有 `demo_nodes_cpp`，補安裝：

```bash
sudo apt update
sudo apt install -y ros-humble-demo-nodes-py
source /opt/ros/humble/setup.bash
```

---

# 課程共用套件

## 11. 安裝 Gazebo Classic / Gazebo 11

```bash
sudo apt update
sudo apt install -y 'ros-humble-gazebo-*'
gazebo --version
```

本課程使用 **Gazebo Classic / Gazebo 11**。安裝完成後，除了 ROS 2 環境，也要載入 Gazebo Classic 自己的環境設定：

```bash
source /opt/ros/humble/setup.bash
source /usr/share/gazebo/setup.bash
```

確認 Gazebo setup 檔存在：

```bash
ls -l /usr/share/gazebo/setup.bash
gazebo --version
```

將 Gazebo 環境加入 `~/.bashrc`，避免開新 Terminal 時遺漏：

```bash
grep -qxF 'source /usr/share/gazebo/setup.bash' ~/.bashrc || \
  echo 'source /usr/share/gazebo/setup.bash' >> ~/.bashrc
```

> [!NOTE]
> Gazebo Classic 啟動時可能顯示 End-of-Life 提示，這是版本生命週期通知，不代表啟動失敗。

---

## 12. 安裝 Turtlesim

```bash
sudo apt install -y ros-humble-turtlesim
ros2 pkg list | grep turtlesim
```

這一章只確認 package 存在，不提供 HW00 的控制方法。

---

## 13. 安裝 Navigation2 / Nav2

```bash
sudo apt install -y \
  ros-humble-navigation2 \
  ros-humble-nav2-bringup

ros2 pkg list | grep nav2_bringup
```

---

## 14. 安裝 SLAM Toolbox

```bash
sudo apt install -y ros-humble-slam-toolbox
ros2 pkg list | grep slam_toolbox
```

本課程 Mapping / SLAM 主線使用 SLAM Toolbox。

---

# TurtleBot3 第三方環境

## 15. 建立 TurtleBot3 Workspace

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

成功後才載入：

```bash
source ~/turtlebot3_ws/install/setup.bash
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

---

## 20. 設定 TurtleBot3 環境

**確認 workspace 已 build 成功後**才加入 `.bashrc`：

```bash
grep -qxF 'source ~/turtlebot3_ws/install/setup.bash' ~/.bashrc || \
  echo 'source ~/turtlebot3_ws/install/setup.bash' >> ~/.bashrc

grep -qxF 'export TURTLEBOT3_MODEL=burger' ~/.bashrc || \
  echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
```

---

# 學生自己的 ROS 2 Workspace

## 21. 建立整學期唯一的學生 Workspace

```bash
mkdir -p ~/mobile_robotics_ws/src
cd ~/mobile_robotics_ws
colcon build --symlink-install
```

```text
~/mobile_robotics_ws/
├── src/        ← HW / Lab / 自己的 ROS package
├── build/
├── install/
└── log/
```

> [!IMPORTANT]
> 不要把 HW 或 Lab 寫在 `~/mobile-robotics-course`，也不要放進 `~/turtlebot3_ws/src`。

---

## 22. 設定學生 Workspace 自動載入

確認：

```bash
ls ~/mobile_robotics_ws/install/setup.bash
```

再加入 `.bashrc`：

```bash
grep -qxF 'source ~/mobile_robotics_ws/install/setup.bash' ~/.bashrc || \
  echo 'source ~/mobile_robotics_ws/install/setup.bash' >> ~/.bashrc
source ~/.bashrc
```

最終 source 順序：

```bash
source /opt/ros/humble/setup.bash
source /usr/share/gazebo/setup.bash
source ~/turtlebot3_ws/install/setup.bash
source ~/mobile_robotics_ws/install/setup.bash
export TURTLEBOT3_MODEL=burger
```

---

## 23. 啟動 TurtleBot3 Simulation 測試

先確認目前 Terminal 已載入完整課程環境：

```bash
source /opt/ros/humble/setup.bash
source /usr/share/gazebo/setup.bash
source ~/turtlebot3_ws/install/setup.bash
source ~/mobile_robotics_ws/install/setup.bash
export TURTLEBOT3_MODEL=burger
```

再啟動：

```bash
printenv ROS_DISTRO
echo $TURTLEBOT3_MODEL
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
```

完成後用 `Ctrl + C` 停止。

---

## 24. 課程環境完整檢查

```bash
cd ~/mobile-robotics-course
git pull
bash scripts/environment_check.sh
```

---

## 25. 完成後的完整目錄

```text
~/
├── turtlebot3_ws/                   ← 第三方 TurtleBot3
│   ├── src/
│   │   ├── DynamixelSDK/
│   │   ├── turtlebot3_msgs/
│   │   ├── turtlebot3/
│   │   └── turtlebot3_simulations/
│   ├── build/
│   ├── install/
│   └── log/
└── mobile_robotics_ws/              ← 學生自己的 ROS 2 程式
    ├── src/
    ├── build/
    ├── install/
    └── log/
```

---

## 26. 手動檢查清單

- [ ] Ubuntu 22.04
- [ ] Terminator
- [ ] ROS 2 Humble
- [ ] `demo_nodes_cpp`
- [ ] `demo_nodes_py`
- [ ] RViz2
- [ ] Gazebo Classic / Gazebo 11
- [ ] `/usr/share/gazebo/setup.bash` 已載入
- [ ] Turtlesim
- [ ] `colcon` / `rosdep`
- [ ] `~/turtlebot3_ws`
- [ ] `turtlebot3_gazebo`
- [ ] SLAM Toolbox
- [ ] Navigation2 / Nav2
- [ ] `~/mobile_robotics_ws`
- [ ] `TURTLEBOT3_MODEL=burger`

---

## 27. 常見問題

### Q1：`ros2: command not found`

```bash
source /opt/ros/humble/setup.bash
```

### Q2：APT 顯示 `Conflicting values set for option Signed-By`

代表 ROS 2 repository 很可能被設定了兩次。先檢查：

```bash
grep -Rni "packages.ros.org/ros2/ubuntu" \
  /etc/apt/sources.list \
  /etc/apt/sources.list.d/ 2>/dev/null
```

如果同時看到 `ros2.sources` 與手動建立的 `ros2.list`，請不要再新增 repository；先向教師 / TA 確認哪一份是舊設定。

### Q3：`Package 'demo_nodes_py' not found`

```bash
sudo apt update
sudo apt install -y ros-humble-demo-nodes-py
source /opt/ros/humble/setup.bash
```

### Q4：`source ~/turtlebot3_ws/install/setup.bash` 顯示檔案不存在

先完成 TurtleBot3 workspace 的 `rosdep` 與 `colcon build`，成功後才 source。

### Q5：`mobile_robotics_ws` setup 不存在

```bash
cd ~/mobile_robotics_ws
colcon build --symlink-install
```

### Q6：Gazebo 出現 `Unable to find shader lib` / `GAZEBO_RESOURCE_PATH` 提示

先確認 Gazebo Classic setup 存在並載入：

```bash
source /opt/ros/humble/setup.bash
source /usr/share/gazebo/setup.bash
source ~/turtlebot3_ws/install/setup.bash
export TURTLEBOT3_MODEL=burger
```

再重新啟動 TurtleBot3：

```bash
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
```

如果這樣可以正常啟動，請確認 `~/.bashrc` 已包含：

```bash
source /usr/share/gazebo/setup.bash
```

### Q7：Gazebo 黑畫面或 GUI 無法正常顯示

VirtualBox 請確認：VMSVGA、128 MB Video Memory、3D Acceleration ON，並確認 Guest Additions 已安裝。

---

## 28. 為什麼不用一鍵安裝 Script？

本課程刻意讓學生親自使用：

```text
apt      → 安裝系統 / ROS 套件
source   → 載入 ROS / Gazebo / Workspace 環境
rosdep   → 安裝 ROS package dependency
colcon   → build ROS 2 workspace
git      → 下載與更新程式碼
```

---

## 官方參考資料

- ROS 2 Humble — Ubuntu Debian package installation：<https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html>
- ROS apt source：<https://github.com/ros-infrastructure/ros-apt-source>
- TurtleBot3 Quick Start：<https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/>
- TurtleBot3 Simulation：<https://emanual.robotis.com/docs/en/platform/turtlebot3/simulation/>
- Navigation2：<https://docs.nav2.org/>
- SLAM Toolbox：<https://docs.ros.org/en/humble/p/slam_toolbox/>

---

## 下一步

環境全部完成後，進入：

➡️ [04 — ROS 2 基礎](04_ROS2基礎.md)
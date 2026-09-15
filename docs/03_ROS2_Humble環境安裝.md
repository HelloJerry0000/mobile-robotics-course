# 03 — ROS 2 Humble 課程環境安裝

本章會把後續移動式機器人課程需要的軟體環境一次準備好。

本課程不是只安裝 ROS 2 本體，還會預先準備後續實驗會使用到的 Gazebo、RViz2、TurtleBot3、Navigation2 與 SLAM Toolbox。

> [!IMPORTANT]
> 本課程統一使用 **Ubuntu 22.04 + ROS 2 Humble**。請不要自行改用 Ubuntu 24.04、ROS 2 Jazzy 或其他主要版本。

---

## 0. 本章完成後會有什麼？

完成本章後，電腦應具備：

```text
Ubuntu 22.04
    ↓
ROS 2 Humble Desktop
    ├── ROS 2 CLI
    ├── RViz2
    ├── demo_nodes_cpp / demo_nodes_py
    └── 開發工具
    ↓
Gazebo Classic / Gazebo 11
    ↓
TurtleBot3
    ├── turtlebot3
    ├── turtlebot3_msgs
    └── turtlebot3_simulations
    ↓
SLAM Toolbox
    ↓
Navigation2 / Nav2
```

本課程後續會依序使用這些環境進行：

```text
Robot Motion
   ↓
Perception / TF
   ↓
State Estimation
   ↓
SLAM / Mapping
   ↓
Localization / Navigation
```

---

## 1. 先確認 Ubuntu 版本

開啟 Terminal：

```text
Ctrl + Alt + T
```

執行：

```bash
lsb_release -a
```

應確認：

```text
Ubuntu 22.04
Jammy
```

再確認系統架構：

```bash
uname -m
```

一般 Intel / AMD 64-bit 電腦應看到：

```text
x86_64
```

> [!WARNING]
> 如果不是 Ubuntu 22.04，請先停止後續步驟並確認前一章的虛擬機版本。

---

## 2. 先把 Ubuntu 更新到最新狀態

在安裝 ROS 2 Humble 前，先更新 Ubuntu 套件。

```bash
sudo apt update
sudo apt upgrade -y
```

更新完成後建議重新啟動：

```bash
sudo reboot
```

重新登入 Ubuntu 後再繼續。

> [!IMPORTANT]
> Ubuntu 22.04 在安裝 ROS 2 前先完成系統更新非常重要。不要跳過這一步。

---

## 3. 安裝基本工具

先安裝本課程與 ROS 2 安裝流程會使用到的工具：

```bash
sudo apt update
sudo apt install -y \
  git \
  curl \
  wget \
  gnupg \
  lsb-release \
  software-properties-common \
  build-essential \
  python3-pip \
  python3-venv \
  tree \
  htop
```

完成後可確認：

```bash
git --version
python3 --version
curl --version
```

---

## 4. 設定 UTF-8 Locale

ROS 2 建議系統使用 UTF-8 locale。

先查看目前設定：

```bash
locale
```

接著執行：

```bash
sudo apt update
sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
```

再確認：

```bash
locale
```

輸出中應可以看到 UTF-8 相關設定。

---

## 5. 啟用 Ubuntu Universe Repository

執行：

```bash
sudo add-apt-repository -y universe
sudo apt update
```

這會啟用 ROS 2 依賴套件常使用的 Ubuntu Universe repository。

---

## 6. 加入 ROS 2 APT Repository

先下載 ROS 2 repository 使用的 key：

```bash
sudo curl -sSL \
  https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  -o /usr/share/keyrings/ros-archive-keyring.gpg
```

接著加入 ROS 2 repository：

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
  | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

更新套件清單：

```bash
sudo apt update
```

---

## 7. 安裝 ROS 2 Humble Desktop

本課程使用 Desktop 版本，因為後續會使用 RViz2、ROS 2 demos 與圖形化工具。

```bash
sudo apt install -y ros-humble-desktop
```

再安裝 ROS 2 開發工具：

```bash
sudo apt install -y ros-dev-tools
```

為了後續建立 workspace，再確認以下工具存在：

```bash
sudo apt install -y \
  python3-colcon-common-extensions \
  python3-rosdep \
  python3-vcstool
```

---

## 8. 載入 ROS 2 環境

ROS 2 安裝完成後，先在目前 Terminal 執行：

```bash
source /opt/ros/humble/setup.bash
```

確認：

```bash
printenv ROS_DISTRO
```

應輸出：

```text
humble
```

### 讓每個 Terminal 自動載入 ROS 2

執行：

```bash
grep -qxF 'source /opt/ros/humble/setup.bash' ~/.bashrc || \
  echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
```

重新載入：

```bash
source ~/.bashrc
```

之後每次開新的 Terminal，就不需要再次手動輸入 `source /opt/ros/humble/setup.bash`。

> [!NOTE]
> `source` 可以理解成「把另一個設定檔載入目前的 Terminal 環境」。如果沒有正確 source，系統可能找不到 `ros2` 指令或 ROS 2 package。

---

## 9. 初始化 rosdep

`rosdep` 之後會用來根據 ROS package 的設定自動安裝相依套件。

第一次使用時執行：

```bash
sudo rosdep init
rosdep update
```

如果 `sudo rosdep init` 顯示已經初始化過，例如：

```text
ERROR: default sources list file already exists
```

通常代表之前已經完成初始化，可以直接執行：

```bash
rosdep update
```

---

## 10. 確認 ROS 2 基本安裝

確認 `ros2` 指令：

```bash
ros2 --help
```

確認 ROS distribution：

```bash
printenv ROS_DISTRO
```

確認 RViz2：

```bash
which rviz2
```

應該能看到類似：

```text
/opt/ros/humble/bin/rviz2
```

### Talker / Listener 快速測試

Terminal 1：

```bash
ros2 run demo_nodes_cpp talker
```

Terminal 2：

```bash
ros2 run demo_nodes_py listener
```

如果 Listener 能持續收到 Talker 的訊息，代表 ROS 2 基本通訊正常。

使用：

```text
Ctrl + C
```

停止兩個程式。

---

# 課程套件安裝

接下來安裝的內容不是 ROS 2 核心本身，而是本課程後續 Lab 會使用到的環境。

---

## 11. 安裝 Gazebo Classic / Gazebo 11 ROS 套件

本課程使用 ROS 2 Humble 搭配 Gazebo Classic。

執行：

```bash
sudo apt update
sudo apt install -y 'ros-humble-gazebo-*'
```

確認 Gazebo：

```bash
gazebo --version
```

Ubuntu 22.04 + ROS 2 Humble 的課程環境應使用 Gazebo 11 系列。

> [!NOTE]
> 後續若 Gazebo 在 VirtualBox 中出現黑畫面或顯示異常，請先回到 VirtualBox 設定確認：VMSVGA、128 MB Video Memory、3D Acceleration ON。

---

## 12. 安裝 HW00 使用的 Turtlesim

為了確保所有同學都有相同環境，另外明確安裝：

```bash
sudo apt install -y ros-humble-turtlesim
```

這裡只確認 package 已經存在，先不要研究作業解法。

確認：

```bash
ros2 pkg list | grep turtlesim
```

應看到：

```text
turtlesim
```

---

## 13. 安裝 Navigation2

後續 Navigation Lab 會使用 Nav2。

```bash
sudo apt install -y \
  ros-humble-navigation2 \
  ros-humble-nav2-bringup
```

確認：

```bash
ros2 pkg list | grep nav2_bringup
```

應看到：

```text
nav2_bringup
```

---

## 14. 安裝 SLAM Toolbox

本課程的 Mapping / SLAM Lab 主要使用 **SLAM Toolbox**。

```bash
sudo apt install -y ros-humble-slam-toolbox
```

確認：

```bash
ros2 pkg list | grep slam_toolbox
```

應看到：

```text
slam_toolbox
```

> [!NOTE]
> TurtleBot3 官方教材也會介紹 Cartographer，但本課程目前的 SLAM 主線是 **SLAM Toolbox**，因此 Week 00 不要求先安裝 Cartographer。

---

# TurtleBot3 環境

## 15. 建立 TurtleBot3 Workspace

本課程將 TurtleBot3 相關 source packages 放在獨立 workspace：

```text
~/turtlebot3_ws
```

建立 workspace：

```bash
mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src
```

---

## 16. 下載 TurtleBot3 核心套件

依 TurtleBot3 Humble 官方環境下載：

```bash
git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git
```

確認：

```bash
ls ~/turtlebot3_ws/src
```

應該至少看到：

```text
DynamixelSDK
turtlebot3
turtlebot3_msgs
```

---

## 17. 安裝 TurtleBot3 相依套件

回到 workspace：

```bash
cd ~/turtlebot3_ws
```

利用 rosdep 安裝缺少的 dependency：

```bash
rosdep install --from-paths src --ignore-src -r -y
```

---

## 18. Build TurtleBot3 Workspace

執行：

```bash
cd ~/turtlebot3_ws
colcon build --symlink-install
```

成功後，workspace 會出現：

```text
build/
install/
log/
src/
```

載入這個 workspace：

```bash
source ~/turtlebot3_ws/install/setup.bash
```

確認：

```bash
ros2 pkg list | grep turtlebot3
```

應該可以看到多個 TurtleBot3 packages。

---

## 19. 安裝 TurtleBot3 Simulation

進入 source folder：

```bash
cd ~/turtlebot3_ws/src
```

下載 Humble branch：

```bash
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
```

回到 workspace 並再次安裝 dependency：

```bash
cd ~/turtlebot3_ws
rosdep install --from-paths src --ignore-src -r -y
```

重新 build：

```bash
colcon build --symlink-install
```

再 source：

```bash
source ~/turtlebot3_ws/install/setup.bash
```

確認 simulation package：

```bash
ros2 pkg list | grep turtlebot3_gazebo
```

應看到：

```text
turtlebot3_gazebo
```

---

## 20. 讓 TurtleBot3 Workspace 自動載入

執行：

```bash
grep -qxF 'source ~/turtlebot3_ws/install/setup.bash' ~/.bashrc || \
  echo 'source ~/turtlebot3_ws/install/setup.bash' >> ~/.bashrc
```

本課程預設使用 TurtleBot3 Burger：

```bash
grep -qxF 'export TURTLEBOT3_MODEL=burger' ~/.bashrc || \
  echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
```

重新載入：

```bash
source ~/.bashrc
```

確認：

```bash
echo $TURTLEBOT3_MODEL
```

應輸出：

```text
burger
```

> [!NOTE]
> 本課程目前不統一設定固定 `ROS_DOMAIN_ID`。若之後需要多台真實機器人或多人共用網路，再依課堂需求指定，避免所有同學使用相同 Domain ID 造成干擾。

---

## 21. 啟動 TurtleBot3 Simulation 測試

確認目前 Terminal 已 source：

```bash
source /opt/ros/humble/setup.bash
source ~/turtlebot3_ws/install/setup.bash
export TURTLEBOT3_MODEL=burger
```

啟動 TurtleBot3 World：

```bash
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
```

第一次啟動 Gazebo 可能需要一些時間。

如果環境正確，應該看到：

```text
Gazebo
   ↓
TurtleBot3 Burger
   ↓
Simulation World
```

完成確認後使用：

```text
Ctrl + C
```

停止 Simulation。

---

## 22. 課程環境完整檢查

回到課程 Repository：

```bash
cd ~/mobile-robotics-course
```

更新教材：

```bash
git pull
```

執行：

```bash
bash scripts/environment_check.sh
```

環境檢查會確認課程主要項目是否可使用。

---

## 23. 手動檢查清單

完成本章後，請確認：

- [ ] Ubuntu 22.04
- [ ] ROS 2 Humble
- [ ] `ros2` CLI
- [ ] RViz2
- [ ] Gazebo Classic / Gazebo 11
- [ ] `turtlesim`
- [ ] TurtleBot3 core packages
- [ ] `turtlebot3_gazebo`
- [ ] SLAM Toolbox
- [ ] Navigation2 / `nav2_bringup`
- [ ] `colcon`
- [ ] `rosdep`
- [ ] `TURTLEBOT3_MODEL=burger`

可以快速執行：

```bash
printenv ROS_DISTRO
gazebo --version
which rviz2
ros2 pkg list | grep turtlesim
ros2 pkg list | grep turtlebot3_gazebo
ros2 pkg list | grep slam_toolbox
ros2 pkg list | grep nav2_bringup
echo $TURTLEBOT3_MODEL
```

---

## 24. 常見問題

### Q1：`ros2: command not found`

先執行：

```bash
source /opt/ros/humble/setup.bash
```

再確認：

```bash
printenv ROS_DISTRO
```

若正常，再檢查 `~/.bashrc` 是否有：

```bash
source /opt/ros/humble/setup.bash
```

### Q2：找不到 TurtleBot3 package

執行：

```bash
source /opt/ros/humble/setup.bash
source ~/turtlebot3_ws/install/setup.bash
```

再確認：

```bash
ros2 pkg list | grep turtlebot3
```

### Q3：`colcon build` 失敗

先確認 ROS 2 已 source：

```bash
source /opt/ros/humble/setup.bash
```

再安裝 dependency：

```bash
cd ~/turtlebot3_ws
rosdep install --from-paths src --ignore-src -r -y
```

再 build：

```bash
colcon build --symlink-install
```

### Q4：Gazebo 開不起來或黑畫面

先確認 VirtualBox：

```text
Graphics Controller = VMSVGA
Video Memory = 128 MB
Enable 3D Acceleration = ON
```

再確認 Guest Additions 已完成安裝。

### Q5：`TURTLEBOT3_MODEL` 沒有設定

執行：

```bash
export TURTLEBOT3_MODEL=burger
```

若要永久設定：

```bash
echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
source ~/.bashrc
```

---

## 25. 為什麼這一章不用一鍵安裝 Script？

本課程刻意讓你親自使用：

```text
apt
source
rosdep
colcon
git
```

因為這些不是只在安裝時使用一次，而是後續 ROS 2 開發每天都會用到的基本工具。

這一章的目標不是背下所有安裝指令，而是至少理解：

```text
apt      → 安裝系統 / ROS 套件
source   → 載入 ROS 環境
rosdep   → 安裝 ROS package dependency
colcon   → build ROS 2 workspace
git      → 下載與更新程式碼
```

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

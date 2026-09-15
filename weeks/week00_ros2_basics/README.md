# Week 00 — 環境、Linux、Git 與 ROS 2 基礎

Week 00 是正式移動式機器人實作開始前的準備週。

本週不要求一次學會所有 ROS 2 功能，目標是先把開發環境準備好，並建立後續課程會反覆使用的基本觀念。

---

## 本週學習目標

完成 Week 00 後，你應該能夠：

- 在 Ubuntu Terminal 中進行基本操作
- 使用 Git 下載與更新課程教材
- 理解 ROS 2 Node 與 Topic 的基本概念
- 執行 Talker / Listener 範例
- 使用 Turtlesim 並觀察 `/turtle1/cmd_vel`
- 理解 `geometry_msgs/msg/Twist` 中 `linear.x` 與 `angular.z` 的用途

---

## 本週流程

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

---

## Part 1 — 環境確認

請先確認：

```bash
lsb_release -a
```

課程環境應為 Ubuntu 22.04。

再執行：

```bash
printenv ROS_DISTRO
```

若 ROS 2 Humble 已正確載入，應看到：

```text
humble
```

也可以執行課程提供的環境檢查工具：

```bash
cd ~/mobile-robotics-course
bash scripts/environment_check.sh
```

---

## Part 2 — Linux 與 Git

教材：

➡️ [Linux 與 Git 基礎](../../docs/02_Linux與Git基礎.md)

本週至少需要熟悉：

```text
pwd
ls
cd
mkdir
cat
sudo apt update
sudo apt install

git clone
git pull
git status
```

---

## Part 3 — ROS 2 基礎

教材：

➡️ [ROS 2 基礎](../../docs/03_ROS2基礎.md)

本週核心概念：

```text
Node
Topic
Publisher
Subscriber
```

---

## Part 4 — Talker / Listener

Terminal 1：

```bash
ros2 run demo_nodes_cpp talker
```

Terminal 2：

```bash
ros2 run demo_nodes_py listener
```

觀察：

```bash
ros2 node list
ros2 topic list
ros2 topic info /chatter
ros2 topic echo /chatter
```

---

## Part 5 — Turtlesim

Terminal 1：

```bash
ros2 run turtlesim turtlesim_node
```

Terminal 2：

```bash
ros2 run turtlesim turtle_teleop_key
```

接著觀察：

```bash
ros2 topic list
ros2 topic info /turtle1/cmd_vel
ros2 topic echo /turtle1/cmd_vel
```

再查看 `Twist`：

```bash
ros2 interface show geometry_msgs/msg/Twist
```

---

## 本週最重要的連結

請建立以下關係：

```text
Keyboard
   ↓
turtle_teleop_key
   ↓
/turtle1/cmd_vel
   ↓
turtlesim_node
   ↓
Turtle moves
```

下一週控制 TurtleBot3 時會再次看到 `/cmd_vel` 與 `Twist`。

---

## 課堂 Examples

本週課堂使用到的指令整理在：

➡️ [examples/](examples/)

---

## 本週作業

➡️ [HW00 — Turtlesim Motion Control](../../assignments/hw00_turtlesim_control/README.md)

作業重點不是鍵盤遙控，而是撰寫自己的 ROS 2 Python Node，自動發布速度命令控制 Turtle。

---

## Week 00 Checkpoint

離開教室前，請確認：

- [ ] Ubuntu 22.04 可以正常啟動
- [ ] `git` 可以使用
- [ ] 課程 Repository 已 clone
- [ ] `ros2` 指令可以使用
- [ ] Talker / Listener 可以正常通訊
- [ ] Turtlesim 可以正常開啟
- [ ] 可以透過鍵盤控制 Turtle
- [ ] 知道 `/turtle1/cmd_vel` 的用途

完成以上項目後，即可開始 HW00。

# Week 00 — 環境、Linux、Git 與 ROS 2 基礎

Week 00 是正式移動式機器人實作開始前的準備週。

本週的目標是完成開發環境準備，並建立後續課程會反覆使用的 ROS 2 基本通訊觀念。

---

## 本週學習目標

完成 Week 00 後，你應該能夠：

- 在 Ubuntu Terminal 中進行基本操作
- 使用 Git 下載與更新課程教材
- 理解 ROS 2 Node、Topic、Publisher、Subscriber 與 Message 的基本概念
- 執行 Talker / Listener 範例並觀察它們的通訊
- 使用 ROS 2 CLI 找出 Node、Topic、Message type 與正在傳送的資料
- 面對新的 ROS 2 系統時，知道如何開始探索

---

## 本週流程

```text
環境確認
   ↓
Linux Terminal
   ↓
Git clone / git pull
   ↓
ROS 2 通訊概念
   ↓
Node / Topic / Message
   ↓
Publisher / Subscriber
   ↓
Talker / Listener
   ↓
ROS 2 CLI 探索工具
   ↓
HW00：自行探索 Turtlesim
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

## Part 3 — ROS 2 基礎通訊

教材：

➡️ [ROS 2 基礎](../../docs/03_ROS2基礎.md)

本週核心概念：

```text
Node
Topic
Message
Publisher
Subscriber
```

先理解這些角色之間的關係，而不是背指令。

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

接著利用 CLI 觀察這個系統：

```bash
ros2 node list
ros2 topic list
ros2 topic info /chatter
ros2 topic echo /chatter
```

請思考：

```text
哪一個 Node 是 Publisher？
哪一個 Node 是 Subscriber？
它們使用哪一個 Topic？
Topic 傳送什麼 Message type？
```

---

## Part 5 — 學會探索，而不是背答案

本週非常重要的一項能力，是面對陌生 ROS 2 系統時知道怎麼開始。

可以從：

```bash
ros2 node list
ros2 topic list
ros2 node info <node_name>
ros2 topic info <topic_name>
ros2 topic echo <topic_name>
ros2 interface show <message_type>
```

開始探索。

這些工具會在後續每一個機器人實作中反覆使用。

---

## 課堂 Examples

本週課堂範例只用來練習 ROS 2 基本通訊與 CLI：

➡️ [examples/](examples/)

---

## HW00 — Turtlesim

課堂不會提供 Turtlesim 控制程式，也不會逐步示範作業解法。

你需要把本週學到的 ROS 2 通訊概念與探索方法應用到一個新的系統：**Turtlesim**。

➡️ [HW00 — Turtlesim 自主控制](../../assignments/hw00_turtlesim_control/README.md)

這次作業真正想練習的是：

> 面對一個新的 ROS 2 系統，能不能自己找出它如何通訊，並利用找到的資訊完成控制任務？

---

## Week 00 Checkpoint

離開教室前，請確認：

- [ ] Ubuntu 22.04 可以正常啟動
- [ ] `git` 可以使用
- [ ] 課程 Repository 已 clone
- [ ] `ros2` 指令可以使用
- [ ] Talker / Listener 可以正常通訊
- [ ] 知道 Node、Topic、Publisher、Subscriber、Message 的基本關係
- [ ] 會使用 ROS 2 CLI 找出 Node 與 Topic
- [ ] 會查詢 Topic 的資訊與 Message type
- [ ] 會觀察 Topic 正在傳送的資料

完成以上項目後，即可開始 HW00。

# Week 00 Examples

本資料夾整理 Week 00 課堂中會使用到的基本 ROS 2 通訊指令。

這些內容是課堂操作範例，不包含 HW00 Turtlesim 的控制方法。

---

## 1. Talker / Listener

Terminal 1：

```bash
ros2 run demo_nodes_cpp talker
```

Terminal 2：

```bash
ros2 run demo_nodes_py listener
```

觀察系統：

```bash
ros2 node list
ros2 topic list
ros2 topic info /chatter
ros2 topic echo /chatter
```

---

## 2. 進一步觀察 Node 與 Message

查看 Talker 或 Listener 的 Node 資訊：

```bash
ros2 node list
ros2 node info <node_name>
```

先利用：

```bash
ros2 topic info /chatter
```

找出 `/chatter` 使用的 Message type，再使用：

```bash
ros2 interface show <message_type>
```

觀察 Message 的資料格式。

---

## 3. 停止 ROS 2 程式

正在執行中的 ROS 2 Node，可在對應 Terminal 使用：

```text
Ctrl + C
```

停止。

---

## HW00 提醒

HW00 會使用一個新的 ROS 2 系統：Turtlesim。

請把本週學到的探索方法帶到作業中：

```text
Node？
  ↓
Topic？
  ↓
Message type？
  ↓
如何與它通訊？
```

課堂 Examples 不會提供 Turtlesim 的控制 Topic、Message 或控制程式。

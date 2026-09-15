# Week 00 Examples

本資料夾整理 Week 00 課堂中會使用到的基本指令。

這些內容是操作範例，不是 HW00 的完整解答。

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

## 2. Turtlesim

Terminal 1：

```bash
ros2 run turtlesim turtlesim_node
```

Terminal 2：

```bash
ros2 run turtlesim turtle_teleop_key
```

觀察速度命令：

```bash
ros2 topic info /turtle1/cmd_vel
ros2 topic echo /turtle1/cmd_vel
```

觀察 Turtle 位置：

```bash
ros2 topic echo /turtle1/pose
```

查看速度訊息格式：

```bash
ros2 interface show geometry_msgs/msg/Twist
```

---

## 3. 停止 ROS 2 程式

正在執行中的 ROS 2 Node，可在對應 Terminal 使用：

```text
Ctrl + C
```

停止。

---

後續若增加課堂範例程式，會放在此資料夾中。

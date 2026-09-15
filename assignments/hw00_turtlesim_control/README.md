# HW00 — Turtlesim Motion Control

本作業是本課程第一個 ROS 2 程式練習。

你需要撰寫自己的 ROS 2 Python Node，發布 `geometry_msgs/msg/Twist` 到 `/turtle1/cmd_vel`，讓 Turtlesim 中的 Turtle 自動完成指定動作。

> [!IMPORTANT]
> 本作業不是使用鍵盤遙控。程式啟動後，Turtle 應由你的 Node 自動完成動作。

---

## 1. 學習目標

完成本作業後，你應該能夠：

- 建立基本 ROS 2 Python Node
- 建立 Publisher
- 發布 `geometry_msgs/msg/Twist`
- 使用 `linear.x` 控制直線速度
- 使用 `angular.z` 控制旋轉速度
- 理解控制程式與 `/turtle1/cmd_vel` 的關係

---

## 2. 任務

請讓 Turtle 依序完成：

1. 向前移動一段距離
2. 左轉約 90°
3. 再向前移動一段距離
4. 停止

概念示意：

```text
          End
           ●
           ↑
           │
           │
Start ●────┘
      →
```

本作業重點是 ROS 2 Publisher 與基本運動控制概念，不要求非常精準的軌跡控制。

---

## 3. 必須使用

Topic：

```text
/turtle1/cmd_vel
```

Message type：

```text
geometry_msgs/msg/Twist
```

主要使用欄位：

```text
linear.x
angular.z
```

---

## 4. Starter Code

Starter code 放在：

```text
starter/turtle_controller.py
```

請先複製一份到自己的工作位置再修改。

Starter code 只提供基本 Node 架構，Publisher 與控制邏輯需要自行完成。

---

## 5. 執行前準備

先啟動 Turtlesim：

```bash
ros2 run turtlesim turtlesim_node
```

確認 Turtlesim 正常開啟後，再於另一個 Terminal 執行自己的控制程式。

如果需要觀察速度命令，可另外開啟 Terminal：

```bash
ros2 topic echo /turtle1/cmd_vel
```

也可以查看 Turtle 目前的位置：

```bash
ros2 topic echo /turtle1/pose
```

---

## 6. 基本要求

你的程式至少需要符合：

- [ ] 使用 ROS 2 Python Node
- [ ] 建立 `/turtle1/cmd_vel` Publisher
- [ ] 發布 `Twist`
- [ ] Turtle 可以自動向前移動
- [ ] Turtle 可以自動左轉
- [ ] 動作完成後速度歸零並停止
- [ ] 程式執行過程不需要使用鍵盤控制 Turtle

---

## 7. 注意事項

### 不要讓 Turtle 一直移動

完成任務後請發布零速度：

```text
linear.x = 0
angular.z = 0
```

### 注意角速度方向

一般情況下：

```text
angular.z > 0  → 左轉
angular.z < 0  → 右轉
```

### 注意 Turtlesim 邊界

速度過快或時間過長可能讓 Turtle 撞到視窗邊界。

---

## 8. Challenge（選做）

完成基本題後，可以嘗試讓 Turtle 自動畫出一個正方形：

```text
┌────────┐
│        │
│        │
│        │
└────────┘
```

Challenge 不影響基本題完成與否，細節依課堂公告為準。

---

## 9. 繳交方式

繳交格式、截止時間與是否需要錄影或截圖，將依課堂公告為準。

在正式繳交前，請至少自行確認：

```bash
ros2 topic list
```

可以看到 `/turtle1/cmd_vel`，且你的程式執行後 Turtle 可以完整完成指定動作。

---

## 10. 與下一週的關係

HW00 使用：

```text
Turtlesim
   ↓
/turtle1/cmd_vel
   ↓
Twist
```

下一週會進入真正的移動式機器人模擬：

```text
TurtleBot3
   ↓
/cmd_vel
   ↓
Twist
```

因此 HW00 的概念會直接延續到後續課程。

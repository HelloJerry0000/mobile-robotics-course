# 02 — Linux 與 Git 基礎

本章介紹 Week 00 會使用到的 Linux Terminal 與 Git 基本操作。

本課程不要求你先成為 Linux 或 Git 專家；第一週只需要能夠：

- 在 Terminal 中切換資料夾與查看檔案
- 建立、複製、移動與刪除檔案
- 安裝基本套件
- 從 GitHub 下載課程 Repository
- 使用 `git pull` 更新教材
- 分清楚「老師教材」與「自己的 ROS 2 Workspace」

---

## 1. Terminal 與 Terminator

Ubuntu 內建 Terminal 可以使用：

```text
Ctrl + Alt + T
```

開啟。

本課程另外建議安裝 **Terminator**。之後 ROS 2 常需要同時開啟多個 Terminal 執行不同 Node，Terminator 可以方便地分割視窗。

安裝：

```bash
sudo apt update
sudo apt install -y terminator
```

啟動：

```bash
terminator
```

> [!NOTE]
> Terminator 只是 Terminal 工具，不是 ROS 2 的必要套件。若 Terminator 暫時無法使用，Ubuntu 內建 Terminal 一樣可以完成課程操作。

之後大部分 ROS 2 操作都會在 Terminal 中完成。

---

## 2. 目前位置與資料夾

顯示目前所在位置：

```bash
pwd
```

查看目前資料夾內容：

```bash
ls
```

顯示較完整資訊：

```bash
ls -l
```

包含隱藏檔案：

```bash
ls -a
```

切換資料夾：

```bash
cd <資料夾名稱>
```

回到上一層：

```bash
cd ..
```

回到自己的 Home：

```bash
cd ~
```

---

## 3. 建立與操作檔案

建立資料夾：

```bash
mkdir week00
```

建立空白檔案：

```bash
touch hello.txt
```

查看文字檔：

```bash
cat hello.txt
```

複製檔案：

```bash
cp hello.txt hello_copy.txt
```

移動或重新命名：

```bash
mv hello_copy.txt hello2.txt
```

刪除檔案：

```bash
rm hello2.txt
```

> [!WARNING]
> Linux 的 `rm` 通常不會把檔案移到資源回收桶。執行刪除指令前請確認路徑與檔名。

---

## 4. Terminal 常用操作

| 操作 | 功能 |
| --- | --- |
| `Tab` | 自動補齊指令或路徑 |
| `↑` / `↓` | 查看之前輸入過的指令 |
| `Ctrl + C` | 停止目前正在執行的程式 |
| `Ctrl + L` | 清除畫面 |

其中 `Ctrl + C` 在 ROS 2 中非常重要，之後常用來停止正在執行的 Node。

---

## 5. APT 套件管理

更新可安裝套件資訊：

```bash
sudo apt update
```

安裝套件：

```bash
sudo apt install <套件名稱>
```

例如安裝 Git：

```bash
sudo apt install git
```

檢查：

```bash
git --version
```

> [!NOTE]
> 使用 `sudo` 時輸入密碼，Terminal 不會顯示 `*` 或任何字元，這是正常現象。輸入完成後按 Enter 即可。

---

## 6. Week 00 Linux 小練習

依序執行：

```bash
cd ~
mkdir -p mobile_robotics/week00
cd mobile_robotics/week00

echo "Hello Mobile Robotics" > hello.txt
cat hello.txt
```

如果畫面顯示：

```text
Hello Mobile Robotics
```

代表你已完成最基本的 Linux 操作。

---

# Git 基礎

## 7. Git 與 GitHub 在本課程的用途

本課程主要使用：

```text
老師 GitHub Repository
        ↓
      git clone
        ↓
~/mobile-robotics-course
        ↓
      git pull
        ↓
取得最新課程教材
```

Week 00 暫時只需要熟悉：

```text
git clone
git pull
git status
```

不需要先學 branch、merge、rebase 或 pull request。

---

## 8. Clone 課程 Repository

第一次下載前先回到 Home：

```bash
cd ~
```

確認是否已經存在同名資料夾：

```bash
ls
```

若 `mobile-robotics-course` **不存在**，才執行：

```bash
git clone https://github.com/HelloJerry0000/mobile-robotics-course.git
```

若已經 clone 過，就不要再執行第二次 `git clone`。

進入 Repository：

```bash
cd ~/mobile-robotics-course
```

查看狀態：

```bash
git status
```

正常情況下會看到目前位於 `main` branch。

> [!IMPORTANT]
> 如果看到 `fatal: destination path 'mobile-robotics-course' already exists and is not an empty directory.`，代表這個資料夾已經存在。通常應該進入原本的 Repository 執行 `git pull`，而不是再次 clone。

---

## 9. 更新課程教材

每次上課前：

```bash
cd ~/mobile-robotics-course
git pull
```

取得最新教材。

---

# 本課程的資料夾規則

## 10. 老師教材與學生程式必須分開

整學期請記住三個位置：

```text
~/mobile-robotics-course/    老師教材：只 clone / pull，不在這裡寫作業
~/turtlebot3_ws/             TurtleBot3 第三方環境：由第 03 章建立
~/mobile_robotics_ws/        學生自己的 ROS 2 Workspace：作業與 Lab 寫在這裡
```

其中學生真正會修改的是：

```text
~/mobile_robotics_ws/src/
```

例如之後可能會看到：

```text
~/mobile_robotics_ws/
├── src/
│   ├── hw00_turtlesim/
│   ├── lab01_motion/
│   └── ...
├── build/
├── install/
└── log/
```

> [!IMPORTANT]
> **不要在 `~/mobile-robotics-course` 裡建立自己的作業、ROS package 或個人 Git 專案。**
> 課程 Repository 是老師發布教材的位置；自己的程式統一放在 `~/mobile_robotics_ws/src/`。

---

## 11. 完成檢查

請確認：

```bash
pwd
ls
git --version
terminator --version
```

以及：

```bash
cd ~/mobile-robotics-course
git status
git pull
```

完成後即可進入下一章：

➡️ [03 — ROS 2 Humble 課程環境安裝](03_ROS2_Humble環境安裝.md)

# 02 — Linux 與 Git 基礎

本章介紹 Week 00 會使用到的 Linux Terminal 與 Git 基本操作。

本課程不要求你先成為 Linux 或 Git 專家；第一週只需要能夠：

- 在 Terminal 中切換資料夾與查看檔案
- 建立、複製、移動與刪除檔案
- 安裝基本套件
- 從 GitHub 下載課程 Repository
- 使用 `git pull` 更新教材

---

## 1. 開啟 Terminal

Ubuntu 中可使用快捷鍵：

```text
Ctrl + Alt + T
```

開啟 Terminal。

之後大部分 ROS 2 操作都會在 Terminal 中完成。

---

## 2. 目前位置與資料夾

### 顯示目前所在位置

```bash
pwd
```

### 查看目前資料夾內容

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

### 切換資料夾

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
GitHub
  ↓
保存與發布課程教材
  ↓
Git
  ↓
下載及更新教材
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

回到 Home：

```bash
cd ~
```

下載課程 Repository：

```bash
git clone https://github.com/HelloJerry0000/mobile-robotics-course.git
```

進入 Repository：

```bash
cd mobile-robotics-course
```

查看狀態：

```bash
git status
```

正常情況下會看到目前位於 `main` branch。

---

## 9. 更新課程教材

之後每次上課前，可以進入課程 Repository：

```bash
cd ~/mobile-robotics-course
```

再執行：

```bash
git pull
```

取得最新教材。

> [!IMPORTANT]
> 建議不要直接修改課程 Repository 內的教材檔案。自己的練習程式與作業請依照作業說明放在指定位置或自己的 workspace，避免之後 `git pull` 發生衝突。

---

## 10. 完成檢查

請確認以下指令都可以正常執行：

```bash
pwd
ls
git --version
```

以及：

```bash
cd ~/mobile-robotics-course
git status
```

完成後即可進入下一章：

➡️ [03 — ROS 2 Humble 課程環境安裝](03_ROS2_Humble環境安裝.md)

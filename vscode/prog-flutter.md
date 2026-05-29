# 搭建 Flutter 舒适编程环境（VSCode）

## 1. 安装 Flutter

macOS/Linux 用户，使用 Homebrew

```shell
brew install flutter
```

Windows 用户，使用 Scoop

```powershell
scoop install flutter
```

## 2. 安卓环境配置

你不需要安装 Android Studio !
你不需要安装 Android Studio !
你不需要安装 Android Studio !

### 安装 Android 命令行工具

macOS/Linux 用户，使用 Homebrew

```shell
brew install android-commandlinetools
```

Windows 用户，使用 Scoop

```powershell
scoop install android-clt
```

### 安装 Android SDK

```bash
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"
```

安装完毕后，使用 Flutter 检查

```bash
flutter doctor
```

当出现类似如下信息时，说明 Android SDK 已安装完成

```console
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.41.7, on macOS 26.4.1 25E253 darwin-arm64, locale en-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 36.0.0)
...
[✓] Chrome - develop for the web
[✓] Connected device (2 available)
[✓] Network resources
```

### 添加环境变量

对 MacOS/Linux 用户，在 .zshrc/.bash_profile 中，添加环境变量

```bash
export ANDROID_HOME="$(brew --prefix)/share/android-commandlinetools"
export ANDROID_SDK_ROOT="$ANDROID_HOME"

export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
```

对 Windows 用户，在环境变量中 Path 中添加 `{$env:SCOOP}\apps\flutter\current\bin`

> `{$env:SCOOP}` 是 Scoop 安装目录，通常是`C:\Scoop`或`C:\Users\{username}\Scoop`。

## 3. 安装扩展

在 VSCode 扩展商店，搜索并安装 Flutter 扩展（下载数量最多的那个），该扩展会自动安装 Dart 扩展。

> 图片没必要展示了。

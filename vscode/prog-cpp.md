# 搭建 C/C++ 轻量级编程环境（VSCode）

## 1. 工具链

工具链是整个编程环境的核心，在 MacOS/Linux 上，系统内置了库文件，但是在 Windows 上，库文件需要自行下载，所以这里只介绍 Windows 上的库文件下载。我们这里选择的微软官方推荐的 MSYS2。

### 1.1. 安装

- 手动安装

下载[安装包](https://mirrors.tuna.tsinghua.edu.cn/msys2/distrib/msys2-x86_64-latest.exe)，默认一路向下，直至完成。

- 包管理器安装（如果有的话）

```powershell
scoop bucket add scoopforge/extras-cn
scoop install msys2-cn
```

### 1.2. 配置

进入 MSYS2 的 UCRT64 终端，执行如下命令，使用清华源

```shell
sed -i "s#https\?://mirror.msys2.org/#https://mirrors.tuna.tsinghua.edu.cn/msys2/#g" /etc/pacman.d/mirrorlist*
```

然后安装 UCRT (Universal C Runtime) 工具链

```shell
pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
pacman -S mingw-w64-ucrt-x86_64-gdb
```

- 接受默认配置，一路向下直至完成安装。
- 将 MSYS2 安装路径下的 `ucrt64\bin` 目录添加到环境变量 `PATH` 中

重启终端，在 PowerShell 中，检验是否安装成功

```powershell
gcc --version
g++ --version
gdb --version
```

### 安装第三方库

进入 MSYS2 的 UCRT64 终端，执行如下命令

- OpenCV

```shell
pacman -S mingw-w64-ucrt-x86_64-opencv
```

- CMake

```shell
pacman -S mingw-w64-ucrt-x86_64-cmake
```

- Qt6

```shell
pacman -S mingw-w64-ucrt-x86_64-qt6-base mingw-w64-ucrt-x86_64-qt6-svg mingw-w64-ucrt-x86_64-qt6-declarative
```

## 2. VSCode 扩展

### 安装扩展

在 VSCode 中的扩展商店里，搜索并安装 C/C++ 扩展（下载数量最多的那个）。

> 图片没必要展示了。

### 配置扩展

安装完毕后，"ctrl +," 进入配置，点击右上角的图标，打开 `settings.json`

基本配置如下

```json
{
  "C_Cpp.autocompleteAddParentheses": true,
  "C_Cpp.default.cppStandard": "c++20",
  "C_Cpp.default.cStandard": "c17",
  "C_Cpp.default.mergeConfigurations": true,
}
```

### 配置工程文件

在工作文件夹下，新建 `.vscode` 文件夹 ，在`c_cpp_properties.json`、`launch.json`和`tasks.json`三个文件中分别写入

> 以下的 `{msys2根目录}` 通常为 `C:\\msys64`。对 `Scoop` 使用者为 `${env:SCOOP}\\apps\\msys2\\current`。

#### c_cpp_properties.json

```json
{
    "configurations": [
        {
            "name": "win-conda-opencv",
            "includePath": [
                "${workspaceFolder}/**",
                "{msys2根目录}\\ucrt64\\include",
                "{msys2根目录}\\ucrt64\\include\\opencv4"
            ],
            "defines": [
                "_DEBUG",
                "UNICODE",
                "_UNICODE"
            ],
            "compilerPath": "{msys2根目录}\\ucrt64\\bin\\g++.exe",
            "cStandard": "c17",
            "cppStandard": "c++17",
            "intelliSenseMode": "windows-gcc-x64"
        }
    ],
    "version": 4
}
```

#### launch.json

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug OpenCV on Windows",
            "type": "cppdbg",
            "request": "launch",
            "targetArchitecture": "x86_64",
            "program": "${fileDirname}/${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "externalConsole": false,
            "cwd": "${fileDirname}",
            "MIMode": "gdb",
            "miDebuggerPath": "{msys2根目录}\\ucrt64\\bin\\gdb.exe",
            "internalConsoleOptions": "openOnSessionStart",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": false
                }
            ],
            // "preLaunchTask": "Build OpenCV4 on Windows"
        }
    ]
}
```

#### tasks.json

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "type": "cppbuild",
            "label": "Build OpenCV4 on Windows",
            "command": "{msys2根目录}\\ucrt64\\bin\\g++.exe",
            "args": [
                "-fdiagnostics-color=always",
                "-g",
                "${file}",
                "-o",
                "${fileDirname}/${fileBasenameNoExtension}.exe",
                "-I",
                "{msys2根目录}\\ucrt64\\include",
                "-I",
                "{msys2根目录}\\ucrt64\\include\\opencv4",
                "-L",
                "{msys2根目录}\\ucrt64\\lib",
                "-lopencv_core",
                "-lopencv_highgui",
                "-lopencv_imgcodecs",
                "-lopencv_imgproc",
            ],
            "options": {
                "cwd": "{msys2根目录}\\ucrt64\\bin"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": "build"
        }
    ]
}
```

## Qt Creator

可以下载 [Qt Creator](https://mirrors.ustc.edu.cn/qtproject/official_releases/qtcreator/latest/installer_source/)，尝试在其中完成环境配置。

# 搭建 ROS 原生编程环境

ROS 传统上绑定 Ubuntu：`apt` 全局安装、一个发行版对应一个 Ubuntu 版本，Windows 与 macOS 只能借助
[WSL2](win-wsl2.md)、虚拟机或双系统。RoboStack 把 ROS 发行版打包成 conda 预编译二进制包，
由 Pixi 按项目建立隔离环境，在 Linux、macOS、Windows 宿主机上直接运行。

这里的「原生」有两层含义：

- ROS 节点与 rviz2 等 GUI 程序直接跑在当前系统，不需要 Docker、双系统或 X Server 转发；
- ROS 与 Python、OpenCV、PyTorch 等 conda-forge / PyPI 包共处同一环境，不需要 `sudo`，不写系统目录。

RoboStack 官方目前推荐 Pixi，且已把 Humble、Jazzy、Lyrical、Rolling 合并到
[单一仓库](https://github.com/RoboStack/robostack)。

**发行版一律选 LTS**：ROS 2 偶数年发行版支持 5 年，奇数年普通版约 1.5 年。
LTS 在接口稳定性、依赖可复现与教学/项目周期上明显更划算，依据见[第 6.2 节](#62-为什么优先选-lts)。
本文以 **ROS 2 Jazzy**（LTS，2024-05 发布，支持至 2029-05）为例：第三方包与教学资料积累更充分。
换用其他发行版时，按第 6.1 节替换频道与包名即可。

> 相关文档：[搭建 Python 轻量级编程环境](prog-python.md) 已介绍 conda 环境管理；
> [搭建 WSL2 舒适开发环境](win-wsl2.md) 是另一条路线，两套 ROS 环境不要混用。

## 1. 方案对比

| 方案      | 系统要求                       | 权限              | 环境隔离                 | GUI                   | 安装来源       |
| --------- | ------------------------------ | ----------------- | ------------------------ | --------------------- | -------------- |
| `apt`     | Ubuntu 版本与 ROS 发行版强绑定 | `sudo`、全局安装  | 无                       | 原生                  | 预编译 deb     |
| WSL2      | Windows + Linux 子系统         | 子系统内 `sudo`   | 一台子系统对应一个发行版 | 需 VcXsrv 等 X Server | 预编译 deb     |
| Docker    | 任意                           | 镜像内 root       | 容器级                   | 需 X11 转发           | 镜像           |
| RoboStack | Linux / macOS / Windows        | 用户级、无 `sudo` | 按项目、可并存多个发行版 | 原生窗口              | conda 二进制包 |

结论：需要跨系统、多发行版并行，或希望 ROS 与数据科学依赖同环境管理时，RoboStack 是唯一不引入虚拟层的方案；
代价是包来自 conda 频道，第三方 ROS 包的覆盖率与 `apt` 不完全一致，冷门包可能需要从源码构建。

## 2. 安装 Pixi

### 2.1 前置条件

Windows 用户需安装 [Visual Studio 2022 的「使用 C++ 的桌面开发」工作负载](https://learn.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-170)。
`colcon build` 编译 C++ 包时依赖 MSVC 工具链，只运行预编译节点也应装上，以免后续临时编译失败。
用 winget 一次装好：

```powershell
winget install --id Microsoft.VisualStudio.2022.Community -e `
  --accept-source-agreements --accept-package-agreements `
  --override "--quiet --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended"
```

winget 默认只装 VS 核心，不含 C++ 工具链；`--override` 把参数原样交给 VS Installer，
`--add Microsoft.VisualStudio.Workload.NativeDesktop` 对应「使用 C++ 的桌面开发」，
`--includeRecommended` 补齐 MSVC、Windows SDK 等推荐组件，否则工具链可能不完整。
安装需要管理员权限，winget 会提示提权；参数含义见
[使用命令行参数安装 Visual Studio](https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2022)。
若本机已装过 VS，改用 Visual Studio Installer 的「修改」补选该工作负载，不要重复执行 `winget install`。
装完重开终端，让 `PATH` 与 MSVC 环境变量生效。

同时**不要 `source` 系统中已有的 `apt` ROS 环境**。其 setup 脚本写入的 `PYTHONPATH` 会与 conda 环境冲突，
表现为 `ros2`、`python` 指向系统版本，或导入包时报错。

### 2.2 安装命令

| 平台             | 命令                 |
| ---------------- | -------------------- |
| Windows（Scoop） | `scoop install pixi` |
| Linux / macOS    | `brew install pixi`  |

用 `pixi --version` 验证。通过包管理器安装的版本用包管理器升级，不要用 `pixi self-update`。

## 3. 创建工作区

### 3.1 初始化

```shell
pixi init ros_ws --channel https://prefix.dev/robostack-jazzy
cd ros_ws
```

`pixi init` 建立 `ros_ws` 目录并生成 `pixi.toml`；`--channel` 指定该发行版对应的 RoboStack 频道。
示例用 ROS 2 Jazzy（LTS），换发行版时按第 6.1 节替换频道名。

```toml
[workspace]
name = "ros_ws"
platforms = ["linux-64"] # Your platform
channels = ["https://prefix.dev/robostack-jazzy"] # The channel to use for the workspace
```

`platforms` 由 Pixi 按本机自动填写：Windows 为 `win-64`，Apple Silicon 为 `osx-arm64`。

### 3.2 macOS 平台声明

当前 RoboStack 构建要求 macOS 14 或更新，而 Pixi 默认按 macOS 13 解析。不声明会**静默**装到旧一代 ROS 包：

```shell
pixi workspace platform add osx-latest=osx-arm64 --osx 14
pixi workspace platform rm osx-arm64
```

Intel Mac 把 `osx-arm64` 换成 `osx-64`；两条命令顺序不可颠倒，Pixi 不允许删除工作区唯一的平台。执行后：

```toml
platforms = [{ name = "osx-latest", platform = "osx-arm64", macos = "14" }]
```

## 4. 安装并验证 ROS

### 4.1 安装 desktop 包

```shell
pixi add ros-jazzy-desktop
```

`pixi add` 把依赖写入 `pixi.toml` 并立即安装，同时生成记录精确版本的 `pixi.lock`。
Pixi 默认写入 `>=1.2.3,<2.0.0` 这类约束：下限锁定当前安装版本，上限按下一个主版本，
以便后续 `pixi update` 取到兼容的最新版本。

### 4.2 验证

```bash
pixi run ros2
# OR
pixi run rviz2
```

`pixi run` 先激活环境再执行指定命令；`pixi shell` 则打开一个已激活环境的新 shell。
Windows 下 `rviz2` 直接弹出原生窗口，不需要 X Server，这是与 WSL2 方案最直观的差别。

### 4.3 双终端收发测试

第一个终端：

```bash
pixi run ros2 run demo_nodes_cpp talker
```

第二个终端：

```bash
pixi run ros2 run demo_nodes_cpp listener
```

两个节点基于 DDS 自动发现，无需额外启动主节点即可互传消息。

## 5. 开发本地 ROS 包

### 5.1 开发工具

```bash
pixi add ros-dev-tools
```

### 5.2 建包与构建

```bash
pixi run ros2 pkg create --build-type ament_cmake --node-name my_node my_package
pixi run ros2 pkg create --build-type ament_python --node-name my_python_node my_python_package
pixi run colcon build
```

### 5.3 自动激活工作区

把 `colcon` 生成的 setup 脚本写入 `pixi.toml` 的 activation，之后每次 `pixi run` / `pixi shell`
都会自动 source 本地工作区（overlay），无需手动 `source install/setup.bash`。

Linux / macOS：

```toml
[target.unix.activation]
scripts = ["install/setup.bash"]
```

Windows：

```toml
[target.win.activation]
scripts = ["install/setup.bat"]
```

这两个文件由 `colcon build` 生成，首次构建之前尚不存在，属正常现象。

### 5.4 运行自建节点

```bash
pixi run ros2 run my_package my_package_node
pixi run ros2 run my_python_package my_python_package_node
```

## 6. 多发行版工作区

一个 `pixi.toml` 可声明多个 environment，各自对应一个 ROS 发行版，通过 `-e` 切换，互不污染。

### 6.1 发行版对照

频道列省略公共前缀 `https://prefix.dev/`。按支持周期倒序列出，LTS 在前；本文采用 Jazzy。

| environment | 定位          | 频道                | desktop 包            | 支持至     |
| ----------- | ------------- | ------------------- | --------------------- | ---------- |
| `lyrical`   | LTS（最新）   | `robostack-lyrical` | `ros-lyrical-desktop` | 2031-05    |
| `jazzy`     | LTS（本教程） | `robostack-jazzy`   | `ros-jazzy-desktop`   | 2029-05    |
| `humble`    | LTS           | `robostack-humble`  | `ros-humble-desktop`  | 2027-05    |
| `kilted`    | 普通版        | `robostack-kilted`  | `ros-kilted-desktop`  | 2026 年底  |
| `rolling`   | 滚动开发版    | `robostack-rolling` | `ros2-desktop`        | 无固定周期 |

`rolling` 的包名不带发行版代号。支持周期依据 [RoboStack 首页](https://robostack.github.io/)
与 ROS 2 发布策略：偶数年发行版为 LTS、支持 5 年，奇数年普通版约 1.5 年。

### 6.2 为什么优先选 LTS

新建工作区一律优先 LTS，本文以 Jazzy 为例。四点理由：

1. **支持周期按年计**：Jazzy 到 2029-05，更新的 Lyrical 到 2031-05；普通版 Kilted 在 2026 年底
   即结束维护，Rolling 没有稳定窗口。课件、实验代码与 CI 不必每年迁移发行版。
2. **稳定窗口长**：发行版发布后核心包只收错误修复与非破坏性改进，LTS 把这个窗口从约 1.5 年拉长到 5 年，
   `rclcpp` / `rclpy` 接口与 launch 写法不会中途失效；Rolling 允许原地引入破坏性变更，
   ROS 官方也不建议用它承载长期项目。
3. **环境可复现**：`pixi.lock` 锁定的包只在对应频道持续可用时才能重装，
   LTS 频道存续时间长，一两年后 `pixi install` 仍能还原同一套环境。
4. **协作与维护成本低**：同一份 `pixi.toml` 可覆盖一个项目周期或整届课程，
   第三方包与示例材料通常也优先适配 LTS。

在多个 LTS 之间选 Jazzy，取的是「时间够用、资料好找」：2024-05 发布，到 2029-05 的窗口
足以覆盖一整个课程或项目周期；更新的 Lyrical 支持到 2031-05，但第三方包适配仍在跟进，
确认依赖齐备后按第 6.1 节替换频道与包名即可升级。

结论：需要跟进新特性时另开 `pixi shell -e rolling` 试探，主工作区始终留在 LTS 上。

### 6.3 安装与切换

保存 `pixi.toml` 后先执行一次 `pixi install`，再按需要**选一条** `pixi shell -e` 进入对应发行版，
不要依次执行下面全部命令：

```bash
# 保存并退出 pixi.toml 后
pixi install

# ROS humble
pixi shell -e humble
# ROS jazzy（本教程）
pixi shell -e jazzy
# ROS kilted
pixi shell -e kilted
# ROS lyrical
pixi shell -e lyrical
# ROS rolling
pixi shell -e rolling
```

也可在项目目录外执行，追加 `--manifest-path` 指向项目目录。

### 6.4 构建任务与平台差异

配置里定义了 `build` task，用 `pixi run -e <ros distro> build` 调用，后面可跟临时参数。

| 平台    | 构建方式                         | 说明                                |
| ------- | -------------------------------- | ----------------------------------- |
| Windows | `colcon build --merge-install`   | 符号链接受限，合并安装到 `install/` |
| Unix    | `colcon build --symlink-install` | 改 Python / launch 文件免重编       |

两者都带三个 CMake 参数：

- `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`：生成 `compile_commands.json`，供 VS Code 的 C++ IntelliSense 使用；
- `-DPython_FIND_VIRTUALENV=ONLY` 与 `-DPython3_FIND_VIRTUALENV=ONLY`：强制 CMake 只用当前 Pixi 环境的 Python，
  避免误连系统 Python。

## 7. VS Code 集成

### 7.1 安装扩展

| 扩展                                 | ID                              | 用途                                                               |
| ------------------------------------ | ------------------------------- | ------------------------------------------------------------------ |
| Robot Developer Extensions for ROS 2 | `Ranch-Hand-Robotics.rde-ros-2` | 自动配置 ROS 环境、colcon 任务、topic 监视、launch 调试，支持 Pixi |
| C/C++                                | `ms-vscode.cpptools`            | C++ IntelliSense 与调试                                            |
| Python                               | `ms-python.python`              | Python 节点                                                        |
| CMake Tools                          | `ms-vscode.cmake-tools`         | CMake 工程与构建                                                   |

> 图片没必要展示了。

微软的 `ms-iot.vscode-ros` 已标记废弃，不要再按旧教程安装。原维护者已将其拆分重发，
其中 ROS 2 版原生支持 Pixi，另提供 URDF 编辑器等配套扩展。

### 7.2 挂载构建任务

把第 6 节的 `build` task 挂到 `Ctrl+Shift+B`，在 `.vscode/tasks.json` 中写：

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "colcon build (jazzy)",
      "type": "shell",
      "command": "pixi run -e jazzy build",
      "group": { "kind": "build", "isDefault": true },
      "problemMatcher": []
    }
  ]
}
```

单发行版工作区（第 3–5 节）没有 `build` task，把 `command` 换成 `pixi run colcon build` 即可。

### 7.3 C++ IntelliSense

头文件飘红（找不到 `rclcpp/rclcpp.hpp`）是 ROS 工程最常见的问题，按优先级处理：

- `rde-ros-2` 在打开含 `package.xml` 的工作区时会自动补齐 ROS 的 C++ include 与 Python import 路径，优先用它；
- 若仍需手动指定，把 `.vscode/c_cpp_properties.json` 的 `compileCommands` 指向 `colcon build`
  生成的 `compile_commands.json`。该数据库位于各包自己的 `build/<package>/` 目录下，
  多包工程需按实际路径分别配置或合并，不要直接填 `build/` 根目录。

### 7.4 从已激活环境启动 VS Code

扩展要继承 `AMENT_PREFIX_PATH` 等变量，最稳妥的做法是先激活，再从同一终端启动编辑器。先执行：

```powershell
cd ros_ws
pixi shell -e jazzy
```

`pixi shell` 会打开一个已激活环境的新 shell，在该 shell 中再执行：

```powershell
code .
```

## 8. 常用命令速查

| 命令                              | 作用                                |
| --------------------------------- | ----------------------------------- |
| `pixi init <dir> --channel <url>` | 初始化工作区并指定 RoboStack 频道   |
| `pixi add <pkg>`                  | 写依赖、安装、更新 lockfile         |
| `pixi run <cmd>`                  | 激活环境后执行单条命令              |
| `pixi shell`                      | 打开已激活环境的 shell              |
| `pixi shell -e <distro>`          | 进入指定发行版环境                  |
| `pixi run -e <distro> build`      | 调用多发行版配置中的构建任务        |
| `pixi install`                    | 按 `pixi.lock` 安装全部 environment |
| `pixi update`                     | 在版本约束内更新依赖并刷新 lockfile |
| `pixi workspace platform add/rm`  | 增删工作区目标平台                  |
| `colcon build`                    | 构建工作区内所有包                  |
| `ros2 pkg create` / `ros2 run`    | 建包 / 运行节点                     |

### 8.1 版本控制

提交 `pixi.toml` 与 `pixi.lock`，二者共同保证团队与 CI 复现同一套依赖。忽略以下目录：

```text
.pixi/
build/
install/
log/
```

它们分别是 Pixi 的环境缓存，以及 `colcon` 的构建、安装与日志产物，均可由配置重建。

## 9. 常见问题

| 级别 | 现象                                   | 原因                                                     | 处理                                                                      |
| ---- | -------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------- |
| 高   | `ros2` / `python` 指向系统版本         | 终端 `source` 过 `apt` ROS 的 setup，`PYTHONPATH` 被覆盖 | 新开终端，不 source 系统 ROS；统一用 `pixi run` 调用                      |
| 高   | Windows 下 `colcon build` 找不到编译器 | 缺 Visual Studio 2022 的 C++ 工作负载                    | 按 2.1 节装好后改用 VS 2022 的 Developer Command Prompt 重试，以加载 MSVC 环境变量 |
| 中   | macOS 装的 ROS 包版本偏旧、功能缺失    | 未声明 macOS 14，Pixi 按 13 解析                         | 按 3.2 节补平台声明，重新 `pixi install`                                  |
| 中   | Windows 上符号链接构建失败             | 用了 `--symlink-install`，权限/开发者模式受限            | 改用官方 Windows task 的 `--merge-install`                                |
| 中   | VS Code 头文件飘红                     | 编辑器未继承 ROS 环境变量，或缺编译数据库                | 按 7.4 从 `pixi shell` 启动，再按 7.3 配置 IntelliSense                   |
| 低   | 激活时报 `install/setup.bat` 不存在    | 首次 `colcon build` 之前该文件尚未生成                   | 先构建一次；或暂时移除 activation 段                                      |
| 低   | `pixi update` 后行为变化               | 约束上界按下一个主版本放开，装入了新版包                 | 用 `pixi.lock` 回滚，或在 `pixi.toml` 中收紧版本                          |

## 参考资料

- [RoboStack Getting Started](https://robostack.github.io/GettingStarted.html)
- [RoboStack 首页](https://robostack.github.io/)
- [Pixi Installation](https://pixi.prefix.dev/latest/installation/)
- [Robot Developer Extensions for ROS 2](https://ranchhandrobotics.com/rde-ros-2/)

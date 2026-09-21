#import "lib/lib.typ": *

#show: touying-quick.with(
  title: "编程环境",
  subtitle: "从解释器到终端，一次装好",
  info: info-skill,
  bgimg: bghexagon,
)

// 模块一 · Python 环境

= Python 环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  你在自己电脑上装过几个 Python？\
  \
  它们现在还住在 *同一个目录* 里吗？
]

== 包管理器怎么选

#align(center + horizon)[
  #set text(size: 11pt)
  #let data = csv("data/env-pkgman.csv")
  #figure(
    tableq(data, 4),
    caption: "Python 包管理器对比",
  )
  #v(0.4em)
  #set text(size: 14pt)
  *一句话：科学计算与多语言场景交给 mamba，纯 Python 项目交给 uv，两者在同一台机器上可以并存。*
]

== conda 与它的四个发行版

#block(height: 17em)[
  #set text(size: 14pt)

  Conda 是服务于 Python 和 R 的多语言包管理器，它解决了 pip 的依赖冲突问题；Mamba 则是 Conda 的 C++ 重写版，默认并行下载，速度更上一个台阶。Anaconda 由 Peter Wang 和 Travis Oliphant 于 2012 年创立，旨在把 Python 带进商业数据分析领域，其社区版把 conda 与数百个数据科学包打包在一起。

  #v(0.3em)

  #let data = csv("data/env-conda.csv")
  #figure(
    tableq(data, 4),
    caption: "conda 系发行版",
  )

  #v(0.2em)
  *推荐 Miniforge*：自带 mamba、只含环境管理功能、不夹带任何数据科学包，装完就是一个干净的工作台。
]

== 安装 Mamba

#block(height: 18em, columns()[
  #set text(size: 15pt)

  *① 包管理器安装*（能翻墙时首选）

  ```powershell
  winget install Mamba.Micromamba
  ```

  或走 Scoop

  ```powershell
  scoop bucket add main-plus https://github.com/Scoopforge/Main-Plus
  scoop install micromamba
  ```

  micromamba 只装出 *一个可执行文件*，不写注册表，也不需要管理员权限，但它与 conda 生态的命令并不完全同名，所以要在 `$PROFILE` 里补一个函数给它改回名字。

  #colbreak()

  *② 手动安装*（不能翻墙时走这条）

  下载 #link("https://mirrors.ustc.edu.cn/github-release/conda-forge/miniforge/LatestRelease/Miniforge3-Windows-x86_64.exe")[Miniforge 安装包]，一路向下，不要做任何改动，直至安装完成。

  *③ 让命令叫回 mamba*

  ```powershell
  code $PROFILE
  ```

  ```powershell
  function mamba { micromamba $args }
  ```

  #tip[ 装完记得 *新开* 一个终端，旧终端不会重新加载 PATH。 ]
])

== 配置 .condarc

#block(height: 18em, columns()[
  #set text(size: 15pt)

  mamba 的配置文件叫 `.condarc`，Windows 下位于 `~\.condarc`，macOS 与 Linux 下位于 `~/.condarc`。

  先用 VS Code 把它打开

  ```shell
  code .condarc
  ```

  再写入右栏内容——前三段决定 *从哪儿下载*，后面几行决定 *怎么下载*。

  #colbreak()

  ```yaml
  # 频道
  channels:
    - conda-forge
  # 使用镜像
  custom_channels:
    conda-forge: https://mirrors.ustc.edu.cn/anaconda/cloud

  # 地址
  envs_dirs:
    - ~/.conda/envs
  pkgs_dirs:
    - ~/.conda/pkgs

  # 将 pip 作为 Python 的依赖
  add_pip_as_python_dependency: true
  # 安装按照频道的顺序
  channel_priority: flexible
  # 显示频道具体链接
  show_channel_urls: true
  # 错误回滚
  rollback_enabled: true
  ```
])

== Mamba 常用操作

#block(height: 18em, columns()[
  #set text(size: 15pt)

  *环境：一间自己的屋子*

  ```shell
  # 创建，指定名字与 Python 版本
  mamba create -n my_python python=3.12
  # 进入与退出
  mamba activate my_python
  mamba deactivate
  # 列出与删除
  mamba env list
  mamba env remove -n my_python
  ```

  环境可以简单理解为系统登录时的用户，同一台机器上的两套环境互不干扰。

  #colbreak()

  *包：屋子里的家具*

  ```shell
  # 安装与删除
  mamba install numpy
  mamba uninstall numpy
  # 更新
  mamba update numpy
  mamba update --all
  # 检索与已装列表
  mamba search numpy
  mamba list
  ```

  #tip[ 要让 VS Code 的 `.ipynb` 认出这个环境，得在环境里补装 `ipykernel`。 ]
])

== uv：新一代包管理器

#block(height: 18em, columns()[
  #set text(size: 15pt)

  uv 由 Astral 公司用 Rust 写成，把 pip、pipx、virtualenv、poetry 四套工具的职责合并成一条命令，依赖求解走全局算法，装包速度通常快出一到两个数量级。

  它只声明一件事：这个项目 *依赖什么*，剩下的事务——建环境、锁版本、跑脚本——全部由 uv 代劳。

  ```powershell
  winget install astral-sh.uv
  ```

  #colbreak()

  *一个项目的完整生命周期*

  ```shell
  # 初始化，生成 pyproject.toml
  uv init
  # 按 pyproject.toml 建环境并锁定
  uv sync
  # 添加与删除依赖
  uv add numpy
  uv remove numpy
  # 在环境里执行
  uv run python main.py
  ```

  #tip[ `uv.lock` 是 *可复现* 的关键——把它一起提交，换台机器 `uv sync` 就能还原出一模一样的环境。 ]
])

== 配置 VS Code

#block(height: 18em, columns()[
  #set text(size: 15pt)

  *安装扩展*

  - Python (Microsoft)
  - Pyrefly (Meta)
  - Ruff (Astral Software)
  - Jupyter (Microsoft)

  扩展装完，新建一个 `.ipynb` 文件，即可开启 Python 之旅。

  #colbreak()

  *配置扩展*

  用 `Ctrl + ,` 打开设置，右上角图标切到 `settings.json`，写入

  ```json
  {
    "[python]": {
      "editor.defaultFormatter": "charliermarsh.ruff",
      "editor.codeActionsOnSave": {
        "source.fixAll": "explicit",
        "source.organizeImports": "explicit"
      }
    },
    "ruff.configuration": "pyproject.toml"
  }
  ```
])

// 模块二 · C/C++ 环境

= C/C++ 环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  在 Windows 上编译一段 C++，\
  \
  你缺的是 *编辑器*，还是 *编译器*？
]

== 工具链：MSYS2

#block(height: 18em, columns()[
  #set text(size: 15pt)

  工具链是整个编程环境的核心。在 macOS 与 Linux 上，系统内置了 C 运行时与库文件，Windows 上则要自己补上这一块，于是我们选择微软官方推荐的 MSYS2，它同时提供了三个不同 ABI 的环境，其中 *UCRT64* 与系统自带的通用 C 运行时一致，是当下的首选。

  ```powershell
  scoop bucket add extras-cn https://github.com/scoopforge/Extras-CN
  scoop install msys2-cn
  ```

  #colbreak()

  也可以手动安装，下载 #link("https://mirrors.ustc.edu.cn/msys2/distrib/msys2-x86_64-latest.exe")[MSYS2 安装包]，默认一路向下，直至完成。

  *同一个 MSYS2，三个环境*

  #tableq(
    (
      ([终端], [运行时], [定位]),
      ([UCRT64], [系统自带 UCRT], [首选]),
      ([MINGW64], [MSVCRT], [兼容旧库]),
      ([CLANG64], [UCRT + LLVM], [尝新]),
    ),
    3,
  )

  #tip[ 本教程统一使用 *UCRT64*，它的 C 运行时与系统内置的一致，跨工具链混用时的坑最少。 ]
])

== 配置 pacman 与 UCRT64

#block(height: 18em, columns()[
  #set text(size: 15pt)

  *① 换成国内源*

  进入 MSYS2 的 UCRT64 终端，把官方镜像换成中科大镜像

  ```shell
  sed -i "s#https\?://mirror.msys2.org/#https://mirrors.ustc.edu.cn/msys2/#g" /etc/pacman.d/mirrorlist*
  ```

  *② 安装 UCRT 工具链*

  ```shell
  pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
  ```

  #colbreak()

  *③ 把编译器交给系统*

  接受默认配置一路向下，然后把 MSYS2 安装路径下的 `ucrt64\bin` 加进环境变量 `PATH`。

  *④ 重启终端后逐条验证*

  ```powershell
  gcc --version
  g++ --version
  gdb --version
  ```

  #warning[ 若 pacman 报「无法提交处理（有冲突的文件）」，用 `pacman -S --overwrite="*" [package]` 覆盖后重试。 ]
])

== 安装第三方库

#block(height: 17em, columns()[
  #set text(size: 15pt)

  MSYS2 的包管理器和 Python 的 conda 一样，把编译好的库与头文件一起交付，不必自己下载源码编译。

  回到 UCRT64 终端，逐条执行

  ```shell
  pacman -S mingw-w64-ucrt-x86_64-cmake
  pacman -S mingw-w64-ucrt-x86_64-opencv
  pacman -S mingw-w64-ucrt-x86_64-qt6-base mingw-w64-ucrt-x86_64-qt6-declarative
  ```

  #colbreak()

  *库与包名一一对应*

  #tableq(
    (
      ([库], [pacman 包名]),
      ([CMake], [`mingw-w64-ucrt-x86_64-cmake`]),
      ([OpenCV], [`...-ucrt-x86_64-opencv`]),
      ([Qt6], [`...-ucrt-x86_64-qt6-base`]),
    ),
    2,
  )

  #tip[ 库的头文件在 `ucrt64\include`，链接库在 `ucrt64\lib`——后面写工程文件时会反复用到这两个路径。 ]
])

== VS Code 扩展

#block(height: 17em, columns()[
  #set text(size: 15pt)

  在扩展商店里搜索并安装 C/C++（下载量最多的那个），它提供补全、跳转与调试前端。

  装完用 `Ctrl + ,` 进入设置，切到 `settings.json` 写入右栏配置。

  #colbreak()

  ```json
  {
    "C_Cpp.autocompleteAddParentheses": true,
    "C_Cpp.default.cppStandard": "c++20",
    "C_Cpp.default.cStandard": "c17",
    "C_Cpp.default.mergeConfigurations": true
  }
  ```
])

== 工程文件：三份 JSON

#block(height: 18em, columns()[
  #set text(size: 15pt)

  在工作文件夹下新建 `.vscode` 目录，里面三份文件各管一段。

  #tableq(
    (
      ([文件], [管什么]),
      ([`c_cpp_properties.json`], [IntelliSense 去哪找头文件]),
      ([`launch.json`], [F5 时用哪个调试器]),
      ([`tasks.json`], [编译时敲哪条命令]),
    ),
    2,
  )

  下文中的 `{msys2根目录}` 通常为 `C:\msys64`，Scoop 用户则为 `%SCOOP%\apps\msys2\current`。

  #colbreak()

  ```json
  {
    "version": "2.0.0",
    "tasks": [
      {
        "type": "cppbuild",
        "label": "Build OpenCV5 on Windows",
        "command": "{msys2根目录}\\ucrt64\\bin\\g++.exe",
        "args": [
          "-fdiagnostics-color=always",
          "-g",
          "${file}",
          "-o",
          "${fileDirname}/${fileBasenameNoExtension}.exe",
          "-I",
          "{msys2根目录}\\ucrt64\\include",
          "-L",
          "{msys2根目录}\\ucrt64\\lib",
          "-lopencv_core",
          "-lopencv_imgcodecs",
          "-lopencv_imgproc",
        ],
        "problemMatcher": ["$gcc"],
        "group": "build"
      }
    ]
  }
  ```
])

== 一键编译与调试

#block(height: 18em, columns()[
  #set text(size: 15pt)

  `tasks.json` 定义编译动作，`launch.json` 定义调试会话，两者用一个任务名串起来。

  ```json
  {
    "name": "Debug OpenCV on Windows",
    "type": "cppdbg",
    "request": "launch",
    "targetArchitecture": "x86_64",
    "program": "${fileDirname}/${fileBasenameNoExtension}.exe",
    "cwd": "${fileDirname}",
    "MIMode": "gdb",
    "miDebuggerPath": "{msys2根目录}\\ucrt64\\bin\\gdb.exe",
    "preLaunchTask": "Build OpenCV5 on Windows"
  }
  ```

  #colbreak()

  *两个快捷键走完全程*

  - `Ctrl + Shift + B` 按 `tasks.json` 编译
  - `F5` 编译并按 `launch.json` 起调试器

  #tip[ `preLaunchTask` 的值必须与 `tasks.json` 里的 `label` *逐字一致*，否则 F5 只会报「找不到任务」。 ]

  想要图形化的构建与调试，也可以下载 #link("https://mirrors.ustc.edu.cn/qtproject/official_releases/qtcreator/latest/installer_source/", "Qt Creator")，在其中把同一套工具链再配一遍。
])

// 模块三 · 终端环境

= 终端环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  你一天要在终端里敲多少行命令？\
  \
  那这个终端 *顺不顺手*，重要吗？
]

== PowerShell 提示符：Starship

#block(height: 18em, columns()[
  #set text(size: 15pt)

  Starship 由 Rust 编写，是一款跨平台的命令行提示符，默认配置已经能报出版本控制、语言与运行时的状态，配置有独立的文件，不与 shell 本身耦合。

  ```powershell
  scoop install starship
  ```

  装完打开 PowerShell 的配置文件

  ```powershell
  code $PROFILE
  ```

  加入一行即可生效

  ```powershell
  Invoke-Expression (&starship init powershell)
  ```

  #colbreak()

  提示符里的图标需要一款带 Nerd Font 字形的等宽字体

  ```powershell
  scoop bucket add nerd-fonts
  scoop install FiraCode-NF
  ```

  #figure(
    image("vscode/images/starship.png", height: 55%),
    caption: none,
  )
])

== PSReadLine：让输入更顺手

#block(height: 18em, columns()[
  #set text(size: 15pt)

  PowerShell 自带的行编辑能力相当有限，PSReadLine 把补全、历史搜索、语法高亮这一整套补上。

  ```powershell
  scoop install psreadline
  ```

  #colbreak()

  打开 `code $PROFILE`，加入

  ```powershell
  Import-Module PSReadLine

  Set-PSReadlineKeyHandler -Key Tab -Function Complete
  Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function MenuComplete
  Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
  ```

  #tip[ 上下箭头变成 *按前缀搜索历史* 之后，同一条长命令不需要再敲第二遍。 ]
])

== Windows Terminal

#block(height: 18em, columns()[
  #set text(size: 15pt)

  Windows Terminal 是微软官方的终端模拟器，把 PowerShell、命令提示符、MSYS2 与 WSL 收进同一扇窗，支持标签、分屏与 GPU 渲染。

  ```powershell
  scoop install windows-terminal
  ```

  它把配置文件放在 `settings.json` 里，外观部分写在 `profiles.defaults` 中，对所有终端类型一并生效。

  #colbreak()

  ```json
  {
    "copyOnSelect": true,
    "centerOnLaunch": true,
    "launchMode": "maximized",
    "defaultInputScope": "alphanumericHalfWidth",
    "profiles": {
      "defaults": {
        "font": {
          "face": "FiraCode Nerd Font",
          "size": 16
        },
        "snapOnInput": true,
        "useAcrylic": true
      }
    }
  }
  ```
])

== 分屏与键位

#block(height: 18em, columns()[
  #set text(size: 15pt)

  *默认键位*

  #tableq(
    (
      ([按键], [动作]),
      ([`Ctrl + Shift + T`], [新建标签页]),
      ([`Ctrl + Tab`], [切换到下一个标签页]),
      ([`Alt + Shift + -`], [向下分屏]),
      ([`Alt + Shift + \`], [向右分屏]),
      ([`Alt + 方向键`], [在窗格间移动焦点]),
      ([`Alt + Shift + 方向键`], [调整窗格大小]),
      ([`Ctrl + Shift + W`], [关闭当前窗格]),
    ),
    2,
  )

  #colbreak()

  开终端的第一件事，是把它 *窗格化*：左边跑服务、右边看日志，或者上边写代码、下边敲命令，一屏之内同时看见输入与输出。

  #tip[ 分屏之后用 `Alt + 方向键` 换焦点、`Alt + Shift + 方向键` 调大小，比拖动鼠标精确得多。 ]

  #note[ 方向键那一行也管着标签页：`Alt + Shift + 方向键` 落在标签栏上时，是 *移动标签* 而非调整窗格。 ]
])

== 把终端放进右键菜单

#block(height: 19em)[
  #set text(size: 15pt)

  在注册表里挂三条命令，右键任意文件夹的背景，就能 *就地* 开一个终端：一条建菜单项，一条挂图标，一条写命令行。

  ```powershell
  $base = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell"
  $wt   = "C:\Scoop\apps\windows-terminal\current"

  sudo New-Item -Path "$base\wt" -Force `
    -Value "Windows Terminal here"

  sudo New-ItemProperty -Path "$base\wt" -Force `
    -Name Icon -PropertyType ExpandString `
    -Value "$wt\Images\LargeTile.scale-100.png"

  sudo New-Item -Path "$base\wt\command" -Force `
    -Type ExpandString `
    -Value "$wt\WindowsTerminal.exe -p PowerShell -d %V"
  ```

  #tip[ `%V` 是资源管理器传来的当前目录——把它换掉，菜单项就会开在别处；`sudo` 则负责把这几条写进 `HKEY_CLASSES_ROOT`。 ]
]

== 集成与别名

#block(height: 18em, columns()[
  #set text(size: 15pt)

  *让 VS Code 用上这个终端*

  在 `settings.json` 中加入

  ```json
  {
    "terminal.integrated.shell.windows": "C:/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe",
    "terminal.integrated.shellArgs.windows": [
      "-ExecutionPolicy", "Bypass", "-NoLogo", "-NoExit"
    ]
  }
  ```

  #colbreak()

  *给常用命令起短名字*

  ```powershell
  function sls {scoop list}
  function sud {scoop update}
  function suda {scoop update *}
  function scl {scoop cleanup *}
  function sst {scoop status}
  ```

  别名的价值不在省下几个字符，而在于 *把「我总忘的那条长命令」固定成一个词*——写进 `$PROFILE`，它就跟着你换机器、换系统。

  #figure(
    image("vscode/images/vscode-settings.png", height: 32%),
    caption: none,
  )
])

// 小结

= 小结

== 三条命令之后

#block(height: 18em, columns()[
  #set text(size: 15pt)

  *一个包管理器*

  - 科学计算与多语言：`mamba`
  - 日常 Python 项目：`uv`
  - Windows 上的通用软件：`scoop` 与 `winget`

  *一条工具链*

  - 编译器与调试器：MSYS2 的 UCRT64
  - 构建与第三方库：`pacman` 一次装齐

  #colbreak()

  *一个终端*

  - 提示符：Starship
  - 行编辑：PSReadLine
  - 窗口：Windows Terminal

  这三件事的共同点是：它们都 *把配置写进了文件*，于是换一台机器时，你只需要带走几个点文件，而不需要重新回忆当初点过哪些「下一步」。
])

== 延伸阅读

- #link("https://github.com/HHSTU-IST/camp/blob/main/vscode/win-scoop.md")[搭建 Windows 统一开发环境]
- #link("https://github.com/HHSTU-IST/camp/blob/main/vscode/prog-python.md")[搭建 Python 轻量级编程环境]
- #link("https://github.com/HHSTU-IST/camp/blob/main/vscode/prog-cpp.md")[搭建 C/C++ 轻量级编程环境]
- #link("https://github.com/HHSTU-IST/camp/blob/main/vscode/tool-terminal.md")[逐步搭建现代大一统终端]
- #link("https://github.com/HHSTU-IST/camp/blob/main/vscode/win-posh.md")[打造 Windows 优雅终端]

#tip[ 本页对应的文本教程与课件同源，命令若有出入，以文本教程为准。 ]

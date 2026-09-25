#import "lib/lib.typ": *
#show: touying-quick.with(
  title: "编程环境",
  subtitle: "从终端到编辑器，构建高效开发流程",
  info: info-skill,
  bgimg: bghexagon,
)

= 终端环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  你一天要在终端里敲多少行命令？\
  \
  那这个终端*顺不顺手*，重要吗？
]

== 提示符：Starship

#columns()[
  #set text(size: 16pt)

  Starship 由 Rust 编写，是一款跨平台的命令行提示符，默认配置已经能报出版本控制、语言与运行时的状态，配置有独立的文件，不与 shell 本身耦合。

  ```sh
  scoop install starship
  ```

  装完打开 PowerShell 的配置文件

  ```sh
  code $PROFILE
  ```

  加入一行即可生效

  ```sh
  Invoke-Expression (&starship init powershell)
  ```

  同理，对 macOS 有

  ```bash
  brew install starship
  ```

  打开`~/.zshrc`，添加：

  ```bash
  eval "$(starship init zsh)"
  ```

  #colbreak()

  提示符里的图标需要一款带 Nerd Font 字形的等宽字体

  ```sh
  scoop bucket add nerd-fonts
  scoop install FiraCode-NF
  ```

  #figure(
    image("vscode/images/starship.png", width: 100%),
    caption: none,
  )

  详情参考 #link("https://starship.rs/")[Starship 官网]
]

== 扩展：让输入更顺手

#columns()[
  #set text(size: 17pt)
  PowerShell 自带的行编辑能力相当有限，PSReadLine 把补全、历史搜索、语法高亮这一整套补上。

  ```sh
  scoop install psreadline
  ```

  打开 `code $PROFILE`，加入

  #[
    #set text(size: 13pt)

    ```sh
    Import-Module PSReadLine

    Set-PSReadlineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    ```
  ]

  #[
    #set text(size: 14pt)
    #tip[
      上下箭头变成*按前缀搜索历史* 之后，同一条长命令不需要再敲第二遍。
    ]
  ]

  #colbreak()

  Zsh 有很好的扩展性，这里推荐 3 个最常用的扩展

  - zsh-autosuggestions（补全提示）
  - zsh-syntax-highlighting（高亮）
  - zsh-completions（补全）

  安装扩展

  ```bash
  brew install zsh-autosuggestions zsh-syntax-highlighting zsh-completions
  ```

  在 `~/.zshrc` 中添加：

  #[
    #set text(size: 14pt)

    ```bash
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    autoload -Uz compinit && compinit
    ```
  ]
]

== 别名

#columns()[

  PowerShell 中，function 关键字用于封装函数，配合`$args`也可以定义别名。

  ```sh
  function .. { cd .. }
  function ... { cd ../.. }
  function cat { bat $args }
  function ls { lsd $args }
  function ll { lsd -l $args }
  function la { lsd -a $args }
  function lla { lsd -la $args }
  function e { echo $args }
  function rr { rm -rf $args }
  function c { clear }
  ```

  #colbreak()

  Linux/Unix 中，alias 关键字/命令用来给命令、函数、类型或字段定义别名。

  ```bash
  alias ..="cd .."
  alias ...="cd ../.."
  alias cat="bat"
  alias ls="lsd"
  alias ll="ls -l"
  alias la="ls -a"
  alias lla="ls -la"
  alias e="echo"
  alias rr="rm -r"
  alias c="clear"
  ```
]

== Windows Terminal 基本配置

#[
  #set text(size: 18pt)

  Windows Terminal 是微软官方的终端模拟器，把 PowerShell、命令提示符、MSYS2 与 WSL 收进同一扇窗，支持标签、分屏与 GPU 渲染。

  ```sh
  scoop install windows-terminal
  ```

  它把配置文件放在 `settings.json` 里，外观部分写在 `profiles.defaults` 中，对所有终端类型一并生效。
]

#columns()[
  #set text(size: 13.5pt)

  ```json
  {
    "alwaysOnTop": false,
    "alwaysShowNotificationIcon": false,
    "centerOnLaunch": true,
    "copyOnSelect": true,
    "defaultInputScope": "alphanumericHalfWidth",
    "firstWindowPreference": "persistedWindowLayout",
    "launchMode": "maximized",
    "newTabMenu": [
        {
            "type": "remainingProfiles"
        }
    ],
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
]

== Windows Terminal 键位

#columns()[
  #set text(size: 18pt)

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

  分屏之后用 `Alt + 方向键` 换焦点、`Alt + Shift + 方向键` 调大小，比拖动鼠标精确得多。

  #colbreak()

  #[
    #set text(size: 14pt)

    ```json
    {
      "keybindings": [
                {
            "id": "Terminal.NextTab",
            "keys": "alt+tab"
        },
        {
            "id": "Terminal.PrevTab",
            "keys": "alt+shift+tab"
        },
        {
            "id": "Terminal.MoveFocusDown",
            "keys": "alt+down"
        },
        ...
    }
    ```
  ]
]

= Markdown 环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  你用 Markdown 写过多少份学习笔记 ？\
  \
  其中有多少次，是*在不同程序之间来回切*着写完的？
]

== 为什么在编辑器里写

#columns()[
  #set text(size: 17pt)

  相比于常见的 Markdown 应用，VS Code 的起点是一台代码编辑器，写起文档有三处占优

  - 集成的布局：大纲与工作区弹性布局，通过拖拽自定义
  - 强大的补全：LaTeX 公式、链接、图片路径都能自动补全
  - 丰富的扩展：不用切换应用，就能同时完成编程和写作

  \

  这三样恰好覆盖「写得快」「写得对」「交得出去」。


  #colbreak()

  VS Code 内置 Markdown 支持，还缺三件事：写得快、查得严、看得见效果。

  - *Markdown All in One* 是个大一统：快捷命令、自动编号、目录更新、公式补全都在里面
  - *rumdl* 管规范：既查语法也做格式化，保存时一并收齐
  - *Markdown Inline Editor* 管观感：像 Typora 一样边写边渲染，分屏省掉了
]

#[
  #set text(size: 14pt)
  #tip[
    挑扩展的通用判据就是看它有没有一个 *别人不做的* 职责。
  ]
]

== 扩展配置

#columns()[
  #set text(size: 18pt)

  在 `settings.json`里补上这一段。

  #[
    #set text(size: 12pt)

    ```json
    {
      "[markdown]": {
        "editor.defaultFormatter": "yzhang.markdown-all-in-one",
        "editor.codeActionsOnSave": {
          "source.fixAll.rumdl": "explicit"
        },
        "editor.quickSuggestions": {
          "other": "on",
          "comments": "off",
          "strings": "off"
        }
      },
      "markdown.extension.toc.levels": "2..4",
      "markdown.updateLinksOnFileMove.enabled": "always",
      "markdown.validate.enabled": true,
      "markdown.preview.fontSize": 16,
      "markdown.preview.openMarkdownLinks": "inEditor",
      "rumdl.fixOnSave": true
    }
    ```
  ]

  #colbreak()

  - `[markdown]` 一节管的是保存那一刻：All in One 负责排版，rumdl 负责查错与修错
  - `toc.levels` 取 `2..4`：目录只收二级到四级标题，一级标题自己当封面
  - `updateLinksOnFileMove` 取 `always`：文件改名或挪目录，指向它的链接自动跟着改
  - `preview.openMarkdownLinks` 取 `inEditor`：预览里点链接原地跳转，不另开窗口
  - `rumdl.fixOnSave`：格式问题在保存时顺手修掉，不必等 CI 来报
]

== 编辑扩展：Draw.io

#columns()[
  #set text(size: 18pt)

  mermaid 能画流程图，却画不了任意形状的示意图，这时用 draw.io 的内嵌扩展。

  在 VS Code 里新建 `.drawio` 文件，绘图界面就在编辑器里打开，画完导出 PNG 或 SVG。

  #colbreak()

  #figure(
    image("vscode/images/vscode-drawio.png", height: 50%),
    caption: none,
  )
]

#[
  #set text(size: 16pt)
  #note[
    `.drawio` 本质是一份文本，与 `.md` 一样进版本库，于是改图的过程也能被 git 记下来。 ]
]

== 输出扩展：Pandoc

#columns()[
  #set text(size: 18pt)

  Pandoc 是文档格式领域的瑞士军刀，从 Markdown 出发，几乎能得到所有常见文本格式。

  对 Windows 用户

  ```sh
  scoop install pandoc
  ```

  对 macOS/Linux 用户

  ```sh
  brew install pandoc
  ```

  对复杂格式，还需安装 LaTeX 引擎，使用

  ```sh
  scoop install miktex
  ```

  或

  ```sh
  brew install basictex
  ```

  #colbreak()

  #[
    #set text(size: 16pt)

    ```json
    {
      "pandoc.pdfOptString": "-f gfm --pdf-engine=xelatex -V colorlinks -V urlcolor=NavyBlue --syntax-highlighting tango -V geometry:a4paper -V geometry:margin=2.5cm -V CJKmainfont=\"STFangsong\" -V monofont=\"FiraCode Nerd Font\"",
      "pandoc.htmlOptString": "-f gfm --standalone --mathjax --shift-heading-level-by=-1"
    }
    ```
  ]

  #[
    #set text(size: 12pt)
    #note[
      `CJKmainfont` 与 `monofont` 是中文导出的两处必填项，缺一个可能就是满纸空白。
    ]
  ]
]



== 控制台实用命令

#[
  #set text(size: 18pt)
  通过 `Ctrl + Shift + P` 打开命令面板，输入 `markdown` 就能看到一堆 Markdown 相关的命令。最常用的有

  - Markdown All in One: Add/Update section numbers
  - Markdown All in One: Remove section numbers
  - Markdown All in One: Create Table of Contents
  - Markdown All in One: Update Table of Contents
  - Draw.io: Convert Mermaid to Draw.io
  - Draw.io: Convert To...
  - Pandoc Render
]

= Typst 环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  Markdown 管得住*文档的结构*，\
  却管不住*公式与版式*。\
  \
  补上这一块，要换会 Word 吗？
]

== 为什么用 Typst

#columns()[
  #set text(size: 18pt)

  上一节的 Markdown 换来了统一的写法，代价是表达力封顶

  - 公式要外挂 LaTeX 语法，渲染还得看引擎脸色
  - 分页、页眉、编号这些版式需求，Markdown 里没有对应物
  - 导出要交给 pandoc 转一手，转完还得自己校版

  #colbreak()

  Typst 用 Rust 写成，是当下 LaTeX 最有力的竞争者

  - 语法接近 Markdown，编译却只要毫秒级
  - 数学、参考文献、图表编号都内建，不必拼装宏包
  - 编译产物是单个 PDF，源码与数据一样能进版本库
]

#[
  #set text(size: 16pt)
  #tip[
    两者不是替代关系：说明文档交给 Markdown，课件、手册和论文交给 Typst。
  ]
]

== 安装

#columns()[
  #set text(size: 18pt)

  === 编译器

  typst 只有 *一个可执行文件*，不必装运行时。

  对 Windows 用户：

  ```sh
  scoop install typst
  ```

  对 macOS/Linux 用户：

  ```sh
  brew install typst
  ```

  === 格式化器

  仿照编译器安装，将其中的 `typst` 替换为 `typstyle`。

  #colbreak()

  === VS Code 扩展

  VS Code 侧的入口只有一个扩展：*Tinymist*（Tiny + LSP）。

  它把编译器包成语言服务器，于是编辑器里能拿到

  - 补全、悬停文档与定义跳转
  - 实时预览与保存时自动导出 PDF
  - 语法检查与格式化

  #[
    #set text(size: 14pt)
    #tip[
      typstyle 是独立的一个可执行程序，Tinymist 自己去找它，装在哪儿由包管理器决定。
    ]
  ]
]

== 扩展配置

#columns()[
  #set text(size: 18pt)

  装完扩展，`settings.json` 里补上这一段。

  ```json
  {
    "[typst]": {
      "editor.defaultFormatter": "myriad-dreamin.tinymist"
    },
    "tinymist.exportPdf": "onDocumentHasTitle",
    "tinymist.formatterMode": "typstyle",
    "tinymist.lint.enabled": true,
    "tinymist.outputPath": "$root/articles/$name"
  }
  ```

  #colbreak()

  - `[typst]` 与 `formatterMode` 是同一件事的两半：排版交给外部的 typstyle，调用它的是 Tinymist
  - `triggerOnSnippetPlaceholders`：补全里的占位符直接用 Tab 跳，不必先退出补全
  - `exportPdf` 取 `onDocumentHasTitle`：只有带标题的文档才导出，零散片段不生成 PDF
  - `lint.enabled` 常开检查，`outputPath` 把导出物收进源码旁的 `articles/`，不与 `.typ` 混放
]

== 辅助扩展：Unicode 与 Emoji

#columns()[
  #set text(size: 18pt)

  Typst 的公式写法比 LaTeX 短，可符号表仍要记。

  *Unicode Math Input* 让你照 LaTeX 的习惯敲，边敲边在候选里挑

  - 敲 `\delta`，从候选里挑出 δ
  - Emoji 同理，敲 `\:` 触发转义输入

  #colbreak()

  #figure(
    image("vscode/images/vscode-unicode.png", width: 100%),
    caption: none,
  )
]

= Python 环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  你在自己电脑上装过几个 Python？\
  \
  它们现在还住在*同一个目录*里吗？
]

== 包管理器怎么选

#align(center + horizon)[
  #set text(size: 18pt)
  #let data = csv("data/env-pkg-py.csv")
  #figure(
    tableq(data, 4),
    caption: "Python 包管理器对比",
  )
]

#[
  #set text(size: 16pt)
  *一句话：科学计算与多语言场景交给 conda/mamba，纯 Python 项目交给 uv，两者在同一台机器上可以并存。*
]

== conda 与它的四个发行版

// #set text(size: 18pt)
Conda 是服务于 Python 和 R 的多语言包管理器，它解决了 pip 的依赖冲突问题；Mamba 则是 Conda 的 C++ 重写版，默认并行下载，速度更上一个台阶。Anaconda 由 Peter Wang 和 Travis Oliphant 于 2012 年创立，旨在把 Python 带进商业数据分析领域。

#let data = csv("data/env-pkg-conda.csv")
#figure(
  tableq(data, 4),
  caption: "conda 系发行版",
)

== 安装 Mamba

#columns()[
  #set text(size: 18pt)

  === 包管理器安装
  micromamba 只有 *一个可执行文件*，不写注册表。

  对 Windows 用户：

  ```sh
  scoop bucket add main-plus https://github.com/Scoopforge/Main-Plus
  scoop install micromamba
  ```

  对 macOS/Linux 用户：

  ```sh
  brew install micromamba
  ```

  === 初始化

  装完需要初始化，让终端自动加载

  ```sh
  micromamba shell init --shell {shell}
  ```

  === 让命令叫回 mamba

  ```sh
  code $PROFILE
  ```

  写入

  ```sh
  function mamba { micromamba $args }
  ```

  或

  ```sh
  alias mamba='micromamba'
  ```

  最后 *新开* 一个终端，旧终端不会重新加载 PATH。

  #[
    #set text(size: 14pt)
    #note[
      为方便起见，以下将 `micromamba` 简称为 `mamba`。
    ]
  ]
]


== 配置 .condarc

#columns()[
  // #set text(size: 18pt)

  conda/mamba 的配置文件为`~\.condarc`，其中`~`表示用户家目录。

  用 VS Code 把它打开

  ```bash
  code .condarc
  ```

  再写入如下内容

  ```yaml
  # 频道
  channels:
    - conda-forge
  # 使用镜像
  custom_channels:
    conda-forge: https://mirrors.ustc.edu.cn/anaconda/cloud
  ```

  #colbreak()

  其他相对重要的配置选项还有

  ```yaml
  # 地址
  envs_dirs:
    - ~/.conda/envs
  pkgs_dirs:
    - ~/.conda/pkgs

  # network
  remote_max_retries: 1
  ssl_verify: true
  # solver
  auto_update_conda: true
  channel_priority: strict
  ```
]

== Mamba 常用操作

#columns()[
  // #set text(size: 18pt)

  *环境：一间自己的屋子*

  ```bash
  # 创建，指定名字与 Python 版本
  mamba create -n {env_name} python=3.14
  # 进入与退出
  mamba activate {env_name}
  mamba deactivate
  # 列出与删除
  mamba env list
  mamba env remove -n {env_name}
  ```

  #colbreak()

  *包：屋子里的家具*

  ```bash
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
]

#[
  // #set text(size: 18pt)
  环境可以简单理解为系统登录时的用户，同一台机器上的两套环境互不干扰。
]

== uv：新一代包管理器

#columns()[
  #set text(size: 18pt)

  uv 由 Astral 公司用 Rust 写成，把 pip、pipx、virtualenv、poetry 四套工具的职责合并成一条命令，依赖求解走全局算法，装包速度通常快出一到两个数量级。

  ```sh
  scoop install uv
  ```

  或

  ```sh
  brew install uv
  ```

  #[
    #set text(size: 16pt)
    #tip[
      Astral 公司还出品了 ruff 和 ty，前者是 Python 最流行的格式化器和检查器，后者是 Python 最快的类型检查器。
    ]
  ]

  #colbreak()

  === 一个项目的完整生命周期

  pyproject.toml 只声明一件事：这个项目 *依赖什么*，剩下的事务，如建环境、锁版本、跑脚本全部由 uv 代劳。

  ```bash
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


]

== 配置 VS Code

#columns()[
  #set text(size: 18pt)

  *安装扩展*

  - Python (Microsoft)
  - Ruff (Astral Software)
  - ty (Astral Software)
  - Jupyter (Microsoft)
  \

  Jupyter 是数据科学的必备工具，提供交互式的编程环境，要让 VS Code 的 Jupyter 文件 `.ipynb` 认出这个环境，得在环境里补装 `ipykernel`。

  ```sh
  micromamba activate {env_name}
  micromamba install ipykernel
  ```

  #colbreak()

  *配置扩展*

  在 `settings.json`，写入

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
]

= C/C++ 环境

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  在 Windows 上编译一个 C++ 工程，\
  \
  你是否还在*手动*管理项目依赖各种库 ？
]

== 工具链：MSYS2

#columns()[
  #set text(size: 18pt)

  工具链是整个编程环境的核心。在 macOS 与 Linux 上，系统内置了 C 运行时与库文件，Windows 上则要自己补上这一块，于是我们选择*微软官方推荐*的 MSYS2，它同时提供了三个不同 ABI 的环境，其中 *UCRT64* 与系统自带的通用 C 运行时一致，是当下的首选。

  ```sh
  scoop bucket add extras-cn https://github.com/scoopforge/Extras-CN
  scoop install msys2-cn
  ```

  #tableq(
    (
      ([终端], [运行时], [定位]),
      ([UCRT64], [系统自带 UCRT], [首选]),
      ([MINGW64], [MSVCRT], [兼容旧库]),
      ([CLANG64], [UCRT + LLVM], [尝新]),
    ),
    3,
  )

  #colbreak()

  *① 换成国内源*

  进入 MSYS2 的 UCRT64 终端，把官方镜像换成中科大镜像

  ```bash
  sed -i "s#https\?://mirror.msys2.org/#https://mirrors.ustc.edu.cn/msys2/#g" /etc/pacman.d/mirrorlist*
  ```

  *② 安装 UCRT 工具链*

  ```bash
  pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
  ```

  *③ 重启终端后逐条验证*

  ```sh
  gcc --version
  g++ --version
  gdb --version
  ```
]

== 安装第三方库

#columns()[
  #set text(size: 18pt)

  MSYS2 的包管理器和 Python 的 conda 一样，把编译好的库与头文件一起交付，不必自己下载源码编译。

  回到 UCRT64 终端，逐条执行

  ```bash
  pacman -S mingw-w64-ucrt-x86_64-cmake
  pacman -S mingw-w64-ucrt-x86_64-opencv
  pacman -S mingw-w64-ucrt-x86_64-qt6-base mingw-w64-ucrt-x86_64-qt6-declarative
  ```

  #[
    #set text(size: 16pt)
    #warning[
      若 pacman 报「无法提交处理（有冲突的文件）」，用 `pacman -S --overwrite="*" [package]` 覆盖后重试。
    ]
  ]

  #colbreak()

  库的头文件在 `ucrt64\include`，链接库在 `ucrt64\lib`——后面写工程文件时会反复用到这两个路径。
]

== VS Code 扩展

#columns()[
  #set text(size: 18pt)

  在扩展商店里搜索并安装 C/C++（下载量最多的那个），它提供补全、跳转与调试前端。

  在 `settings.json` 写入如下配置。

  ```json
  {
    "C_Cpp.autocompleteAddParentheses": true,
    "C_Cpp.default.cppStandard": "c++20",
    "C_Cpp.default.cStandard": "c17",
    "C_Cpp.default.mergeConfigurations": true
  }
  ```

  #colbreak()

  在工作文件夹下新建 `.vscode` 目录，里面三份文件各管一段。

  #tableq(
    (
      ([文件], [管什么]),
      ([`c_cpp_properties.json`], [去哪找头文件]),
      ([`tasks.json`], [编译时敲哪条命令]),
      ([`launch.json`], [用哪个调试器]),
    ),
    2,
  )
]

== c_cpp_properties.json

#[
  #set text(size: 18pt)
  下文中，`{msys2_root}` 通常为 `C:\msys64`，Scoop 用户则为 `$env:SCOOP\apps\msys2\current`。
]

#columns()[
  #set text(size: 14.5pt)

  ```json
  {
      "configurations": [
          {
              "name": "win-opencv",
              "includePath": [
                  "${workspaceFolder}/**",
                  "{msys2_root}\\ucrt64\\include",
                  "{msys2_root}\\ucrt64\\include\\opencv5"
              ],
              "compilerPath": "{msys2_root}\\ucrt64\\bin\\g++.exe",
              "intelliSenseMode": "windows-gcc-x64"
          }
      ],
  }
  ```

  #colbreak()

  #set text(size: 16pt)

  *这份文件只管「看」*：补全、跳转与报错红线都以它为准，编译另由 `tasks.json` 负责。

  - `name`：配置名，显示在状态栏的选择器里
  - `includePath`：去哪找头文件；`${workspaceFolder}/**` 是工作区递归，`ucrt64\include` 收着标准库与第三方库，再往里的 `opencv5` 才是 OpenCV 的头
  - `compilerPath`：填上 g++ 之后，VS Code 直接问它系统头文件在哪，`includePath` 里的系统部分可以省
  - `intelliSenseMode`：解析模式，要与编译器 ABI 对上，`windows-gcc-x64` 即 Windows 上的 64 位 GCC
]

== tasks.json

#columns()[
  #set text(size: 12pt)

  ```json
  {
    "tasks": [
        {
          "type": "cppbuild",
          "label": "Build OpenCV5 on Windows",
          "command": "{msys2_root}\\ucrt64\\bin\\g++.exe",
          "args": [
              "-g",
              "${file}",
              "-o",
              "${fileDirname}/${fileBasenameNoExtension}.exe",
              "-I",
              "{msys2_root}\\ucrt64\\include",
              "-I",
              "{msys2_root}\\ucrt64\\include\\opencv5",
              "-L",
              "{msys2_root}\\ucrt64\\lib",
              "-lopencv_core",
              ...
            ],
        }
    ]
  }
  ```
  #colbreak()

  #set text(size: 15pt)

  `command` 与 `args` 拼起来，就是终端里的一条命令：

  ```bash
  g++ -g main.cpp -o main.exe \
      -I include -L lib -lopencv_core
  ```

  - `type`：取 `cppbuild`，说明任务由 C/C++ 扩展接管
  - `label`：任务名
  - `command`：真正执行的程序，这里是 g++
  - `-g`：把调试信息写进可执行文件，缺了 gdb 就断不进去
  - `${file}`：当前打开的源文件；`-o ${fileDirname}/${fileBasenameNoExtension}.exe` 让产物落在源文件旁，与它同名
  - `-I`/`-L`：头文件与库文件的搜索路径，分别指向 `ucrt64\include` 与 `ucrt64\lib`
  - `-l`：要链接的库，`-lopencv_core` 即 `libopencv_core.dll.a`
]

== launch.json

#columns()[
  #set text(size: 14pt)

  ```json
  {
    "configurations": [
        {
            "name": "Debug OpenCV on Windows",
            "type": "cppdbg",
            "request": "launch",
            "targetArchitecture": "x86_64",
            "program": "${fileDirname}/${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${fileDirname}",
            "MIMode": "gdb",
            "miDebuggerPath": "{msys2_root}\\ucrt64\\bin\\gdb.exe",
            "preLaunchTask": "Build OpenCV5 on Windows"
        }
    ]
  }
  ```

  #colbreak()


  #set text(size: 16pt)

  - `name`：调试配置名，出现在运行面板的下拉里
  - `type`：前端取 `cppdbg`（MSVC 是 `cppvsdbg`）
  - `request`：`launch` 由 VS Code 拉起程序，改成 `attach` 就变成挂到已运行的进程上
  - `program`：要调试的可执行文件，要与 `tasks.json` 里 `-o` 的输出一致
  - `args`：传给程序自己的命令行参数
  - `stopAtEntry`：取 `false` 不在 `main` 停
  - `cwd`：程序的运行目录，取 `${fileDirname}` 时读图读数据的相对路径才对得上
  - `MIMode`/`miDebuggerPath`：调试器类型与路径，gdb 走 MI 协议
  - `preLaunchTask`：按下调试前先跑的任务，值必须与 `tasks.json` 的 `label` *逐字一致*

]

= 小结

== 三条命令之后

#columns()[
  #set text(size: 18pt)

  *一个终端*

  - 提示符：Starship
  - 行编辑：PSReadLine
  - 窗口：Windows Terminal

  *一个编辑器*

  - 窗口：VS Code
  - 命令行：code
  - 通用扩展：Markdown 三件套、Draw.io、Pandoc
  - 排版：Typst 与 Tinymist

  #colbreak()

  *一个包管理器*

  - 科学计算与多语言：`micromamba`
  - 日常 Python 项目：`uv`
  - Windows 上的通用软件：`scoop` 与 `winget`

  *一条工具链*

  - 编译器与调试器：MSYS2 的 UCRT64
  - 构建与第三方库：`pacman` 一次装齐
]
\

#[
  #set text(size: 16pt)
  这 4 件事的共同点是：它们都 *把配置写进了文件*，于是换一台机器时，你只需要带走几个点文件，而不需要重新回忆当初点过哪些「下一步」。
]


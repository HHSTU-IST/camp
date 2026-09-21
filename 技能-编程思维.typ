#import "lib/lib.typ": *
#show: touying-quick.with(
  title: "编程思维",
  subtitle: "一次写清，处处复用",
  info: info-skill,
  bgimg: bghexagon,
)

// 无行号的浅灰代码盒，用于短命令片段，避免行号占去半栏宽度。
#let cbox(body) = block(
  fill: rgb("#F2F3F4"),
  stroke: rgb("#DBDBDB"),
  inset: (x: 1em, y: .5em),
  radius: 5pt,
  outset: -.3em,
  width: 100%,
  no-codly(body),
)

// 开场

= 编程思维

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  你用电脑很多年了。

  但真正说了算的是 *你*，还是 *机器*？
]

== 什么是「编程思维」

#columns()[
  #set text(size: 16pt)

  它不是「整天写代码」，而是一种习惯：

  - *描述*得足够精确，让机器可以照着做
  - 把每个决定 *落到文件里*，而不是留在脑子里
  - 凡是会让你做第二遍的事，就把它 *自动化*

  #colbreak()

  落到手上，就是四件事：

  - 工具链由 *一条命令* 装好，而不是点出来
  - 编辑器由 *配置文件* 决定行为
  - 每一次改动由 *Git* 留档
  - 笔记、文档与课件都是 *纯文本*

])

#note[ 这四件事的共同点：它们都留下了 *可以重新执行的记录*。 ]

== 今日路线图 · 四个模块

#block(height: 19em, align(center + horizon)[
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    column-gutter: 12pt,
    row-gutter: 10pt,
    block(
      fill: rgb("#EAF2FF"),
      stroke: rgb("#BFD7FF"),
      inset: 10pt,
      radius: 6pt,
      width: 100%,
    )[
      #align(center)[
        *🛠 模块一* \
        #set text(size: 12pt)
        WinGet / Scoop \
        系统软件 \
        一条命令装好
      ]
    ],
    block(
      fill: rgb("#EAFBEA"),
      stroke: rgb("#A8E6A8"),
      inset: 10pt,
      radius: 6pt,
      width: 100%,
    )[
      #align(center)[
        *🌳 模块二* \
        #set text(size: 12pt)
        Git \
        每一次改动 \
        都有出处
      ]
    ],
    block(
      fill: rgb("#FFF6E0"),
      stroke: rgb("#FFE08A"),
      inset: 10pt,
      radius: 6pt,
      width: 100%,
    )[
      #align(center)[
        *📝 模块三* \
        #set text(size: 12pt)
        Markdown \
        程序文档 \
        本身就是文本
      ]
    ],
    block(
      fill: rgb("#F3EAFF"),
      stroke: rgb("#D6BBFF"),
      inset: 10pt,
      radius: 6pt,
      width: 100%,
    )[
      #align(center)[
        *📐 模块四* \
        #set text(size: 12pt)
        Typst \
        笔记与幻灯片 \
        一份源码
      ]
    ],
  )
  #v(0.6em)
  #set text(size: 14pt)
  每个模块，都是把一个 *点击的习惯* 换成一份 *能留存的文件*。
])

== 今日所需

#block(height: 15em, columns()[
  #set text(size: 16pt)

  - 一台 Windows 10 / 11 电脑
  - 一条能上网的网络
  - 一个态度：*我写一次，机器重复一万次*

  #colbreak()

  #align(center + horizon)[
    #cbox[
      ```text
      点击 → 命令 → 脚本 → 仓库
      ```
    ]
    #v(0.6em)
    今天，我们就沿这条线从左走到右。
  ]
])

// 模块一 · 系统软件管理

= 模块一 · 系统软件管理

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  平时你是怎么 *装软件* 的？
  \
  \
  下载安装包，一路点 *下一步*？\
  还是敲 *一行命令*？
]

== 三个词：包 · 仓库 · 依赖

#block(height: 17em, columns()[
  #set text(size: 15pt)

  *核心概念*

  - *包* —— 一个软件连同它的版本与安装、卸载规则
  - *仓库* —— 包管理器检索的官方目录，Scoop 里叫 bucket
  - *依赖* —— 这个软件还要用到的别的软件，由管理器自动解析

  #colbreak()

  *其实你早就见过它们*

  - 📱 App Store / 各类应用商店 —— 手机上的软件
  - 🐍 `pip` —— Python · 📦 `npm` —— JavaScript
  - 🐧 `apt`（Ubuntu）· 🍺 `brew`（macOS）
  - 🪟 *`winget`* 与 *`scoop`* —— 今天的主角
])

== 为什么要用包管理器

#align(center + horizon)[
  #set text(size: 13pt)
  #tableq(
    (
      ([任务], [手动安装], [包管理器]),
      ([装 Python], [搜官网、挑版本、下载、下一步 ×5、记得勾 PATH], [`winget install Python.Python.3.12`]),
      ([升级软件], [逐个打开程序找「检查更新」], [`scoop update`]),
      ([换新机器], [半天时间，还总漏掉一两样], [一条脚本，跑一次]),
      ([复现同事的环境], [截图 + 一份 Word 步骤说明], [发一个脚本文件]),
      ([干净卸载], [控制面板里自己找残留], [`scoop uninstall ...`]),
    ),
    3,
  )
  #v(0.4em)
  *一条命令胜过十次点击，而命令可以保存、可以分享、可以重放。*
]

== WinGet 与 Scoop：两种设计

#align(center + horizon)[
  #set text(size: 11.5pt)
  #let data = csv("data/scoop-winget.csv")
  #figure(
    tableq(data, 3),
    caption: "Windows 包管理器对比",
  )
]

== WinGet：五个常用命令

#align(center + horizon)[
  #set text(size: 14pt)
  #tableq(
    (
      ([命令], [作用]),
      ([`winget search python`], [在官方仓库里查找一个包]),
      ([`winget install Git.Git`], [安装，包 ID 必须精确]),
      ([`winget list`], [列出本机已托管的全部软件]),
      ([`winget upgrade --all`], [一次性升级所有过期软件]),
      ([`winget uninstall Git.Git`], [干净地删掉一个包]),
    ),
    2,
  )
  #v(0.4em)
  *search → install → list → upgrade → uninstall。*
]

#[
  #set text(size: 15pt)
  #tip[ 把包 ID 读成 `发布者 · 产品 · 版本` —— 名字会重，ID 不会。 ]
]

== 一条命令装好工具链

#block(height: 18em, columns()[
  #set text(size: 14pt)

  *① 打开终端* \
  按 `Win`，输入 `PowerShell`，回车

  *② 敲几行命令*
  #cbox[
    ```powershell
    winget install Git.Git
    winget install Microsoft.VisualStudioCode
    winget install Typst.Typst
    winget install JohnMacFarlane.Pandoc
    winget install astral-sh.uv
    ```
  ]
  一个版本控制工具、一个编辑器、一个排版软件、一个文档转换器、一个包工具。

  #colbreak()

  *③ 在新终端里逐条验证*
  #cbox[
    ```powershell
    git --version
    code --version
    typst --version
    pandoc --version
    uv --version
    ```
  ]

  #warning[ 装完软件要 *新开* 一个终端 —— 旧终端不会重新加载 PATH。 ]
])

== Scoop：为什么开发者偏爱它

#block(height: 17em, columns()[
  #set text(size: 15pt)

  *它的性格*

  - 安装与管理 *不需要管理员权限*，受限账户和公共机房也能用
  - 安装脚本是 *JSON*，可读、可改，也可以自己写一份
  - 软件都装在自己的目录里，*解压即安装*，卸载不留残留
  - 命令行工具覆盖得全，GUI 软件靠 extras 等扩展库补齐

  #colbreak()

  *它的代价*

  - 默认收录的 GUI 软件少，需要自己添加 bucket
  - 由社区维护，收录速度取决于参与者
  - 更适合 *愿意折腾*、要定制环境的开发者

  #tip[ 这两者不是二选一：Scoop 管命令行，WinGet 补 GUI，可以并存。 ]
])

== Scoop：安装与扩展

#block(height: 18em, columns()[
  #set text(size: 13pt)

  *① 允许本用户执行脚本*
  #cbox[
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```
  ]

  *② 自定义安装目录*
  #cbox[
    ```powershell
    irm get.scoop.sh -outfile 'install.ps1'
    .\install.ps1 -ScoopDir 'C:\Scoop' -NoProxy
    ```
  ]

  #colbreak()

  *③ 装好基础件*
  #cbox[
    ```powershell
    scoop install git aria2 sudo
    ```
  ]

  *④ 添加扩展库（含大量 GUI 程序）*
  #cbox[
    ```powershell
    scoop bucket add extras
    scoop update
    ```
  ]
])

== Scoop：日常管理

#block(height: 16em, columns()[
  #set text(size: 13pt)

  *五个高频命令*
  #cbox[
    ```powershell
    scoop search <app>   # 搜索软件
    scoop list           # 已装清单
    scoop status         # 哪些可更新
    scoop cleanup        # 清掉旧版本
    scoop checkup        # 自身诊断
    ```
  ]

  #colbreak()

  *两点习惯*

  - 装 `aria2` 可以多线程加速下载；若开了代理，用
    `scoop config aria2-enabled false` 关掉它
  - 用 `scoop-completion` 补全：敲前几个字母，按 `Tab`

  #note[ 不习惯命令行，也可以用图形界面的 UniGetUI 来操作 Scoop 与 WinGet。 ]
])

== 把机器还原到任何地方

#block(height: 15em, columns()[
  #set text(size: 15pt)

  *给现在的机器拍一张快照*
  #cbox[
    #set text(size: 12pt)
    ```powershell
    winget export -o packages.json
    ```
  ]

  *换一台电脑重放一遍*
  #cbox[
    #set text(size: 12pt)
    ```powershell
    winget import -i packages.json --accept-package-agreements
    ```
  ]

  #colbreak()

  *更简单的写法* —— 一个 `setup.ps1`
  #cbox[
    #set text(size: 12pt)
    ```powershell
    winget install Git.Git --silent
    winget install Microsoft.VisualStudioCode --silent
    winget upgrade --all --silent
    ```
  ]

  #tip[ 脚本可以反复跑 —— 已经装好的包会自动跳过。 ]
])

#v(0.2em)
#text(size: 12pt)[#link(
  "https://github.com/HHSTU-IST/camp/blob/main/vscode/win-scoop.md",
)[延伸阅读：搭建 Windows 统一开发环境（Scoop）]]

// 模块二 · 代码工程管理

= 模块二 · 代码工程管理

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  没见过这样的文件夹吗？
  \
  \
  `报告.docx` · `报告_v2.docx` · `报告_最终版_最后一版.docx` \
  \
  到底哪一份才 *真的* 是最终版？
]

== 为什么用 Git

#block(height: 17em, columns()[
  #set text(size: 16pt)

  - *版本控制* —— 随时回到历史上的任意一点
  - *可追溯* —— 每一行都有作者与理由
  - *备份* —— 你的工作同时活在不止一台机器上
  - *分支* —— 放心试错，成功才合并
  - *协作* —— 几个人改同一个工程，不会互相覆盖

  #colbreak()
  #figure(
    image("vscode/images/git.png", height: 78%),
    caption: none,
  )
])

== 四个区与三组命令

#align(center + horizon)[
  #set text(size: 14pt)
  #tableq(
    (
      ([方向], [命令], [含义]),
      ([工作区 → 暂存区], [`git add`], [挑出这次要提交的改动]),
      ([暂存区 → 本地仓库], [`git commit`], [连同理由一起冻存]),
      ([本地仓库 → 远程仓库], [`git push`], [推到远端留一份]),
      ([远程仓库 → 本地仓库], [`git fetch`], [只取回，不合并]),
      ([远程仓库 → 工作区], [`git clone` / `git pull`], [整份取回并合并]),
    ),
    3,
  )
  #v(0.4em)
  *先想清楚改动现在在哪一个区里，命令就不会记错。*
]

== 一次性配置与五个动词

#block(height: 17em, columns()[
  #set text(size: 14pt)

  *告诉 Git 你是谁（每台机器一次）*
  #cbox[
    ```powershell
    git config --global user.name  "Your Name"
    git config --global user.email "you@example.com"
    git config --global init.defaultBranch main
    ```
  ]

  #note[ 这份身份会写进每一条提交记录里，之后想改会很麻烦，一次配对。 ]

  #colbreak()

  *一个人干活，五个动词够了*
  #cbox[
    ```powershell
    git init      # 让这个文件夹开始被跟踪
    git add .     # 挑出要进入快照的内容
    git commit -m "docs: lab skeleton"   # 冻存，并写下理由
    git status    # 从那以后改了什么？
    git log       # 历史上发生过什么？
    ```
  ]

  要和别人协作，再加 `clone` 与 `push`。
])

== 一次真实会话：从 init 到 merge

#block(height: 19em, columns()[
  #set text(size: 12pt)

  *① 起一个工程*
  #cbox[
    ```powershell
    mkdir bearing-lab; cd bearing-lab
    git init
    # 写下 README.md
    git add .
    git commit -m "docs: add lab skeleton"
    ```
  ]

  *② 试一个冒险的改动*
  #cbox[
    ```powershell
    git branch exp/new-material
    git switch exp/new-material
    # 随便改 torque.py，main 分支保持干净
    git add torque.py
    git commit -m "feat: convert mm/GPa units"
    ```
  ]

  *③ 成功就合并*
  #cbox[
    ```powershell
    git switch main
    git merge exp/new-material
    git log --oneline --graph
    ```
  ]

  #colbreak()

  *④ 放到安全的地方*
  #cbox[
    ```powershell
    git remote add origin https://github.com/<you>/bearing-lab.git
    git push -u origin main
    ```
  ]

  *⑤ 在另一台机器上取回来*
  #cbox[
    ```powershell
    git clone https://github.com/<you>/bearing-lab.git
    ```
  ]

  *常用分支与查看操作*
  #cbox[
    ```powershell
    git branch <name>      # 新建分支
    git switch <name>      # 切换分支
    git branch -d <name>   # 删除已合并的分支
    git diff               # 看差异
    git blame <file>       # 看每一行是谁写的
    ```
  ]
])

== .gitignore 与提交信息

#block(height: 17em, columns()[
  #set text(size: 14pt)

  *`.gitignore` —— 不该进历史的东西*
  #cbox[
    ```text
    .venv/
    __pycache__/
    *.pyc
    output/
    ```
  ]
  环境与构建产物都是 *可以重新生成的*，所以不必入库。

  #colbreak()

  *好的提交信息说的是「为什么」*
  #cbox[
    ```text
    fix: convert shaft diameter from mm to m
    docs: add torque-twist lab procedure
    feat: plot twist angle vs torque
    ```
  ]
  `类型: 做了什么` —— 未来的你会在凌晨两点读这一行。
])

== 编辑器里的 Git

#block(height: 16em, columns()[
  #set text(size: 14pt)

  VS Code 内置的 Git 面板已经覆盖了绝大多数命令：
  暂存、提交、看差异、切换分支，都在侧边栏里完成。

  #figure(
    image("vscode/images/vscode-git.png", height: 62%),
    caption: none,
  )

  #colbreak()

  *两个很有用的进阶动作*
  #cbox[
    ```powershell
    git reset --soft HEAD^   # 撤回上一个提交，改动留在暂存区
    git reset --soft HEAD~N  # 压缩前 N 个提交，再重新提交一次
    ```
  ]

  *扩展*：Conventional Commits 之类的提交规范助手值得装。
  GitLens 功能很全，但相当笨重 —— 是否为了功能牺牲编辑器性能，自己权衡。
])

#v(0.2em)
#text(size: 12pt)[#link(
  "https://github.com/HHSTU-IST/camp/blob/main/vscode/tool-git.md",
)[延伸阅读：搭建便捷 Git 文件管理环境]]

// 模块三 · 程序文档

= 模块三 · 程序文档

== 开场提问

#align(center + horizon)[
  #set text(size: 27pt)

  老师要一份实验报告。

  你打开 *Word*，还是打开一个 *纯文本文件*？
  \
  \
  同样的内容、同样导出 PDF —— 哪一份能被 Git *比对*、\
  能被 *模板化*、能被 *AI 直接改写*？
]

== Word · Markdown · Typst 三者对照

#align(center + horizon)[
  #set text(size: 12pt)
  #tableq(
    (
      ([维度], [Word], [Markdown], [Typst]),
      ([文件], [.docx（二进制）], [.md（纯文本）], [.typ（纯文本）]),
      ([Git 比对], [✗ 一团乱码], [✓ 看得懂], [✓ 看得懂]),
      ([版式控制], [拖拽与点击], [~ 有限], [✓ 可编程，精确]),
      ([数学公式], [公式编辑器], [~ 需靠转换器], [✓ 原生 `$...$`]),
      ([重复 50 份], [复制、粘贴、重排], [✓ 一份模板], [✓ 一份模板 + 循环]),
      ([最适合], [对外交接文件], [笔记、README、提示词], [报告、幻灯片、论文]),
    ),
    4,
  )
  #v(0.4em)
  *按用途选，不要按习惯选 —— 它们最终都能导出同一份 PDF。*
]

== Markdown 是什么

#block(height: 17em, columns()[
  #set text(size: 15pt)

  Markdown 是一种易于读写的 *轻量级标记语言*，
  写出来的东西本身就是可读的文本，
  近年来被广泛用于日常写作乃至电子书出版。

  常见的免费编辑器有

  - 闭源：Obsidian、Typora
  - 开源：Zettlr、MarkText

  #colbreak()

  *为什么程序员偏爱它*

  - 你和 AI 之间最短的一条路：*纯文本进，纯文本出*
  - 每一次修改都能被 Git 读出差异
  - 没有格式负担，注意力全在内容上

  #note[ 大模型最熟练的三种语言里，Markdown 是唯一一门 *人人当天就能学会* 的。 ]
])

== 写 Markdown 的扩展

#block(height: 18em, columns()[
  #set text(size: 14pt)

  *Markdown All in One* —— 大一统型扩展，Markdown 类插件下载榜榜首

  - 快捷命令与代码片
  - 自动生成标题编号、自动维护目录
  - LaTeX 数学公式支持

  *rumdl* —— 语法检查器与格式化器

  - 帮你写出规范文档，避免语法错误导致渲染失败
  - 保存时自动修掉结构问题

  #colbreak()

  *Markdown Inline Editor* —— 类似 Typora 的即时渲染

  - 不用分屏预览，边写边看
  - 支持全部基础语法，也支持 mermaid 图表

  *编辑与输出的补充*

  - AutoCorrect：给中英混写补上正确的空格与标点
  - Draw.io：复杂图形直接用它的内嵌扩展画
  - Word Count CJK：中文按「字」、英文按「词」分别统计
  - Pandoc：文档格式领域的瑞士军刀，负责最后一步输出
])

== 表格 · 公式 · 代码

#block(height: 18em, columns(2, gutter: 1em)[
  #set text(size: 12pt)

  *Markdown* —— 写起来就是内容本身
  #cbox[
    ```text
    # 轴扭转实验 —— 实验三

    ## 1. 实验目的

    测量钢轴的**扭转角**。

    | 工况 | T (N·m) | θ (°) |
    | ---- | ------- | ----- |
    | A    | 20      | 0.8421 |
    | B    | 35      | 1.4737 |
    ```
  ]

  #colbreak()

  *Typst* —— 版式也能写进源码
  #cbox[
    ```typ
    #set page(paper: "a4")

    = 轴扭转实验 —— 实验三
    == 1. 实验目的
    测量钢轴的*扭转角*。

    #table(
      columns: 3,
      [工况], [T (N·m)], [θ (°)],
      [A], [20], [0.8421],
      [B], [35], [1.4737],
    )
    ```
  ]

  注意：同样的内容，*全程没有碰过工具栏*。
])

== 一条命令变出 PDF / DOCX / HTML

#block(height: 16em, columns()[
  #set text(size: 14pt)

  *从 Typst 出发*
  #cbox[
    ```powershell
    typst compile report.typ report.pdf
    typst watch report.typ      # 边写边看实时预览
    ```
  ]

  *从 Markdown 出发*（需要 Pandoc，同样可以用包管理器装）
  #cbox[
    ```powershell
    scoop install pandoc
    pandoc README.md -o README.docx
    pandoc README.md -o README.pdf
    ```
  ]

  #colbreak()

  *你换来了什么*

  - 文档是 *可 diff* 的 —— 审阅者看得见每一处改动
  - 一个班 60 人可以共用 *一份模板*，而不是 60 套版式
  - 机构名改一次，60 份 PDF 几秒钟重建完成
  - 它是文本，所以 *AI 读得懂、审得了、改得动*

  #tip[ 导出 PDF 需要本机有一套 LaTeX 引擎与中文字体，这一步配置一次即可。 ]
])

#v(0.2em)
#text(size: 12pt)[#link(
  "https://github.com/HHSTU-IST/camp/blob/main/vscode/prog-markdown.md",
)[延伸阅读：搭建 Markdown 强大写作环境]]

// 模块四 · 学习笔记与幻灯片

= 模块四 · 学习笔记与幻灯片

== 开场提问

#align(center + horizon)[
  #set text(size: 27pt)

  Markdown 排不出论文级的版式，\
  LaTeX 又重、又难调。
  \
  \
  有没有 *第三条路*？
]

== Typst 是什么

#block(height: 17em, columns()[
  #set text(size: 15pt)

  一个用 Rust 写的新一代排版软件，
  当前 LaTeX 最有力的竞争者：既有 Markdown 的简洁语法，
  又有 LaTeX 的多样版式，编译速度快到可以边写边看。

  它的环境配置非常简单：

  - 装一个几十兆的命令行程序
  - 编辑器里装一个 Tinymist 扩展
  - 想格式化代码，再加一个 typstyle

  #colbreak()

  *它解决的正是前两个模块的痛点*

  - 语法比 LaTeX 短得多，报错信息是给人看的
  - 源码是纯文本，所以 Git 管得了、AI 改得动
  - 同一份源码可以产出讲义、幻灯片、论文
  - 包生态虽小，但需要的排版能力大多已经有了

  #figure(
    image("vscode/images/typst.png", height: 42%),
    caption: none,
  )
])

== 安装与编辑器配置

#block(height: 18em, columns()[
  #set text(size: 13pt)

  *装软件*
  #cbox[
    ```powershell
    scoop install typst git
    # 或
    winget install typst.typst
    ```
  ]

  *再装格式化器*
  #cbox[
    ```powershell
    scoop install typstyle
    ```
  ]

  *在扩展商店里搜索并安装 Tinymist*

  #colbreak()

  *让编辑器用上它* —— `settings.json`
  #cbox[
    #set text(size: 11pt)
    ```json
    {
      "[typst]": {
        "editor.defaultFormatter": "myriad-dreamin.tinymist"
      },
      "tinymist.formatterMode": "typstyle",
      "tinymist.lint.enabled": true,
      "tinymist.exportPdf": "onDocumentHasTitle",
      "tinymist.preview.cursorIndicator": true
    }
    ```
  ]

  #note[ 辅助扩展：Unicode Math Input 帮忙输入数学符号，Emoji 则用 `\:` 转义即可。 ]
])

== 一份源码，两种成品

#block(height: 18em, columns()[
  #set text(size: 14pt)

  *讲义与笔记* —— 用 `chapter-style`，按章节排版

  #cbox[
    #set text(size: 11pt)
    ```typ
    #import "lib/lib.typ": *
    #show: chapter-style.with(title: "技能树")

    = 软件选择
    == 选择标准
    ```
  ]

  *幻灯片* —— 用 `touying-quick`，一个标题一页

  #cbox[
    #set text(size: 11pt)
    ```typ
    #import "lib/lib.typ": *
    #show: touying-quick.with(title: "编程思维")

    = 模块一
    == 开场提问
    ```
  ]

  #colbreak()

  *同一个工程的两种入口* —— 内容重复的部分由 `lib/` 与 `data/` 承担

  - 表格数据放在 `data/*.csv`，讲义与幻灯片共用同一份
  - 图片放在 `images/`，用仓库根相对路径引用
  - 代码示例落成真实文件，用 `read()` 取回来，而不是抄进文档
  - 自定义函数先查已有包，避免各页版式各写一套

  #tip[ 结论：一份数据、一处模板，产出多少份文件都不需要重新排版。 ]
])

== 一条命令出 PDF

#block(height: 16em, columns()[
  #set text(size: 15pt)

  *写出成品*
  #cbox[
    ```powershell
    typst compile 技能-编程思维.typ out.pdf
    ```
  ]

  *边写边看*
  #cbox[
    ```powershell
    typst watch 技能-编程思维.typ
    ```
  ]

  *导出图片序列*
  #cbox[
    #set text(size: 12pt)
    ```powershell
    typst compile --ppi 100 deck.typ "output/{0p}.png"
    ```
  ]

  #colbreak()

  *几个越早知道越好的习惯*

  - 编译时带上字体路径，否则中文会缺字
  - 一页装不下就 *调小字号或拆页*，而不是硬挤
  - 路径一律相对 *仓库根*，不要写绝对路径
  - 报错会精确定位到行列，读第一行就够了

  #warning[ 记得把编译产物放进 `output/` 并写进 `.gitignore`：可以重新生成的东西不入库。 ]
])

== 你正在看的这一页

#align(center + horizon)[
  #set text(size: 24pt)

  你现在看的每一页幻灯片，\
  都是 Git 仓库里的一个 *.typ 文件*。
  \
  \

  #cbox[
    ```powershell
    typst compile 技能-编程思维.typ 技能-编程思维.pdf
    ```
  ]

  #v(0.4em)
  #set text(size: 16pt)
  这节课本身就是案例 —— 内容、数据、图片、版式，全部可以 *审查与复用*。
]

#v(0.2em)
#text(
  size: 12pt,
)[#link("https://github.com/HHSTU-IST/camp/blob/main/vscode/prog-typst.md")[延伸阅读：搭建 Typst 舒适写作环境] · #link("https://typst-doc-cn.github.io/docs/")[Typst 中文文档]]

// 小结

= 小结

== 掌握度自查

#block(height: 18em, columns(2, gutter: 1.5em)[
  #set text(size: 13pt)

  *系统软件*

  - ✓ `winget search / install / list / upgrade --all / uninstall`
  - ✓ `scoop install / bucket add / list / status / cleanup`
  - ✓ 说清包、仓库、依赖三者是什么
  - ✓ 写一个 `setup.ps1`，让机器可以重建

  *代码工程*

  - ✓ `init → add → commit → status → log`
  - ✓ 建一个分支，再把它合回 main
  - ✓ 写 `.gitignore`，写一条像样的提交信息

  #colbreak()

  *程序文档*

  - ✓ 说清哪些内容该写进 Markdown，哪些该交给 Typst
  - ✓ 用扩展把 Markdown 写出规范、看见渲染效果
  - ✓ 一条命令把纯文本变成 PDF 或 DOCX

  *笔记与幻灯片*

  - ✓ 装好 typst 与 Tinymist，让编辑器能预览
  - ✓ 认出 `chapter-style` 与 `touying-quick` 两种入口
  - ✓ 用一条编译命令拿到成品
])

== 带回家的一句话

#align(center + horizon)[
  #set text(size: 26pt)

  编程思维不是关于 *代码*。

  它是拒绝把同一件事做第二遍 —— \
  凡是能 *写一次* 的，就不再用手点第二次。
  \
  \
  点击 → 命令 → 脚本 → 仓库

  #v(0.6em)
  #set text(size: 18pt)
  今天我们只走了这条线的一段；接下来，是让 *AI* 和你一起走完它。
]

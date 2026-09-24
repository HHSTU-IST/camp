#import "lib/lib.typ": *
#show: touying-quick.with(
  title: "编程思维",
  subtitle: "一次写清，处处复用",
  info: info-skill,
  bgimg: bghexagon,
)

= 编程思维

== 开场提问

#align(center + horizon)[
  #set text(size: 32pt)

  你用电脑很多年了。

  但真正说了算的是*你*，还是*机器*？
]

== 什么是「编程思维」

#columns()[
  #set text(size: 18pt)

  它不是「整天写代码」，而是一种习惯：

  - 凡是会让你做第二遍的事，就把它*自动化*
  - 把每个参数写进*文件*，而不是靠手动调节
  - *实时追踪*每一次改动，而不是靠记忆

  #colbreak()

  落到手上，就是3件事：

  - 工具链由*命令*装好，而不是点出来
  - 软件由*配置文件*决定行为
  - 每一次改动由*版本管理工具*留档
]
\

#align(center + horizon)[
  以上原则都指向了同一个关键字：*可复现*。
]

== 今日路线图·四个模块

#align(center + horizon)[
  #grid(
    columns: (1fr,) * 4,
    block(fill: rgb("#EAF2FF"), stroke: rgb("#BFD7FF"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *🛠 模块一*\
        #set text(size: 18pt)
        WinGet / Scoop \
        系统软件 \
        一条命令装好
      ]
    ],
    block(fill: rgb("#EAFBEA"), stroke: rgb("#A8E6A8"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *🌳 模块二*\
        #set text(size: 18pt)
        Git \
        每一次改动 \
        都有出处
      ]
    ],
    block(fill: rgb("#FFF6E0"), stroke: rgb("#FFE08A"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *📝 模块三*\
        #set text(size: 18pt)
        Markdown \
        程序文档 \
        本身就是文本
      ]
    ],
    block(fill: rgb("#F3EAFF"), stroke: rgb("#D6BBFF"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *📐 模块四*\
        #set text(size: 18pt)
        Typst \
        笔记与幻灯片 \
        也可以是代码
      ]
    ],
  )
  \

  #set text(size: 28pt)
  每个模块，都是把一个*点击的习惯*换成一份*能留存的文件*。
]

== 今日所需

#[
  #set text(size: 28pt)

  - 一台 Windows 10 / 11 电脑
  - 一条能上网的网络
  - 一个态度：*我只写一次，机器重复一万次*
]

= 模块一 系统软件管理

== 开场提问

#align(center + horizon)[
  #set text(size: 32pt)

  平时你是怎么*装软件*的？
  \
  \
  下载安装包，一路点*下一步*？还是敲*一行命令*？
]

== 包·依赖·包管理器·仓库

#[
  包管理器（Package Manager）是一种用于自动安装, 升级, 配置和卸载软件（或依赖库）的工具集，能省去用户手动下载, 寻找依赖和配置环境变量的繁琐步骤。

  *核心概念*

  - *包*：一个软件连同它的版本与安装, 卸载规则
  - *依赖*：这个软件还要用到的别的软件，由管理器自动解析
  - *仓库*：包管理器检索的官方目录
]

== 包管理器

#columns()[
  === 操作系统级包管理器

  - Windows：
    - 官方：WinGet（微软）
    - 社区：Scoop, Chocolatey
  - macOS：Homebrew, MacPorts
  - Linux：
    - Debian/Ubuntu 系：apt, dpkg
    - Red Hat/Fedora 系：dnf
    - Arch Linux 系：pacman
    - Nix 系：Nix

  === 编程语言级包管理器

  - Python：pip, uv, Poetry, pipx, pdm
  - Node.js：npm, pnpm, bun, yarn
  - Java：Maven, Gradle
  - Rust：cargo
  - Go：go mod
  - C/C++：vckpg

  === 跨语言包管理器

  - conda 系：mamba/micromamba, pixi
  - spack
])

== 为什么要用包管理器

#align(center + horizon)[
  #set text(size: 18pt)
  #tableq(
    (
      ([任务], [手动安装], [包管理器]),
      ([装软件], [搜官网, 挑版本, 下载, 下一步×5, 勾 PATH], [`winget/scoop install xxx`]),
      ([升级软件], [逐个打开程序找「检查更新」], [`winget/scoop update`]),
      ([换新机器], [半天时间，还总漏掉一两样], [一条脚本，跑一次]),
      ([复现同事的环境], [截图 + 一份 Word 步骤说明], [发一个脚本文件]),
      ([干净卸载], [控制面板里自己找残留], [`winget/scoop uninstall xxx`]),
    ),
    3,
  )
  \
  *一条命令胜过十次点击，而命令可以保存, 可以分享, 可以重放。*
]

== WinGet：五个常用命令

#align(center + horizon)[
  #set text(size: 22pt)
  #tableq(
    (
      ([命令], [作用]),
      ([`winget search git`], [在官方仓库里查找一个包]),
      ([`winget install Git.Git`], [安装，包 ID 必须精确]),
      ([`winget list`], [列出本机已托管的全部软件]),
      ([`winget upgrade --all`], [一次性升级所有过期软件]),
      ([`winget uninstall Git.Git`], [干净地删掉一个包]),
    ),
    2,
  )
  \
  *search → install → list → upgrade → uninstall。*
]

== Scoop：为什么开发者偏爱它

#columns()[
  #set text(size: 18pt)

  *它的性格*

  - 安装与管理*不需要管理员权限*，受限账户和公共机房也能用
  - 安装脚本是*JSON*，可读性好
  - *解压即安装*，卸载不留残留
  - 扩展性强，方便自行构建扩展仓库

  #colbreak()

  *它的代价*

  - 默认收录的 GUI 软件少，需自行写脚本
  - 对需管理员权限的软件，覆盖案例不够全
  - 不能自动退出后台服务，升级进程容易被后台占用中断
  - 更适合*愿意折腾*, 要定制环境的开发者
]

#tip[
  这两者不是二选一：Scoop 管命令行，WinGet 补 GUI，可以并存。
]

== Scoop：安装与扩展

#columns()[
  #set text(size: 22pt)

  === 允许本用户执行脚本

  ```bash
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

  === 自定义安装目录

  ```bash
  irm get.scoop.sh -outfile 'install.ps1'
  .\install.ps1 -ScoopDir 'C:\Scoop' -NoProxy
  ```

  #colbreak()

  === 装好基础件

  ```bash
  scoop install git aria2
  ```

  === 添加官方扩展库

  ```bash
  scoop bucket add extras
  ```

  === 添加自定义扩展库

  ```bash
  scoop bucket add extras-cn https://github.com/scoopforge/Extras-CN
  ```
]

== Scoop：日常管理

#columns()[
  #set text(size: 20pt)

  *五个高频命令*
  ```bash
  scoop search <app>   # 搜索软件
  scoop list           # 已装清单
  scoop status         # 哪些可更新
  scoop cleanup        # 清掉旧版本
  scoop checkup        # 自身诊断
  ```

  #colbreak()

  *两点习惯*

  - 装 `aria2` 可以多线程加速下载；若开了代理，用
    `scoop config aria2-enabled false` 关掉它
  - 用 `scoop-completion` 补全：敲前几个字母，按 `Tab`

]

#tip[
  不习惯命令行，也可以用图形界面的 UniGetUI 来操作 Scoop 与 WinGet。
]

== WinGet 与 Scoop：两种设计

#align(center + horizon)[
  #set text(size: 22pt)
  #let data = csv("data/scoop-winget.csv")
  #figure(
    tableq(data, 3),
    caption: "Windows 包管理器对比",
  )
]

== 把机器还原到任何地方

#[
  #set text(size: 20pt)

  === 给现在的机器拍一张快照

  ```bash
  winget export -o packages.json
  ```

  === 换一台电脑重放一遍

  ```bash
  winget import -i packages.json --accept-package-agreements
  ```

  === 更简单的写法：一个 `setup.ps1`

  ```bash
  winget install Git.Git --silent
  winget install Microsoft.VisualStudioCode --silent
  winget upgrade --all --silent
  ```
]

= 模块二 代码工程管理

== 开场提问

#align(center + horizon)[
  #set text(size: 28pt)

  没见过这样的文件夹吗？
  \
  `报告.docx`·`报告_v2.docx`·`报告_最终版_最后一版.docx`
  \
  到底哪一份才*真的*是最终版？
]

== 为什么用 Git

#figure(
  image("vscode/images/git.png", height: 70%),
  caption: none,
)

#columns()[
  #set text(size: 18pt)

  - *版本控制*：随时回到历史上的任意一点
  - *可追溯*：每一行都有作者与理由
  - *备份*：你的工作同时活在不止一台机器上
  - *分支*：放心试错，成功才合并
  - *协作*：几个人改同一个工程，不会互相覆盖
]

== 四个区与三组命令

#align(center + horizon)[
  #set text(size: 22pt)
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
  \
  *先想清楚改动现在在哪一个区里，命令就不会记错。*
]

== 一次性配置

#columns()[
  #set text(size: 18pt)

  ```toml
  [user]
  name = ivaquero
  email = msaintms@outlook.com

  [credential]
  helper = store

  [commit]
  gpgsign = false

  [gpg]
  program = gpg

  [pull]
  rebase = false

  [merge]
  conflictstyle = diff3

  [diff]
  colorMoved = default

  [alias]
  # basics
  cf = config
  h = help
  ...
  ```
]

== .gitignore 与提交信息

#columns()[
  #set text(size: 18pt)

  *`.gitignore` —— 不该进历史的东西*
  ```text
    .venv/
    __pycache__/
  *.pyc
    output/
  ```
  环境与构建产物都是*可以重新生成的*，所以不必入库。

  #colbreak()

  *好的提交信息说的是「为什么」*
  ```text
  fix: convert shaft diameter from mm to m
  docs: add torque-twist lab procedure
  feat: plot twist angle vs torque
  ```
  `类型: 做了什么` —— 未来的你会在凌晨两点读这一行。
]

== 一次真实会话：从 init 到 merge

#columns()[
  #set text(size: 16pt)

  *① 起一个工程*
  ```bash
  mkdir bearing-lab; cd bearing-lab
  git init
  # 写下 README.md
  git add .
  git commit -m "docs: add lab skeleton"
  ```

  *② 试一个冒险的改动*
  ```bash
  git branch exp/new-material
  git switch exp/new-material
  # 随便改 torque.py，main 分支保持干净
  git add torque.py
  git commit -m "feat: convert mm/GPa units"
  ```

  *③ 成功就合并*
  ```bash
  git switch main
  git merge exp/new-material
  git log --oneline --graph
  ```

  #colbreak()

  *④ 放到安全的地方*
  ```bash
  git remote add origin https://github.com/<you>/bearing-lab.git
  git push -u origin main
  ```

  *⑤ 在另一台机器上取回来*
  ```bash
  git clone https://github.com/<you>/bearing-lab.git
  ```

  *常用分支与查看操作*
  ```bash
  git branch <name>      # 新建分支
  git switch <name>      # 切换分支
  git branch -d <name>   # 删除已合并的分支
  git diff               # 看差异
  git blame <file>
  ```
]

= 模块三 程序文档

== 开场提问

#align(center + horizon)[
  #set text(size: 27pt)

  当你要做一份学习笔记。
  \
  你打开的是*Word*，还是*纯文本文件*？
  \
  同样的内容 —— 哪一份更能被*模板化*, 被*AI 直接改写*？
]

== Word·Markdown·Typst

#align(center + horizon)[
  #set text(size: 18pt)
  #tableq(
    (
      ([维度], [Word], [Markdown], [Typst]),
      ([文件], [.docx（二进制）], [.md（纯文本）], [.typ（纯文本）]),
      ([Git 比对], [✗ 一团乱码], [✓ 看得懂], [✓ 看得懂]),
      ([版式控制], [拖拽与点击], [~ 有限], [✓ 可编程，精确]),
      ([数学公式], [公式编辑器], [✓], [✓]),
      ([重复 50 份], [复制, 粘贴, 重排], [✓ 一份模板], [✓ 一份模板 + 循环]),
      ([最适合], [对外交接文件], [笔记, README, 提示词], [报告, 幻灯片, 论文]),
    ),
    4,
  )
  \
  *按用途选，不要按习惯选 —— 它们最终都能导出同一份 PDF。*
]

== Markdown 是什么

#columns()[
  #set text(size: 18pt)

  Markdown 是一种易于读写的*轻量级标记语言*，
  写出来的东西本身就是可读的文本，
  近年来被广泛用于日常写作乃至电子书出版。

  常见的免费编辑器有

  - 闭源：Obsidian, Typora
  - 开源：Zettlr, MarkText

  #colbreak()

  *为什么程序员偏爱它*

  - 你和 AI 之间最短的一条路：*纯文本进，纯文本出*
  - 每一次修改都能被 Git 读出差异
  - 没有格式负担，注意力全在内容上

]

#note[
  大模型最熟练的三种语言里，Markdown 是唯一一门*人人当天就能学会*的。
]

== 写 Markdown 的扩展

#columns()[
  #set text(size: 18pt)

  *Markdown All in One*：大一统型扩展，Markdown 类插件下载榜榜首

  - 快捷命令与代码片
  - 自动生成标题编号, 自动维护目录
  - LaTeX 数学公式支持

  *rumdl*：语法检查器与格式化器

  - 帮你写出规范文档，避免语法错误导致渲染失败
  - 保存时自动修掉结构问题

  #colbreak()

  *Markdown Inline Editor*：类似 Typora 的即时渲染

  - 不用分屏预览，边写边看
  - 支持全部基础语法，也支持 mermaid 图表

  *编辑与输出的补充*

  - Draw.io：复杂图形直接用它的内嵌扩展画
  - Word Count CJK：中文按「字」, 英文按「词」分别统计
  - Pandoc：文档格式领域的瑞士军刀，负责最后一步输出
]

```bash
code --install-extension yzhang.markdown-all-in-one rvben.rumdl codesmith.markdown-inline-editor-vscode hediet.vscode-drawio
```

== 表格·公式·代码

#columns(2, gutter: 1em)[
  #set text(size: 18pt)

  *Markdown*：写起来就是内容本身

  ```text
  # 轴扭转实验

  ## 1. 实验目的

  测量钢轴的**扭转角**。

  | 工况 | T (N·m) | θ (°) |
  | ---- | ------- | ----- |
  | A    | 20      | 0.8421 |
  | B    | 35      | 1.4737 |
  ```

  #colbreak()

  *Typst*：版式也能写进源码

  ```typ
  #set page(paper: "a4")

  = 轴扭转实验

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

== 一条命令变出 PDF / DOCX / HTML

#columns()[
  #set text(size: 20pt)

  *从 Markdown 出发*（需要 Pandoc）
  ```bash
  scoop install pandoc
  pandoc README.md -o README.docx
  pandoc README.md -o README.pdf
  ```

  *从 Typst 出发*
  ```bash
  typst compile report.typ report.pdf
  ```
  #[
    #set text(size: 14pt)
    #tip[
      导出 PDF 需要本机有一套 LaTeX 引擎与中文字体，这一步配置一次即可。
    ]
  ]

  #colbreak()

  *你换来了什么*

  - 文档是*可 diff*的，审阅者看得见每一处改动
  - 一个班 60 人可以共用*一份模板*
  - 机构名改一次，60 份 PDF 几秒钟重建完成
  - 它是文本，所以*AI 读得懂, 审得了, 改得动*

]

= 模块四 学习笔记与幻灯片

== 开场提问

#align(center + horizon)[
  #set text(size: 27pt)

  Markdown 排不出论文级的版式，\
  LaTeX 又重, 又难调。
  \
  \
  有没有*第三条路*？
]

== Typst 是什么

#[
  // #set text(size: 18pt)
  Typst 是可用于出版的可编程标记语言，拥有变量、函数与包管理等现代编程语言的特性，注重于科学写作，定位与 LaTeX 相似，是当前 LaTeX 最有力的竞争者：既有 Markdown 的简洁语法，又有 LaTeX 的多样版式，编译速度快到可以边写边看。
]
\
\
#columns()[
  // #set text(size: 18pt)
  - 语法简洁：上手难度近似 Markdown
  - 编译速度快：使用 Rust 语言编写
  - 环境搭建简单：使用 VSCode 本地开发
  - 现代编程语言：拥有变量、函数、包管理与错误检查等现代编程语言的特性

  - #link("https://typst.app/universe/search/?kind=packages")[Typst 社区]

  #colbreak()
  #figure(
    image("vscode/images/typst.png", width: 90%),
    caption: none,
  )
]

== 安装与编辑器配置

#columns()[
  #set text(size: 18pt)

  *装软件*
  ```bash
  scoop install typst git
  # 或
  winget install typst.typst
  ```

  *再装格式化器*
  ```bash
  scoop install typstyle
  ```

  *安装扩展 Tinymist*

  ```bash
  code --install-extension myriad-dreamin.tinymist czhang03.unicode-math-input
  ```

  #[
    #set text(size: 14pt)
    #note[
      辅助扩展：Unicode Math Input 帮忙输入数学符号，Emoji 则用 `\:` 转义即可。
    ]
  ]

  #colbreak()

  *让编辑器用上它*：`settings.json`

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



== 一份源码，两种成品

#columns()[
  #set text(size: 17pt)

  *讲义与笔记*：用 `chapter-style`，按章节排版

  ```typ
  #import "lib/lib.typ":*
  #show: chapter-style.with(title: "技能树")

  = 软件选择
  == 选择标准
  ```


  *幻灯片*：用 `touying-quick`，一个标题一页

  ```typ
  #import "lib/lib.typ":*
  #show: touying-quick.with(title: "编程思维")

  = 模块一
  == 开场提问
  ```

  #colbreak()

  *同一个工程的两种入口*：内容重复的部分由 `lib/` 与 `data/` 承担

  - 表格数据放在 `data`，讲义与幻灯片共用同一份
  - 图片放在 `images/`，用仓库根相对路径引用
  - 代码示例落成真实文件，用 `read()` 取回来，而不是抄进文档
  - 自定义函数先查已有包，避免各页版式各写一套

  #[
    #set text(size: 14pt)
    #tip[
      结论：一份数据, 一处模板，产出多少份文件都不需要重新排版。
    ]
  ]
]

== 一条命令出 PDF

#columns()[
  #set text(size: 18pt)

  *写出成品*
  ```bash
  typst compile 技能-编程思维.typ out.pdf
  ```

  *边写边看*
  ```bash
  typst watch 技能-编程思维.typ
  ```

  *导出图片序列*

  ```bash
  typst compile --ppi 100 deck.typ "output/{0p}.png"
  ```

  #colbreak()

  *几个越早知道越好的习惯*

  - 编译时带上字体路径，否则中文会缺字
  - 一页装不下就*调小字号或拆页*，而不是硬挤
  - 路径一律相对*仓库根*，不要写绝对路径
  - 报错会精确定位到行列，读第一行就够了

]

#warning[
  记得把编译产物放进 `output` 并写进 `.gitignore`：可以重新生成的东西不入库。
]

== 你正在看的这一页

#align(center + horizon)[
  #set text(size: 24pt)

  你现在看的每一页幻灯片，\
  都是 Git 仓库里的一个*.typ 文件*。
  \
  \

  ```bash
  typst compile 技能-编程思维.typ 技能-编程思维.pdf
  ```

  \
  这节课本身就是案例 —— 内容, 数据, 图片, 版式，全部可以*审查与复用*。
]

= 小结

== 掌握度自查

#columns(2, gutter: 1.5em)[
  #set text(size: 18pt)

  *系统软件*

  - ✓ `winget search / install / list / upgrade --all / uninstall`
  - ✓ `scoop install / bucket add / list / status / cleanup`
  - ✓ 说清包, 仓库, 依赖三者是什么
  - ✓ 写一个 `setup.ps1`，让机器可以重建

  *代码工程*

  - ✓ `init → add → commit → status → log`
  - ✓ 建一个分支，再把它合回 main
  - ✓ 写 `.gitignore`，写一条像样的提交信息

  #colbreak()

  *程序文档*

  - ✓ 说清哪些内容该写进 Markdown，哪些该交给 Typst
  - ✓ 用扩展把 Markdown 写出规范, 看见渲染效果
  - ✓ 一条命令把纯文本变成 PDF 或 DOCX

  *笔记与幻灯片*

  - ✓ 装好 typst 与 Tinymist，让编辑器能预览
  - ✓ 认出 `chapter-style` 与 `touying-quick` 两种入口
  - ✓ 用一条编译命令拿到成品
])

== 带回家的一句话

#align(center + horizon)[
  #set text(size: 26pt)

  编程思维不是关于*代码*。

  它是拒绝把同一件事做第二遍 —— \
  凡是能*写一次*的，就不再用手点第二次。
  \
  \
  点击 → 命令 → 脚本 → 仓库

  \
  今天我们只走了这条线的一段；接下来，是让*AI*和你一起走完它。
]

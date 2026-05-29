#import "lib/lib.typ": *
#show: chapter-style.with(title: "技能树", info: info-skill)

= 软件选择

== 选择标准

#block(height: 8em, columns()[
  - 首选
    - ☐ 开源软件
    - ☐ 可扩展，生态繁荣的软件
    - ☐ 有大厂（好爸爸）背书的软件
    - ☐ 提供 C++ 或 Python 接口的软件
  - 软件必备特征
    - ☐ 跨平台
    - ☐ 半年内开发活跃
    - ☐ 贡献者过百（开源软件可见）
])

== 注意事项

- ☐ 不安装软件管家
- ☐ 不安装杀毒软件
- ☐ 不安装多个具有相同功能的软件
- ☐ 不从非官方渠道下载安装软件
- ☐ 尽量使用包管理器下载安装软件
- ☐ 尽量不使用破解版，除非该软件具有绝对的效率优势
  - 如学习建模时，使用 Autodesk MAYA
  - 如学习自动化控制时，使用 MATLAB

== 默认选择

#let data = csv("data/tools-default.csv")
#figure(
  tableq(data, 3),
  caption: "默认选择",
)

= 必会软件

== 编程环境

=== VSCode + Git

通用编辑器，扩展生态繁荣，通过配置可作为强大的脚本语言（动态语言）编辑器，也适合写算法。其对应配置参考如下文章

- #link("https://zhuanlan.zhihu.com/p/694181464")[搭建便捷 Git 文件管理环境]
- #link("https://zhuanlan.zhihu.com/p/139140492")[搭建 Markdown 强大写作环境]
- #link("https://zhuanlan.zhihu.com/p/147336202")[搭建 Python 轻量级编程环境]
- #link("https://zhuanlan.zhihu.com/p/158824489")[搭建 Python 轻量级编程环境（WSL2）]
- #link("https://zhuanlan.zhihu.com/p/493323612")[搭建 C/C++ 轻量级编程环境]

=== Scoop / WinGet

包管理器通过​​自动化软件安装、更新与依赖解析​​，可显著提升开发与系统管理效率。其具有如下优势

- ✅ 通过简单命令一键获取所需工具，自动处理复杂的依赖关系，避免手动配置错误
- ✅ 支持版本锁定与多版本共存，确保环境一致性
- ✅ 依托官方仓库或可信源，降低恶意软件风险，并通过定期更新修复漏洞。

Scoop / WinGet 的设计理念略有不同，其差别如下

#let data = csv("data/scoop-winget.csv")
#figure(
  tableq(data, 3),
  caption: "Windows 包管理器对比",
)

推荐首选 Scoop 进行管理。Scoop 的使用推荐阅读如下文章

- #link("https://zhuanlan.zhihu.com/p/128955118")[搭建 Windows 统一开发环境]
- #link("https://zhuanlan.zhihu.com/p/165635039")[Scoop 进阶 - 建立自己的 Bucket]

若不习惯命令行操作，可使用 GUI 软件 UniGetUI，通过图形化操作 Scoop / WinGet 进行软件管理。

=== Terminal & WSL

- #link("https://zhuanlan.zhihu.com/p/144611023")[打造 Windows 优雅终端]
- #link("https://zhuanlan.zhihu.com/p/263658960")[搭建 WSL2 下的 Kali 环境]

=== 通用软件

#block(height: 6em, columns()[
  - 绘图（禁用 Visio）
    - Draw.io
  - 科学上网
    - Clash Verge Rev
  - 大模型
    - Cherry Studio
    - Ollama
])

=== Markdown

AI 时代，大模型均支持三种语言：

#block(height: 1em, columns(3)[
  - ☐ Markdown（输入输出）
  - ☐ Python（前端交互）
  - ☐ C++（后端运算）
])

由上到下，其学习难度递增。Markdown 是必会的。

= 推荐软件

== 简单级

=== Typst

现代文本语言，其拥有 Markdown 的简洁语法和 LaTeX 的多样版式。

- #link("https://zhuanlan.zhihu.com/p/642509853")[搭建 Typst 舒适写作环境]
- #link("https://typst-doc-cn.github.io/docs/")[Typst 中文文档]

=== Desmos

强大的在线可视化计算软件，拥有网页端和手机端。

- #link("https://desmos.com")[Desmos]

== 专业级

这类软件，上手有难度，值得尝试

=== IntelliJ IDEA

地位无可撼动的 Java IDE。

=== 数据科学编程语言

#let data = csv("data/tools-compute.csv")
#figure(
  tableq(data, 4),
  caption: "数据科学编程语言",
)

== 高难度级

=== Blender

开源 3D 建模软件，拥有丰富的 Python 扩展生态，其使用场景覆盖动画、游戏和建筑（BIM）。

=== Godot

开源游戏引擎，发展迅速，近年来已与商业游戏引擎 Unity 和 Unreal 形成三足鼎立之势。

= 学习路径

== Python

#figure(
  image("images/path-python.drawio.png", height: 50%),
  caption: none,
)

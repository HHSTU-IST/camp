#import "lib/lib.typ": *
#show: chapter-style.with(title: "研究预备课", info: info-skill)

= 文献
<文献>

== 通用文献库

#figure(
  table(
    columns: 5,
    align: center + horizon,
    inset: 3pt,
    stroke: table-three-line(rgb("000")),
    [国际通用], [国内对标], [类型], [多语言], [APP],
    [#link("https://scholar.google.com")[谷歌学术]], [#link("https://gfsoso.99lb.net")[谷粉学术]], [通用引擎], [✓], [×],
    [#link("https://sci-hub.se")[Sci-Hub]],
    [图书馆文献传递],
    [PDF 文献全文分享],
    [×],
    [#link("https://github.com/leovan/SciHubEVA")[✓]],

    [#link("https://zlibrary-asia.se")[Z-Library]],
    [],
    [电子图书分享],
    [✓],
    [#link("https://zlibrary-asia.se/soft/zlibrary-setup-latest.dmg")[✓]],

    [#link("https://zlib.pub")[ZLIB.PUB]], [], [电子图书分享], [×], [×],
  ),
  caption: "国内外主要通用文献库",
)

== 管理与阅读

#let data = csv("data/tools-literature.csv")
#figure(tableq(data, 4), caption: "文献管理软件", kind: table)

== 知识图谱软件

- #link("https://obsidian.md")[Obsidian]
- #link("https://logseq.com")[LogSeq]

== 图像处理

#block(height: 5em, columns()[
  - 位图编辑器
    - 处理格式：png, jpeg
    - 适用场景：修图得
  - 矢量图编辑器
    - 处理格式：svg
    - 适用场景：图表排版、海报等
])

#figure(
  table(
    columns: 4,
    align: center + horizon,
    inset: 3pt,
    stroke: table-three-line(rgb("000")),
    [适用对象], [付费软件], [开源替代], [替代度],
    [位图], [Adobe PhotoShop], [#link("https://gimp.org")[GIMP]], [★★★],
    [矢量图], [Adobe Illustrator], [#link("https://inkscape.org")[Inkscape]], [★★★★★],
  ),
  caption: "图像处理软件",
)

= 外文媒体处理

== 下载 YouTube 视频

+ 打开终端
+ 输入 `cd $HOME/Documents`
+ 输入 #raw("yt-dlp -N 50 --no-check-certificate \"视频链接\"", lang: "bash")

= 外文文本处理

== 字幕处理

+ 两指点击字幕文件，选择 Visual Studio Code 打开
+ 选中时间戳标志 `->`
+ 两指点击选中部分，选择"更改所有匹配项"
+ 使光标移动至行尾
+ 删除整行
+ 打开命令控制台
+ 输入"duplicate"，选择"删除重复项"
+ 输入"subtitle"，选择"translate"
+ 选择目标语言（中文：CN），进行翻译

#figure(
  table(
    columns: 3,
    align: center + horizon,
    inset: 3pt,
    stroke: table-three-line(rgb("000")),
    [功能键], [触发键], [功能],
    [⌘], [→], [光标移动至行尾],
    [⌘], [`删除`], [删除整行],
    [⌘+⌥], [`p`], [打开命令控制台],
  ),
  caption: "Visual Studio Code 快捷键",
)

= 专业数据库

== 音乐类

#figure(
  table(
    columns: 3,
    align: center + horizon,
    inset: 3pt,
    stroke: table-three-line(rgb("000")),
    [], [类型], [APP],
    [#link("https://musescore.com")[MuseScore]], [手打乐谱分享], [电脑端 + 移动端],
    [#link("https://imslp.org")[IMSLP]], [印刷乐谱分享], [×],
    [#link("https://free-scores.com")[Free-Scores]], [印刷乐谱分享], [×],
  ),
  caption: "音乐类数据库",
)

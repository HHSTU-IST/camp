#import "lib/lib.typ": *
#show: chapter-style.with(title: "文献的检索与管理", info: info-skill)

= 背景知识
<背景知识>

== 从SCI说起

说起文献检索，第一个绕不过去的词便是 SCI，则什么是 SCI 呢？

SCI 的中文翻译为《科学引文索引》（Science Citation Index），其创始人为美国语言学家尤金·加菲尔德（Eugene Garfield, 1925\~2017）。

#figure(
  image("images/fig-eugene.png", width: 40%),
  caption: "Eugene Garfield",
)

1955年，尤金在《科学》（Science）杂志上首次提出“引文索引”的设想，旨在提供一种帮助科学家识别感兴趣的文献的计量学工具@garfieldCitationIndexesScience1955。1960年，尤金在费城（Philadelphia）创立美国科学信息研究所（Institute for Scientific Information，ISI）。后者在尤金的领导，将“引文索引”付诸于实践，并于1964年正式发行了第一版SCI@borgmanScholarlyCommunicationBibliometrics2005。

SCI（科学引文索引）、EI（工程索引）、ISTP（科技会议录索引）是世界著名的三大科技文献检索系统，是国际公认的进行科学统计与科学评价的主要检索工具，其中以 SCI 最为重要。

== 影响因子的诞生

为对SCI期刊进行定量评估，尤金在随后又设计了“影响因子”（Impact Factor，IF）这一计量，并自1975年始，由ISI每年定期发布于“期刊引用报告”（Journal Citation Reports，JCR）@garfieldHistoryMeaningJournal2006。

IF 值的定义为：指定期刊在前两年的被引用次数总和与前两年发表文章数量总和的商，即

$
  "IF"_y = frac("Citations"_(y-1) + "Citations"_(y-2), "Publications"_(y-1) + "Publications"_(y-2))
$

IF值通过直观计量期刊的影响力，从而间接地反映出期刊的学术质量，然而其也有自身的局限性：如期刊文章研究领域的限制，医学相关研究者众多，且研究又多由团队完成，所以医学期刊的IF值普遍都在两位数以上；而航天领域因为研究者相对较少，加上方向差异、部分技术保密等原因，相关期刊的影响因子往往只有2、3，然而这并不影响一些优秀期刊的质量。

注：

$ a > 0, med b > 0 med ⇒ med frac(a + 1, b + 1) > a / b $

即发表的文章越多，IF往往越高。

= 文献检索
<文献检索>

== 傻瓜入门 – Web of Science

1992 年，ISI 被汤普森·路透集团（Thomson Reuters，TR）收购，SCI 和 JCR 也顺理成章地成为了 TR 集团旗下的产品。TR 集团在随后特地为 SCI 打造了网站 #link("https://webofknowledge.com")[Web of Science]。简单说，Web of Science 就是 SCI 的官网，若某个期刊在上面查询不到，则该期刊一定不属于 SCI。

进入网站后，可根据自己需要检索的类别进行选择，如话题、标题、作者等；还可以通过下方对检索的时间区间进行限定。Web of Science多用于精确检索，操作为傻瓜式，非常适合刚入门的研究生。

#tip[
  2016年，TR集团将其知识产权和科学业务部（Intellectual Property and Science business）出售，后者独立为一家全新公司 Clarivate Analytics，负责 Web of Science 等原有产品及业务的维护。
]

#figure(
  image("images/doc-web-of-science.png", width: 40%),
  caption: "Web of Science",
)

== 模糊检索 – 百度学术

若你想搜索的是一篇非 SCI 的英文报道，则这个时候就需要用到学术搜索引擎了，当前国内最好用的当属#link("https://xueshu.baidu.com")[百度学术]。具体使用方法也是傻瓜式的，在此不再赘述。

= 文献下载
<文献下载>

== 知识壁垒 – 文献出版五巨头

Web of Science 和百度学术的本质只是给搜索引擎，而要将搜索到的文献下载下来，往往要前往相应期刊的网站或出版集团的网站。超过四分之一的 SCI 期刊来自于以下 5 个出版集团的旗下：

+ #link("https://sicencedirect.com")[Elsevier]
+ #link("https://springernature.com")[Springer-Nature]
+ #link("https://wiley.com")[Wiley-Blackwell]
+ #link("https://taylorandfrancis.com")[Taylor & Francis]
+ #link("https://journals.sagepub.com")[Sage]

这些出版集团下的绝大多数期刊都是需要付费才能阅读的。

#figure(
  image("images/doc-publishers.png", width: 40%),
  caption: "文献出版巨头",
)

== 文献传递 – 百链

由于前面提到的出版集团的数据库整体价格高昂，所以大部分高校只会根据学校专业设立情况，购买整个数据库的一部分，所以对于一所高校冷门专业的学生，经常会遇到无法下载文献的情况，为解决这一问题，国内高校各图书馆间建立强大而有效的文献传递系统，#link("https://blyun.com")[百链]，其使用类似同百度学术，只要将文献信息提交并留下联系邮箱，一般 3 天之内就能收到自己想要的文献。

#figure(
  image("images/doc-bylun.png", width: 40%),
  caption: "百链",
)

== 突破垄断 – Sci-Hub

若百链仍然帮助你获取已经检索到的文献，那你不妨试试 Sci-Hub，你的问题将会有超过 9 成的概率被解决。

#link("https://sci-hub.se")[Sci-Hub] 是由哈萨克斯坦研究生 Alexandra Asanovna Elbakyan（Алекса́ндра Аса́новна Элбакя́н，1988\~）在 2011 年创立的一个业余项目，旨在帮助科研工作者们突破出版商们的高校“付费墙”。由于 Sci-Hub 遭到各出版商的不断打压，网站域名也经常由于被屏蔽而更换，所以若遇到不能登录的情况，请前往各论坛咨询。

Sci-Hub 相对简单，常用方法为到相应期刊网站查找到（ctr + f）目标文献的 DOI（Digital Object Identifier），然后粘贴于 Sci-Hub 搜索栏中进行搜索即可。

#figure(
  image("images/doc-doi.png", width: 40%),
  caption: "DOI",
)

#figure(
  image("images/doc-sci-hub.png", width: 40%),
  caption: "Sci-Hub",
)

== 文献交流 – ResearchGate

对于一些新发表的文献，Sci-Hub 可能还来不及计时更新，此时你可以求助 #link("https://researchgate.net")[ResearchGate]，在此网站上向目标文献的作者求助，请求其将文献通过邮箱分享给你。

ResearchGate 是一个科研社交网络服务网站，于 2008 年 5 月上线。网站旨在推动全球范围内的科学合作。用户可以联系同行，了解研究动态，分享科研方法以及交流想法@thelwallResearchgateDisseminatingCommunicating2015。

当然，ResearchGate 反馈效率因人而异，有时等待时间会无比漫长。不过，ResearchGate 可以帮助你及时了解自己已发表文章的动态（被引用次数等）和同领域相关研究进展，所以，对于有志于长期投身于科研的同学来说，还是建议拥有一个 ResearchGate 账户。

= 文献的重命名
<文献的重命名>

下载好的文献的文件名往往因为来源的不同千奇百怪，当文献达到一定数量时，查找起来会非常麻烦，影响效率。所以，建议大家把整理文献的时间均摊到平时，在文献下载时或完成后，便立即对其进行重命名，推荐采用同一的样式进行重命名，这样便于查找。如“发表年份-标题”的样式进行重命名：

#figure(
  image("images/doc-filenames.png", width: 40%),
  caption: "文献的重命名",
)

= 回顾与总结
<回顾与总结>

+ 什么是SCI？
+ 什么是IF值，其是如何计算的？
+ SCI的官网是哪个？其与SCI期刊有什么具体关系？
+ 百度学术一般适用于什么类型文献的检索？
+ 遇到文献需要付费下载的文献怎么办？
+ 文献重命名应遵从什么原则？

= 结束语
<结束语>

以上即是我自研究生以来关于查找和获取文献的经验总结，希望能够帮助大家尽快入门并步入科研正轨。熟练操作文献管理软件可以在科研上为我们节约很多时间，这个方面同学们要在平时多加实践，当然这个软件还有不少其他的非常实用的功能等着大家慢慢去探索。

上文中如有谬误，敬请指正，我的邮箱：`xavieryangzz@163.com`。

#bibliography("lib/scholar.bib", style: "future-science")

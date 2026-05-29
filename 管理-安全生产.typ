#import "lib/lib.typ": *
#show: chapter-style.with(title: "安全生产", info: info-man)

= 基本准则

== 6S 管理

6s管理，是兴起于日本企业的一种管理方法。6S 将工作现场中的人员、机器、材料、方法等生产要素进行有效的管理，针对企业每位员工的日常工作行为提出要求，倡导从小事做起，力求使每位员工都养成事事“讲究”的习惯，从而达到提高整体工作质量的目的。

6S具体指整理、整顿、清扫、清洁、素养和安全6个方面。由于这些日语单词的罗马标注发音的英文单词都以“S”开头，因而简称 6S。

#let data = csv("data/man-6s.csv")
#figure(
  tableq(data, 4),
  caption: none,
)

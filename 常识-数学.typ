#import "lib/lib.typ": *
#show: chapter-style.with(title: "数学", info: info-know)

= 数学概念
<数学概念>

== 数据类型
<数据类型>

数据分 4 种，分别是定类、定序、定距和定比。

- 定类数据：指数字只代表类别，没有顺序，不能比大小，不能四则计算。
  - 邮编
- 定序数据，数字代表”序数”或者”等级”，有顺序，可以比大小，但不能四则计算。
  - 宾馆星级
- 定距数据，没有绝对零点，有顺序，可以比大小，数据的差值有意义，但比例没有意义。
  - 摄氏温度
  - 时刻
- 定比数据，有绝对零点，有顺序，可以比大小，数据差值和比例都有意义。
  - 开氏温度
  - 时间

= 数学计算
<数学计算>

== 速算

- 两位数乘法
  - 平方
    - $(a × 10 + 5)^2 = (a + 1) × a × 100 + 25$

= 级数

== 有限级数

#figure(
  table(
    columns: (auto,) * 2,
    align: center + horizon,
    inset: 0.4em,
    stroke: table-three-line(rgb("000")),
    [Item], [Sum],
    [$n$], [$1 / 2n(n+1)$],
    [$n^2$], [$1 / 6n(n+1)(n+2)$],
    [$n^3$], [$[1 / 2n(n+1)]^2$],
    [$2n-1$], [$n^2$],
    [$(2n-1)^2$], [$1 / 3(2n-1)(2n+1)$],
    [$(2n-1)^3$], [$n^2(2n^2-1)$],
    [$(2n)^2$], [$2 / 3n(n+1)(2n+1)$],
    [$(2n)^3$], [$2n^2(n+1)^2$],
  ),
  caption: "有限级数",
)

== 无穷级数

=== 非交替型

#figure(
  table(
    columns: (auto,) * 2,
    inset: 0.4em,
    align: center + horizon,
    stroke: table-three-line(rgb("000")),
    [Item], [Sum],
    [], [$1 / 2^i$],
    [$1$], [$1 / 3^i$],
    [$1 / 2$], [],
    [$1 / 4^i$], [$1 / 3$],
    [$1 / (i-1)!$], [$e$],
    [],
  ),
  caption: "非交替无穷级数",
)

=== 交替型

#figure(
  table(
    columns: (auto,) * 2,
    inset: 0.5em,
    align: center + horizon,
    stroke: table-three-line(rgb("000")),
    [Item], [Sum],
    [$(-1)^(2i-1)1 / (2i-1)$], [$pi / 4$],
    [$(-1)^(2i-1) 1 / i$], [$ln 2$],
  ),
  caption: "交替无穷级数",
)

=== 其他

$ γ = (sum_(i=1)^(∞) frac(1, i!)) - lg ∞ $

= 几何

== 三角形

=== 特征

#let data = csv("data/math-triangle.csv")
#figure(tableq(data, 3), caption: "三角形点几何特征", kind: table)

- 重心：与顶点连线等分三角形面积
- Euler 圆：九点共圆，包括三边的中点、垂足和 Euler 点
- Fermat 点：到顶点距离和最小

= 代数证明
<代数证明>

== 构造

- $α, β ∈ ℂ$

令$α = a + b i, β = c + d i$

- $x, y ∈ 𝔽^n$

令$x = (x_1, x_2, …, x_n), y = (y_1, y_2, …, y_n)$

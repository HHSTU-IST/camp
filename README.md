# 训练营

本仓库存放各类培训课件和相关资料，主要面向人工智能和机器人领域。

为方便管理和查找，每个一级文件夹内的内容应相对独立，文件命名需遵循如下相应规范。同时，代码亦有相应规范。每个新加入的文件夹，需在[资料目录](#资料目录)处添加其文件结构简介。

## 文件管理

### 命名规范

公文中，标题通常有如下几种模式

- Title Case：所有单词的首字母大写（介词除外），其他字母小写，单词之间用空格隔开。
- Sentence Case：句首单词的首字母大写，其他单词的首字母小写，单词之间用空格隔开。
- Upper Case：所有单词全大写。
- Lower Case：所有单词全小写。

编程中，文件和变量命名通常有如下几种模式

- 🐪 Camel Case：所有单词首字母大写，单词之间不使用连接符。
- 📐 Pascal Case：所有单词首字母大写（除第一个单词外），单词之间不使用连接符。
- 🍖 Kebab Case：所有单词全小写，单词之间用短横线`-`隔开。
- 🐍 Snake Case：所有单词全小写，单词之间用下划线`_`隔开。
- 🔢 Constant Case：所有单词全大写，单词之间用下划线`_`隔开。

|   对象   | 中文  | 小写英文 | 数字  | 连接符 |       |
| :------: | :---: | :------: | :---: | :----: | :---: |
|  文件夹  |   ✅   |    ✅     |   ✅   |  `-`   |   🍖   |
| 媒体文件 |   ✅   |    ✅     |   ✅   |  `-`   |   🍖   |
| 文本文件 |   ✅   |    ✅     |   ✅   |  `-`   |   🍖   |
| 代码文件 |   ❌   |    ✅     |   ✅   |  `_`   |   🐍   |
|    类    |   ❌   |    ✅     |   ✅   |   ❌    |  🐪 📐  |
|   函数   |   ❌   |    ✅     |   ✅   |  `_`   |   🐍   |
|   常量   |   ❌   |    ❌     |   ✅   |  `_`   |   🔢   |

### 提交规范

- 每次提及的更改只发生在同一个一级文件夹内

## 资料目录

仓库根目录文件为知识分享文件，文件夹为课程相关文件。

### 根目录资料

- 工作流：高效的工作流程
- 技能：软件及工具推荐

### 编程基础

- python：Python 基础
- vscode：VS Code 环境搭建
  - lang-：语法简介
  - prog-：编程语言
  - tool-：常用工具链
  - unix-：Linux/macOS 环境
  - win-：Windows 环境

### 机器人

## 代码规范：Python

### Basics

#### Iteration

- `enumerate()` is prefered to `range(len())`

```python
xs = range(3)

# good
for ind, x in enumerate(xs):
  print(f'{ind}: {x}')

# bad
for i in range(len(xs)):
  print(f'{i}: {xs[i]}')
```

### Matplotlib

#### Subplots

- Object-based interface is prefered to Artist API
- `plt.subplots(, constrained_layout=True)` is prefered to `plt.tight_layout()` when draw subplots

```python
# good
_, axes = plt.subplots(1, 2, constrained_layout=True)
axes[0].plot(x1, y1)
axes[1].hist(x2, y2)

# bad
plt.subplot(121)
plt.plot(x1, y1)
plt.subplot(122)
plt.hist(x2, y2)
```

- `axes.flatten()` is prefered to `plt.subplot()` in cases where subplots' data is iterable
- `zip()` or `enumerate()` is prefered to `range()` for iterable objects

```python
# good
_, ax = plt.subplots(2, 2, figsize=[12,8], constrained_layout=True)

for ax, x, y in zip(axes.flatten(), xs, ys):
  ax.plot(x, y)

# bad
for i in range(4):
  ax = plt.subplot(2, 2, i+1)
  ax.plot(x[i], y[i])
```

#### Decoration

- `set()` method is prefered to `set_*()` method

```python

# good
ax.set(xlabel='x', ylabel='y')

# bad
ax.set_xlabel('x')
ax.set_ylabel('y')
```

- `ax.spines[*].set_visible()` with list is prefered to line-by-line `ax.spines[*].set_visible()`

```python
# good
ax.spines["top", "bottom"].set_visible(False)

# bad
ax.spines["top"].set_visible(False)
ax.spines["bottom"].set_visible(False)
```

## 代码规范：LaTeX 公式

### Multiple lines

Reduce the use of `begin{array}...end{array}`

- equations in centering: `begin{gathered}...end{gathered}`

$$
\begin{gathered}
  x_1 = \bigg(1 + \dfrac{3}{100} \bigg) ×10, 000 \\
  x_2 = \bigg(1 + \dfrac{3}{100} \bigg) × x_1 = \bigg(1 + \dfrac{3}{100} \bigg)^2×10, 000 \\
  …
\end{gathered}
$$

```latex
\begin{gathered}
  x_1 = \bigg(1 + \dfrac{3}{100} \bigg) ×10, 000 \\
  x_2 = \bigg(1 + \dfrac{3}{100} \bigg) × x_1 = \bigg(1 + \dfrac{3}{100} \bigg)^2×10, 000 \\
  …
\end{gathered}
```

- equations in numbered centering: `begin{gather}...end{gather}`

$$
\begin{gather}
3x_1^2 + 2x_1x_2 + x_2^2 \\
x_1^2 - 2x_2^2
\end{gather}
$$

```latex
\begin{gather}
3x_1^2 + 2x_1x_2 + x_2^2 \\
x_1^2 - 2x_2^2
\end{gather}
```

- equations aligned by symbols: `begin{aligned}...end{aligned}`

$$
\begin{aligned}
y_1 &= x^2 + 2*x \\
y_2 &= x^3 + x
\end{aligned}
$$

```latex
\begin{aligned}
y_1 &= x^2 + 2*x \\
y_2 &= x^3 + x
\end{aligned}
```

- equations with conditions: `begin{cases}...end{cases}`

$$
\begin{cases}
y = x^2 + 2*x & x > 0 \\
y = x^3 + x & x ⩽ 0
\end{cases}
$$

```latex
\begin{cases}
y = x^2 + 2*x & x > 0 \\
y = x^3 + x & x ⩽ 0
\end{cases}
```

- determinant: `begin{vmatrix}...end{vmatrix}`

$$
\begin{vmatrix}
  a + a' & b + b' \\
  c & d
\end{vmatrix} =
\begin{vmatrix}
  a & b \\
  c & d
\end{vmatrix} +
\begin{vmatrix}
  a' & b' \\
  c & d
\end{vmatrix}
$$

```latex
\begin{vmatrix}
  a + a' & b + b' \\
  c & d
\end{vmatrix} =
\begin{vmatrix}
  a & b \\
  c & d
\end{vmatrix} +
\begin{vmatrix}
  a' & b' \\
  c & d
\end{vmatrix}
```

- matrix: `begin{bmatrix}...end{bmatrix}`

$$
\begin{bmatrix}
  a_{11} & a_{12} & ⋯ & a_{1n} \\
  a_{21} & a_{22} & ⋯ & a_{2n} \\
  ⋮ & ⋮ & ⋱ & ⋮ \\
  a_{m1} & a_{m2} & ⋯ & a_{mn}
\end{bmatrix}
$$

```latex
\begin{bmatrix}
  a_{11} & a_{12} & ⋯ & a_{1n} \\
  a_{21} & a_{22} & ⋯ & a_{2n} \\
  ⋮ & ⋮ & ⋱ & ⋮ \\
  a_{m1} & a_{m2} & ⋯ & a_{mn}
\end{bmatrix}
```

### Brackets

- Prefer `\bigg...\bigg` to `\left...\right`

$$
A\bigg[\frac{1}{2}\ \frac{1}{3}\ ⋯\ \frac{1}{99}\bigg]
$$

```latex
A\bigg[\frac{1}{2}\ \frac{1}{3}\ ⋯\ \frac{1}{99}\bigg]
```

- Prefer `\underset{}{}` to `\underset{}`

### Expressions

- Prefer `^{\top}` to `^T` for transpose

$$
A^{⊤}
$$

```latex
A^{\top}
```

- Prefer `\to` to `\rightarrow` for limit

$$
\lim_{n → ∞}
$$

```latex
\lim_{n\to \infty}
```

- Prefer `underset{}{}` to `\limits_`

$$
\underset{w}{\mathrm{argmin}}(wx + b)
$$

```latex
\underset{w}{\mathrm{argmin}}(wx + b)
```

### Fonts

- Prefer `mathrm{}` to `{\rm }` or `\mathop{}` or `\operatorname{}`

$$
θ_\mathrm{MLE} = \underset{θ}{\mathrm{argmax}}\sum_{i=1}^{N}\log p(x_i ∣ θ)
$$

```latex
θ_\mathrm{MLE} = \underset{θ}{\mathrm{argmax}}\sum_{i=1}^{N}\log p(x_i ∣ θ)
```

- Prefer `\mathbf{}` to `{\bf }`
- Prefer `\mathit{}` to `{\it }`

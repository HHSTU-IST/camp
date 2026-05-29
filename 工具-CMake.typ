#import "lib/lib.typ": *
#show: chapter-style.with(title: "CMake 简介", info: info-tool)

= 构建系统

构建系统（build system），又称构建器，是用来从源代码生成用户可以使用的目标（targets）的自动化工具。目标可以包括库、可执行文件、或者生成的脚本等等。

构建系统的需求是随着软件规模的增大而提出的。当软件规模逐渐增加，此时不仅可能有成百上千个源代码文件，且有了模块划分，有的要编译成静态库，有的要编译成动态库，最后链接成可执行代码，此时命令行方式就捉襟见肘了，构建系统便应运而生。

#warning[
  构建系统并非 GCC 等编译器的替代，而是定义编译规则，最终还是会调用这些工具链编译代码。
]

迄今为止 C++ 至少有几十种构建系统，当下流行的如@sys。

#let csv1 = csv("data/tools-make.csv")
#figure(
  tableq(csv1, 6, inset: 0.35em),
  caption: "常用构建系统",
) <sys>

ᵃ 此为 CMake 在 GitHub 上的官方镜像的数据。

== Make

最常见的构建系统是 Make（GNU Make，BSD Make），其出现可以追溯至 1976 年，是最早的构建系统，Unix 系统的内置组件。在类 Unix 系统上，大多数 C++ 的项目代码是通过编写或生成 Makefile 进行编译构建的。

然而，直接编写 Makefile，复杂且难以阅读，维护困难；项目规模比较大的 C++ 项目尤甚。构建速度相对较慢。

== 其他主流构建系统

Maven 和 Gradle 均为 JVM 系编程语言的首选构建系统，在跨平台非常令人头痛的时期，和 JVM 联手确立了 Java 生态在软件工程领域的强势地位。两者区别在于，前者基于 XML 进行配置，而后者基于 Groovy 语言。Gradle 因在 2013 年被 Google 用作 Android 项目的构建系统而声名大噪。

Ninja 专注中小型工程，是对当时庞杂臃肿的 Make 和 CMake 的一种非常受欢迎的解决方案。现在，很多时候会代替 Make 作为 CMake 的后端出现。

Meson 是由 Python 编写的多语言构建系统。相比于其他几个构建系统，Meson 有些默默无闻，但在底层为 C/++ 的 Python 库的开发者中，备受推崇。2023 年，所有主流的数据科学 Python 库全部采用了 Meson 进行构建发布。

Bazel 是第一个支持云编译的多语言构建系统，以易用性著名，在诸多商业公司中，有很高的人气。被 Tensorflow 项目选中，也让其迎来了又一波热度。

XMake 是国人程序员 waruqi 基于 Lua 编写一款灵活而强大的构建系统。其特性有且不限于支持多语言，支持多后端，集成多种包管理器，提供多种主流编辑器插件，交互式命令行等等。其几乎兼具了所有其他构建系统的主打卖点，但由于更多依赖作者个人维护，缺少推广，所以用户还不够多。

== 项目构建系统

除了通用构建系统外，还有 2 个非常有名的编辑器自带的构建器，QMake 和 MSBuild。

其中，QMake 是 Qt 自带的构建器。QMake 根据 Qt 工程文件（.pro）来生成对应的 Makefile。.pro 文件语法简单，可以自己手写，但是更多时候都是由 Qt Creator 自动生成。由于 QMake 简单、好用、跨平台，且是可以独立于 IDE，所以也可用在非 Qt 工程上面，只要在 .pro 文件中加入`CONFIG -= qt` 就可以了。然而，由于 CMake 3 生态近些年的大繁荣，Qt6 也将 CMake 作为默认构建器取代了亲生的 QMake。

MSbuild 是微软旗下的产品，在 Visual Studio 2013 前，MSBuild 作为 .NET 框架的一部分，之后，MSBuild 被绑定到了 Visual Studio。MSBuild 的一个亮点是其构建速度很快，不过，作为硬伤，MSBuild 目前的跨平台性很差。

= 背景知识
<背景知识>

== 关于库

现实中每个程序都要依赖很多基础的底层库（library）。则库是什么？本质上，库是一种可以复用的、可执行的二进制代码，可以被操作系统载入内存执行。

库有两种：静态库和动态库。所谓静态、动态是针对链接（link）而言的。这里的链接指的是，从汇编到可执行文件的中间环节。

=== 静态库

静态库在链接阶段会将汇编生成的目标文件 `.o` 与引用到的库一起链接打包到可执行文件中。因此对应的链接方式称为静态链接。Linux 和 Windows 分别使用 ar 和 VS 的 lib.exe 将目标文件压缩到一起，并且对其进行编号和索引，以便于查找和检索，所以生成的文件扩展名分别为 `.a` 和 `.lib`。

简单说，一个静态库可以看成是一组目标文件（.o/.obj 文件）的集合，其有如下特征

- 对函数库的链接是放在编译时期完成的
- 程序在运行时与函数库再无瓜葛，移植方便
- 浪费空间和资源，因为所有相关的目标文件与牵涉到的函数库被链接合成一个可执行文件

=== 动态库

动态库和静态库类似，但是它并不在链接时将需要的二进制代码都“拷贝”到可执行文件中，而是仅仅“拷贝”一些重定位和符号表信息，这些信息可以在程序运行时完成真正的链接过程。Linux 和 Windows 通常以 `.so`（shared object）和 `dll`（dynamic-link library）作为动态库的文件扩展名。动态库有如下特征

- 将对一些库函数的链接载入推迟到程序运行的时期
- 可实现进程间的资源共享（故又称为共享库）
- 将一些程序升级变得简单
- 甚至可以真正做到链接载入完全由程序员在程序代码中控制（显示调用）

与创建静态库不同的是，无需打包工具（ar/lib.exe），直接使用编译器即可创建动态库。

== 宏

宏指令（macroinstruction），简称宏（macro），是一种批量处理的称谓。计算机科学里的宏是一种抽象，它根据一系列预定义的规则替换一定的文本模式。解释器或编译器在遇到宏时会自动进行这一模式替换。

不太严格的说，宏就是指把较长的指令序列用某种规则对应到较短的指令序列的规则或模式。

= CMake 基础
<基础>

CMake 是 Kitware 公司为了解决 ITK 软件跨平台构建的需求而设计出来的，是 Cross-platform Make 的简称。CMake 是一个元构建系统工具，支持多种语言，多种后端（backend），其中，默认后端为 Make。早年间的 CMake 并不好用，这种情况一直持续到 CMake 2.8，此时，C++11 还没有出现。而在这一时期产生了一大批非常糟糕的 CMake 教程，使很多人至今都对 CMake 望而却步。

2014 年，CMake 3 发布。新版本完成了对 CMake 的重构，并支持了 C++11，由此开启了加速迭代。在随后的版本中，陆续加入了对 UTF-8、CCache（编译器启动器）、ARM、Android、CUDA 以及多语言（Swift、C\#等）的支持。2021 年，CMake 3.21 开始支持 MSVC 和 MSYS（Windows 上的类 Unix 环境），成为了事实上的构建系统标准。

CMake 行为由 CMakeLists.txt 定义，其语句不区分大小写。通常，使用遵守如下约定

- 函数：全小写
- 变量：全大写

== Hello, World
<hello>

如同编程中的“Hello, World”一样，```cmake cmake_minimum_required``` 永远都是第一个需要知道的 CMake 语句。这个命令会出现在每个 CMakeLists.txt 中，且往往是第一行。如

```cmake
cmake_minimum_required(VERSION 3.12)
```
从 CMake 3.12 开始，版本号可以声明为一个范围，所以，大多数的项目开头会采用如下写法。

```cmake
cmake_minimum_required(VERSION 3.7...3.21)

if(${CMAKE_VERSION} VERSION_LESS 3.12)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()
```
然后，每一个顶层 CMakelists 文件都应该有下面这一行

```cmake
project(MyProject VERSION 1.0
                  DESCRIPTION "My 1st Project"
                  LANGUAGES CXX)
```

=== 导入项目文件
<项目文件>

接下来，我们使用```cmake include_directories()``` 导入项目文件。注意，目标文件所在的每一级目录都要单独导入。对于，较大的项目，IDE 会帮助我们完成这项繁琐的工作。

而对于其他依赖，我们应避免使用使用具有全局作用域的函数，如 ```cmake link_directories()```、```cmake include_libraries()```等。

#block(height: 10em, columns()[
  ```cmake
  include_directories(
    bin
    opt
    lib/Eigen/src/Array
    lib/Eigen/src/Cholesky
    lib/Eigen/src/Core
    lib/Eigen/src/Core/arch/AltiVec
    lib/Eigen/src/Core/arch/SSE
    lib/Eigen/src/Core/util
    ...)
  ```
])

=== 生成目标

首先，我们先试着生成一个可执行文件，这里用到的语句是`add_executable()`。

```cmake
add_executable(<name> [WIN32] [MACOSX_BUNDLE]
               [EXCLUDE_FROM_ALL]
               [source1] [source2 ...])
```
其中，各参数释义为

- name：可执行文件的名称，也就是目标（target）的名称。
- WIN32：可选参数，控制是否生成 `WIN32_EXECUTABLE`
- MACOSX_BUNDLE：可选参数，控制是否生成 `MACOSX_BUNDLE`
- source\*：源文件的列表，想列多少个都可以。CMake 根据拓展名只编译源文件。在大多数情况下，头文件将会被忽略。

#tip[
  CMake 文档中，`< >` 表示普通参数，`[ ]` 表示关键字参数，通常用于控制函数的行为模式。
]

=== 制作库

我们可以 ```cmake add_library()``` 制作一个库，并指定库的类型，若不指定，CMake 将会通过 `BUILD_SHARED_LIBS` 的值来选择库类型。

```cmake
add_library(<name> [STATIC | SHARED | MODULE]
            [EXCLUDE_FROM_ALL]
            [<source>...])
```
其中，前 2 个参数分别为库文件名称和库类型（静态｜动态｜插件）。

=== 回到目标

我们来添加关于目标的信息，首先是目录

```cmake
target_include_directories(<target> [SYSTEM] [AFTER|BEFORE]
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```
其中，各参数释义为

- name：目标名称
- \<INTERFACE|PUBLIC|PRIVATE\> [items1...]：
  - PUBLIC 主要针对库，于任何链接到这个目标的目标也必须包含这个目录
  - PRIVATE：只影响当前目标，不影响依赖
  - INTERFACE：只影响依赖
现在，将目标之间链接起来

```cmake
add_library(another STATIC another.cpp)
target_link_libraries(another PUBLIC one)
```
```cmake target_link_libraries``` 可能是 CMake 中最有用也最令人迷惑的命令。它指定一个目标，并且在给出目标的情况下添加一个依赖关系。若不存在名称为 one 的目标，那它会添加一个链接到我们路径中 one 库。其 API 如下

```cmake
target_link_libraries(<target> ... <item>... ...)
```

== 变量

=== 本地与环境
```cmake set()``` 用于声明变量，如

```cmake
# 本地变量
set(<variable> <value>... [PARENT_SCOPE])
# 环境变量（不推荐）
set(ENV{<variable>} [<value>])
```
其中，`value...` 可以是个列表，如```cmake set(MY_VARIABLES "value" "value2")```

我们可以通过`${}`来解析本地变量，如`${MY_VARIABLE}`，而解析环境变量使用 `$ENV{variable_name}`。

=== 缓存
缓存变量是一类特殊的本地本地变量，其声明语句如下

```cmake
set(<variable> <value>... CACHE <type> <docstring> [FORCE])
```
其中

- `type` 有 5 个可选值，即 `BOOL`、`PATH`、`FILEPATH`、`STRING` 和 `INTERNAL`
- `docstring` 指对变量的描述
对于 `type`，绝大多数情况下，都会使用 `STRING`。`INTERNAL` 使得用户运行 `cmake -L ..` 或使用 GUI 的时候不会列出该变量。`PATH` 和 `FILEPATH` 分别表示文件夹路径和文件路径。当`type`为 `BOOL` 时，可以使用以下语句对其进行设置

```cmake
option(MY_OPTION "This one settable" OFF)
```
缓存实际上指 CMakeCache.txt，当运行 CMake 构建目录时会创建它。CMake 可以通过它来记住我们设置的所有东西，因此可以不必在重新运行 CMake 的时候再次列出所有的选项。

=== 属性

CMake 也可以通过属性来存储信息。一个全局的属性可以是一个有用的非缓存的全局变量。许多目标属性都是被以 `CMAKE_` 为前缀的变量来初始化的。如，当设置 `CMAKE_CXX_STANDARD` 这个变量，意味着之后创建的所有目标的 `CXX_STANDARD` 都将被设为 `CMAKE_CXX_STANDARD` 变量的值。

我们可以一次性设置多个目标、文件、或测试。

```cmake
set_property(TARGET TargetName PROPERTY CXX_STANDARD 11)
```
也可以一个目标设置多个属性的快捷方式。

```cmake
set_target_properties(TargetName PROPERTIES CXX_STANDARD 11)
```
对于已知属性，可以使用如下语句获取

```cmake
get_property(ResultVariable TARGET TargetName PROPERTY CXX_STANDARD)
```

== 控制流与函数

=== 条件语句

正如我们在@hello 所见，CMake 有内置的 `if...else` 语句，对于变量，我们可以这样写

```cmake
if("${variable}")
    # True if variable is not false-like
else()
    # Note that undefined variables would be `""` thus false
endif()
```
这里还有一些可以设置的关键字，如：

- 一元的：`NOT`、`TARGET`、`EXISTS`、`DEFINED` 等。
- 二元的：`STREQUAL`、`AND`、`OR`、`MATCHES`、`VERSION_LESS`、`VERSION_LESS_EQUAL` 等。

=== 函数与宏

CMake 允许自定义函数（function）或宏（macro）。

#block(height: 7em, columns()[
  ```cmake
  # 函数
  function(<name> [<arg1> ...])
    <commands>

  endfunction()
  # 宏
  macro(<name> [<arg1> ...])
    <commands>

  endmacro()
  ```
])

function 和 macro 在作用域上存在区别，前者的作用域是局部的，而后者的作用域是全局的。若想让 function 中定义的变量对外部可见，需要使用`PARENT_SCOPE`来改变其作用域。function 还可以有返回值，返回值可以通过```cmake set()```设置。如

#block(height: 7em, columns()[
  ```cmake
  function(add_numbers num1 num2)
    math(EXPR result "${num1} + ${num2}")
    set(${result} PARENT_SCOPE)
  endfunction()

  add_numbers(1 2)
  message("The result is ${RESULT}")
  # The result is 3
  ```
])

若是在嵌套函数中，使用`PARENT_SCOPE`会变得异常繁琐，因为必须在想要变量对外的可见的所有函数中添加`PARENT_SCOPE`标志。这样函数才不会像宏那样对外“泄漏”所有的变量。实践中，我们可以通过在调用时设定变量值的形式来获取返回值。

#block(height: 5em, columns()[
  ```cmake
  function(add_numbers num1 num2)
    math(EXPR result "${num1} + ${num2}")
  endfunction()
  add_numbers(1 2 RESULT)
  message("The result is ${RESULT}")
  # The result is 3
  ```
])

=== 参数的控制

CMake 拥有一个变量命名系统，可以通过 ```cmake cmake_parse_arguments()```来对变量进行命名与解析。这个函数在 CMake 3.5 被引入。其调用格式为

#block(height: 11em, columns(gutter: 1em)[
  ```cmake
  # 形式 1
  cmake_parse_arguments(<prefix>

    <options>

    <one_val_keywords>

    <multi_value_keywords>

    <args>...
  )
  # 形式 2
  cmake_parse_arguments(PARSE_ARGV <N>

    <prefix>

    <options>

    <one_val_keywords>

    <multi_value_keywords>

  )
  ```
])

这里的参数似乎有点多，我们给出一个简单的例子方便理解

#block(height: 15em, columns(gutter: 1em)[
  ```cmake
  function(COMPLEX)
      cmake_parse_arguments(
          THE_PREFIX
          "SINGLE;ANOTHER"
          "ONE_VAL;ALSO_ONE_VAL"
          "MULTI_VALS"
          ${ARGN}
      )
  endfunction()

  complex(
    SINGLE
    ONE_VAL value
    MULTI_VALS one two three
  )
  # THE_PREFIX_SINGLE = TRUE
  # THE_PREFIX_ANOTHER = FALSE
  # THE_PREFIX_ONE_VAL = "value"
  # THE_PREFIX_ALSO_ONE_VAL = <UNDEFINED>

  # THE_PREFIX_MULTI_VALS = "one;two;three"
  ```
])

可以看到

- 参数 1，`THE_PREFIX` 为所有参数的前缀（prefix）
- 参数 2，`"SINGLE;ANOTHER"` 接收选项值，有则为 TRUE，反之为 FALSE
- 参数 3，`"ONE_VAL;ALSO_ONE_VAL"` 接收单个关键字，缺省值为 `<UNDEFINED>`
- 参数 4，`"MULTI_VALS"` 接收多个关键字
- 参数 5，`${ARGN}` 为普通参数列表

当然，我们也可以选择使用```cmake set()```来避免使用分号，有时候，这样看起来可能会更清晰，如

```cmake
macro(my_install)
    set(options OPTIONAL FAST)
    set(oneValueArgs DESTINATION RENAME)
    set(multiValueArgs TARGETS CONFIGURATIONS)
    cmake_parse_arguments(MY_INSTALL
      "${options}"
      "${oneValueArgs}"
      "${multiValueArgs}" ${ARGN}
    )
    # ...
```

== 获取第三方库

当我们想要在配置的时候下载数据或者是包，而非在编译的时候下载，可以使用`FetchContent`模块（CMake 3.11+ 支持）。

```cmake
include(FetchContent)
FetchContent_Declare(
  Armadillo
  GIT_REPOSITORY https://gitlab.com/conradsnicta/armadillo-code
  GIT_TAG        12.8.x
)

# CMake 3.14+
FetchContent_MakeAvailable(Armadillo lib/armadillo)

add_executable(fetch_example main.cpp)
target_link_libraries(fetch_example PRIVATE Armadillo::arma)
add_test(NAME fetch_example COMMAND fetch_example)
```

== 安装、导出、打包

= Qt 项目实践
<qt>

== 基本设置

```cmake
# 设置所需的最低 CMake 版本
cmake_minimum_required(VERSION 3.5)
# 指定项目名称和版本
set(PROJECT_NAME MyProject)
project(${PROJECT_NAME} VERSION 0.1 LANGUAGES CXX)
# 设置 C++ 标准，并要求编译器支持此标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
```

=== 全局变量

首先，让我们来看一下 Qt 项目必然遇到的三个变量。

```cmake
# 启用自动 UI 编译（AUTOUIC）
set(CMAKE_AUTOUIC ON)
# 自动元对象编译（AUTOMOC）
set(CMAKE_AUTOMOC ON)
# 自动资源编译（AUTORCC）
set(CMAKE_AUTORCC ON)
```
`CMAKE_AUTOUIC` 参数用于控制自动调用 Qt 的 UI 编译器（user interface compiler，UIC），将 .ui 文件转换为对应的 C++ 代码，并将生成的 C++ 文件添加到构建系统中，以便编译器编译。

类似的，`CMAKE_AUTOMOC`参数用于控制自动调用 Qt 元对象编译器（meta object compiler，MOC），处理 Qt 中的特殊 C++ 扩展，例如信号和槽、动态属性和反射机制。启用后，CMake 会在构建过程中自动为需要 MOC 处理的 Qt 扩展生成对应的 MOC 输出文件，并添加到构建系统中，以便编译器编译。

而`CMAKE_AUTORCC`参数用于启用自动处理 Qt 资源文件的功能。启用后，CMake会在构建过程中自动查找项目中的资源文件（.qrc文件），并调用资源编译器（resource compiler，RCC）来将这些资源文件编译为二进制数据，并添加到构建系统中，以便在应用程序中使用。

== 文件与依赖

=== 导入项目文件

如同，我们在@项目文件 中所见到的那样，使用```cmake include_directories()```导入项目文件。这里，为了后面可能的复用，我们给文件列表设定一个变量名。

```cmake
# 定义项目的源文件列表
set(PROJECT_SOURCES main.cpp widget.cpp widget.h widget.ui qtplot.cpp qtplot.h)
# 包含源文件目录
include_directories(${PROJECT_SOURCE_DIR})
```

=== 导入依赖

接下来，我们需要加载 Qt 了。

```cmake
# Qt 安装路径
set(CMAKE_PREFIX_PATH "/bin/qt")

find_package(QT NAMES Qt6 Qt5 COMPONENTS REQUIRED COMPONENTS Widgets PrintSupport)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets PrintSupport)
```

这里，第一个 ```cmake find_package()``` 中，CMake 尝试查找并加载 Qt6，若找不到再尝试 Qt5，同时 CMake 将要求同时加载 Widgets 和 PrintSupport 这两个模块，`REQUIRED` 关键字确保这些模块是必需的，若找不到任何一个模块，将会导致 CMake 错误并停止构建过程。在此过程中，CMake 将对 `QT_VERSION_MAJOR` 变量进行赋值告诉我们使用到的 QT 版本是什么。

第二个```cmake find_package()```根据第一个```cmake find_package()```中找到的 Qt 版本来引用具体的模块。这样连续的两个```cmake find_package()```，确保了之后的构建过程中使用到的模型能够和先前找到的 Qt 版本匹配。

== 生成可执行文件

现在，我们来创建可执行文件。由于从 Qt 5.14 版本开始，Qt 推荐使用 ```cmake qt_add_executable()``` 代替 ```cmake add_executable()```，以更好地集成 Qt 的构建系统。所以，我们这样写。

```cmake
if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
  qt_add_executable(main MANUAL_FINALIZATION ${PROJECT_SOURCES})
else()
  add_executable(main ${PROJECT_SOURCE_DIR})
endif()
```
接下来，将 Qt 模块链接到目标可执行文件或动态库。使用```cmake target_link_libraries()```。

```cmake
target_link_libraries(main PRIVATE Qt${QT_VERSION_MAJOR}::Widgets
                                        Qt${QT_VERSION_MAJOR}::PrintSupport)
```
然后，我们为可执行文件设置属性。

#let code1 = read("data/cm_dll_prop.txt")
#code(code1, lang: "cmake")

#tip[
  设置属性也可以使用```cmake set_property()```，但它一次只能设置一个属性，不推荐使用。
]

最后，安装目标可执行文件到指定的目录，这里使用当前目录，也就是`.`。

```cmake
install(
  TARGETS main
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
```
补充一点，若使用的是 Qt6，则使用`qt_finalize_executable()`进行最后的可执行文件处理。这是一个 CMake 宏，用于在构建 Qt 应用程序时进行最后的可执行文件处理。对于旧版本的 Qt，不需要调用此宏，因为构建过程会自动完成。

```cmake
if(QT_VERSION_MAJOR EQUAL 6)
  qt_finalize_executable(MyProject)
endif()
```

=== 添加子模块

若我们需要将，一个库或子文件夹（假定为 my_module）的程序作为一个独立的模块，则我们需要在根目录的 CMakeLists.txt 通过 ```cmake add_subdirectory()``` 添加。

```cmake
add_subdirectory(my_module)
add_executable(main ${PROJECT_SOURCE_DIR})
target_link_libraries(main PUBLIC my_module)
```
子模块目录中的 CMakeLists.txt 负责添加库

```cmake
add_library(my_module SHARED my_module.cpp my_module.h)
```

=== 关于 DLL

对 Windows 的动态链接库，在.h 文件开头和.cpp 文件开头，还要分别加上

#block(height: 10em, columns()[
  ```cmake
  #pragma once

  #ifdef _MSC_VER
  __declspec(dllimport)
  #endif
  void func1();
  #include <cstdio>

  #ifdef _MSC_VER
  __declspec(dllexport)
  #endif
  void func1() { ... }
  ```
])

需要注意的是，.dll 和 .exe 必须在同一目录，因为 Windows 只会查找当前 .exe 所在目录，然后查找 `PATH`。这个问题的另一种解决方案是，把 .dll 文件所在位置加到我们的 `PATH` 环境变量里去，一劳永逸。当然，这两种方法都显得有一点点蠢。

另外，Windows 中，CMake 会把定义在顶层模块里的 main 放在 build 里。而 my_module.dll 会在 build/my_module 里的生成。为了让 CMake 把 .dll 自动生成在 .exe 同一目录，需要设置 my_module 对象的 `*_OUTPUT_DIRECTORY` 系列属性。

#let code1 = read("data/cm_dll_prop.txt")
#code(code1)

相比之下，Linux 系统支持 `RPATH`，CMake 会让生成出来可执行文件的 `RPATH` 字段指向他链接了的 .so 文件所在目录，运行时会优先从 `RPATH` 里找链接库，所以即使不在同目录也能找到。命令行使用 `chrpath` 可轻松修改 `RPATH`。CMake 也有一些列与 `RPATH` 相关的变量 `CMAKE_*_RPATH` 来控制 `RPATH` 的使用。如

- `CMAKE_INSTALL_RPATH`：以分号分隔的列表，用于指定安装目标的 RPATH
- `CMAKE_SKIP_RPATH`：若为"TRUE"，则不添加运行时的路径信息
- `CMAKE_SKIP_BUILD_RPATH`：不将 `RPATH` 包含在构建树中
- `CMAKE_BUILD_WITH_INSTALL_RPATH`：使用安装路径作为 `RPATH`
- `CMAKE_INSTALL_RPATH_USE_LINK_PATH`：添加链接搜索路径和已安装的 `RPATH` 路径

#tip[
  #align(center, "结论：请远离 Windows")
]

= Visual Studio 实践
<vs>

== 基本设置

== 文件与依赖

== 生成可执行文件

```cmake
set(BUILD_FLAGS "-DHZ_PLATFORM_WINDOWS -DWINDOWS -DHZ_BUILD_DLL" )
set_target_properties(main PROPERTIES COMPILE_FLAGS ${BUILD_FLAGS})
```

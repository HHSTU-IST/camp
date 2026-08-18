# 搭建便捷嵌入式开发环境（VSCode）

PlatformIO 是一个专业的开源物联网与嵌入式开发生态系统，主要支持 VSCode 插件、跨平台构建、库管理器三项核心功能，能极大简化单片机与物联网开发。它支持上千种开发板（如 ESP32、STM32、Arduino 等），提供比传统 Arduino IDE 更快的编译和智能代码提示。

## 1. 安装 PlatformIO IDE 扩展

在 VSCode 扩展商店，搜索并安装 PlatformIO IDE 扩展（下载数量最多的那个）

> 图片没必要展示了。

安装完成后，VSCode 侧边栏会出现 PlatformIO 图标。第一次启动 PlatformIO 时，会自动下载核心组件和工具链，需要等待一段时间。出现 PlatformIO 图标，说明安装成功。

## 2. 创建 PlatformIO 项目

点击 VSCode 侧边栏的 PlatformIO 图标。

依次点击 PIO Home -> New Project

填写项目信息：

- Name: 项目名称
- Board: 开发板型号
- Framework: 开发框架
  - Arduino：方便快速验证
  - STM32Cube：更接近 STM32 工程
- Location: 项目保存位置

填写完成后点击创建，PlatformIO 会自动生成项目结构。PlatformIO 项目一般包含以下内容：

```text
project-name/
├── platformio.ini
├── include/
├── lib/
├── src/
│   └── main.cpp
├── test/
└── README.md
```

目录说明：

- `platformio.ini`：项目配置文件
- `include/`：头文件目录
- `lib/`：项目私有库目录
- `src/`：主程序目录
- `test/`：测试目录
- `README.md`：项目说明文档

## 3. 配置 platformio.ini

### 3.1. 常用配置项

常用配置项包括：

```text
platform        芯片平台
board           开发板型号
framework       开发框架
monitor_speed   串口监视器波特率
upload_port     烧录端口
monitor_port    串口监视器端口
lib_deps        第三方库依赖
```

若需要指定串口，可以在 `platformio.ini` 中添加：

```ini
upload_port = COM端口号
monitor_port = COM端口号
monitor_speed = 115200
```

Windows 下端口号可以在设备管理器中查看。

### 3.2. STM32F103C8T6 配置

```ini
[env:bluepill_f103c8]
platform = ststm32
board = bluepill_f103c8
framework = arduino
upload_protocol = stlink
monitor_speed = 115200
```

### 3.3. STM32F103RC 配置

```ini
[env:genericSTM32F103RC]
platform = ststm32
board = genericSTM32F103RC
framework = arduino
upload_protocol = stlink
monitor_speed = 115200
```

### 3.4. 使用 STM32Cube 框架

```ini
[env:bluepill_f103c8]
platform = ststm32
board = bluepill_f103c8
framework = stm32cube
upload_protocol = stlink
monitor_speed = 115200
```

### 3.5. 指定串口号

完整配置示例：

```ini
[env:bluepill_f103c8]
platform = ststm32
board = bluepill_f103c8
framework = arduino
upload_protocol = stlink
upload_port = COM26
monitor_port = COM26
monitor_speed = 115200
```

## 4. 主程序编写

- 主程序通常写在 `src/main.cpp`

若使用 Arduino Framework，入口函数通常是：

```text
setup()
loop()
```

若使用 STM32Cube Framework，入口函数通常是：

```text
main()
```

## 5. 编译与烧录

- 每次修改代码后，需要重新编译并烧录到开发板。
- 编译按钮为`√`，也可以在终端执行

```bash
pio run
```

- 若项目编译异常，可以清理缓存，然后重新编译：

```bash
pio run --target clean && pio run
```

- 烧录按钮为`→`，也可以在终端执行：

```bash
pio run --target upload
```

若 ESP32 烧录时一直停在 `Connecting`，可以按住开发板的 `BOOT` 键后重新烧录。

## 6. 串口与调试

### 6.1. 监视器

打开串口监视器可以点击 VSCode 底部工具栏中的串口监视器按钮。

也可以在终端执行：

```bash
pio device monitor
```

指定波特率：

```bash
pio device monitor -b 115200
```

退出串口监视器：

```text
Ctrl + C
```

### 6.2. 查看串口设备

查看当前电脑连接的串口设备：

```bash
pio device list
```

串口乱码时，检查程序中的串口波特率是否和 `monitor_speed` 一致。

## 7. 常用命令

| 命令                      | 作用           |
| ------------------------- | -------------- |
| `pio run`                 | 编译项目       |
| `pio run --target upload` | 烧录程序       |
| `pio device monitor`      | 打开串口监视器 |
| `pio device list`         | 查看串口设备   |
| `pio run --target clean`  | 清理编译缓存   |
| `pio pkg list`            | 查看项目依赖   |
| `pio pkg update`          | 更新项目依赖   |

## 8. 第三方库

- 通过 PlatformIO 图形界面安装：点击 PIO Home > Libraries
- 通过 platformio.ini 安装：在 `platformio.ini` 中添加：

```ini
lib_deps = 库名称
```

保存后，PlatformIO 会自动下载依赖。

## 9. ST-Link

若使用 ST-Link 烧录 STM32，需要安装 ST-Link 驱动。安装完成后，将 ST-Link 接入电脑，并在设备管理器中确认识别正常。

 ST-Link 接线 为

| ST-Link | STM32      |
| ------- | ---------- |
| 3.3V    | 3.3V       |
| GND     | GND        |
| SWDIO   | SWDIO      |
| SWCLK   | SWCLK      |
| NRST    | NRST，可选 |

注意事项：

```text
必须共地
不要接错 3.3V 和 5V
确认开发板供电正常
确认 ST-Link 驱动正常
SWDIO 和 SWCLK 不要接反
```

## 10. 常见问题原因

### 10.1. 串口没有输出

- USB 数据线不支持数据传输
- 串口线未连接
- 串口号错误
- 波特率错误
- 程序没有初始化串口
- TX/RX 接反
- GND 未共地

### 10.2. 串口乱码

- 程序波特率和 monitor_speed 不一致

### 10.3. 编译失败

- framework 选择错误
- 头文件路径错误
- 代码语法错误
- 库依赖缺失

### 10.4. 烧录失败

- upload_protocol 未设置为 stlink
- SWDIO 和 SWCLK 接反
- 开发板未供电
- GND 未共地
- 芯片型号选择错误

### 10.5. 找不到 ST-Link

- ST-Link 驱动未安装
- USB 数据线异常
- ST-Link 接触不良
- 电脑没有识别设备

## 11. 文档维护

后续新增项目时，建议记录：

- 开发板型号
- 芯片型号
- 开发框架
- 烧录方式
- 串口号
- 主要外设
- 引脚连接
- 测试结果
- 常见问题

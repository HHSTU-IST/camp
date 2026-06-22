# OpenClaw

> 全程只需要复制粘贴几条命令，跟着做就能搞定。

## 安装 Node.js

macOS/Linux 用户，使用 Homebrew

```shell
brew install nodejs
```

Windows 用户，使用 Scoop

```powershell
scoop install node-lts
```

或使用 winget

```console
winget install OpenJS.NodeJS.LTS
```

## 安装 OpenClaw

> ⚠️ 重要：不要安装 3.22 及以上版本，否则无法连接微信！

复制粘贴下面这行命令，按回车：

```console
npm install -g openclaw
```

安装成功后，脚本会引导你配置 **AI 大模型的 API Key**，推荐**智谱（zai）** 或 **Kimi（moonshot）**

## 安装仪表盘

```console
openclaw dashboard
```

## 连接微信

### 安装 ClawBot

在刚才的 PowerShell 窗口中，输入以下命令：

```text
npx -y @tencent-weixin/openclaw-weixin-cli@latest install
```

系统会自动下载并安装微信插件。

### 扫码授权

### 重启服务

扫码授权后，执行：

```text
openclaw gateway restart
```

重启成功后，微信通讯录中会出现 **「微信ClawBot」** 。

## 开始使用

打开微信 → 找到「微信ClawBot」→ 发送任意消息（比如“你好”），就能和你的 OpenClaw AI 对话了。

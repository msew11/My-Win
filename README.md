# My-Win

基于 Windows 的个人工作流配置集合，涵盖了平铺窗口管理、终端增强及美化。

---

## 📑 目录 (Table of Contents)

| 📚 类别 (Category) | ✨ 应用 (App) | 🔗 配置链接 (Config Link) |
| :--- | :--- | :--- |
| **Status Bar** | YASB | [config/YASB](./config/YASB) |
| **Window Manager** | GlazeWM | [config/GlazeWM](./config/GlazeWM) |
| **Terminal** | Windows Terminal | [config/Terminal](./config/Terminal) |
| **System Fetch** | Fastfetch | [config/Fastfetch](./config/Fastfetch) |
| **Shell Prompt** | Oh My Posh | [PowerShell Profile](./config/Terminal/Microsoft.PowerShell_profile.ps1) |
| **File Manager** | **Yazi** | **[yazi.md](./yazi.md)** |
| **Package Manager** | **Scoop** | **[scoop.md](./scoop.md)** |

---

## 🚀 快速开始

### 1. 克隆仓库
```powershell
git clone https://github.com/your-username/My-Win.git
cd My-Win
```

### 2. 设置符号链接 (Symbolic Links)
项目中包含 `setup_links.ps1` 脚本，用于将配置文件链接到系统对应的配置目录：
```powershell
./setup_links.ps1
```

### 3. 组件说明

#### 📂 文件管理器 (Yazi)
关于 Yazi 的详细安装步骤、插件说明及快捷键配置，请参阅：**[Yazi 配置指南](./yazi.md)**。

#### 🐚 终端与 Shell
使用 Windows Terminal 配合 PowerShell 7，通过 Oh My Posh 提供主题增强。

---

## 🛠️ 环境要求

- **OS**: Windows 10/11
- **Shell**: PowerShell 7+
- **Package Manager**: [Scoop](./scoop.md) (用于安装各类 CLI 依赖)
- **Font**: 建议安装 [Nerd Fonts](https://www.nerdfonts.com/) (如 JetBrainsMono Nerd Font) 以获得完整的图标支持。

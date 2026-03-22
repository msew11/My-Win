# PowerShell 美化指南

本工程提供了一套基于 PowerShell 7、Fastfetch 和 Oh My Posh 的终端美化方案。

## 安装步骤

### 1. 安装 PowerShell 7
使用 winget 安装最新版本的 PowerShell 7：
```powershell
winget install --id Microsoft.PowerShell --source winget
```

### 2. 安装 Fastfetch
使用 scoop 安装 Fastfetch 系统信息显示工具：
```powershell
scoop install fastfetch
```

### 3. 安装 Oh My Posh
使用 scoop 安装 Oh My Posh 提示符自定义工具：
```powershell
scoop install oh-my-posh
```

### 4. 安装 Terminal-Icons
安装 Terminal-Icons 模块以在终端中显示文件和文件夹图标：
```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery
```

### 5. 配置软链接
运行根目录下的 `setup_links.ps1` 脚本，根据提示选择以下编号进行配置：
- **Fastfetch**: 选择编号 **4**。
- **PowerShell 7 Profile**: 选择编号 **5**。

运行脚本前，请确保已开启 Windows 的“开发人员模式”或以管理员权限运行。

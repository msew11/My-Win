# Scoop 包管理器安装指南

Scoop 是 Windows 下的一个命令行包管理器，旨在减少在 Windows 上安装和管理各种开发工具和应用程序的麻烦。

## 1. 自定义路径安装 Scoop

为了节省 C 盘空间并保持个人文件夹整洁，建议将 Scoop 及其软件安装到 D 盘。

请在 PowerShell (推荐 PowerShell 7+) 中运行以下命令：

### 执行安装并指定路径
```powershell
# 1. 设置执行策略
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 2. 下载并执行安装脚本，通过参数指定 root_path 和 global_path
irm get.scoop.sh -outfile install.ps1

.\install.ps1 -ScoopDir 'D:\Users\<YourUsername>\scoop' -ScoopGlobalDir 'D:\Scoop'
```
> [!NOTE]
> 请将 `<YourUsername>` 替换为您系统中的实际用户名。执行完毕后，脚本会自动配置相应的系统环境变量。

安装完成后，你可以通过 `scoop help` 验证安装。

## 2. 添加软件库 (Buckets)

Scoop 默认只包含核心软件库。为了安装更多常用的第三方应用程序，建议添加 `extras` 库：

```powershell
# 添加 extras 库
scoop bucket add extras
```

## 3. 常用命令

- **搜索软件**: `scoop search <app>`
- **安装软件**: `scoop install <app>`
- **更新软件**: `scoop update <app>`
- **卸载软件**: `scoop uninstall <app>`
- **查看已安装**: `scoop list`


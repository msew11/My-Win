# Yazi 配置说明

Yazi 是一款用 Rust 编写的高性能、可定制、由异步 I/O 驱动的任务管理器。

## 1. 官方资源

- **GitHub 仓库**: [sxyazi/yazi](https://github.com/sxyazi/yazi)
- **官方文档**: [Yazi Documentation](https://yazi-rs.github.io/docs/)
- **插件市场**: [Yazi-rs Plugins](https://github.com/yazi-rs/plugins)

## 2. 安装 Yazi

在 Windows 上，推荐通过 **[Scoop](./scoop.md)** 快速安装：

```powershell
# 安装 Yazi
scoop install yazi
```

## 3. 插件安装

本配置使用了 `ya pkg` 插件管理器。如果您是第一次克隆此配置，可以使用以下命令安装或更新插件：

### 核心插件 (yazi-rs 官方库)
```powershell
# Git 集成 (显示文件列表侧边状态)
ya pkg add yazi-rs/plugins:git

# 全边框 UI
ya pkg add yazi-rs/plugins:full-border

# 智能进入 (Smart Enter)
ya pkg add yazi-rs/plugins:smart-enter
```

### 第三方插件
```powershell
# Githead (在顶部 Header 显示分支和详细统计)
ya pkg add llanosrocas/githead

# Lazygit 集成 (需要预装 lazygit)
ya pkg add Lil-Dank/lazygit
```

> [!IMPORTANT]
> `lazygit` 插件需要系统安装有 `lazygit` 命令行工具。
> 推荐通过 **[Scoop](./scoop.md)** 安装：
> ```powershell
> scoop install lazygit
> ```

### 批量安装所有配置
如果您已经存在 `package.toml`，也可以直接运行：
```powershell
ya pkg install
```

# 强制设置输出编码为 UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- 权限检查逻辑 ---
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "错误: 创建软连接需要管理员权限！" -ForegroundColor Red
    Write-Host "请尝试以下操作之一：" -ForegroundColor Yellow
    Write-Host "1. 右键点击 PowerShell，选择 '以管理员身份运行'"
    Write-Host "2. 在 Windows 设置中开启 '开发人员模式' (Developer Mode)"
    exit
}

# 定义映射列表
$mappings = @(
    @{
        Source      = "config\yazi"
        Destination = "$env:APPDATA\yazi\config"
    }
)

foreach ($map in $mappings) {
    # 路径解析
    $srcPath = Join-Path $PSScriptRoot $map.Source
    if (-not (Test-Path $srcPath)) {
        Write-Warning "源路径不存在，跳过: $srcPath"
        continue
    }
    $src = (Get-Item $srcPath).FullName
    $dest = [System.Environment]::ExpandEnvironmentVariables($map.Destination)

    Write-Host "`n--- 正在检查: $($map.Source) ---" -ForegroundColor Cyan

    # 1. 处理目标路径冲突
    if (Test-Path $dest) {
        $item = Get-Item $dest
        if ($item.Attributes -match "ReparsePoint") {
            $currentTarget = if ($item.LinkTarget) { $item.LinkTarget } else { $item.Target }
            $absCurrentTarget = (Get-Item $currentTarget).FullName
            if ($absCurrentTarget -eq $src) {
                Write-Host "软连接已存在且指向正确，无需操作。" -ForegroundColor Gray
                continue
            } else {
                Write-Host "软连接指向错误，正在重置..." -ForegroundColor Yellow
                Remove-Item $dest -Force
            }
        } else {
            $backup = $dest + "_back"
            if (Test-Path $backup) { Remove-Item $backup -Recurse -Force }
            Write-Host "发现同名目录，正在备份到: $backup" -ForegroundColor Yellow
            Move-Item $dest $backup
        }
    }

    # 2. 确保父目录存在
    $parentDir = Split-Path $dest -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    # 3. 创建软连接（带错误捕获）
    try {
        Write-Host "正在创建软连接: $dest -> $src"
        New-Item -ItemType SymbolicLink -Path $dest -Target $src -ErrorAction Stop | Out-Null
        Write-Host "连接成功！" -ForegroundColor Green
    } catch {
        Write-Host "连接失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}

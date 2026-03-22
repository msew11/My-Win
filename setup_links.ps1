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
    @{ Name = "Yazi"; Source = "config\_yazi"; Destination = "$env:APPDATA\yazi\config" }
    @{ Name = "GlazeWM"; Source = "config\_glazewm"; Destination = "$env:USERPROFILE\.glzr\glazewm" }
    @{ Name = "Yasb"; Source = "config\_yasb"; Destination = "$env:USERPROFILE\.config\yasb"; ProcessToKill = "yasb" }
    @{ Name = "Fastfetch"; Source = "config\_fastfetch"; Destination = "$env:USERPROFILE\.config\fastfetch" }
    @{ Name = "PowerShell7"; Source = "config\_powershell7\Microsoft.PowerShell_profile.ps1"; Destination = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }
)

# --- 省略中间函数 ---

function Get-LinkStatus {
    param($src, $dest)
    if (Test-Path $dest) {
        $item = Get-Item $dest
        if ($item.Attributes -match "ReparsePoint") {
            $currentTarget = if ($item.LinkTarget) { $item.LinkTarget } else { $item.Target }
            # 确保目标路径存在后再取 FullName
            if (Test-Path $currentTarget) {
                $absCurrentTarget = (Get-Item $currentTarget).FullName
                if ($absCurrentTarget -eq $src) { return "Linked" }
            }
            return "WrongTarget"
        } else {
            return "Conflict"
        }
    }
    return "Missing"
}

# --- 交互界面 ---
Write-Host "`n=== 配置文件软连接管理 ===" -ForegroundColor Cyan
$availableOptions = @()

for ($i = 0; $i -lt $mappings.Count; $i++) {
    $map = $mappings[$i]
    $srcPath = Join-Path $PSScriptRoot $map.Source
    if (-not (Test-Path $srcPath)) {
        Write-Host "$($i + 1). [$($map.Name)] 源路径不存在，跳过" -ForegroundColor Red
        continue
    }
    $src = (Get-Item $srcPath).FullName
    $dest = [System.Environment]::ExpandEnvironmentVariables($map.Destination)
    
    $status = Get-LinkStatus -src $src -dest $dest
    $displayIndex = $i + 1
    
    Write-Host "$displayIndex. [$($map.Name)] ($dest) " -NoNewline
    switch ($status) {
        "Linked" {
            Write-Host "已链接 (已就绪)" -ForegroundColor Gray
        }
        "WrongTarget" {
            Write-Host "链接指向错误 (待修复)" -ForegroundColor Yellow
            $availableOptions += $displayIndex
        }
        "Conflict" {
            Write-Host "存在同名冲突 (待备份并链接)" -ForegroundColor Magenta
            $availableOptions += $displayIndex
        }
        "Missing" {
            Write-Host "未链接" -ForegroundColor White
            $availableOptions += $displayIndex
        }
    }
}

if ($availableOptions.Count -eq 0) {
    Write-Host "`n所有配置已正确链接，无需操作。" -ForegroundColor Green
    exit
}

$choice = Read-Host "`n请输入要链接的应用编号 (例如 1)"

$val = 0
if (-not [int]::TryParse($choice, [ref]$val) -or ($availableOptions -notcontains $val)) {
    Write-Host "无效的选择或该应用已链接。" -ForegroundColor Red
    exit
}

# --- 执行链接逻辑 ---
$map = $mappings[$val - 1]
$srcPath = Join-Path $PSScriptRoot $map.Source
$src = (Get-Item $srcPath).FullName
$dest = [System.Environment]::ExpandEnvironmentVariables($map.Destination)

Write-Host "`n--- 正在处理: $($map.Name) ---" -ForegroundColor Cyan

# 0. 结束相关进程
if ($map.ProcessToKill) {
    $processes = Get-Process -Name $map.ProcessToKill -ErrorAction SilentlyContinue
    if ($processes) {
        Write-Host "正在结束进程: $($map.ProcessToKill)..." -ForegroundColor Yellow
        $processes | Stop-Process -Force
        
        # 等待进程完全退出（带超时监控）
        $timeoutSeconds = 10
        $elapsed = 0
        while ($elapsed -lt $timeoutSeconds) {
            if (-not (Get-Process -Name $map.ProcessToKill -ErrorAction SilentlyContinue)) {
                break
            }
            Start-Sleep -Seconds 1
            $elapsed++
        }

        if (Get-Process -Name $map.ProcessToKill -ErrorAction SilentlyContinue) {
            Write-Host "错误: 无法在 $($timeoutSeconds) 秒内结束进程 '$($map.ProcessToKill)'，操作已取消。" -ForegroundColor Red
            exit
        }
        Write-Host "进程已结束。" -ForegroundColor Gray
    }
}

# 1. 处理冲突或旧链接
if (Test-Path $dest) {
    $item = Get-Item $dest
    if ($item.Attributes -match "ReparsePoint") {
        Write-Host "正在移除旧的错误链接..." -ForegroundColor Yellow
        Remove-Item $dest -Force
    } else {
        # 针对文件使用 .bak 后缀，针对目录使用 _back 后缀
        $suffix = if ($item.PSIsContainer) { "_back" } else { ".bak" }
        $backup = $dest + $suffix
        
        if (Test-Path $backup) { Remove-Item $backup -Recurse -Force }
        Write-Host "发现同名冲突，正在备份到: $backup" -ForegroundColor Yellow
        Move-Item $dest $backup
    }
}

# 2. 确保父目录存在
$parentDir = Split-Path $dest -Parent
if (-not (Test-Path $parentDir)) {
    New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
}

# 3. 创建软连接
try {
    Write-Host "正在创建软连接: $dest -> $src"
    New-Item -ItemType SymbolicLink -Path $dest -Target $src -ErrorAction Stop | Out-Null
    Write-Host "链接成功！" -ForegroundColor Green
} catch {
    Write-Host "连接失败: $($_.Exception.Message)" -ForegroundColor Red
}

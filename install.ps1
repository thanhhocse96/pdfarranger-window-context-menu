# install.ps1 - Open in PDF Arranger context menu installer
# Right-click -> "Run with PowerShell"

$ErrorActionPreference = "Continue"

function Write-Step($msg) { Write-Host "`n$msg" -ForegroundColor Cyan }
function Write-OK($msg)   { Write-Host "   [OK] $msg" -ForegroundColor Green }
function Write-ERR($msg)  { Write-Host "   [!!] $msg" -ForegroundColor Red }
function Write-INF($msg)  { Write-Host "   [-] $msg" -ForegroundColor Gray }

# ---- Kiem tra quyen Admin ----
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
           ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

Write-Host "================================" -ForegroundColor Yellow
Write-Host " PDF Arranger - Context Menu    " -ForegroundColor Yellow
Write-Host "================================" -ForegroundColor Yellow
Write-INF "Admin: $isAdmin | User: $env:USERNAME"

# ---- Buoc 1: Tim pdfarranger.exe ----
Write-Step "[1/3] Tim kiem PDF Arranger..."

$exePath = $null

# Cach 1: Quet registry Uninstall key (chinh xac nhat, khong phu thuoc path)
Write-INF "Quet registry uninstall keys..."
$regKeys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)
foreach ($regKey in $regKeys) {
    Get-ItemProperty $regKey -ErrorAction SilentlyContinue |
    Where-Object { $_.DisplayName -match "PDFArranger|PDF Arranger" } |
    ForEach-Object {
        # Thu InstallLocation truoc
        $candidate = "$($_.InstallLocation)\pdfarranger.exe".Trim()
        if (Test-Path $candidate) {
            $exePath = $candidate
            Write-OK "Tim thay (InstallLocation): $exePath"
        }
        # Thu UninstallString de lay folder neu InstallLocation rong
        if (-not $exePath -and $_.UninstallString) {
            $dir = Split-Path $_.UninstallString -Parent
            $candidate2 = "$dir\pdfarranger.exe"
            if (Test-Path $candidate2) {
                $exePath = $candidate2
                Write-OK "Tim thay (UninstallString): $exePath"
            }
        }
    }
    if ($exePath) { break }
}

# Cach 2: where.exe (neu pdfarranger co trong PATH)
if (-not $exePath) {
    Write-INF "Thu where.exe..."
    $whereResult = where.exe pdfarranger 2>$null
    if ($whereResult -and (Test-Path $whereResult)) {
        $exePath = $whereResult
        Write-OK "Tim thay (PATH): $exePath"
    }
}

# Cach 3: Get-Command
if (-not $exePath) {
    Write-INF "Thu Get-Command..."
    $cmd = Get-Command pdfarranger -ErrorAction SilentlyContinue
    if ($cmd) {
        $exePath = $cmd.Source
        Write-OK "Tim thay (Get-Command): $exePath"
    }
}

# Cach 4: GUI picker - nguoi dung tu chon
if (-not $exePath) {
    Write-ERR "Khong tu tim thay."
    Write-INF "Mo hop thoai chon file..."
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title  = "Chon file pdfarranger.exe"
    $dialog.Filter = "pdfarranger.exe|pdfarranger.exe|All EXE|*.exe"
    $dialog.InitialDirectory = "C:\"
    if ($dialog.ShowDialog() -eq "OK") {
        $exePath = $dialog.FileName
        Write-OK "Da chon: $exePath"
    } else {
        Write-ERR "Nguoi dung huy. Thoat."
        Read-Host "`nNhan Enter de dong"
        exit 1
    }
}

# ---- Buoc 2: Tao file .reg ----
Write-Step "[2/3] Tao file registry..."

$escapedPath = $exePath.Replace("\", "\\")
Write-INF "Path: $exePath"

$regContent = @"
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\SystemFileAssociations\.pdf\shell\OpenInPDFArranger]
@="Open in PDF Arranger"
"Icon"="$escapedPath,0"
"Position"="Top"

[HKEY_CLASSES_ROOT\SystemFileAssociations\.pdf\shell\OpenInPDFArranger\command]
@="`"$escapedPath`" `"%1`""
"@

$tempReg = "$env:USERPROFILE\Desktop\pdfarranger_menu_temp.reg"
try {
    [System.IO.File]::WriteAllText($tempReg, $regContent, [System.Text.Encoding]::Unicode)
    Write-OK "Da ghi file: $tempReg ($((Get-Item $tempReg).Length) bytes)"
} catch {
    Write-ERR "Loi ghi file: $_"
    Read-Host "`nNhan Enter de dong"
    exit 1
}

# ---- Buoc 3: Chay regedit ----
Write-Step "[3/3] Ghi vao registry..."

$regeditArgs = "/s `"$tempReg`""
if ($isAdmin) {
    $proc = Start-Process "regedit.exe" -ArgumentList $regeditArgs -PassThru -Wait
} else {
    $proc = Start-Process "regedit.exe" -ArgumentList $regeditArgs -Verb RunAs -PassThru -Wait
}

Write-INF "regedit exit code: $($proc.ExitCode)"
Remove-Item $tempReg -ErrorAction SilentlyContinue

if ($proc.ExitCode -eq 0) {
    Write-Host ""
    Write-Host "  ============================" -ForegroundColor Green
    Write-Host "   CAI DAT THANH CONG!" -ForegroundColor Green
    Write-Host "  ============================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Click phai file PDF -> 'Open in PDF Arranger'" -ForegroundColor White
    Write-Host "  (Neu chua thay, mo lai Explorer hoac nhan F5)" -ForegroundColor Gray
} else {
    Write-ERR "regedit that bai (exit code: $($proc.ExitCode))"
    Write-Host "  Thu chay PowerShell bang 'Run as Administrator' roi chay lai" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Nhan Enter de dong"

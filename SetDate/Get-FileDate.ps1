# [CmdletBinding()]
function NewDateTime {
    param (
        [string]$date = "2020-01-01 00:00:00",
        [string]$formatType = "yyyy-MM-dd HH:mm:ss"
    )
    # 未輸入日期則返回當前時間
    if ([string]::IsNullOrEmpty($date)) {
        $newDate = (Get-Date)
    }
    # 格式化日期
    else {
        $newDate = [DateTime]::ParseExact(
            $date.Trim(), $formatType,
            [CultureInfo]::InvariantCulture
        )
    }
    return $newDate
}
function Get-FileDate_dir {
    Param(
        [Parameter(Position = 0)]
        [String]$srcPath,
        [Parameter(ParameterSetName = "Date")]
        [switch]$CreationTime,
        [Parameter(ParameterSetName = "Date")]
        [switch]$LastWriteTime,
        [Parameter(ParameterSetName = "Date")]
        [switch]$LastAccessTime,
        [Parameter(ParameterSetName = "")]
        [System.Object]$Filter
    )
    
    if (!$CreationTime -and !$LastWriteTime -and !$LastAccessTime) {
        $CreationTime = $true
        $LastWriteTime = $true
        $LastAccessTime = $true
    }
    $collection = Get-ChildItem $srcPath -I $Filter
    foreach ($item in $collection) {
        Write-Host "#" $item.FullName
        if ($CreationTime) {
            Write-Host "  ├─建立日期 "$item.CreationTime.ToString("yyyy-MM-dd HH:mm:ss")
        } if ($LastWriteTime) {
            Write-Host "  ├─修改日期 "$item.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
        } if ($LastAccessTime) {
            Write-Host "  └─存取日期 "$item.LastAccessTime.ToString("yyyy-MM-dd HH:mm:ss")
        }
    }
}
function Set-FileDate_dir {
    Param(
        [Parameter(Position = 0)]
        [String]$srcPath,
        [Parameter(ParameterSetName = "Date", Position = 1)]
        [String]$LastWriteTime,
        [Parameter(ParameterSetName = "Date")]
        [String]$CreationTime,
        [Parameter(ParameterSetName = "Date")]
        [String]$LastAccessTime,
        [Parameter(ParameterSetName = "")]
        [switch]$AllTime,
        [Parameter(ParameterSetName = "")]
        [System.Object]$Filter,
        [Parameter(ParameterSetName = "")]
        [String]$cmdLine
    )
    if ($AllTime) {
        if($CreationTime -eq "") {
            $CreationTime = $LastWriteTime
        } if($LastAccessTime -eq "") {
            $LastAccessTime = $LastWriteTime
        }
    }
    # 當前層資料夾    : 只有檔案 -File
    $collection = Get-ChildItem $srcPath -I $Filter -File
    # 當前層資料夾    : 只有目錄 -Dir
    # $collection = Get-ChildItem $srcPath -I $Filter -Directory
    # 所有層資料夾 -R : 所有項目
    # $collection = Get-ChildItem $srcPath -I $Filter -R
    
    foreach ($item in $collection) {
        if ($CreationTime) {
            $item.CreationTime = $CreationTime
        } if ($LastWriteTime) {
            $item.LastWriteTime = $LastWriteTime
        } if ($LastAccessTime) {
            $item.LastAccessTime = $LastAccessTime
        }
    }
}


$date = "1999-01-01 00:00:00"
$path = $PSScriptRoot

Set-FileDate_dir $path $date
Get-FileDate_dir $path



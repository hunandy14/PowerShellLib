function CopySpecificFile {
    param (
        [String] $srcPath,
        [String] $dstPath,
        [switch] $Preview, 
        # [Parameter(ParameterSetName="Filter")]
        [String] $FilterStr
    )
    ########################### 控制項目 ###########################
    # 排外檔案
    $ExcludeFile = @("*.java", "*.class", ".classpath", 
        ".mymetadata", ".project", "MANIFEST.MF")
    $ExcludeStr = "\\WebRoot\\WEB-INF\\classes\\|\\.settings\\|\\bin\\"
    $FilterFile = @("*.xml", "*.jsp")
    ###############################################################
    # 修復路徑
    $srcPath = $srcPath.TrimEnd('\')
    $dstPath = $dstPath.TrimEnd('\')
    # 資料夾名稱
    $MainDirName = $srcPath.Substring($srcPath.LastIndexof("\")+1)
    # 獲取複製項目相對路徑
    $FileItem = (Get-ChildItem -Recurse -File `
                    -Path $srcPath `
                    -Include $FilterFile)
    # 去除路徑含有特定字串
    $FileItem = $FileItem -notmatch "$ExcludeStr"
    # 排序
    $FileItem = $FileItem  | Sort-Object
    ###############################################################
    for ($i = 0; $i -lt $FileItem.Count; $i++) {
        $F1=$FileItem[$i].FullName
        $F2=$dstPath+"\"+$MainDirName+$F1.Substring($srcPath.Length)
        $Dir2=$F2 | Split-Path
        if ($Preview) {
            Write-Output "CopyFiles::預覽"
            Write-Output "  From: $F1"
            Write-Output "  To  : $F2"
            # Write-Output "  Dir : $Dir2"
        } else {
            if (!(Test-Path $Dir2)) {mkdir $Dir2 | Out-Null}
            # New-Item -ItemType File -Path $F2 -Force | Out-Null
            Copy-Item $F1 $F2
        }
    }
}

$FilePath = "Z:\Workspaces\JavaWeb_Part3\hr_sys\WebRoot"
$TempPath = "Z:\apache-tomcat-6.0.39\webapps\hr_sys"
# $TempPath = "Z:\hr_sys"
cd $PSScriptRoot

CopySpecificFile $FilePath $TempPath
# CopySpecificFile $FilePath $TempPath -Preview
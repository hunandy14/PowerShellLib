# 要被轉換的檔案位置與編碼
$En1 = "SJIS"
$F1 = "C:\Users\hunan\OneDrive\Git Repository\PowerShellLib\findStr_replace\data.txt"
# 轉換後的檔案位置與編碼
$En2 = "SJIS"
$F2 = "C:\Users\hunan\OneDrive\Git Repository\PowerShellLib\findStr_replace\data2.txt"

# 獲取檔案
$ct = Get-Content $F1

#  轉換檔案
$dstStr = $ct -replace '"#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})"', '#$1';

#  寫入檔案
$dstStr | Out-File $F2

function getRegData {
    param (
        $path
    )
    $path = "Registry::" + $path
    $reg = Get-Item $path
    for ($i = 0; $i -lt $reg.ValueCount; $i++) {
        $name = $reg.Property[$i]
        $value = $reg.GetValue($name)
        Write-Host $name = $value
        
        
    }
}
# getRegData "HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor"


$reg = Get-Item "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor"
$name = $reg.Property[0]
$value = $reg.GetValue($name)
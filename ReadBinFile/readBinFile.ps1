function readBin {
    param (
        $fileName,
        $readCount = 10,
        [switch] $Preview
    )
    $charBuf = [char[]]::new($readCount) # buffer to read into
    $textStream = [IO.StreamReader] $fileName # create the stream reader
    $charCount = $textStream.Read($charBuf, 0, $charBuf.Length) # read into buffer
    $textStream.Close() # close the stream
    
    if ($Preview) {
        -join $charBuf[0..($charCount-1)] # output the chars. read as a string
        $textBin = [System.Text.Encoding]::ASCII.GetBytes($charBuf)
        $textBin -join " "
    }
    
    return $charBuf
}

$file_FullName = "C:\Users\hunan\OneDrive\Git Repository\PowerShellLib\ReadBinFile\0.docx";
readBin $file_FullName 10 -Preview





function GetLineAt([String] $path, [Int32] $index)
{
    # StreamReader(String, Boolean) constructor
    # http://msdn.microsoft.com/library/9y86s1a9.aspx
    [System.IO.StreamReader] $reader = New-Object `
        -TypeName 'System.IO.StreamReader' `
        -ArgumentList ($path, $true);
    [String] $line = $null;
    [Int32] $currentIndex = 0;

    try
    {
        while (($line = $reader.ReadLine()) -ne $null)
        {
            if ($currentIndex++ -eq $index)
            {
                return $line;
            }
        }
    }
    finally
    {
        $reader.Close();
    }

    # There are less than ($index + 1) lines in the file
    return $null;
}

$file_FullName = "C:\Users\hunan\OneDrive\Git Repository\PowerShellLib\ReadBinFile\0.docx";
GetLineAt $file_FullName 0;


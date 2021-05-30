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
    
    # return $charBuf
}

readBin "0.docx" 10 -Preview



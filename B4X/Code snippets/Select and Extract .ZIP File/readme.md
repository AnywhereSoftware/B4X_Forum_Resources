###  Select and Extract .ZIP File by Lucas Siqueira
### 07/24/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/167917/)

```B4X
Private Sub selectAndExtractZIP_Click  
  
    ' Define the internal folder and ZIP file name  
    Dim diretorioArquivo As String = xui.DefaultFolder  
    Dim nomeArquivo As String = "arquivo.zip"  
    
    ' Delete ZIP file if it already exists to avoid conflicts  
    If File.Exists(diretorioArquivo, nomeArquivo) Then  
        Log("Deleting existing ZIP file in internal folder: " & nomeArquivo)  
        File.Delete(diretorioArquivo, nomeArquivo)  
    End If  
    
    Log("Selecting ZIP file")  
    
    ' Variables to store selected file information  
    Dim Success As Boolean = False  
    Dim FileName As String = ""  
    Dim Dir As String = ""  
    
    #if b4a  
        ' Android: open file picker to choose a ZIP file  
        Dim cc As ContentChooser  
        cc.Initialize("cc")  
        cc.Show("application/zip", "Choose zip file")  
        Wait For CC_Result (Success As Boolean, Dir As String, FileName As String)  
    #Else b4i  
        ' iOS: use DocumentPicker to select a ZIP file  
        Dim DocumentPicker As DocumentPickerViewController  
        DocumentPicker.InitializeImport("picker", Array("com.pkware.zip-archive"))  
        DocumentPicker.Show(B4XPages.GetNativeParent(Me), Null)  
        Wait For Picker_Complete (Success As Boolean, URLs As List)  
        If Success And URLs.Size > 0 Then  
            FileName = URLs.Get(0)  
        End If  
    #End If  
    
    ' Exit if no file was selected  
    If FileName = "" Then Return  
    
    Log("Selection success: " & Success)  
    Log("Source folder: " & Dir)  
    Log("Selected file: " & FileName)  
    
    Log("Copying ZIP file to internal folder")  
    
    ' Copy selected file to app's internal folder  
    Wait For (File.CopyAsync(Dir, FileName, diretorioArquivo, nomeArquivo)) Complete (Success As Boolean)  
    Log("Copy success: " & Success)  
    
    Log("Extracting ZIP file")  
    
    ' Instantiate archiver for extraction  
    Dim unzip As Archiver  
    
    #if b4a  
        unzip.AsyncUnZip(diretorioArquivo, nomeArquivo, diretorioArquivo, "unzip")  
    #Else b4i  
        unzip.AsyncUnzip(diretorioArquivo, nomeArquivo, diretorioArquivo, "", "unzip")  
    #End If  
    
    ' Wait for the extraction to finish  
    #if b4a  
        Wait For unzip_UnZipDone(CompletedWithoutError As Boolean, NbOfFiles As Int)  
    #Else b4i  
        Wait For unzip_UnzipDone(CompletedWithoutError As Boolean)  
    #End If  
    
    ' Check if extraction completed successfully  
    If CompletedWithoutError Then  
        Log("ZIP extracted successfully to: " & diretorioArquivo)  
    Else  
        Log("Failed to extract ZIP file.")  
    End If  
    
    ' List all files in the internal folder  
    Log("Files in internal folder:")  
    For Each nome As String In File.ListFiles(diretorioArquivo)  
        Log(nome)  
    Next  
    
End Sub
```
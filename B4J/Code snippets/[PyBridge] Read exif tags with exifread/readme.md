### [PyBridge] Read exif tags with exifread by Erel
### 01/16/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170030/)

Based on: <https://github.com/ianare/exif-py> :  
  
"Easy to use Python module to extract Exif metadata from digital image files.  
Pure Python, lightweight, no dependencies.  
Supported formats: TIFF, JPEG, JPEG XL, PNG, Webp, HEIC, RAW"  
  
pip install exifread  
  

```B4X
Private Sub ReadExifTags (Path As Object) As PyWrapper  
    Dim Code As String = $"  
import exifread  
def ReadExifTags (Path):  
  with open(Path, "rb") as file_handle:  
    return exifread.process_file(file_handle, builtin_types=True)  
"$  
    Return Py.RunCode("ReadExifTags", Array(Path), Code)  
End Sub
```

  
  
Usage:  

```B4X
Dim PyTags As PyWrapper = ReadExifTags("Path\To\Image.jpg")  
Wait For (PyTags.Fetch) Complete (PyTags As PyWrapper)  
Dim Tags As Map = PyTags.Value  
Log(Tags.As(JSON).ToString) 'just for logging
```
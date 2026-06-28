###  B4XDaisyFileInput - Sleek, DaisyUI-Styled File Pickers for Your Apps! 🎨 by Mashiane
### 06/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171376/)

Hello Fam!  
  
Are you tired of plain, uninspiring file selection buttons in your apps? Meet the **B4XDaisyFileInput**, a powerful custom component designed to bring the elegant and modern aesthetics of DaisyUI straight into your B4X projects!  
  
This component replaces standard file choosers with a highly customizable input field and button combination. Whether you want a completely transparent "ghost" style or a vibrant "primary" color variant, B4XDaisyFileInput handles it flawlessly.  
  
**Key Features:**  

- **DaisyUI Styling:** Out-of-the-box support for sizes (md, lg, xl), variants (neutral, primary, secondary, accent, info, success, warning, error), and styles (default, ghost).
- **Validation Made Easy:** Automatically displays built-in Hint and Error text beneath the input field. You can even check if a file exceeds a specific MaxSize (in MB) and dynamically display error messages.
- **Smart File Handling:** Effortlessly extract metadata. Check if the selection is an image, video, PDF, Word, or Excel document using helper properties like getIsImage or getIsPDF.
- **Rich Media Parsing:** Easily decode selected image files directly into a B4XBitmap using the built-in GetBitmap method.

![](https://www.b4x.com/android/forum/attachments/172030) ![](https://www.b4x.com/android/forum/attachments/172031) ![](https://www.b4x.com/android/forum/attachments/172032)  
  
Beginner-Friendly Usage Example  
  
Here is a quick snippet demonstrating how to initialize the component programmatically, set a few styling properties, and trap its core events (Click, FileSelected, and Cancelled).  
  

```B4X
Sub Globals  
    ' Declare the component  
    Private myFileInput As B4XDaisyFileInput  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    ' 1. Initialize the component with a callback and event name  
    myFileInput.Initialize(Me, "myFileInput")  
      
    ' 2. Add it to your layout (Parent, Left, Top, Width, Height)  
    myFileInput.AddToParent(Activity, 20dip, 50dip, 300dip, 65dip)  
      
    ' 3. Customize Properties  
    myFileInput.ButtonText = "Upload Avatar"  
    myFileInput.Placeholder = "No photo chosen"  
    myFileInput.Variant = "primary"            ' Applies DaisyUI primary colors  
    myFileInput.Size = "lg"                    ' Large size for better touch targets  
    myFileInput.Accept = "image/png, image/jpg" ' Restrict OS file picker to images  
    myFileInput.MaxSize = 2                    ' Max size of 2 MB  
    myFileInput.HintText = "Max size 2MB"  
End Sub  
  
' Event: Triggered when the user taps the file input surface  
Sub myFileInput_Click(Tag As Object)  
    Log("Opening file chooser…")  
    ' The host app handles opening the platform file picker here  
    ' (e.g., using B4XDaisyFileHandler.Load)  
End Sub  
  
' Event: Triggered after a file is chosen and assigned to the component  
Sub myFileInput_FileSelected(FileName As String)  
    ' Check if the user's file exceeds the 2MB limit  
    If myFileInput.ExceedsSize Then  
        myFileInput.ShowError("Image is too large! Please re-capture.")  
    Else  
        myFileInput.ClearError  
        Log("Awesome! You selected: " & FileName)  
        Log("MIME Type: " & myFileInput.MimeType)  
          
        ' If it's an image, let's grab the B4XBitmap!  
        If myFileInput.IsImage Then  
            Dim bmp As B4XBitmap = myFileInput.GetBitmap  
            ' Now you can apply this bmp to a B4XImageView!  
        End If  
    End If  
End Sub  
  
' Event: Triggered if the file dialog is dismissed without a selection  
Sub myFileInput_Cancelled()  
    Log("File selection was cancelled by the user.")  
End Sub
```

  
  
Add a touch of class to your file uploads today. Try it out and let me know what you think below!  
  
  
[MEDIA=youtube]YWhijzz-4TM[/MEDIA]
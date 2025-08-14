### Show iOS System Dictionary Screen by jkhazraji
### 07/08/2025
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/167689/)

```B4X
'Code module  
#Region  Project Attributes  
    #ApplicationLabel: B4i Example  
    #Version: 1.0.0  
    'Orientation possible values: Portrait, LandscapeLeft, LandscapeRight and PortraitUpsideDown  
    #iPhoneOrientations: Portrait, LandscapeLeft, LandscapeRight  
    #iPadOrientations: Portrait, LandscapeLeft, LandscapeRight, PortraitUpsideDown  
    #Target: iPhone, iPad  
    #ATSEnabled: True  
    #MinVersion: 8  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
    Private xui As XUI  
    Private tfWord As TextField  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.RootPanel.LoadLayout("Page1")  
    NavControl.ShowPage(Page1)  
    
    
End Sub  
  
Sub Button1_Click  
    Dim word As String = tfWord.Text  
    If word.Length > 0 Then  
        Log("Cleaned word: '" & word & "'")  
        ShowDefinition(word)  
    End If  
    
End Sub  
  
Public Sub ShowDefinition(word As String)  
    Dim no As NativeObject = Me  
    'no.RunMethod("showDefinitionFromTextField:", Array(tf))  
    no.RunMethod("showDefinitionForWord:", Array(word))  
End Sub  
  
Private Sub Page1_Resize(Width As Int, Height As Int)  
    
End Sub  
  
  
#If OBJC  
- (void)showDefinitionForWord:(NSString *)word {  
    // Clean the string  
    NSString *cleanWord = [word stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  
    
    NSLog(@"Original word: '%@' (length: %lu)", word, (unsigned long)[word length]);  
    NSLog(@"Cleaned word: '%@' (length: %lu)", cleanWord, (unsigned long)[cleanWord length]);  
    
    if (@available(iOS 10.0, *)) {  
        if ([cleanWord length] > 0) {  
            UIViewController *topVC = [self topViewController];  
            if (topVC) {  
                UIReferenceLibraryViewController *dictVC = [[UIReferenceLibraryViewController alloc] initWithTerm:cleanWord];  
                [topVC presentViewController:dictVC animated:YES completion:nil];  
            }  
        } else {  
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"  
                                                            message:@"Please enter a valid word"  
                                                           delegate:nil  
                                                  cancelButtonTitle:@"OK"  
                                                  otherButtonTitles:nil];  
            [alert show];  
        }  
    }  
}  
//  
//  
  
  
  
#End if
```

  
  
  
See video Demo: [https://youtube.com/shorts/wl6p4HffJtk](https://youtube.com/shorts/wl6p4HffJtk?feature=share)
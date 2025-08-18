### RubikCube - See post #6 of this thread by Johan Schoeman
### 04/23/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/138933/)

**EDIT 21/03/2022: Go to post #6 for a project that can also automatically solve a scrambled cube**  
  
A "partial" wrap for [**this Github project**](https://github.com/cjurjiu/AnimCubeAndroid). Extract and copy the library files (jars and xml) to your additional library folder (B4A).  
  
Attached:  
Java code - change it to your liking  
B4A sample project  
B4A libs - extract and copy to your additional libs folder.  
  
LibRes (attached) should be on the same folder level as that of the B4A /Files and /Objects folder.  
  
![](https://www.b4x.com/android/forum/attachments/126364)  
  
![](https://www.b4x.com/android/forum/attachments/126365)  
  
![](https://www.b4x.com/android/forum/attachments/126366)  
  
[**Read/study this post**](https://github.com/cjurjiu/AnimCubeAndroid) to understand the manner that commands should be send to the lib to execute the commands.  
See the commands hard coded in the EditText box - study and change it  
  
Rotate the entire cube by touching the view  
Rotate a single layer inside the cube - use your finger to do such.  
  
Sure you will figure it out.  
  
Sample code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: b4aRubikCube  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalRes: ..\LibRes  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private rc1 As RubikCube  
   
    Private Button1 As Button  
    Dim move As String  
    Private et1 As EditText  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
   
    'using smart string literals for the move commands  
    rc1.Editable = True                   'set to true to rotate planes manually  
    rc1.BackFaceDistance = 4              'set the distance of the back faces from the cube -> a value (0) zero -> no back faces are shown  
    et1.Text = $"R2' U3 M2 U3' R3' U2 M1' U1'"$  
    rc1.DoubleRotationSpeed = 25  
    rc1.SingleRotationSpeed = 25  
   
   
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
  
  
Private Sub Button1_Click  
   
    move = et1.Text                            'get the move sequence from the EditText box  
    rc1.MoveSequence = move                    'pass the move sequence to be performed  
    rc1.AnimateMoveSequence                    'execute the move as defined above  
    Wait For rc1_animation_finished            'with for animation to finish  
    Log("now going to do move sequence in reverse")         
    rc1.AnimateMoveSequenceReversed            'do the same move sequence but in reverse order  
  
   
End Sub  
  
Private Sub rc1_animation_finished  
    Log("gotcha")  
    rc1.CubeModel = "000000000111111111222222222333333333444444444555555555"    'define a model to set when animation is completed  
    rc1.ResetToInitialState                                                     'set the cube state as defined in rc1.CubeModel = "012345012012345012012345012012345012012345012012345012"  
End Sub  
  
Private Sub rc1_cube_model(model As String)  
    Log("in rc1_cube_model")  
    Log(model)  
End Sub
```
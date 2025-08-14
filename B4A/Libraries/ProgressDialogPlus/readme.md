### ProgressDialogPlus by Blueforcer
### 06/02/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167258/)

[HEADING=1]ProgressDialogPlus – Native Android ProgressDialog Wrapper (Spinner + Horizontal)[/HEADING]  
![](https://www.b4x.com/android/forum/attachments/164530)  
  
Hi everyone 👋  
  
because i needed the ability to update the text inside the B4A ProgressDialog without flickering (wich isnt possible), ive created a lightweight yet powerful wrapper for the native Android ProgressDialog using JavaObject wich supports the standard Spinner and the Progressbar..  
  

---

  
  
[HEADING=1]✅ Features[/HEADING]  

- Native Android look & feel (android.app.ProgressDialog)
- No flickering while updating
- Spinner for indefinite progress (default)
- Horizontal style for percentage/progress tasks
- Dynamic control: SetMessage, SetProgress, SetMax, SetTitle, Dismiss, Cancel
- Cancelable or modal
- Works great in loops, background tasks, downloads, timeouts etc.

  

---

  
  
[HEADING=1]📘 Function Overview[/HEADING]  
[HEADING=2]Initialize[/HEADING]  
Initializes the class context. Must be called before use.  
  
[HEADING=3]Show(Message As String, Cancelable As Boolean, Title As String, Style As String)[/HEADING]  
Displays the dialog.  

- **Message**: Text displayed in the dialog.
- **Cancelable**: Allows user to cancel by pressing Back.
- **Title**: Optional title for the dialog window.
- **Style**: "SPINNER" (indeterminate) or "HORIZONTAL" (with progress bar).

[HEADING=3]SetMessage(Message As String)[/HEADING]  
Updates the message text dynamically.  
[HEADING=3]SetTitle(Title As String)[/HEADING]  
Updates the dialog title.  
[HEADING=3]SetProgress(Value As Int)[/HEADING]  
Sets current progress value (only works in "HORIZONTAL" style).  
[HEADING=3]SetMax(Max As Int)[/HEADING]  
Sets the maximum value for the progress bar (only for "HORIZONTAL").  
[HEADING=3]Dismiss[/HEADING]  
Closes the dialog gracefully.  
[HEADING=3]Cancel[/HEADING]  
Force-cancels the dialog (equivalent to pressing back).  
[HEADING=3]IsShowing As Boolean[/HEADING]  
Returns True if the dialog is currently visible.  
  

---

  
  
[HEADING=1]📦 Example Usage[/HEADING]  
  
[HEADING=2]1. Simple Spinner Dialog[/HEADING]  

```B4X
Dim pdp As ProgressDialogPlus  
pdp.Initialize  
pdp.Show("Please wait…", False, "Loading", "SPINNER")  
Sleep(3000) ' Simulated task  
pdp.Dismiss
```

  
  
![](https://www.b4x.com/android/forum/attachments/164529)  

---

  
  
[HEADING=2]2. Horizontal Progress (0–100%)[/HEADING]  

```B4X
    Dim pd As ProgressDialogPlus  
    pd.Initialize  
    pd.Show("Processing…", False, "Progress", "HORIZONTAL")  
    pd.SetMax(10)  
    For i = 1 To 10  
        pd.SetProgress(i)  
        pd.SetMessage("Step " & i & "/10")  
        Sleep(500)  
    Next  
    pd.Dismiss
```

  
  
![](https://www.b4x.com/android/forum/attachments/164528)  
  
  

---

  
  
[HEADING=2]3. Confirm Loop with Timeout (Horizontal + MsgBox)[/HEADING]  

```B4X
Dim maxTries As Int = 10  
Dim pdp As ProgressDialogPlus  
pdp.Initialize  
pdp.Show("Waiting for condition…", False, "Checking", "HORIZONTAL")  
pdp.SetMax(maxTries)  
  
Dim success As Boolean = False  
For i = 1 To maxTries  
    ' Simulate check  
    success = (Rnd(0, 10) = 3)  
    pdp.SetProgress(i)  
    pdp.SetMessage("Attempt " & i & "/" & maxTries)  
    If success Then Exit  
    Sleep(500)  
Next  
  
pdp.Dismiss  
  
If success Then  
    ToastMessageShow("Confirmed!", False)  
Else  
    Dim res As Int = Msgbox2("Condition not confirmed. Proceed anyway?", "Timeout", "Yes", "Cancel", "", Null)  
    If res = DialogResponse.POSITIVE Then  
        ToastMessageShow("Proceeding anyway.", False)  
    Else  
        ToastMessageShow("Cancelled.", False)  
    End If  
End If
```
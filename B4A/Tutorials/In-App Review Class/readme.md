### In-App Review Class by Mr.Coder
### 02/25/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/170428/)

Hi,  
  
This is In-App Review class :  
  
1 - You need to install these libraries using SDK Manager :  

```B4X
com.google.android.play:review  
com.google.android.gms:play-services-tasks  
com.google.android.play:core-common
```

  
  
2 - You need to set minSdkVersion="21" and to add this in your manifest :  

```B4X
AddApplicationText(<activity  
            android:name="com.google.android.play.core.common.PlayCoreDialogWrapperActivity"  
            android:exported="false"  
            android:stateNotNeeded="true"  
            android:theme="@style/Theme.PlayCore.Transparent" />)
```

  
  
3 - Add this to your app project :  

```B4X
#AdditionalJar: com.google.android.play:review
```

  
  
4 - Add the attached class to your app project.  
  
5 - Start using the class :  

```B4X
#AdditionalJar: com.google.android.play:review  
  
Sub Globals  
    Private InAppReview As InAppReviewHelper  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
  
        ' UseFakeReviewManager = True - This should only be used For unit or integration tests to verify the behaviour of the app once the review Is completed.  
        ' Note: FakeReviewManager does not simulate the UI (no pop-up will be shown).  
        '       It only fakes the API method result by always providing a fake ReviewInfo object and returning a success status when the in-app review flow is launched.  
        ' UseFakeReviewManager = False - Use it for production app.  
        InAppReview.Initialize(Me, "InAppReview", False)  
  
End Sub  
  
Private Sub BtnAppReview_Click  
  
    Try  
       
        Dim oContext As JavaObject  
       
        oContext.InitializeContext  
       
        InAppReview.LaunchReview(oContext)  
       
        Wait For InAppReview_Complete (Success As Boolean, ErrorDetails() As String)  
       
        Log("InAppReview Success = " & Success)  
        Log("ErrorType = " & ErrorDetails(0))  
        Log("ErrorDescription = " & ErrorDetails(1))  
        Log("IsReviewDialogLikelyToAppear = " & InAppReview.IsReviewDialogLikelyToAppear)  
       
        Return  
   
    Catch  
       
         Log(LastException)  
                                   
         Return  
       
    End Try    
   
End Sub
```
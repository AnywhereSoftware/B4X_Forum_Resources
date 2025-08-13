###  AS FeatureRequest - Approved and implemented requests by Alexander Stolte
### 12/17/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/163905/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-featurerequest-payware.163524/>  
  
In this example I show how easy you can display 2 pages, with the features that are under development and the features that are already implemented.  
  
**Libraries that are needed:**  

- [AS\_AnimatedCounter](https://www.b4x.com/android/forum/threads/b4x-xui-as-animatedcounter-negative-and-positive-numbers.98107/#content) V2.0+
- [AS\_ScrollingChips](https://www.b4x.com/android/forum/threads/b4x-xui-as-scrollingchips-based-on-xcustomlistview-display-your-hashtags-or-categories.123425/)
- [AS\_SegmentedTab](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/)
- [Supabase](https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/) V1.25+

  
![](https://www.b4x.com/android/forum/attachments/158244) ![](https://www.b4x.com/android/forum/attachments/158242) ![](https://www.b4x.com/android/forum/attachments/158243)  
  

```B4X
Private Sub LoadFeatureRequests(FeatureRequest As AS_FeatureRequest,LoadApproved As Boolean)  
   
    FeatureRequest.Clear 'Clears the list  
    FeatureRequest.ShowLoadingIndicator  
   
    Try  
   
        Dim CallFunction As Supabase_DatabaseRpc = xSupabase.Database.CallFunction  
        CallFunction.Parameters(CreateMap("appid":1)) 'Change this to the app id in the dt_FeatureRequestApp  
        CallFunction.Rpc("GetFeatureRequests".ToLowerCase)  
        If LoadApproved Then  
            CallFunction.Filter_Is(CreateMap("implementedversion":"null")) 'Load implemented items  
            CallFunction.OrderBy("status.desc,votecount.desc")  
        Else  
            CallFunction.Filter_NotEqual(CreateMap("implementedversion":"")) 'Load approved items  
            CallFunction.OrderBy("implementedversion.desc")  
        End If  
  
        Wait For (CallFunction.Execute) Complete (RpcResult As SupabaseRpcResult)  
        'Log(RpcResult.Error.ErrorMessage)  
        If RpcResult.Error.Success Then  
            'Log(RpcResult.Data)  
      
            Dim parser As JSONParser  
            parser.Initialize(RpcResult.Data)  
            Dim jRoot As List = parser.NextArray  
            For Each Row As Map In jRoot  
          
                Dim StatusText As String = ""  
                Select Row.Get("status")  
                    Case 0  
                        StatusText = "Submitted"  
                    Case 1  
                        StatusText = "Planned"  
                    Case 2  
                        StatusText = "In Development"  
                    Case 3  
                        StatusText = "Testing"  
                    Case 4  
                        StatusText = "Done"  
                End Select  
          
                Dim lstChips As List : lstChips.Initialize  
                If Row.Get("implementedversion") <> Null Then lstChips.Add(FeatureRequest.CreateItemChip(Row.Get("implementedversion"),xui.Color_ARGB(255,73, 98, 164),xui.Color_White))  
                lstChips.Add(FeatureRequest.CreateItemChip(StatusText,xui.Color_ARGB(255,45, 136, 121),xui.Color_White))  
                If Row.Get("ispremiumfeature") Then lstChips.Add(FeatureRequest.CreateItemChip("Premium",xui.Color_ARGB(255,141, 68, 173),xui.Color_White))  
              
                FeatureRequest.AddItem(Row.Get("title"),Row.Get("description"),lstChips,FeatureRequest.UserVoteStatus2Text(Row.Get("uservotestatus")),Row.Get("votecount"),Row.Get("id"))  
              
            Next  
      
        End If  
   
    Catch  
        Log(LastException)  
    End Try  
   
    FeatureRequest.HideLoadingIndicator  
   
End Sub
```
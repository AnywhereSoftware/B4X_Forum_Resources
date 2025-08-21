### [BANano] The Logic of Loading AutoComplete Input from API with BANanoFetch at runtime by Mashiane
### 03/04/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/114582/)

Ola  
  
Whilst this is being tested with [BANanoVueMaterial](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-vuejs-ux-based-framework-for-banano.113789/), the **LOGIC** is applicable for any related code like this. We are loading an autocomplete input based of a fetch results from a github repo of public API. The qualifier is the code logic. You can trap the input event of your autocomplete to achieve the same..  
  
Assumptions  
  
1. When our app runs, our autocomplete is empty  
2. Each type a user types something, we detect a few things, (a) is the autocomplete filled already and (b) is it loading  
3. If the autocomplete is already filled exit the reload and if its loading exit the reload else load it.  
4. The **SearchItems** sub can then be fed the results of your autocomplete input detection and the Fetch happens  
  
  
![](https://www.b4x.com/android/forum/attachments/89519)  
  
  

```B4X
Sub SearchItems(xval As String)  
    'get the already existing list of items  
    Dim items As List = vm.GetState("itemsa", Array())  
    'get the loading status  
    Dim isloading As Boolean = vm.GetState("isloading",False)  
    'items already loaded  
    If items.Size > 0 Then Return  
    'items have been requested  
    If isloading Then Return  
    'change the state to loading  
    vm.SetStateSingle("isloading", True)  
      
    ' do the search  
    Dim Response As BANanoFetchResponse  
    Dim Data As BANanoJSONParser  
    Dim Error As BANanoJSONParser  
    ' list (GET is default, and we do not need extra options so we pass Null for the options)  
    Dim fetch1 As BANanoFetch  
    'execute the fetch  
    fetch1.Initialize("https://api.publicapis.org/entries", Null)  
    'we got a promise response  
    fetch1.Then(Response)  
    ' so resolve it to a json  
    fetch1.Return(Response.Json)  
    fetch1.Then(Data)  
        Dim res As Map = Data.NextObject  
        Dim count As Long = res.Get("count")  
        Dim entries As List = res.Get("entries")  
        'lets build up our items  
        Dim items As List  
        items.Initialize   
        'we define how long a description should be  
        Dim dl As Int = vm.GetState("descriptionlimit",descriptionlimit)  
        'get the entries and limit the description to specified length  
        For Each entry As Map In entries  
            Dim sDescription As String = entry.Get("Description")  
            If sDescription.Length > descriptionlimit Then  
                sDescription = vm.LeftString(sDescription, dl) & "…"  
                entry.Put("Description", sDescription)  
            End If  
            items.Add(entry)  
        Next  
        'save the list of items to load to the auto-complete  
        vm.SetStateSingle("itemsa", items)  
    fetch1.Else(Error)  
        Log(Error)  
    fetch1.Finally   
        'turn the loading state to false  
        vm.SetStateSingle("isloading", False)  
    fetch1.End  
End Sub
```

  
  
In our case, when the "itemsa" state changes after a load, the autocomplete is loaded automatically with new content. That is where BANano specific code can come in to load your autocomplete.  
  
After everything is loaded, of course,the isloading is made false.   
  
One of the interesting things is getting the details of a selected API. On the list of items listed, each is saved as an object. So on click of the autocomplete, the selected object is read and a key, value pair list is made. Ours is called a "model"  
  

```B4X
Sub ComputeFields As List  
    Dim fields As List  
    fields.Initialize  
    Dim model As Map = vm.GetState("model",Null)  
    If model = Null Then Return fields  
    For Each k As String In model.Keys  
        Dim v As Object = model.Get(k)  
        fields.Add(CreateMap("key": v, "value":v))  
    Next  
    vm.SetStateSingle("fields", fields)  
    Return fields  
End Sub
```

  
  
Ta!
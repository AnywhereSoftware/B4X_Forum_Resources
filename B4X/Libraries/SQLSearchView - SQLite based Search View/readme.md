###  SQLSearchView - SQLite based Search View by Erel
### 08/15/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/133379/)

![](https://www.b4x.com/android/forum/attachments/117753)  
  
This library is based on B4XSearchTemplate. The difference is that instead of building an in-memory index, it uses a SQLite database. It is relevant when you want to search large collections.  
I've tested it with a collection of almost 400k items. It starts immediately and the search is fast.  
  
The idea is to build the database once with B4J and then add the database file to the project.  
SearchView.BuildDatabase builds the database. Note that it uses MAX\_LIMIT and MaxNumberOfItemsToShow while building the index. You cannot change them later.  
  
Assuming that the database file is added to the assets folder, it needs to be copied to XUI.DefaultFolder. This happens, when needed, in SearchView.LoadDatabase. The file is copied asynchronously.  
  
The database is not small. For this collection it is 30mb uncompressed and about 20mb when compressed inside the APK.  
  
Usage example:  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private SearchView As SQLSearchView  
    Private Dialog As B4XDialog  
    Private Button1 As B4XView  
End Sub  
  
Public Sub Initialize  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    SearchView.Initialize  
'    SearchView.BuildDatabase("C:\Users\H\Downloads", "search.db", File.ReadList("C:\Users\H\Downloads\words.txt", ""))  
    xui.SetDataFolder("SQLSearchView")  
    Wait For (SearchView.LoadDatabase(File.DirAssets, "search2.db")) Complete (Success As Boolean)  
    Button1.Enabled = Success  
    Dialog.Initialize(Root)  
    Dialog.Title = "SQL Search View"  
    SetDialogTheme  
End Sub  
  
Private Sub SetDialogTheme  
    Dim TextColor As Int = 0xFF5B5B5B  
    SearchView.SearchField.TextField.TextColor = TextColor  
    SearchView.SearchField.NonFocusedHintColor = TextColor  
    SearchView.CustomListView1.sv.ScrollViewInnerPanel.Color = 0xFFDFDFDF  
    SearchView.CustomListView1.sv.Color = Dialog.BackgroundColor  
    SearchView.CustomListView1.DefaultTextBackgroundColor = xui.Color_White  
    SearchView.CustomListView1.DefaultTextColor = TextColor  
    If SearchView.SearchField.lblV.IsInitialized Then SearchView.SearchField.lblV.TextColor = TextColor  
    If SearchView.SearchField.lblClear.IsInitialized Then SearchView.SearchField.lblClear.TextColor = TextColor  
    Dialog.BackgroundColor = xui.Color_White  
    Dialog.ButtonsColor = xui.Color_White  
    Dialog.BorderColor = xui.Color_Gray  
    Dialog.ButtonsTextColor = 0xFF007DC3  
    Dialog.OverlayColor = xui.Color_Transparent  
End Sub  
  
Private Sub Button1_Click  
    Wait For (Dialog.ShowTemplate(SearchView, "", "", "Cancel")) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        Log(SearchView.SelectedItem)  
    End If  
End Sub
```
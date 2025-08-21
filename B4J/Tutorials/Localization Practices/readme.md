### Localization Practices by xulihang
### 07/08/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/119940/)

I am trying to use B4XLocalizator to localize my B4J app ImageTrans from Chinese to English. I would like to share my practices with the forum and suggestions are appreciated.  
  
1. Automatic localizable strings extraction  
  
a. Use a form to load every layout, iterate all views and extract text  
  

```B4X
Sub ExportLayoutText(map1 As Map)  
    Dim frm As Form  
    frm.Initialize("frm",600,200)  
    Dim assets As String  
    assets=File.Combine(File.GetFileParent(File.DirApp),"Files")  
    If File.Exists(assets,"")=False Then  
        Return  
    End If  
    For Each filename As String In File.ListFiles(assets)  
        If filename.ToLowerCase.EndsWith(".bjl") Then  
            frm.RootPane.RemoveAllNodes  
            frm.RootPane.LoadLayout(Utils.GetFilenameWithoutExtension(filename))  
             
            If frm.Title<>"" Then  
                Dim transUnit As Map  
                transUnit.Initialize  
                transUnit.Put("type","Form Title")  
                transUnit.Put("note",filename)  
                transUnit.Put("text",frm.Title)  
                map1.Put(frm.Title.ToLowerCase,transUnit)  
            End If  
             
            For Each node As Object In frm.RootPane.GetAllViewsRecursive  
                Dim transUnit As Map  
                transUnit.Initialize  
                transUnit.Put("type",GetType(node))  
                transUnit.Put("note",filename)  
                Dim n As Node=node  
                If n Is TextArea Then  
                    Dim ta As TextArea = n  
                    transUnit.Put("text",ta.Text)  
                Else If n Is TextField Then  
                    Dim tf As TextField = n  
                    transUnit.Put("text",tf.Text)  
                Else if n Is Button Then  
                    Dim btn As Button = n  
                    transUnit.Put("text",btn.Text)  
                Else if n Is CheckBox Then  
                    Dim cbx As CheckBox = n  
                    transUnit.Put("text",cbx.Text)  
                Else If n Is RadioButton Then  
                    Dim rbtn As RadioButton = n  
                    transUnit.Put("text",rbtn.Text)  
                Else If n Is ToggleButton Then  
                    Dim tbtn As ToggleButton = n  
                    transUnit.Put("text",tbtn.Text)  
                Else If n Is Label Then  
                    Dim lbl As Label = n  
                    transUnit.Put("text",lbl.Text)  
                else if n Is ListView Then  
                    Dim lv As ListView = n  
                    If lv.ContextMenu.IsInitialized Then  
                        ExportMenuItems(lv.ContextMenu.MenuItems,transUnit,map1)  
                    End If  
                    Continue  
                else if n Is MenuBar Then  
                    Dim mb As MenuBar = n  
                    ExportMenuItems(mb.Menus,transUnit,map1)  
                    Continue  
                else if n Is TableView Then  
                    Dim tv As TableView=n  
                    ExportTableViewColumns(tv,transUnit,map1)  
                    Continue  
                End If  
                If transUnit.ContainsKey("text") Then  
                    Dim text As String=transUnit.Get("text")  
                    map1.Put(text.ToLowerCase,transUnit)  
                End If  
            Next  
        End If  
    Next  
End Sub
```

  
  
b. Wrap text in code with Localize, LocalizeParams and LocalizeList methods (This process needs to be automated). Extract these in-code text.  
  

```B4X
result=fx.Msgbox2(MainForm,Main.loc.Localize("均衡含文字与无文字区域？"),"", _  
                                   Main.loc.Localize("是"),"", _  
                                   Main.loc.Localize("否"),fx.MSGBOX_CONFIRMATION)
```

  
  

```B4X
Sub ExportInCodeString(map1 As Map)  
    Dim projectDir As String = File.GetFileParent(File.DirApp)  
    For Each filename As String In File.ListFiles(projectDir)  
        If filename.EndsWith(".bas") Or filename.EndsWith(".b4j") Then  
            Dim strings As List  
            strings.Initialize  
            Dim content As String = File.ReadString(projectDir,filename)  
            Dim matcher1 As Matcher=Regex.Matcher($"\.Localize\("(.*?)"\)"$,content)  
            Do While matcher1.Find  
                strings.Add(matcher1.Group(1))  
            Loop  
            stringsToMap(strings,map1)  
        End If  
    Next  
End Sub
```

  
  
c. Save the result to xlsx with control type and layout name as reference for translation  
  
2. Translation with computer-aided translatoin tools like BasicCAT and OmegaT  
3. Use B4XLocalizator to load translated strings.  
  
I have enhanced the localizator to let it support tabpane, splitpane, context menu and table view column headers.  
  
Code practice:  
  
I use context menu text in select… case… expression. Instead of wrapping all the text in cases, I choose to convert the translation back to source text.  
  

```B4X
Select loc.FindSource(menu)  
    Case "过滤过小项"  
        tl.smallFilteredBoxes(boxesList)  
    Case "过滤过大项"  
        tl.oversizeFilteredBoxes(boxesList)  
End Select
```

  
  
A big problem is that the English target text is ofter longer than the Chinese source text, text will be ellispis. I do not want to adjust control's size and font. I just add tooltips to these controls. I think a better solution is to use different layout files for different languages which need the abstract designer to add support.  
  
![](https://www.b4x.com/android/forum/attachments/96798)
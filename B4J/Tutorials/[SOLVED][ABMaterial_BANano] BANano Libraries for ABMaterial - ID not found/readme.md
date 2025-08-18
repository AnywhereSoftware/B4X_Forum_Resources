### [SOLVED][ABMaterial/BANano] BANano Libraries for ABMaterial - ID not found by Cableguy
### 02/07/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/127409/)

So…  
  
I wanted to test the new feature of creating BaNano libs to use with ABMaterial…  
I basically copied the hover example as it was what I needed for time being, and followed the indications…  
The issue is, nothing happens!  
I can't figure out if its an ABMaterial issue or BaNano one!  
  
For the BaNano part:  
[SPOILER="BaNano Code"]

```B4X
#Event: Hover(ID As String, IsOver As Boolean)  
  
Sub Class_Globals  
    Private BANano As BANano 'ignore  
    Private mEventName As String  
End Sub  
  
'Initializes the object, setting the event  
Public Sub Initialize(eventName As String)  
    mEventName = eventName  
End Sub  
  
' Adds hover functionality to an ABM Component  
public Sub AddHover(ID As String)  
    ' get the element with the ID  
    Dim mElement As BANanoElement  
    mElement.Initialize("#" & ID)  
  
    ' add the Mouse Enter and Out events to the element  
    Dim event As Object  
    mElement.AddEventListener("mouseenter", BANano.CallBackExtra(Me, "HandleMouseEnter", event, Array(mElement)),True)  
    mElement.AddEventListener("mouseout", BANano.CallBackExtra(Me, "HandleMouseOut", event, Array(mElement)),True)  
End Sub  
  
' the Callback for the Mouse Enter event  
private Sub HandleMouseEnter(event As BANanoEvent, Element As BANanoElement) 'ignore  
    Element.RemoveClass("light-blue").AddClass("red")  
    ' optionaly raise an event back to ABM  
    BANano.RaiseEventToABM(mEventName & "_Hover", Array("ID","IsOver"), Array(Element.Name, True), "")  
End Sub  
  
' the Callback for the Mouse Out event  
private Sub HandleMouseOut(event As BANanoEvent, Element As BANanoElement) 'ignore  
    Element.RemoveClass("red").AddClass("blue")  
    ' optionaly raise an event back to ABM  
    BANano.RaiseEventToABM(mEventName & "_Hover", Array("ID","IsOver"), Array(Element.Name, False), "")  
End Sub
```

[/SPOILER]  
  
And for the ABMaterial part i have:  

```B4X
public Sub BuildPage()  
    ' initialize the theme  
    BuildTheme  
     
    ' initialize this page using our theme  
    page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)  
    page.ShowLoader=True  
    page.PageHTMLName = "index.html"  
    page.PageTitle = "Dev-i9"  
    page.PageDescription = "Development & Innovation"  
    page.PageKeywords = ""  
    page.PageSiteMapPriority = ""  
    page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY  
         
    page.ShowConnectedIndicator = True  
     
    page.AddExtraJavaScriptFile("bananocore.js")  
    page.AddExtraJavaScriptFile("Hover/hover.js")  
    ' unless you use a specific other place where your Static Files are, this will always be "www"  
    Hover.UnzipAssets("www")  
                 
    ' adding a Transparent Navigation Bar (TNB)  
     ABMShared.BuildTransparentNavigationBar(page)    
     
    ' create the page grid  
    page.AddRowsM(2,True,20,0, "").AddCells12MP(1,0,0,0,0,"")    
     
    page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components        
End Sub  
…..  
  
public Sub ConnectPage()            
    Hover.Initialize(ws)  
    '    connecting the navigation bar  
     ABMShared.ConnectTransparentNavigationBar(page)  
     
    ' Add the extra content, transparent  
    page.NavigationBar.InitializeExtraContent("extracontent", True, "TransparentExtraContent")  
    page.NavigationBar.ExtraContent.AddRowsM(1, False,0,0,"").AddCellsOS(1,0,0,1,12,12,10,"")  
    page.NavigationBar.ExtraContent.BuildGrid  
    page.NavigationBar.Refresh ' IMPORTANT  
     
    BuildNavBar  
    ' refresh the page  
    page.Refresh  
     
    ' Tell the browser we finished loading  
    page.FinishedLoading  
    ' restoring the navigation bar position  
    page.RestoreNavigationBarPosition    
End Sub  
  
…  
  
Sub BuildNavBar()  
    Dim floatingcont1 As ABMContainer  
    floatingcont1.Initialize(page, "floatingcont1", "")  
    floatingcont1.AddRowsM(1,False,0,0, "").AddCellsOSMP(1,0,0,0,12,12,12,0,0,0,0,"")  
    floatingcont1.BuildGrid ' IMPORTANT  
    floatingcont1.SetFixedWidth("100%")  
    floatingcont1.SetFixedPosition("0px","0px","0px","")  
    floatingcont1.SetFixedHeight("80px")  
    floatingcont1.SetExtraStyle("z-index: 1000") ' IMPORTANT as it has to be OVER the normal Navigation Bar.  
    page.AddFloatingContainer(floatingcont1, ABM.FLOATING_FROMTOP, "0px")  
     
'    ' get the floating container  
'    Dim floatingcont1 As ABMContainer  
'    floatingcont1 = page.FloatingContainer("floatingcont1")  
  
    ' create menu container  
    Dim cont2 As ABMContainer  
    cont2.Initialize(page, "cont2", "NewNavigationBar")  
    ' you have to take care yourself how it bahaves on the different devices  
     
    cont2.AddRows(1,True,"").AddCellsOS(1,0,0,0,3,3,3,"").AddCellsOS(1,0,0,0,4,4,4,"").AddCellsOS(1,0,0,0,5,5,5,"")  
    cont2.BuildGrid  
   
    cont2.Cell(1,1).Margintop = "6px"  
      cont2.Cell(1,2).MarginTop = "64px"  
    cont2.Cell(1,3).Margintop = "64px"  
  
    Dim img As ABMImage  
    img.Initialize(page, "img", "../images/signature.png",1)  
    img.SetFixedSize(225,75)  
    cont2.Cell(1,1).AddComponent(img)  
   
    Dim lbl1 As ABMLabel  
    lbl1.Initialize(page, "lbl1","{NBSP}", ABM.SIZE_A, False,"")  
    cont2.Cell(1,2).AddComponent(lbl1)  
       
    Dim btn1 As ABMButton  
    btn1.InitializeFlat( page, "btn1", "", "", "{B}Activitées{/B}", "NewNavigationBarButton")  
    btn1.Size = ABM.BUTTONSIZE_SMALL  
    cont2.Cell(1,3).AddComponent(btn1)  
  
     
    Dim btn2 As ABMButton  
    btn2.InitializeFlat( page, "btn2", "", "", "{B}Partenariats{/B}", "NewNavigationBarButton")  
    btn2.Size = ABM.BUTTONSIZE_SMALL  
    cont2.Cell(1,3).AddComponent(btn2)  
   
    Dim btn3 As ABMButton  
    btn3.InitializeFlat( page, "btn3", "", "", "{B}Contacts{/B}", "NewNavigationBarButton")  
    btn3.Size = ABM.BUTTONSIZE_SMALL  
    cont2.Cell(1,3).AddComponent(btn3)  
   
    ' add it to the floating container  
    floatingcont1.Cell(1,1).AddComponent(cont2)  
     
    page.Refresh  
     
    Dim myJS As ABMHover  
    myJS.Initialize("myJS")  
    myJS.AddHover("btn2")  
End Sub  
  
Sub myJS_Hover(ID As String, IsOver As Boolean)  
    Log("Hover on " & ID & "-> is Over : " & IsOver)  
End Sub
```

  
  
SO… (I told ya!)
B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore

	Private Drawer As B4XDrawer
	Private HamburgerIcon As B4XBitmap
	Private clvData As CustomListView
	Private pmDate As B4XPlusMinus
	Private lblType As Label
	Private lblDescription As Label
	Private lblEdit, lblDelete As Label
	Private PrefDialogEvents As PreferencesDialog
	Private lblValue As Label
	Private B4XLoadingIndicator1 As B4XLoadingIndicator
	#if B4J
	Private btnPlus,btnRefresh As B4XView
	#End If
	
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Drawer.Initialize(Me, "Drawer", Root, 200dip)
	Drawer.CenterPanel.LoadLayout("DataCards")
	Drawer.LeftPanel.LoadLayout("Page2Left")
	B4XPages.SetTitle(Me,"Data Cards")
	HamburgerIcon = xui.LoadBitmapResize(File.DirAssets, "hamburger.png", 32dip, 32dip, True)
	pmDate.SetStringItems(Array("January", "February", "March"))
	pmDate.SelectedValue = "January"
	pmDate.mCyclic = True
	PrefDialogEvents.Initialize(Root , "Events", 300dip, 300dip)
	CreateMenu
	PopulateCards(pmDate.SelectedValue)
	#if B4i
	Dim bb As BarButton
	bb.InitializeBitmap(HamburgerIcon, "hamburger")
	B4XPages.GetNativeParent(Me).TopLeftButtons = Array(bb)
	#Else If B4J
	Dim iv As ImageView
	iv.Initialize("imgHamburger")
	iv.SetImage(HamburgerIcon)
	Drawer.CenterPanel.AddView(iv, 2dip, 2dip, 32dip, 32dip)
	iv.PickOnBounds = True
	#end if
End Sub
#if B4J
Sub imgHamburger_MouseClicked (EventData As MouseEvent)
	Drawer.LeftOpen = True
End Sub
#else if B4i
Private Sub B4XPage_MenuClick (Tag As String)
	If Tag = "hamburger" Then
		Drawer.LeftOpen = Not(Drawer.LeftOpen)
	End If
End Sub
#end if

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub PopulateCards (Month As String)
	clvData.Clear
	Dim rs As DBResult
	B4XLoadingIndicator1.Show
	Dim Paremeters() As String = Array As String(Month, B4XPages.MainPage.KVS.Get("id_user"))
	Wait For(B4XPages.MainPage.jRDC.GetRecord("getEvents", Paremeters)) Complete (Answer As Map)
	If Answer.Get("Success") Then
		Dim mapData As Map
		rs = Answer.Get("Data")
		For Each row() As Object In rs.Rows
			Dim i As Int = 0
			mapData.Initialize
			For Each record As Object In row
				'We will make a map to pass to B4XPreferencesDialo. The map keys must suit to the db name fields
				'Construimos un mapa para pasarlo a B4XPreferencesDialog. Las claves del mapa deben coincidir con los nombres de las columnas de la bd
				mapData.Put(rs.Columns.GetKeyAt(i), record) 
				i = i + 1
			Next
			Dim p As B4XView = CreateCard(mapData)
			clvData.Add(p, mapData)
		Next
	Else
		xui.MsgboxAsync("There was an error getting the data. Check your server: " & Answer.Get("Error"), "Error")
		Log("No data")
	End If
	B4XLoadingIndicator1.Hide
End Sub

Sub CreateCard (Data As Map) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	Dim height As Int = 180dip
	#if B4A
	If GetDeviceLayoutValues.ApproximateScreenSize < 4.5 Then height = 310dip
	#end if
	p.SetLayoutAnimated(0, 0, 0, clvData.AsView.Width, height)
	p.LoadLayout("Card")
	lblType.Text = Data.Get("event_type")
	lblDescription.Text = Data.Get("description")
	lblValue.Text = Data.Get("value")
	'We store the map in the tag properties to pass it to B4XPreferencesDialog when editing or deleting
	'Almacenamos el mapa en la propiedad tag para pasarla a B4XPreferencesDialog al editar o borrar
	lblEdit.Tag = Data 
	lblDelete.Tag = Data
	Return p
End Sub

Private Sub pmDate_ValueChanged (Value As Object)
	PopulateCards(Value)
End Sub


#if B4J
Private Sub lblEdit_MouseClicked (EventData As MouseEvent)
#else
Private Sub lblEdit_Click
#end if

	Dim Index As Int = clvData.GetItemFromView(Sender)
	Dim l As Label = Sender
	Dim m As Map = l.Tag
	PrefDialogEvents.LoadFromJson(File.ReadString(File.DirAssets, "events.json"))
	Wait For (PrefDialogEvents.ShowDialog(m, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim Paremeters() As String = Array As String(m.Get("month"), m.Get("event_type"), m.Get("description"), m.Get("value"), m.Get("id"))
		B4XLoadingIndicator1.Show
		Wait For(B4XPages.MainPage.jRDC.InsertUpdateRecord("updateEvents", Paremeters)) Complete (Answer As Map)
		If Answer.Get("Success") Then
			If m.Get("month") = pmDate.SelectedValue Then
				clvData.GetPanel(Index).GetView(0).GetView(1).Text = m.Get("event_type")
				clvData.GetPanel(Index).GetView(0).GetView(2).Text = m.Get("description")
				clvData.GetPanel(Index).GetView(0).GetView(6).Text = m.Get("value")
			Else
				PopulateCards(m.Get("month"))
				pmDate.SelectedValue = m.Get("month")
			End If
		Else 
			B4XPages.MainPage.Toast.Show("There was an error updating the remote database: " & Answer.Get("Error"))
			m = l.Tag 'Restore the map to the original value
		End If
		B4XLoadingIndicator1.Hide
	End If
End Sub

#if B4J
Private Sub lblDelete_MouseClicked (EventData As MouseEvent)
#else
Private Sub lblDelete_Click
#end if
	Dim Index As Int = clvData.GetItemFromView(Sender)
	Dim l As Label = Sender
	Dim m As Map = l.Tag
	Dim sf As Object = xui.Msgbox2Async("Delete event?", "WARNING", "Yes", "Cancel", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim Paremeters() As String = Array As String(m.Get("id"))
		B4XLoadingIndicator1.Show
		Wait For(B4XPages.MainPage.jRDC.InsertUpdateRecord("deleteEvents", Paremeters)) Complete (Answer As Map)
		If Answer.Get("Success") Then
			clvData.RemoveAt(Index)
		Else
			B4XPages.MainPage.Toast.Show("There was an error updating the remote database: " & Answer.Get("Error"))
			m = l.Tag 'Restore the map to the original value
		End If
		B4XLoadingIndicator1.Hide
	End If

End Sub

Private Sub AddCard
	Dim Data As Map = CreateMap()
	'By default, we will insert the card of the same month we're seeing. You can change it later
	'Por defecto, insertaremos una tarjeta del mismo mes seleccionado, aunque se puede cambiar
	Data.Put("month", pmDate.SelectedValue)
	PrefDialogEvents.LoadFromJson(File.ReadString(File.DirAssets, "events.json"))
	Wait For (PrefDialogEvents.ShowDialog(Data, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim Paremeters() As String = Array As String(B4XPages.MainPage.KVS.Get("id_user"), Data.Get("month"), Data.Get("event_type"), Data.Get("description"), Data.Get("value"))
		B4XLoadingIndicator1.Show
		Wait For(B4XPages.MainPage.jRDC.InsertUpdateRecord("addEvents", Paremeters)) Complete (Answer As Map)
		If Answer.Get("Success") Then
			If Data.Get("month") = pmDate.SelectedValue Then
				'If we add data in the selected month, add a card
				'Si añadimos datos del mismo mes seleccionado, añadimos una tarjeta
				Dim p As B4XView = CreateCard(Data)
				clvData.Add(p, Data)
				clvData.ScrollToItem(clvData.Size - 1)
			Else 
				'If we add data for a different month, change the date to this month and reload data
				'Si añadimos de otro mes, cambiamos la fecha a ese mes y recargamos los datos
				PopulateCards(Data.Get("month"))
				pmDate.SelectedValue = Data.Get("month")
			End If
		Else
			B4XPages.MainPage.Toast.Show("Error updating remote database: " & Answer.Get("Error"))
		End If
		B4XLoadingIndicator1.Hide
	End If
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	#if B4A
	'home button
	If Main.ActionBarHomeClicked Then
		Drawer.LeftOpen = Not(Drawer.LeftOpen)
		Return False
	End If
	'back key
	If Drawer.LeftOpen Then
		Drawer.LeftOpen = False
		Return False
	End If
	'back key while showing a PrefDialog
	If PrefDialogEvents.IsInitialized And PrefDialogEvents.Dialog.Visible Then 
		PrefDialogEvents.Dialog.Close(xui.DialogResponse_Cancel)
		Return False
	End If
	#end if
	Return True
End Sub

Private Sub B4XPage_Appear
	#if B4A
	Sleep(0)
	B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(True))
	Dim bd As BitmapDrawable
	bd.Initialize(HamburgerIcon)
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(bd))
	#End If
	
End Sub

Private Sub B4XPage_Disappear
	#if B4A
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(0))
	#end if
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	Drawer.Resize(Width, Height)
End Sub

Private Sub CreateMenu
	#if B4A
	Dim cs As CSBuilder
	Dim mi As B4AMenuItem
	mi = B4XPages.AddMenuItem(Me, cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(B4XPages.MainPage.PlusChar).PopAll)
	mi.AddToBar = True
	mi.Tag = "Add Event"
	#Else if B4i
	Dim bb As BarButton
	bb.InitializeSystem(bb.ITEM_REFRESH, "refresh")
	Dim bb2 As BarButton
	bb2.InitializeSystem(bb.ITEM_SEARCH, "search")
	Dim bb3 As BarButton
	bb3.InitializeSystem(bb.ITEM_ADD, "new post")
	B4XPages.GetNativeParent(Me).TopRightButtons = Array(bb2, bb, bb3)
	#Else If B4J
	Dim ivHamburger As ImageView
	ivHamburger.Initialize("imgHamburger")
	Drawer.CenterPanel.AddView(ivHamburger, 2dip, 2dip, 32dip, 32dip)
	ivHamburger.PickOnBounds = True
	#end if
End Sub

'this is not working
Private Sub B4XPage_MenuClick (Tag As String)
	Log(Tag)
	If Tag = "Add Event" Then
		Log("Adding Event")
		AddCard
	End If
End Sub

Sub btnSignOut_Click
	Drawer.LeftOpen = False
	B4XPages.MainPage.KVS.Remove("user")
	B4XPages.MainPage.KVS.Remove("id_user")
	B4XPages.MainPage.etPass.Text = ""
	B4XPages.MainPage.etUser.Text = ""
	B4XPages.ShowPageAndRemovePreviousPages("MainPage")
End Sub


#if B4J
Private Sub btnPlus_MouseClicked (EventData As MouseEvent)
	AddCard
End Sub

Private Sub btnRefresh_MouseClicked (EventData As MouseEvent)
	PopulateCards(pmDate.SelectedValue)
End Sub
#end if


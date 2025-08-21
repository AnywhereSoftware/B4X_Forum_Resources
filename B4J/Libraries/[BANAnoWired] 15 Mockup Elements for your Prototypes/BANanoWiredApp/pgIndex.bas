B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private wired As BANanoWired
	Private BANano As BANano
End Sub

Sub Init
	wired.Initialize(Me)
	wired.SetStateSingle("spin", False)
	'
	wired.CreateToggle("tgl").SetOnChange(Me, "onToggle").SetVModel("tgl").SetChecked(True).render
	wired.addbr
	
	'
	wired.CreateTextArea("txta").SetRows(9).SetPlaceholder("My text area").SetValue("Testing text area",False).Render
	wired.addbr
	
	'
	Dim tabs As WTabs = wired.createtabs("tabs1").SetSelected("three")
	tabs.AddItem("one","One", wired.CreateLabel("").SetText("Content of Tab 1").label)
	tabs.AddItem("two","Two", wired.CreateLabel("").SetText("Content of Tab 2").label)
	tabs.AddItem("three","Three", wired.CreateLabel("").SetText("Content of Tab 3").label)
	tabs.AddItem("four","Four", wired.CreateLabel("").SetText("Content of Tab 4").label)
	tabs.Render
	wired.addbr
	
	'
	wired.CreateSpinner("spn1").SetSpinning("spin", True).SetColor("red").Render
	wired.addbr
	'
	wired.createfab("fab1").SetText("favorite").SetBackgroundColor("lightpink").SetColor("darkred").Render
	wired.addbr
	'
	wired.CreateIconButton("ib1").SetText("favorite").SetColor("cyan").Render
	wired.addbr
	'
	wired.CreateProgress("prog1").SetValue("25",False).Render
	wired.AddBR
	'
	wired.CreateProgress("prog2").SetValue("10",False).SetMin(5).SetMax(15).Render
	wired.AddBR
	'
	wired.CreateProgress("prog3").SetValue("65",False).SetPercentage(True).Render
	wired.AddBR
	'
	wired.CreateProgress("prog4").SetValue("30",False).SetColor("rgba(220, 0, 50, 0.1)").SetLabelColor("green").SetFontSize("24px").SetWidth("300px").Render
	wired.AddBR
	'
	Dim inpname As WInput = wired.CreateInput("firstname").SetName("firstname",False).SetPlaceholder("Enter first name")
	inpname.SetVModel("firstname")
	inpname.Render
	wired.AddBR
	'
	wired.CreateInputPassword("pwd").SetPlaceholder("Password").Render
	wired.addbr
	'
	wired.CreateInput("dis").SetPlaceholder("Disabled").SetDisabled(True).Render
	wired.addbr
	'
	wired.CreateInputSearch("search").SetPlaceholder("Search").Render
	wired.addbr
	
	'
	Dim btn As WButton = wired.CreateButton("btn").SetText("Submit")
	btn.SetBackgroundColor("yellow").SetOnClick(Me, "onSave")
	btn.render
	wired.AddBR
	'
	wired.CreateButton("btnx").SetText("Elevated").SetElevation(3).render
	wired.addbr
	
	wired.CreateButton("btnd").SetText("Disabled").SetDisabled(True).render
	wired.addbr
	
	'
	Dim chk As WCheckBox = wired.CreateCheckBox("chk1").SetText("I agree").SetVModel("chk1")
	chk.SetIconColor("red")
	chk.SetOnChange(Me, "onChange")
	chk.Render
	'wired.AddBR
	'
	Dim rad As WRadio = wired.CreateRadio("rad1").SetText("A radio").SetVModel("rad1")
	rad.SetOnChange(Me, "onRadio")
	rad.Render
	wired.AddBR
	'
	Dim cbo As WCombo = wired.CreateCombo("combo")
	cbo.SetSelectedBackgroundColor("darkblue")
	cbo.SetSelected("two")
	cbo.AddItem("one","One")
	cbo.AddItem("two","Two")
	cbo.AddItem("three","Three")
	cbo.SetVModel("combo")
	cbo.SetOnSelected(Me, "onCombo")
	cbo.render
	wired.AddBR
	'
	Dim lbox As WListBox = wired.CreateListBox("lbox")
	lbox.SetSelected("two")
	lbox.AddItem("one","One")
	lbox.AddItem("two","Two")
	lbox.AddItem("three","Three")
	lbox.SetVModel("lbox")
	lbox.SetOnSelected(Me, "onListBox")
	lbox.render
	wired.AddBR
	'
	Dim lbox1 As WListBox = wired.CreateListBox("lbox1")
	lbox1.SetSelected("one").SetHorizontal(True)
	lbox1.AddItem("one","One")
	lbox1.AddItem("two","Two")
	lbox1.AddItem("three","Three")
	lbox1.SetVModel("lbox1")
	lbox1.SetOnSelected(Me, "onListBox1")
	lbox1.render
	wired.AddBR
	'
	Dim card1 As WCard = wired.CreateCard("card1")
	wired.CreateLabel("h3").SetSizeH3(True).SetText("Card 1").Pop(card1.Card)
	wired.CreateLabel("p1").SetSizeP(True).SetText("Lorem Ipsum....").Pop(card1.Card)
	card1.Render
	wired.AddBR
	'
	Dim card2 As WCard = wired.CreateCard("card2").SetElevation(3)
	Dim p2 As WLabel = wired.CreateLabel("p2").SetSizeP(True)
	p2.SetText("Lorem Ipsum....")
	card2.AddElement(p2.Label)
	card2.Render
	wired.AddBR
	'
	Dim rg As WRadioGroup = wired.CreateRadioGroup("rg")
	rg.SetSelected("one")
	rg.AddItem("one","One")
	rg.AddItem("two","Two")
	rg.AddItem("three","Three")
	rg.SetVModel("rg")
	rg.SetOnSelected(Me, "onRadioGroup")
	rg.render
	wired.AddBR
	'
	wired.CreateSlider("slid").SetVModel("slid").SetOnChange(Me, "onSlider").SetKnobZeroColor("red").SetKnobColor("green").Render
	wired.AddBR
	'
	wired.ux 
End Sub

Sub onToggle(e As BANanoEvent)
	Dim tgl As Boolean = wired.GetState("tgl",False)
	Log(tgl)
End Sub

Sub onSlider(e As BANanoEvent)
	Dim slid As String = wired.GetState("slid","0")
	Log(slid)
End Sub

Sub onRadioGroup(e As BANanoEvent)
	Dim rg As String = wired.GetState("rg","")
	Log(rg)
End Sub


Sub onSave(e As BANanoEvent)
	Dim fName As String = wired.GetState("firstname","")
	BANano.Window.Alert(fName)
End Sub


Sub onCombo(e As BANanoEvent)
	Dim combo As String = wired.GetState("combo","")
	Log(combo)
End Sub

Sub onListBox(e As BANanoEvent)
	Dim lbox As String = wired.GetState("lbox","")
	Log(lbox)
End Sub

Sub onListBox1(e As BANanoEvent)
	Dim lbox1 As String = wired.GetState("lbox1","")
	Log(lbox1)
End Sub

Sub onChange(e As BANanoEvent)
	Dim chk1 As Boolean = wired.GetState("chk1",False)
	Log(chk1)
End Sub

Sub onRadio(e As BANanoEvent)
	Dim rad1 As Boolean = wired.GetState("rad1",False)
	Log(rad1)
End Sub
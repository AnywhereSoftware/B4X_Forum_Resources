B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.19
@EndOfDesignText@
#Event: TextChanged(Text As String)
#DesignerProperty: Key: Editable, DisplayName: Editable, FieldType: Boolean, DefaultValue: True, Description: Whether the text of the CodeView is Editable
'Class module
Private Sub Class_Globals

	Private mCallBack As Object
    Private mEventName As String
	Private mForm As Form
	Private mBase As Pane
	Private mTag As Object
	Private DesignerCVCalled As Boolean
	Private Initialized As Boolean
	Private CustomViewName As String = "CodeArea" 'Set this to the name of your custom view to provide meaningfull error logging
	Private fx As JFX
	
	'Custom View Specific Vars
	Private JO As JavaObject				'To hold the wrapped CoreArea object
	Private CustomViewNode As Node			'So that we can call B4x exposed methods on the object and don't have to use Javaobject's RunMethod for everything
	
	Private mBaseJO As JavaObject			'So that we can call Methods not exposed to B4x on the base pane.
	
	'For string matching
	Private KEYWORD_PATTERN  As String
	Private TYPES_PATTERN  As String
	Private STRING_PATTERN As String
	Private COMMENT_PATTERN As String
	Private CONDITIONAL_PATTERN As String
	Private DIRECTIVE_PATTERN As String
	Private AS_PATTERN As String
	
	Private mTabCheckIgnore As Boolean
	
	Type SetScrollType(Required As Boolean,SB As JavaObject,XPos As Double,CursorPos As Int)
	Private SetScroll As SetScrollType
	
	Private Collections As JavaObject
	Private TotalStrLen As Int
End Sub

'Initializes the object.
'For a custom view these should not be changed, if you need more parameters for a Custom view added by code, you can add them to the
'setup sub, or an additional Custom view control method
'Required for both designer and code setup. 
Public Sub Initialize (vCallBack As Object, vEventName As String)
	'CallBack Module and eventname are provided by the designer, and need to be provided if setting up in code
	'These allow callbacks to the defining module using CallSub(mCallBack,mEventname), or CallSub2 or CallSub3 to pass parameters, or CallSubDelayed....
	mCallBack = vCallBack
	mEventName = vEventName
	
	'Global JavaObjects - Classes
	Collections.InitializeStatic("java.util.Collections")
End Sub
Public Sub DesignerCreateView(Base As Pane, Lbl As Label, Props As Map)
	'Check this is not called from setup
	If Not(Props.GetDefault("CVfromsetup",False)) Then DesignerCVCalled = True
	
	'Assign vars to globals
	mBase = Base

	'So that we can Call Runmethod on the Base Panel to run non exposed methods
	mBaseJO = Base

	'This is passed from either the designer or setup
	mForm = Props.get("Form")

	'Initialize our wrapper object
	JO.InitializeNewInstance("org.fxmisc.richtext.CodeArea",Null)
	
	'Cast the wrapped view to a node so we can use B4x Node methods on it.
	CustomViewNode = GetObject
	
	'Add the stylesheet to colour matching words to the code area node
	JO.RunMethodJO("getStylesheets",Null).RunMethod("add",Array(File.GetUri(File.DirAssets,"richtext.css")))
	
	'KeyListener
	Dim Event As Object = JO.CreateEvent("javafx.event.EventHandler","KeyPressed","")
	JO.RunMethod("setOnKeyPressed",Array(Event))
	
	'TextProperty Listener
	'Add an eventlistener to the ObservableValue "textProperty" so that we can get changes to the text
	Dim Event As Object = JO.CreateEvent("javafx.beans.value.ChangeListener","TextChanged","")
	JO.RunMethodJO("textProperty",Null).RunMethod("addListener",Array(Event))
	
	
	'BaseChanged Listener
	'Add an eventlistener to the ReadOnlyObjectProperty "layoutBoundsProperty" on the Base Pane so that we can change the internal layout to fit
	Dim Event As Object = JO.CreateEvent("javafx.beans.value.ChangeListener","BaseResized","")
	mBaseJO.RunMethodJO("layoutBoundsProperty",Null).RunMethod("addListener",Array(Event))
	
	'Deal with properties we have been passed
	setEditable(Props.Get("Editable"))
	
	
	'Create your CustomView layout in sub CreateLayout
	CreateLayout
	
	'Other Custom Initializations
	InitializePatternsB4x
	
	SetScroll.Initialize
	
	'Finally
	Initialized = True
End Sub

'Manual Setup of Custom View Pass Null to Pnl if adding to Form
Sub Setup(Form As Form,Pnl As Pane,Left As Int,Top As Int,Width As Int,Height As Int)
	'Check if DesignerCreateView has been called
	If DesignerCVCalled Then
		Log(CustomViewName & ": You should not call setup if you have defined this view in the designer")
		ExitApplication
	End If
	
	mForm = Form
	
	'Create our own base panel
	Dim Base As Pane
	Base.Initialize("")
	
	'If Null was passed, a Panel wii be created by casting, but it won't be initialized
	If Pnl.IsInitialized Then
		Pnl.AddNode(Base,Left,Top,Width,Height)
	Else
		If Form <> Null Then
			Form.RootPane.AddNode(Base,Left,Top,Width,Height)
		Else
			Base.SetSize(Width,Height)
		End If
	End If
		
	'Set up variables to pass to DesignerCreateView so we don't have to maintain two identical subs to create the custom view
	Dim M As Map
	M.Initialize
	M.Put("Form",Form)
	M.Put("Editable",True)
	'As we are passing a map, we can use it to pass an additional flag for our own use 
	'with an ID unlikely To be used by B4a In the future
	M.Put("CVfromsetup",True)
	
	'We need a label to pass to DesignerCreateView
	Dim L As Label
	L.Initialize("")
	'Default text alignment
	CSSUtils.SetStyleProperty(L,"-fx-text-alignment","center")
	'Default size for Custom View text in designer is 15
	L.Font = fx.DefaultFont(15)
	
	'Call designer create view
	DesignerCreateView(Base,L,M)
	
End Sub



#Region Working Subs
	'Working subs for the custom view go here, these should be mainly Private methods not accessible to other modules
	'For instance, automatic sizing or calculations or specific data validation methods called from customview specific methods.

	'Set the initial layout for the custom view
	Private Sub CreateLayout
		
		'Add the wrapper object to customview mBase
		mBase.AddNode(CustomViewNode,0,0,mBase.Width,mBase.Height)
		
		'Add any other Nodes to the CustomView
		
	End Sub
	
	'Called by a BaseChanged Listener when mBase size changes
	Private Sub BaseResized_Event(MethodName As String,Args() As Object) As Object			'ignore
		
		'Make our node added to the Base Pane the same size as the Base Pane
		CustomViewNode.PrefWidth = mBase.Width
		CustomViewNode.PrefHeight = mBase.Height
		
		'Make any changes needed to other integral nodes
		UpdateLayout
	End Sub
	
	'Update the layout as needed when the Base Pane has changed size.
	Private Sub UpdateLayout
		
	End Sub

#End Region Working subs

#Region Base Interface
	Sub getBasePane As Pane
		Return mBase
	End Sub
#End Region


#Region Wrapper Methods
	'Convenient method to assign a single style class.
	Public Sub SetStyleClass(SetFrom As Int, SetTo As Int, Class As String)
		JO.RunMethod("setStyleClass",Array As Object(SetFrom, SetTo, Class))
	End Sub
	'Gets the value of the property length.
	Public Sub Length As Int
		Return JO.RunMethod("getLength",Null)
	End Sub
	Sub GetText As String
		Return JO.RunMethod("getText",Null)
	End Sub
	'Replaces a range of characters with the given text.
	Public Sub ReplaceText(Start As Int, ThisEnd As Int, Text As String)
		JO.RunMethod("replaceText",Array As Object(Start, ThisEnd, Text))
	End Sub
	Public Sub setWrapText(Wrap As Boolean)
		JO.RunMethod("setWrapText",Array(Wrap))
	End Sub
	Public Sub getWrapText As Boolean
		Return JO.RunMethod("getWrapText",Null)
	End Sub
	'Get/Set the CodeArea Editable
	Public Sub setEditable(Editable As Boolean)
		JO.RunMethod("setEditable",Array(Editable))
	End Sub
	Public Sub getEditable As Boolean
		Return JO.RunMethod("isEditable",Null)
	End Sub
	Public Sub setFont(Font1 As Font)
		JO.RunMethod("setFont",Array(Font1))	
	End Sub
	Public Sub getFont As Font
		Return JO.RunMethod("getFont",Null)
	End Sub
		'Not yet implemented
	Public Sub ShowLineNumbers(Show As Boolean)
		Dim Target As JavaObject = JO
		Dim LF As JavaObject
		LF.InitializeStatic("org.fxmisc.richtext.LineNumberFactory")
		If Not(Show) Then
			JO.RunMethod("setParagraphGraphicFactory",Array(Null))	
		Else
			Log(LF.RunMethod("get",Array(Target)))
			Log(JO.RunMethod("getParagraphGraphicFactory",Null)	)
			JO.RunMethod("setParagraphGraphicFactory",Array(LF.RunMethod("get",Array(Target))))	
			
		End If
	End Sub


	Public Sub setTag(Tag As Object)
		mTag = Tag
	End Sub
	Public Sub getTag As Object
		Return mTag
	End Sub

	'Get the unwrapped object
	Public Sub GetObject As Object
		Return JO
	End Sub

	'Get the unwrapped object As a JavaObject
	Public Sub GetObjectJO As JavaObject
		Return JO
	End Sub
	'Comment if not needed

	'Set the underlying Object, must be of correct type
	Public Sub SetObject(Obj As Object)
		JO = Obj
	End Sub
#End Region Wrapper Methods



#Region CustomView Specific Methods
	'Customview specific control methods go here, these should be accessible from the calling module
	'For instance, setting text on a contained label
	
	Sub getTabCheckIgnore As Boolean
		Return mTabCheckIgnore
	End Sub
	Sub setTabCheckIgnore (Set As Boolean)
		mTabCheckIgnore = Set
	End Sub
	
	'Callback from KeyListener - Capture Crtl-c event and modify the text before passing it to the clipboard: Remove spaces and replace Tabs
	Sub KeyPressed_Event (MethodName As String, Args() As Object) As Object
		Dim KeyEvent As JavaObject = Args(0)
		Dim KeyName As String = KeyEvent.RunMethodJO("getCode",Null).RunMethod("getName",Null)
		If Main.cbTabsAsSpaces.Checked Then
			If KeyEvent.RunMethod("isControlDown",Null) And Not(KeyEvent.RunMethod("isShiftDown",Null)) And Not(KeyEvent.RunMethod("isAltDown",Null)) And Not(KeyEvent.RunMethod("isMetaDown",Null)) Then
				If KeyName = "C" Or KeyName = "X" Then
					Dim Text As String = JO.RunMethod("getSelectedText",Null)
					If Text = "" Then Text = GetText
					fx.Clipboard.SetString(TabStopManager.ReplaceSpaces(Text,Main.cmbTabsAsSpaces.Value))
					If KeyName = "X" Then
						Dim IndexRange As JavaObject = JO.RunMethod("getSelection",Null)
						Dim Start As Int = IndexRange.RunMethod("getStart",Null)
						Dim eEnd As Int = IndexRange.RunMethod("getEnd",Null)
						ReplaceText(Min(Start,eEnd),Max(Start,eEnd),"")
						JO.RunMethod("selectRange",Array(Start,Start))
					End If
					KeyEvent.RunMethod("consume",Null)
					Return ""
				End If
				If KeyName = "V" Or KeyName = "Z" Then
					Dim SBSet As JavaObject = JO.RunMethod("lookupAll",Array(".scroll-bar"))
					Dim Iterator As JavaObject = SBSet.RunMethod("iterator",Null)
					Dim Orientation As String
					Do While Iterator.RunMethod("hasNext",Null)
						Dim SB As JavaObject = Iterator.RunMethod("next",Null)
						Orientation = SB.RunMethodJO("getOrientation",Null).RunMethod("toString",Null) 
						If Orientation = "VERTICAL" Then Exit
					Loop
					Log(SB.RunMethod("getValue",Null))
					If Orientation = "VERTICAL" Then 
						SetScroll.Required = True
						SetScroll.SB = SB
						SetScroll.XPos =  SB.RunMethod("getValue",Null)
						SetScroll.CursorPos = JO.RunMethodJO("getSelection",Null).RunMethod("getStart",Null)
					End If
				End If	
			End If
		End If
		Return ""
	End Sub
	
	Sub ResetScrollPos(SScroll As SetScrollType)
		SetCursor(SScroll)
		CallSubDelayed2(Me,"SetScrollPos",SetScroll)
	End Sub
	
	Sub SetCursor(SScroll As SetScrollType)
		JO.RunMethod("selectRange",Array(SScroll.CursorPos,SScroll.CursorPos))
	End Sub

	Sub SetScrollPos(SScroll As SetScrollType)
'		Log("Setting Scroll to : " & SScroll.XPos)
'		Log("From : " & SScroll.SB.RunMethod("getValue",Null))
		SScroll.SB.RunMethod("setValue",Array(SScroll.XPos))
		SScroll.Initialize
	End Sub
	
	'Callback from TextProperty Listener when the codearea text changes
	Private Sub TextChanged_Event(MethodName As String,Args() As Object) As Object							'ignore
		Dim NewVal As String = Args(2)
		If Main.cbTabsAsSpaces.Checked And Not(mTabCheckIgnore) Then
'			Log(Utils.StringCount(NewVal,TAB,False) & "Tabs ")
			If NewVal.Contains(TAB) Then
				Dim Replacement As String = TabStopManager.ReplaceTabs(NewVal,Main.cmbTabsAsSpaces.Value)
				Dim IndexRange As JavaObject = JO.RunMethod("getSelection",Null)
				Dim Start As Int = IndexRange.RunMethod("getStart",Null)
			Start = Start + RT_Utils.StringCount(NewVal,TAB,False) * (Main.cmbTabsAsSpaces.Value - 1)
				mTabCheckIgnore = True
				ReplaceText(0,Length,Replacement)
				
				JO.RunMethod("selectRange",Array(Start,Start))
				Return ""
			End If
		End If
		mTabCheckIgnore = False
		JO.RunMethod("setStyleSpans",Array(0,ComputeHighlightingB4x(GetText)))
		If SetScroll.Required Then CallSubDelayed2(Me,"ReSetScrollPos",SetScroll)
		If SubExists(mCallBack,mEventName & "_TextChanged") Then
			Dim OldVal As String = Args(1)
			CallSub3(mCallBack,mEventName & "_TextChanged",OldVal,NewVal)
		End If
	End Sub
	
	'Setup for pattern matching
	Private Sub InitializePatternsB4x
	Dim FindStr As String = RT_Utils.StringJoin("|", RT_Utils.GetKeywords).Replace("()","\(\)")
		KEYWORD_PATTERN = $"\b(?:${FindStr})\b"$
	FindStr = RT_Utils.StringJoin("|", RT_Utils.GetTypes).Replace("()","\(\)")
		TYPES_PATTERN = $"\b(?:${FindStr})\b"$
		STRING_PATTERN = """""|""[^""]+""|[\w]+""|\$.*\$"
		COMMENT_PATTERN = $"'.*"$
	CONDITIONAL_PATTERN = $"^\s*(?:${RT_Utils.StringJoin("|", RT_Utils.GetConditional)}).*$"$
	DIRECTIVE_PATTERN = $"(^\s*${RT_Utils.StringJoin("|", RT_Utils.GetDirectives)})(.*$)"$
		AS_PATTERN = "(\bAs\b)\W(\w*)"																'The "As" word, not word character then any word characters
	End Sub

	'Create the style types for matching words
	Private Sub ComputeHighlightingB4x(Text As String) As JavaObject

		Dim Matcher1 As Matcher = Regex.Matcher2($"(${STRING_PATTERN})|(${KEYWORD_PATTERN})|${AS_PATTERN}|(${COMMENT_PATTERN})|(${CONDITIONAL_PATTERN})|${DIRECTIVE_PATTERN}|(${TYPES_PATTERN})"$,Regex.MULTILINE,Text)
		
		Dim SpansBuilder As JavaObject
		SpansBuilder.InitializeNewInstance("org.fxmisc.richtext.model.StyleSpansBuilder",Null)
		
		Dim Collections As JavaObject
		Collections.InitializeStatic("java.util.Collections")

		Dim TypesList As List
		TypesList.Initialize
		TypesList.AddAll(RT_Utils.GetTypes)
		
		Dim LastKwEnd As Int = 0
		Dim StyleClass As String
		Dim Index As Int
		TotalStrLen = 0
		Do While Matcher1.Find
			StyleClass = ""
				If Matcher1.Group(1) <> Null Then 
					Index = 1
					StyleClass = "string"
					LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
				Else
				If Matcher1.Group(7) <> Null Or Matcher1.Group(8) <> Null Then 
					If Matcher1.Group(8).Trim = "" Then
						Index = 7
						StyleClass = "error"
						LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
					Else
					Index = 7
					StyleClass = "directive"
					LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
					Index = 8
					StyleClass = "string"
					LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
					End If
				Else
					If Matcher1.Group(6) <> Null Then 
						Index = 6
						StyleClass = "conditional"
						LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
					Else
						If Matcher1.Group(2) <> Null Then
							Index = 2
							StyleClass = "keyword"
							LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
						Else
							If Matcher1.Group(3) <> Null Or Matcher1.Group(4) <> Null Then
'								Log(Matcher1.Group(3) & " : " & Matcher1.Group(4))
								If Matcher1.Group(4).Trim = "" Then
									Index = 3
									StyleClass = "error"
									LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
								Else		
									Index = 3
									StyleClass = "keyword"
									LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
									Index = 4
									StyleClass = "types"
									If TypesList.IndexOf(Matcher1.Group(4)) = -1 Then
										StyleClass = "notcoretype"
									End If
									LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)
								End If
							Else
								If Matcher1.Group(9) <> Null Then
									Index = 9
									StyleClass = "types"
									LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)				
								Else
									If Matcher1.Group(5) <> Null Then 
										Index = 5
										StyleClass = "comment"
										LastKwEnd = AddSpan(SpansBuilder,Index,LastKwEnd,Matcher1,StyleClass)				
									
										
										End If
									End If
								End If
							End If
						End If
				End If
			End If
				Loop
		SpansBuilder.RunMethod("add",Array(Collections.RunMethod("emptyList",Null),Text.Length - LastKwEnd))
		Return SpansBuilder.RunMethod("create",Null)		
	End Sub
	Sub AddSpan (SpansBuilder As JavaObject,Index As Int,LastKwEnd As Int,Matcher1 As Matcher,StyleClass As String)	As Int
'		Log("Gp" & Index & " " &  Matcher.Group(Index) & " : " & (Matcher.GetEnd(Index) - Matcher.GetStart(Index)))
		
		Dim StrLength As Int = Matcher1.GetStart(Index) - LastKwEnd
		TotalStrLen = TotalStrLen + StrLength
		SpansBuilder.RunMethod("add",Array(Collections.RunMethod("emptyList",Null),StrLength))
		StrLength = Matcher1.GetEnd(Index) - Matcher1.GetStart(Index)
		TotalStrLen = TotalStrLen + StrLength
		SpansBuilder.RunMethod("add",Array(Collections.RunMethod("singleton",Array(StyleClass)),StrLength))
		Return Matcher1.GetEnd(Index)
End Sub
	
#End Region CustomView Specific Methods

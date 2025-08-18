B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.19
@EndOfDesignText@
#IgnoreWarnings: 12
#DesignerProperty: Key: ChordColour, DisplayName: Chord Colour, FieldType: Color, DefaultValue: 0xFF000000, Description: Select a colour for the chord dots
#DesignerProperty: Key: TextColour, DisplayName: Text Colour, FieldType: Color, DefaultValue: 0xFF000000, Description: Select a colour for the text
'Class module
Private Sub Class_Globals

	Private mTarget As Object
    Private mEventName As String
	Private mForm As Form
	Private mBase As Pane
	Private mBaseJO As JavaObject
	Private DesignerCVCalled As Boolean
	Private Initialized As Boolean
	Private CustomViewName As String = "ShowChord" 'Set this to the name of your custom view to provide meaningfull error logging
	Private fx As JFX
	
	'Custom Vars
	Private StringCanv As Canvas
	Private ChordCanv As Canvas
	Private YTopBorder,YBottomBorder As Int
	Private StringPlaceWidth As Float
	Private FretHeight As Float
	Private mName As String
	Private mChord() As String
	Private ChordColour As Paint
	Private TextColour As Paint
	Private MidiSystem,Receiver,Synth As JavaObject
	Private MidiReady As Boolean
	Private Openstrings(6) As Int
	Private NoteOn As List
	Private TimeStamp As Long = -1
	Private Resizing As Boolean
	
	Type TextMetric (Width As Int,Height As Int)
	Dim CVS As B4XCanvas
	
End Sub

'Initializes the object.
'For a custom view these should not be changed, if you need more parameters for a Custom view added by code, you can add them to the
'setup sub, or an additional Custom view control method
'Required and code setup. 
'Provides callback {EventName}_ItemClick(Position As Int,Value As Object)
Public Sub Initialize (TargetModule As Object, EventName As String)
	'TargetModule and event name are provided by the designer, and need to be provided if setting up in code
	'These allow callbacks to the defining module using CallSub(mTarget,mEventname), or CallSub2 or CallSub3 to pass parameters, or CallSubDelayed etc.
	mTarget = TargetModule
	mEventName = EventName
	NoteOn.Initialize

End Sub
Public Sub DesignerCreateView(Base As Pane, Lbl As Label, Props As Map)
	'Check this is not called from setup
	If Not(Props.GetDefault("CVfromsetup",False)) Then DesignerCVCalled = True
	
	'Assign vars to globals
	mBase = Base
	mBaseJO = Base
	'This is passed from either the designer or setup
	mForm = Props.get("Form")
	CVS.Initialize(MForm.RootPane)
	
	ChordColour = Props.Get("ChordColour")
	TextColour = Props.Get("TextColour")
	Log(ChordColour)
	Log(TextColour)
'	ChordColour = fx.Colors.Blue
'	TextColour = fx.Colors.Black
	
	'Create your CustomView layout in sub CreateLayout
	CreateLayout
	
	MidiStart
	
	'Finally
	Initialized = True
End Sub

'Manual Setup of Custom View Pass Null as Panel if adding to activity
Sub Setup(Form As Form,Pnl As Pane,Left As Int,Top As Int,Width As Int,Height As Int)
	'Check if DesignerCreateView has been called
	If DesignerCVCalled Then
		Log(CustomViewName & ": You should not call setup if you have defined this view in the designer")
		Return
	End If
	
	mForm = Form
	
	'Create our own base panel
	Dim Base As Pane
	Base.Initialize("")
	
	'If Null was passed, a Panel wii be created by casting, but it won't be initialized
	If Pnl.IsInitialized Then
		Pnl.AddNode(Base,Left,Top,Width,Height)
	Else
		Form.RootPane.AddNode(Base,Left,Top,Width,Height)
	End If
		
	'Set up variables to pass to DesignerCreateView so we don't have to maintain two identical subs to create the custom view
	Dim M As Map
	M.Initialize
	M.Put("Form",Form)
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
	'Leave TextColor as default. Color is write only so we can't copy it, don't bother setting it
	
	'Call designer create view
	DesignerCreateView(Base,L,M)
	
End Sub
#Region Working Subs
	'Working subs for the custom view go here, these should be mainly Private methods not accessible to other modules
	'For instance, automatic sizing or calculations or specific data validation methods called from either panel methods or customview specific methods.

	'Set the initial layout for the custom view
	Private Sub CreateLayout
		'Add the views to mBase with initial sizes
		StringCanv.Initialize("")
		ChordCanv.Initialize("")
		mBase.AddNode(StringCanv,0,0,mBase.Width,mBase.Height)
		mBase.AddNode(ChordCanv,0,0,mBase.Width,mBase.Height)
		
		DrawBackGround

		'Set the base midi notes for the open strings
		Openstrings = Array As Int(40,45,50,55,59,64)
	
	End Sub
	'Update the layout
	Private Sub UpdateLayout(Width As Int,Height As Int)
		'Resize the views to fit the new mBase size. Called from Standard Panel Methods: setHeight, setWidth, setLayout
		ChordCanv.Width = Width
		ChordCanv.Height = Height
		StringCanv.Width = Width
		StringCanv.Height = Height
		DrawBackGround
		If mName <> "" Then 
			Resizing = True
			DrawChord(mName,mChord)
		End If
	End Sub
#End Region Working subs

#Region Standard Panel Methods
	'Standard Panel methods that work on the Base Panel (mBase)

	'Sets the background of the node via css
	Sub setColor(Color As String)
		CSSUtils.SetStyleProperty(mBase,"-fx-background-color",Color)
	End Sub
	'Changes the Z order of this view and brings it to the front.
	Sub BringToFront
		mBaseJO.RunMethod("toFront",Null)
	End Sub
	'Gets or sets the height of the displayed View. You will need to update the layout if the base panels Height changes
	Sub setHeight(Height As Int)
		mBase.PrefHeight = Height
		UpdateLayout(mBase.Width,Height)
	End Sub
	Sub getHeight As Int
		Return mBase.Height
	End Sub
	' Invalidates the view, forcing it to redraw itself.
	'Redrawing will only happen when the program can process messages. Usually when it finishes running the current code.
	Sub Invalidate
		mBaseJO.RunMethod("requestLayout",Null)
	End Sub
	'Returns True if the View has been initialized.  For a manually added custom view, subs Initialize and Setup must have also been called
	Sub IsInitialized As Boolean
		Return Initialized
	End Sub
	'Gets or sets the view's left position.
	Sub setLeft(Left As Int)
		mBase.Left = Left
	End Sub
	Sub getLeft As Int
		Return mBase.Left
	End Sub
		'Changes the Z order of this view and sends it to the back.
	Sub SendToBack
		mBaseJO.RunMethod("toBack",Null)
	End Sub
	Private Sub Base_Resize(Width As Double,Height As Double)
		UpdateLayout(Width, Height)
	End Sub
	'Changes the view position and size. You will need to update the layout if the base panels width or height changes
	Sub SetLayout(Left As Int,Top As Int,Width As Int,Height As Int)
		mBase.SetLayoutAnimated(0,Left,Top,Width,Height)
		UpdateLayout(Width,Height)
	End Sub
	'Gets or sets the Tag value. This is a place holder which can used to store additional data.
	Sub setTag(Tag As Object)
		mBase.Tag = Tag
	End Sub
	Sub getTag As Object
		Return mBase.Tag
	End Sub
	'Gets or sets the views top position.
	Sub getTop As Int
		Return mBase.Top
	End Sub
	Sub setTop(Top As Int)
		mBase.Top = Top
	End Sub
	'Gets or sets the views Visibility
	Sub setVisible(Visible As Boolean)
		mBase.Visible = Visible
	End Sub
	Sub getVisible As Boolean
		Return mBase.Visible
	End Sub
	'Gets or sets the view's width. You will need to update the layout if the base panels width changes
	Sub setWidth(Width As Int)
		mBase.PrefWidth = Width
		UpdateLayout(Width,mBase.height)
	End Sub
	Sub getWidth As Int
		Return mBase.Width
	End Sub
#End Region Standard Panel Methods



#Region CustomView Specific Methods
	'Customview specific control methods go here, these should be accessible from the calling module
	'For instance, setting text on a contained label

Private Sub DrawBackGround
	
	StringCanv.ClearRect(0,0,ChordCanv.Width,ChordCanv.Height)
	'Set Vars
	Dim StringHeight As Int = MeasureText("A",fx.DefaultFont(20)).Height

	YBottomBorder = (mBase.Height/100)*10
	YTopBorder = YBottomBorder+StringHeight
	StringPlaceWidth = mBase.Width/6
	FretHeight = (mBase.Height-(YTopBorder+YBottomBorder))/5
	
	Dim StringDispWidth As Int = 1
	Dim YPos As Float
	Dim XPos As Float
	
	'Draw Strings
	For i = 0 To 5
		XPos = (i*StringPlaceWidth)+(StringPlaceWidth/2)
		StringCanv.DrawLine(XPos,YTopBorder,XPos,mBase.Height-YBottomBorder,fx.Colors.Black,StringDispWidth)
	Next
	
	'Draw Frets
	For i = 0 To 5
		YPos = (i*FretHeight)+YTopBorder
		StringCanv.DrawLine(StringPlaceWidth/2,YPos,mBase.Width-StringPlaceWidth/2,YPos,fx.Colors.Black,StringDispWidth)
	Next
End Sub

Public Sub DrawChord(Name As String,Chord() As String)
	mName = Name
	mChord = Chord
	NoteOn.Clear

	'Clear the canvas
	ChordCanv.ClearRect(0,0,ChordCanv.Width,ChordCanv.Height)

	'Draw the chord name
	Dim X,Y As Float
	X=(mBase.Width-MeasureText(Name,fx.DefaultFont(16)).Width)/2
	Y=YBottomBorder
	ChordCanv.DrawText(Name,X,Y,fx.DefaultFont(16),TextColour,"LEFT")
		
	For i = 0 To Chord.Length-1
		If Chord(i).ToLowerCase <> "x" Then
			'Draw Open Strings marker
			X = (i*StringPlaceWidth)+(StringPlaceWidth/2)
			If Chord(i) = 0 Then 
				Y = YTopBorder
				ChordCanv.DrawText("O",X,Y,fx.DefaultFont(16),ChordColour,"CENTER")
				PlayNote(Openstrings(i) + Chord(i))
				
			Else
				'Draw Fingering markers
				Y=((Chord(i)-1)*FretHeight)+(FretHeight/2)+YTopBorder
				ChordCanv.DrawCircle(X,Y,FretHeight/4,ChordColour,True,1)
				PlayNote(Openstrings(i) + Chord(i))
			End If
			
		Else
			'Draw Muted Strings marker
			X = (i*StringPlaceWidth)+(StringPlaceWidth/2)
			Y = YTopBorder
			ChordCanv.DrawText("X",X,Y,fx.DefaultFont(16),TextColour,"CENTER")
		End If
	Next
	Resizing = False
End Sub

Private Sub PlayNote(NoteNum As Int)
	If Not(MidiReady) Then
		Log("Midi Device is not ready")
		Return
	End If
	If Resizing Then Return	
	'Create a short midi message
	Dim Message As JavaObject
	Message.InitializeNewInstance("javax.sound.midi.ShortMessage",Null)

	'Set our data to the message (0x90 is note on, 0x60 is the velocity (volume)
	Dim NoteOnMsg() As Object
	NoteOnMsg = Array As Object(0x90,NoteNum,0x60)
	Message.RunMethod("setMessage",NoteOnMsg)

	'Play the note
	Receiver.RunMethod("send",Array(Message,TimeStamp))
	
	'Record the note so we can turn it off in notesoff sub
	NoteOn.Add(NoteOnMsg)
End Sub

'Return a customtype with width and height
Private Sub MeasureText(Text As String,TFont As Font) As TextMetric
    Dim TB,Bounds As JavaObject
    Dim TM As TextMetric

	Dim R As B4XRect = CVS.MeasureText(Text,TFont)
	TM.Initialize
	TM.Width = R.Width
	TM.Height = R.Height

'    TB.InitializeStatic("javafx.scene.text.TextBuilder")
'    Bounds = TB.RunMethodJO("create",Null).RunMethodJO("text",Array(Text)).RunMethodJO("font",Array(TFont)).RunMethodJO("build",Null).RunMethodJO("getLayoutBounds",Null)
'
'    TM.Width = Bounds.RunMethod("getWidth",Null)
'    TM.Height = Bounds.RunMethod("getHeight",Null)
    Return TM
End Sub

'Start the Midi System
Private Sub MidiStart
	Try
		'Get the MidiSysten Object
		MidiSystem.InitializeStatic("javax.sound.midi.MidiSystem")
		
		'Get the receiver for the Default Midi Synthesizer
		Receiver = MidiSystem.RunMethod("getReceiver",Null)
		
		Synth = MidiSystem.RunMethod("getSynthesizer",Null)
		Synth.RunMethod("open",Null)
		Receiver = Synth.RunMethodJO("getReceiver",Null)
		
	Catch
		'If a midi synth is not available
		Log(LastException)
		Log("Midi System unavailable")
		Return
	End Try
	
	'Create a Short Midi Message
	Dim Message As JavaObject
	Message.InitializeNewInstance("javax.sound.midi.ShortMessage",Null)
	
	'Create a patch change message to a guitar sound
	Message.RunMethod("setMessage",Array(0xc0,26,0x0))
	
	'Send the message
	Receiver.RunMethod("send",Array(Message,TimeStamp))
	
	
	'Now we are ready to play notes
	MidiReady = True
End Sub

'Turn off currently playing notes
Public Sub NotesOff
	If Not(MidiReady) Then
		Log("Midi Device is not ready")
		Return
	End If
	For Each NoteOffMsg() As Object In NoteOn
		
		'Create a short midi message
		Dim Message As JavaObject
		Message.InitializeNewInstance("javax.sound.midi.ShortMessage",Null)
		
		'Change the note on data to a note off
		NoteOffMsg(0) = 0x80
		
		'Set our data to the message
		Message.RunMethod("setMessage",NoteOffMsg)
		
		'Play the message
		Receiver.RunMethod("send",Array(Message,TimeStamp))
	Next
End Sub

'Closes the Midi Receiver
Sub Close
	Receiver.RunMethod("close",Null)
	Synth.RunMethod("close",Null)
End Sub
	
#End Region CustomView Specific Methods

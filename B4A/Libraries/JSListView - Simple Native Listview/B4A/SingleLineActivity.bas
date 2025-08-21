Type=Activity
Version=6.3
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
	#Extends: android.support.v7.app.AppCompatActivity
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private JSListView1 As JSListView
	Private Label1 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	Activity.LoadLayout("1")
	Activity.Title = "Single Line Item"		

	Dim data As List
	data.Initialize
	For i= 1 To 100
		data.Add("This is an item " & i)
	Next
	
	JSListView1.DataSource = data
	JSListView1.FastScrollEnabled = True
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub JSListView1_OnGetView(position As Int, itemLayout As ItemViewLayout, forViewUpdate As Boolean)
	Dim iv As ItemViewLayout = itemLayout	
	
	If forViewUpdate = False Then
		Dim p As Panel
		p.Initialize("")
		p.LoadLayout("SingleLineItem")
		iv.Container = p
		
		Label1.Tag = 1	
		Label1.Width = 100%x - Label1.Left
		
		Label1.Typeface = Typeface.LoadFromAssets("JosefinSans-Bold.ttf")
		
		iv.Height = Label1.Top + Label1.Height + 10dip
		iv.Width = 100%x	
		
	End If

	Label1 = iv.findViewWithTag(1)	
	Label1.Text = JSListView1.DataSource.Get(position)
End Sub

Sub JSListView1_OnItemClick(view As ItemViewLayout, position As Int)
	Log(GetType(view))
	ToastMessageShow($"JSListView1_OnItemClick @ position: ${position}"$, False)
End Sub

Sub JSListView1_OnItemLongClick(view As ItemViewLayout, position As Int)
	Log(GetType(view))
	ToastMessageShow($"JSListView1_OnItemLongClick @ position: ${position}"$, False)
End Sub
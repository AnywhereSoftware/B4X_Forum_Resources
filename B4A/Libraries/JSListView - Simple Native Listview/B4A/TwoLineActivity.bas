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
	Private Label2 As Label	
	Dim recipes As List 
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("1")
	Activity.Title = "Two Line Item"		
	
	Dim js As JSONParser
	js.Initialize(File.ReadString(File.DirAssets, "recipes.json"))
	Dim m As Map = js.NextObject
	recipes = m.Get("recipes")
	
	JSListView1.DataSource = recipes
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
		p.LoadLayout("TwoLineLayout")
		iv.Container = p

		Label1.Tag = 1	
		Label2.Tag = 2
		
		Label1.Width = 100%x - Label1.Left - 10dip
		Label2.Width = 100%x - Label2.Left - 10dip
		
		'		
		Label1.Typeface = Typeface.LoadFromAssets("JosefinSans-Bold.ttf")
		Label2.Typeface = Typeface.LoadFromAssets("JosefinSans-SemiBoldItalic.ttf")
		Label1.Gravity = Gravity.TOP
		Label2.Gravity = Gravity.TOP
		
		Label1.Height = 15dip
		Label2.Top = Label1.Top + Label1.Height
		Label2.Height = 30dip
		Label2.TextColor = Colors.RGB(3, 169, 244)		
		
		iv.Height = Label1.Top + Label2.top + Label2.Height 
		iv.Width = 100%x	
	End If

	Dim mapper As Map = recipes.Get(position)

	Label1 = iv.findViewWithTag(1)	
	Label2 = iv.findViewWithTag(2)	
			
	Label1.Text = mapper.Get("title")	
	Label2.Text = mapper.Get("url")
		
End Sub

Sub JSListView1_OnItemClick(view As ItemViewLayout, position As Int)
	Log(GetType(view))
	ToastMessageShow($"JSListView1_OnItemClick @ position: ${position}"$, False)
End Sub

Sub JSListView1_OnItemLongClick(view As ItemViewLayout, position As Int)
	Log(GetType(view))
	ToastMessageShow($"JSListView1_OnItemLongClick @ position: ${position}"$, False)
End Sub
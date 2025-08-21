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
	Private ImageView1 As ImageView
	Private Label1 As Label
	Private Label2 As Label	
	Private Label3 As Label
	Dim data As List 
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("1")
	Activity.Title = "Custom Listview 2"		
	
	Dim js As JSONParser
	js.Initialize(File.ReadString(File.DirAssets, "MOCK_DATA.json"))
	Dim data As List = js.NextArray

	' Create gradient divider
	Dim cd As GradientDrawable
	Dim c() As Int = Array As Int(Colors.rgb(252, 237, 242), 0xFFE91E63, Colors.rgb(252, 237, 242))
	cd.Initialize("TR_BL", c)
	
	JSListView1.Divider = cd
	JSListView1.DividerHeight = 3dip
	
	' set custom overscroll: which is currently not working...
	Dim cd2 As ColorDrawable
	cd2.Initialize(0xFFE91E63, 0)
	JSListView1.OverscrollHeader = cd
	JSListView1.OverscrollFooter = cd

	JSListView1.DataSource = data
	JSListView1.FastScrollEnabled = True	
	
	Activity.Title = "Custom Listview 2 - Total: " & data.Size
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub JSListView1_OnGetView(position As Int, itemLayout As ItemViewLayout, forViewUpdate As Boolean)
	Log($"JSListView1_OnGetView @ Position: ${position}"$)
	
	Dim iv As ItemViewLayout = itemLayout	
	
	Dim p As Panel	
	p.Initialize("")	
	If forViewUpdate = False Then
		p.LoadLayout("CustomLayout2")
		iv.Container = p

		Label1.Tag = 1	
		Label2.Tag = 2
		Label3.Tag = 3
		ImageView1.Tag = 4

		Label1.Width = 100%x - Label1.Left - 10dip
		Label2.Width = 100%x - Label2.Left - 10dip
		Label3.Width = 100%x - Label3.Left - 10dip
		
		'		
		Label1.Typeface = Typeface.LoadFromAssets("JosefinSans-Bold.ttf")
		Label1.TextColor = Colors.RGB(3, 169, 244)	
		Label1.Gravity = Gravity.TOP
		
		Label2.Typeface = Typeface.LoadFromAssets("JosefinSans-Bold.ttf")	
		Label2.Gravity = Gravity.TOP
		
		Label3.Typeface = Typeface.LoadFromAssets("JosefinSans-SemiBoldItalic.ttf")		
		Label3.Gravity = Gravity.TOP

		iv.Height = ImageView1.Top + ImageView1.Height + 10dip
		iv.Width = 100%x	
	End If

	Dim mapper As Map = data.Get(position)

	Label1 = iv.findViewWithTag(1)	
	Label2 = iv.findViewWithTag(2)	
	Label3 = iv.findViewWithTag(3)	
	ImageView1 = iv.findViewWithTag(4)	

	Label1.Text = $"(${mapper.Get("id")}) ${mapper.Get("fullname")} - ${mapper.Get("job_title")}"$	
	Label2.Text = mapper.Get("company")
	Label3.Text = mapper.Get("slogan")
	
	p = iv.Container
	If position Mod 2 = 0 Then
		p.Color = Colors.Transparent
	Else
		p.Color = Colors.ARGB(20, 100, 100, 100)
	End If
	
	Dim picaso As Picasso
	picaso.Initialize
	picaso.LoadUrl(mapper.Get("avatar")).Resize(ImageView1.Width,ImageView1.Height).CenterCrop.IntoImageView(ImageView1)
	
End Sub

Sub JSListView1_OnItemClick(view As ItemViewLayout, position As Int)
	ToastMessageShow($"JSListView1_OnItemClick @ position: ${position}"$, False)
End Sub

Sub JSListView1_OnItemLongClick(view As ItemViewLayout, position As Int)
	ToastMessageShow($"JSListView1_OnItemLongClick @ position: ${position}"$, False)
End Sub
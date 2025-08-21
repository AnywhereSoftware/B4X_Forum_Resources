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
	Dim data As List 
	Dim tempData As List

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private JSListView1 As JSListView
	Private ImageView1 As ImageView
	Private Label1 As Label
	Private Label2 As Label	
	Private Label3 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("2")
	Activity.Title = "Custom Listview 3"		
		
	If FirstTime Then
		' will use this to generate sample data
		Dim js As JSONParser
		js.Initialize(File.ReadString(File.DirAssets, "MOCK_DATA.json"))
		tempData = js.NextArray

		' initialize temporary data
		Dim data As List
		data.Initialize
	End If
	
	' Create gradient divider
'	Dim cd As GradientDrawable
'	Dim c() As Int = Array As Int(Colors.rgb(252, 237, 242), 0xFFE91E63, Colors.rgb(252, 237, 242))
'	cd.Initialize("TR_BL", c)
'
'	JSListView1.Divider = cd
'	JSListView1.DividerHeight = 3dip
	
	' add menu
	Activity.AddMenuItem3("Add Item", "btnAdd", Null, True)
	Activity.AddMenuItem3("Add Item At", "btnAddAt", Null, True)
	Activity.AddMenuItem3("Update Item", "btnUpdate", Null, True)
	Activity.AddMenuItem3("Remove Item", "btnRemove", Null, True)
	Activity.AddMenuItem3("Clear All", "btnClear", Null, True)
	
	' Sample Header
'	Dim lblHeader As Label
'	lblHeader.Initialize("")
'	lblHeader.Text = "This is Header"
'	lblHeader.TextSize = 20
'	lblHeader.Gravity = Gravity.CENTER
'	lblHeader.Color = 0xFFE91E63	
'	lblHeader.TextColor = Colors.White
'	lblHeader.Typeface = Typeface.LoadFromAssets("JosefinSans-Bold.ttf")
'	
'	JSListView1.addHeaderView(lblHeader, Null, False)
	
	JSListView1.DataSource = data
	JSListView1.FastScrollEnabled = True			
	JSListView1.CacheColorHint = 0
	JSListView1.DividerHeight = 5dip
	Activity.Title = "Custom Listview 3 - Total: " & data.Size
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub JSListView1_OnGetView(position As Int, itemLayout As ItemViewLayout, forViewUpdate As Boolean)	
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
'	ToastMessageShow($"JSListView1_OnItemClick @ position: ${position}"$, False)
End Sub

Sub JSListView1_OnItemLongClick(view As ItemViewLayout, position As Int)
'	ToastMessageShow($"JSListView1_OnItemLongClick @ position: ${position}"$, False)
End Sub

Sub btnAdd_Click
	Try
		' lets just copy a data from tempdata randomly and add it to listview		
		Dim m As Map = tempData.Get(Rnd(0, tempData.Size-1))
		JSListView1.ItemAdd(m)
		Activity.Title = "Custom Listview 3 - Total: " & data.Size		
		Log("New item added...")
	Catch
		Log(LastException)
	End Try
End Sub


Sub btnAddAt_Click
	Try
		' check if size is not zero and randomly add item on the list
		Dim m As Map = tempData.Get(Rnd(0, tempData.Size-1))
		Dim pos As Int = 0 
		If data.Size > 0 Then pos = Rnd(0, data.Size)
		JSListView1.ItemAddAt(pos, m)	
		Activity.Title = "Custom Listview 3 - Total: " & data.Size
		Log($"New item added at position ${pos}..."$)
	Catch
		Log(LastException)
	End Try
End Sub

Sub btnUpdate_Click
	Try
		' check if size is not zero
		If data.Size <= 0 Then Return		
		' get random item
		Dim m As Map = tempData.Get(Rnd(0, tempData.Size-1))
		' update an item on listview randomly
		Dim pos As Int = Rnd(0, data.Size)
		JSListView1.ItemUpdateAt(pos, m)	
		Log($"item updated at position ${pos}..."$)
	Catch
		Log(LastException)
	End Try
End Sub

Sub btnRemove_Click
	Try
		' check if size is not zero and randomly remove item on the list
		If data.Size <= 0 Then Return		
		Dim pos As Int = Rnd(0, data.Size)
		JSListView1.ItemRemoveAt(pos)	
		Activity.Title = "Custom Listview 3 - Total: " & data.Size
		Log($"item removed at position ${pos}..."$)
	Catch
		Log(LastException)
	End Try
End Sub

Sub btnClear_Click
	Try
		' check if size is not zero and randomly remove item on the list
		If data.Size <= 0 Then Return		
		JSListView1.ItemClearAll
		Activity.Title = "Custom Listview 3 - Total: " & data.Size
		Log($"item list cleared"$)
	Catch
		Log(LastException)
	End Try
End Sub

B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.7
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private MC7RecyclerView1 As MC7RecyclerView
	
	Dim Model As iModel
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("2")
	Model.Initialize
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Private Sub MC7RecyclerView1_GetItemCount As Int
	Return Model.ListSize
End Sub

Private Sub MC7RecyclerView1_onCreateViewHolder (Parent As Panel,ViewType As Int)
	Parent.SetLayout(0 , 0 , 100%x , 140dip)
	Parent.LoadLayout("rv_items")
End Sub
Private Sub MC7RecyclerView1_onBindViewHolder (Parent As Panel,Position As Int)
	Dim mp As Map = Model.getListObject(Position)
	
	Private Pnl As Panel 		= Parent.GetView(0)
	Private title As Label		= Pnl.GetView(0)
	Private imgv As ImageView	= Pnl.GetView(1)
	
	title.Text 	= mp.GetKeyAt(0)
	imgv.Bitmap = LoadBitmapSample(File.DirAssets , mp.GetValueAt(0) , imgv.Width , imgv.Height)
End Sub

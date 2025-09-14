B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
' B4XTblClmUtils - Class module.
' Description: allows you to set some properties of a B4XTableColumn (simple and default cells).
' Author: LucaMs
' Version: 1.0	4/22/2020

Sub Class_Globals
	#If B4J
		Private fx As JFX
	#End If
	Private xui As XUI
	
	Private Const XCLMN_PROP_TEXTSIZE As String = "TextSize"
	Private Const XCLMN_PROP_TEXTCOLOR As String = "TextColor"	'XUI colors
	Private Const XCLMN_PROP_FONT As String = "Font"					'B4XFont
	Private Const XCLMN_PROP_PADDING As String = "Padding"			'B4A only.
	Private Const XCLMN_PROP_COLORANDBORDER As String = "ColorAndBorder"
	Private Const CAB_BGCOLOR As String = "BGC"
	Private Const CAB_BWIDTH As String = "BW"
	Private Const CAB_BCOLOR As String = "BC"
	Private Const CAB_BCRADIUS As String = "BCR"
	
	Private mB4XTable As B4XTable
	Private mmapProps As Map
End Sub

'Allows you to set some properties of a B4XTableColumn (simple and default cells).
' Version 1.0 - LucaMs
Public Sub Initialize(Table As B4XTable)
	mB4XTable = Table
	mmapProps.Initialize
End Sub

#Region PROPERTIES 

Public Sub setTable(Table As B4XTable)
	mB4XTable = Table
End Sub
Public Sub getTable As B4XTable
	Return mB4XTable
End Sub

#End Region

#Region PUBLIC METHODS 

Public Sub SetTextSize(ColumnIndex As Int, Size As Double)
	mmapProps.Clear
	mmapProps.Put(XCLMN_PROP_TEXTSIZE, Size)
	SetColumnCellProps(ColumnIndex, mmapProps)
End Sub

Public Sub SetFont(ColumnIndex As Int, Font As B4XFont)
	mmapProps.Clear
	mmapProps.Put(XCLMN_PROP_FONT, Font)
	SetColumnCellProps(ColumnIndex, mmapProps)
End Sub

Public Sub SetFont2(ColumnIndex As Int, FontFileName As String, Size As Double)
	Dim Font As B4XFont
	#If B4J
		Font = xui.CreateFont(fx.LoadFont(File.DirAssets, FontFileName, Size), Size)
	#Else If B4A OR B4I
		Dim TF As Typeface
		TF = Typeface.LoadFromAssets(FontFileName)
		Font = xui.CreateFont(TF, Size)
	#End If
	SetFont(ColumnIndex, Font)
End Sub

' Color must be one of the xui colors.
'<code>
' Dim xui As XUI
' Dim mB4XTblClmUtils As B4XTblClmUtils
' mB4XTblClmUtils.Initialize(B4XTable1)
' mB4XTblClmUtils.SetTextColor(0, xui.Color_Blue)
'</code>
Public Sub SetTextColor(ColumnIndex As Int, Color As Int)
	mmapProps.Clear
	mmapProps.Put(XCLMN_PROP_TEXTCOLOR, Color)
	SetColumnCellProps(ColumnIndex, mmapProps)
End Sub

#If B4A
Public Sub SetPadding(ColumnIndex As Int, Left As Int, Top As Int, Right As Int, Bottom As Int)
	mmapProps.Clear
	mmapProps.Put(XCLMN_PROP_PADDING, Array As Int(Left, Top, Right, Bottom))
	SetColumnCellProps(ColumnIndex, mmapProps)
End Sub
#End If

Public Sub SetColorAndBorder(ColumnIndex As Int, _
									  BackgroundColor As Int, _
									  BorderWidth As Double, _
									  BorderColor As Int, _
									  BorderCornerRadius As Double)
	mmapProps.Clear
	Dim mapValues As Map
	mapValues.Initialize
	mapValues.Put(CAB_BGCOLOR, BackgroundColor)
	mapValues.Put(CAB_BWIDTH, BorderWidth)
	mapValues.Put(CAB_BCOLOR, BorderColor)
	mapValues.Put(CAB_BCRADIUS, BorderCornerRadius)
	mmapProps.Put(XCLMN_PROP_COLORANDBORDER, mapValues)
	SetColumnCellProps(ColumnIndex, mmapProps)
End Sub

#End Region

#Region PRIVATE METHODS 

' Note:
' 1 - you should first set BuildLayoutsCache, like:
'	B4XTable1.MaximumRowsPerPage = 10
'	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
'
' 2 - for XCLMN_PROP_COLORANDBORDER, pass a map with BAC_ constants as keys:
'	SetColumnCellProps(B4XTable1, 0, CreateMap(CAB_BGCOLOR:xui.Color_LightGray))
Private Sub SetColumnCellProps(ColumnIndex As Int, Properties As Map)
	Dim xColumn As B4XTableColumn = mB4XTable.Columns.Get(ColumnIndex)
	For i = 1 To xColumn.CellsLayouts.Size - 1
		Dim pnl As B4XView = xColumn.CellsLayouts.Get(i)
		Dim lbl As Label = pnl.GetView(0)
		Dim xLbl As B4XView = lbl
		' Here set the lbl properties.
		Dim PropName As String
		Dim PropValue As Object
		For p = 0 To Properties.Size - 1
			PropName = Properties.GetKeyAt(p)
			PropValue = Properties.GetValueAt(p)
			Select PropName
				Case XCLMN_PROP_TEXTSIZE
					lbl.TextSize = PropValue
				Case XCLMN_PROP_FONT
					xLbl.Font = PropValue
				Case XCLMN_PROP_TEXTCOLOR
					xLbl.TextColor = PropValue
				Case XCLMN_PROP_PADDING
					#If B4A
						lbl.Padding = PropValue
					#End If
				Case XCLMN_PROP_COLORANDBORDER
					Dim mCAB As Map = PropValue
					xLbl.SetColorAndBorder(mCAB.GetDefault(CAB_BGCOLOR, xui.Color_White), _
												  mCAB.GetDefault(CAB_BWIDTH, 1), _
												  mCAB.GetDefault(CAB_BCOLOR, xui.Color_Black), _
												  mCAB.GetDefault(CAB_BCRADIUS, 0))
			End Select
		Next
	Next
End Sub

#End Region

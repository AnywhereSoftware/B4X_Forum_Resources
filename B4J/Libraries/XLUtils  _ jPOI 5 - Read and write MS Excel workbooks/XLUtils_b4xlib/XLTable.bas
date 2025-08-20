B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Public jTable As JavaObject
	Private mSheet As XLSheetWriter
	Private jMe As JavaObject
End Sub

'Use XLSheetWriter.CreateTable instead.
Public Sub Initialize (XSSFTable As JavaObject, Sheet As XLSheetWriter)
	jTable = XSSFTable
	mSheet = Sheet
	jMe = Me
End Sub

'Gets or sets the table name.
Public Sub getName As String
	Return jTable.RunMethod("getName", Null)
End Sub

Public Sub setName(n As String)
	If mSheet.ValidateTableName(n) = False Then Return
	jTable.RunMethod("setName", Array(n))
End Sub
'Gets or sets the table display name.
Public Sub getDisplayName As String
	Return jTable.RunMethod("getDisplayName", Null)
End Sub

Public Sub setDisplayName(n As String)
	If mSheet.ValidateTableName(n) = False Then Return
	jTable.RunMethod("setDisplayName", Array(n))
End Sub

'Gets or sets the table style name.
Public Sub getStyleName As String
	Return jTable.RunMethod("getStyleName", Null)
End Sub

Public Sub setStyleName(n As String)
	jTable.RunMethod("setStyleName", Array(n))
End Sub

Private Sub GetStyle As JavaObject
	Return jTable.RunMethodJO("getStyle", Null)
End Sub

'Gets or sets the table area.
Public Sub getCellReferences As XLRange
	Dim area As JavaObject = jTable.RunMethod("getCellReferences", Null)
	Return mSheet.xl.AreaReferenceToXLRange(mSheet.Workbook.PoiWorkbook, area)
End Sub

Public Sub setCellReferences (Range As XLRange)
	Range.Sheet = mSheet.PoiSheet
	Dim area As Object = mSheet.xl.XLRangeToAreaReference(mSheet.Workbook, Range)
	jTable.RunMethod("setArea", Array(area))
End Sub

'Gets or sets whether column stripes are shown.
Public Sub getShowColumnStripes As Boolean
	Return GetStyle.RunMethod("isShowColumnStripes", Null)
End Sub

Public Sub setShowColumnStripes (b As Boolean)
	GetStyle.RunMethod("setShowColumnStripes", Array(b))
End Sub

'Gets or sets whether rows stripes are shown.
Public Sub getShowRowStripes As Boolean
	Return GetStyle.RunMethod("isShowRowStripes", Null)
End Sub

Public Sub setShowRowStripes (b As Boolean)
	GetStyle.RunMethod("setShowRowStripes", Array(b))
End Sub

'Adds auto filter to the table columns.
Public Sub AddAutoFilter
	jMe.RunMethod("addAutoFilter", Array(jTable))
End Sub

'Public Sub getTotalsRowCount As Int
'	Return jTable.RunMethod("getTotalsRowCount", Null)
'End Sub
'
'Public Sub setTotalsRowCount (t As Int)
'	jMe.RunMethod("setTotalsRowCount", Array(jTable, t))
'End Sub
'
'Public Sub setTotalsRowShown (b As Boolean)
'	jMe.RunMethod("setTotalsRowShown", Array(jTable, b))
'End Sub

#if Java
import org.apache.poi.xssf.usermodel.*;
public void addAutoFilter(XSSFTable table) {
	table.getCTTable().addNewAutoFilter().setRef(table.getArea().formatAsString());
}

public void setTotalsRowShown(XSSFTable table, boolean b) {
	table.getCTTable().setTotalsRowShown(b);
}
public void setTotalsRowCount(XSSFTable table, int b) {
	table.getCTTable().setTotalsRowCount(b);
}
#End If


B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

Public Sub GetCurrentLocale As Object
	Dim Locale As JavaObject
	Locale.InitializeStatic("java.util.Locale")
	Return Locale.RunMethod("getDefault",Null)
End Sub

Public Sub GetIncrementalFileName(FileName As String) As String
	Dim Counter As Int = 1
	If File.Exists("",FileName) = False Then Return FileName
	Dim Pos As Int = FileName.LastIndexOf(".")
	Dim FileStub As String
	Dim FileExtn As String
	If Pos = -1 Then
		FileStub = FileName
		FileExtn = ""
	Else
		FileStub = FileName.SubString2(0,Pos)
		FileExtn = FileName.SubString(Pos)
	End If
	Do While File.Exists("",FileStub & "(" & Counter & ")" & FileExtn)
		Counter = Counter + 1
	Loop
	Return FileStub & "(" & Counter & ")" & FileExtn
End Sub

'Inches to PPI
Public Sub INToPPI(Inches As Double) As Double
	Return Inches * 72
End Sub

'CM to PPI
Public Sub CMToPPI(Cm As Double) As Double
	Return INToPPI(Cm * 0.3937007874015748)
End Sub

'MM to PPI
Public Sub MMToPPI(mm As Double) As Double
	Return INToPPI(mm * 0.03937007874015748)
End Sub

Public Sub PPItoMM(PPI As Double) As Double
	Return PPI * 0.3527777777777778
End Sub

'Return the current PackageName
Public Sub GetPackageName As String
	Dim JO As JavaObject
	JO.InitializeStatic("anywheresoftware.b4a.BA")
	Return JO.GetField("packageName")
End Sub

Public Sub LogServiceSupportedFlavors(Service As PrintService)
	Log(" ")
	Log("############################################################")
	Log("Flavors Supported for " & Service.GetName)
	Log(" ")
	Dim L As List = Service.GetSupportedDocFlavors
	For Each F As DocFlavor In L
		Log(TAB & F.ToString)
	Next
	Log("############################################################")
	Log(" ")
End Sub

Public Sub GetInputStream(DirName As String, FileName As String) As InputStream
	Dim FullFilePath As String = File.Combine(DirName,FileName)
	Dim IStream As InputStream
	If FullFilePath.StartsWith("AssetsDir") Then
		IStream = File.OpenInput(File.DirAssets,File.GetName(FullFilePath))
	Else
		IStream = File.OpenInput("",FullFilePath)
	End If
	Return IStream
End Sub

Public Sub LoadBufferedImage(DirName As String, FileName As String) As Object
	Dim Istream As InputStream = GetInputStream(DirName,FileName)
	
	Dim TJO As JavaObject
	TJO.InitializeStatic("javax.imageio.ImageIO")
	Return TJO.RunMethod("read",Array(Istream))
End Sub

'Is the passed object part of this Library / Application
Public Sub IsPackageObject(O As Object) As Boolean
	Return GetType(O).StartsWith(GetPackageName)
End Sub

Public Sub GetLineHeight(Font As AWTFont) As Int
	Return (Me).As(JavaObject).RunMethod("getLineHeight",Array(Font.GetObject))
End Sub

Public Sub GetAscent(font As AWTFont) As Double
	Return (Me).As(JavaObject).RunMethod("getAscent",Array(font.GetObject))
End Sub

Public Sub PrinterSupportsDestination(PrinterName As String) As Boolean
	
	Dim PNameAtt As JavaObject
	PNameAtt.InitializeNewInstance("javax.print.attribute.standard.PrinterName",Array As Object(PrinterName, Null))

	Dim AttSet As JavaObject
	AttSet.InitializeNewInstance("javax.print.attribute.HashPrintServiceAttributeSet",Null)
	AttSet.RunMethod("add",Array(PNameAtt))
	
	Dim PSL As JavaObject
	PSL.InitializeStatic("javax.print.PrintServiceLookup")
	
	Dim Temp() As Object = PSL.RunMethod("lookupPrintServices",Array As Object(Null, AttSet))
	If Temp.Length > 0 Then
		Dim PtrSvc As JavaObject = Temp(0)
		Dim M As Map
		M.Initialize
		Dim arr() As Object = PtrSvc.RunMethod("getSupportedAttributeCategories",Null)
		For Each JO As JavaObject In arr
			Dim Class As JavaObject = JO.RunMethod("getClass",Null)
			Dim Method As JavaObject = Class.RunMethod("getMethod",Array("getSimpleName",Null))
			Dim SimpleName As String = Method.RunMethod("invoke",Array(JO,Null))
			Dim Method As JavaObject = Class.RunMethod("getMethod",Array("getName",Null))
			Dim Name As String = Method.RunMethod("invoke",Array(JO,Null))
		
			M.put(SimpleName,Name)
		Next
		Return M.ContainsKey("Destination")
	Else
		Return False
	End If
	
End Sub

Public Sub GetStringWidth(Font As AWTFont, Str As String) As Int
	Return (Me).As(JavaObject).RunMethod("getStringWidth",Array(Font.GetObject, Str))
End Sub



#if java
import java.awt.FontMetrics;
import java.awt.Font;
import java.awt.Canvas;

public static int getLineHeight(Font font){
	Canvas c = new Canvas();
	FontMetrics fm = c.getFontMetrics(font);
	return fm.getHeight();
}

public static int getAscent(Font font){
	Canvas c = new Canvas();
	FontMetrics fm = c.getFontMetrics(font);
	return fm.getAscent();
}

public static int getStringWidth(Font font,String str){
	Canvas c = new Canvas();
	FontMetrics fm = c.getFontMetrics(font);
	return fm.stringWidth(str);
}
#End If
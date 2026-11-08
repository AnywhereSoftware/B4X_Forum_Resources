B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Private Response As ServletResponse
End Sub

Public Sub Initialize
	
End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Response = resp
	Response.ContentType = "text/html"
	
	RenderProductsPage
End Sub

Sub RenderProductsPage
    Dim Contents As String = File.ReadString(File.DirAssets, "products.html")
    Contents = Contents.Replace("$PRODUCT$", "oranges")
 
    Response.Write(Contents)
End Sub
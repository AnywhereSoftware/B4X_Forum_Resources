B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Handler class for JSON requests from Web Clients (JavaScript/axios)
'VERSION 14 (Validación de Parámetros): Chequea que el número de '?' coincida con los parámetros recibidos.
Sub Class_Globals
	
End Sub

Public Sub Initialize

End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	' --- Headers CORS ---
	resp.SetHeader("Access-Control-Allow-Origin", "*")
	resp.SetHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
	resp.SetHeader("Access-Control-Allow-Headers", "Content-Type")
	Try
		SendSuccessResponse(resp, CreateMap("message": $"Pong ${DateTime.now}"$))
	Catch
		Log(LastException)
		SendErrorResponse(resp, 500, LastException.Message)
	End Try
End Sub


' --- Subrutinas de ayuda para respuestas JSON (sin cambios) ---
Private Sub SendSuccessResponse(resp As ServletResponse, dataMap As Map)
	dataMap.Put("success", True)
	Dim jsonGenerator As JSONGenerator
	jsonGenerator.Initialize(dataMap)
	resp.ContentType = "application/json"
	resp.Write(jsonGenerator.ToString)
End Sub

Private Sub SendErrorResponse(resp As ServletResponse, statusCode As Int, errorMessage As String)
	Dim resMap As Map = CreateMap("success": False, "error": errorMessage)
	Dim jsonGenerator As JSONGenerator
	jsonGenerator.Initialize(resMap)
	resp.Status = statusCode
	resp.ContentType = "application/json"
	resp.Write(jsonGenerator.ToString)
End Sub
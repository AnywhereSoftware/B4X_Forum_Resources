B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Class module: FaviconHandler
' Manejador para la petición de /favicon.ico
' Simplemente devuelve un estado HTTP 204 (No Content)
' para indicar al navegador que no hay un favicon.

Sub Class_Globals
	' No se necesitan variables globales para este manejador simple.
End Sub

Public Sub Initialize
	' No se necesita inicialización específica para este manejador.
End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
'	Registra la petición en el Log (opcional, para depuración)
'	Log("Petición de Favicon recibida: " & req.RequestURI)
'
'	Establece el código de estado HTTP a 204 (No Content).
'	Esto le dice al navegador que la petición fue exitosa, pero no hay contenido que devolver.
	resp.Status = 204

'	Es buena práctica cerrar el OutputStream, aunque para 204 no haya contenido explícito.
'	Algunos servidores web podrían requerir cerrar el stream de respuesta.
	Try
		resp.OutputStream.Close
	Catch
		Log("Error al cerrar el OutputStream en FaviconHandler: " & LastException)
	End Try

'	El Return es fundamental para que el manejador termine su ejecución
'	y no intente procesar la petición con otros manejadores o caiga en el "catch-all".
	Return
End Sub
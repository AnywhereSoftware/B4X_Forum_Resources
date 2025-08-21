B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.5
@EndOfDesignText@
Sub Class_Globals
	Private mCallback As Object
	Private mEventName As String
	Private boundary() As Byte
	Private hc As OkHttpClient
	Private bbuffer As B4XBytesBuilder
	Private const PackageName As String = "b4j.example" '<------ change as needed
	Public gout As OutputStream
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mCallback = Callback
	mEventName = EventName
	hc.Initialize("hc")
	bbuffer.Initialize
End Sub

Public Sub Connect(url As String)
	Dim req As OkHttpRequest
	req.InitializeGet(url)
	hc.Execute(req, 0)
End Sub

Private Sub hc_ResponseError (Response As OkHttpResponse, Reason As String, StatusCode As Int, TaskId As Int)
	Log("Error: " & StatusCode)
End Sub

Private Sub hc_ResponseSuccess (Response As OkHttpResponse, TaskId As Int)
	Dim out As JavaObject
	out.InitializeNewInstance($"${PackageName}.mjpeg$MyOutputStream"$, Array(Me))
	gout = out
	bbuffer.Clear
	Dim ct As String = Response.GetHeaders.Get("content-type")
	Dim i As Int = ct.IndexOf("boundary=")
	If i = -1 Then
		Log("Invalid content type")
		Response.Release
		Return
	End If
	boundary = ct.SubString(i + "boundary=".Length).Replace("]", "").GetBytes("ascii")
	Log("boundary: " & BytesToString(boundary, 0, boundary.Length, "ascii"))
	Response.GetAsynchronously("req", out, False, 0)
	Wait For req_StreamFinish (Success As Boolean, TaskId As Int)
	Log("Stream finish")
End Sub

Private Sub Data_Available (Buffer() As Byte)
	bbuffer.Append(Buffer)
	Dim b1 As Int = bbuffer.IndexOf(boundary)
	If b1 > -1 Then
		Dim b2 As Int = bbuffer.IndexOf2(boundary, b1 + 1)
		If b2 > -1 Then
			Dim startframe As Int = bbuffer.IndexOf2(Array As Byte(0xff, 0xd8), b1)
			Dim endframe As Int = bbuffer.IndexOf2(Array As Byte(0xff, 0xd9), b2 - 10)
			If startframe > -1 And endframe > -1 Then
				Dim In As InputStream
				In.InitializeFromBytesArray(bbuffer.SubArray2(startframe, endframe + 2), 0, endframe + 2 - startframe)
	#if B4J
				Dim bmp As Image
	#else
				dim bmp As Bitmap
	#end if
				bmp.Initialize2(In)
				CallSub2(mCallback, mEventName & "_frame", bmp)
			End If
			bbuffer.Remove(0, b2)
				
		End If
	End If
End Sub


#if Java
import java.io.*;
public static class MyOutputStream extends OutputStream {
	B4AClass cls;
	private boolean closed;
	public MyOutputStream (B4AClass cls) {
		this.cls = cls;
	}
	
	public void write(int b) throws IOException {
		if (closed)
			throw new IOException("closed");
		cls.getBA().raiseEventFromDifferentThread (null, null, 0, "data_available", true, new Object[] {new byte[] {(byte)b}});
	}
	public void write(byte b[], int off, int len) throws IOException {
		if (closed)
			throw new IOException("closed");
		byte[] bb = new byte[len];
		System.arraycopy(b, off, bb, 0, len);
		cls.getBA().raiseEventFromDifferentThread (null, null, 0, "data_available", true, new Object[] {bb});
	}
	public void close() {
		closed = true;
	}
}
#End If


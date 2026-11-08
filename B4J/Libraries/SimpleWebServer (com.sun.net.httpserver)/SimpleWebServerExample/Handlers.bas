B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@

Sub Process_Globals
	
End Sub

Sub Index(QueryString As String) As String
	Return $"<!DOCTYPE html>
<html>
<body>
<h1>Index</h1>
<p>Hello from SimpleWebServer</p>
<img src="b4x.jpg">

<h2>Perform a POST</h2>

<form action="process_form" method="post">
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname" value="John"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname" value="Doe"><br><br>
  <input type="submit" value="Submit">
</form> 

<p>If you click the "Submit" button, the form-data will be sent to a page called "process_form".</p>

</body>
</html>
"$
End Sub

Sub ProcessPost(body As String) As String
	Dim ParameterMap As Map = ParseFormBody(body)
	
	Return $"<!DOCTYPE html>
<html>
<body>
<h1>Post Handler</h1>
<p>Hello ${ParameterMap.Get("fname")} ${ParameterMap.Get("lname")}</p>

</body>
</html>
"$
	
End Sub

Private Sub ParseFormBody(body As String) As Map
	Dim result As Map
	result.Initialize
	If body.Length = 0 Then Return result
	Dim parts() As String = Regex.Split("&", body)
	For Each part As String In parts
		Dim idx As Int = part.IndexOf("=")
		If idx > 0 Then
			Dim key As String = URLDecode(part.SubString2(0, idx))
			Dim value As String = URLDecode(part.SubString(idx + 1))
			result.Put(key, value)
		End If
	Next
	Return result
End Sub

Private Sub URLDecode(s As String) As String
	Try
		Dim jo As JavaObject
		jo.InitializeStatic("java.net.URLDecoder")
		Return jo.RunMethod("decode", Array(s, "UTF-8"))
	Catch
		Return s.Replace("+"," ")
	End Try
End Sub

Sub GuessPage(QueryString As String) As String
	Return $"
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta content="text/html; charset=UTF8" http-equiv="content-type">
	<title>Guess My Number</title>
	<script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
	<style>
		html {
			height: 100%;
		}
		body {
			height: 100%;
			background-repeat: no-repeat;
			background-attachment: fixed;
			background: #f0f9ff; /* Old browsers */
			background: -moz-linear-gradient(top,  #f0f9ff 0%, #cbebff 47%, #a1dbff 100%); /* FF3.6+ */
			background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f0f9ff), color-stop(47%,#cbebff), color-stop(100%,#a1dbff)); /* Chrome,Safari4+ */
			background: -webkit-linear-gradient(top,  #f0f9ff 0%,#cbebff 47%,#a1dbff 100%); /* Chrome10+,Safari5.1+ */
			background: -o-linear-gradient(top,  #f0f9ff 0%,#cbebff 47%,#a1dbff 100%); /* Opera 11.10+ */
			background: -ms-linear-gradient(top,  #f0f9ff 0%,#cbebff 47%,#a1dbff 100%); /* IE10+ */
			background: linear-gradient(to bottom,  #f0f9ff 0%,#cbebff 47%,#a1dbff 100%); /* W3C */
		}
	</style>
</head>
<body>
	<h1>Guess My Number</h1>
	Enter number: <input type="text" id="txtNumber"></input>
	<button type="button" id="btnGuess">Guess!</button><br/><br/>
	<button type="button" id="btnReset">Reset secret number</button><br/>
	<p id="result"></p>
	
	<script type="text/javascript">
		$("#btnGuess").click(function(){
			$.post("guess", "number=" + txtNumber.value,
				function(data) {
					$("#result").html(data);
					$("#txtNumber").focus();
					$("#txtNumber").select();
				}
			
			);
		});
		$("#txtNumber").keyup(function(event){
			if(event.keyCode == 13){
				$("#btnGuess").click();
			}
}		);
		$("#btnReset").click(function(){
			$.post("reset");
			$("#result").html("-");
		});
	</script>
	
</body>
</html>
	"$
End Sub

Sub Guess(body As String) As String
	Dim ParameterMap As Map = ParseFormBody(body)
	
	Try
		Dim n As String = ParameterMap.Get("number")
		If IsNumber(n) = False Then
			Return "Please enter a valid number."
		Else
			If n > Main.myNumber Then
				Return "My number is smaller."
			Else If n < Main.myNumber Then
				Return "My number is larger."
			Else
				Return "Well done!!!"
			End If
		End If
	Catch
		Return "error...."
	End Try
End Sub
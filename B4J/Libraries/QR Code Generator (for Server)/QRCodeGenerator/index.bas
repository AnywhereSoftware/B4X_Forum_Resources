B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.Write( $"<!DOCTYPE html>
<html>
<body>

<h2>QR Example</h2>

<form action="/action_page.php">
  <label for="myInput">Type Some Text:</label><br>
  <input type="text" id="myInput" name="myInput" value="" onkeyup="myFunction()"><br>
</form>

<div id="qr"><div>

</body>

<script>
function myFunction() {
  var input;
  input = document.getElementById("myInput").value;
  console.log(input);
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function(){
    if (this.readyState == 4 && this.status == 200) {
       document.getElementById("qr").innerHTML = xhttp.responseText;
    }
};
xhttp.open("GET", "qrgen?input="+input, true);
xhttp.send();
  
}
</script>
</html>"$)
End Sub
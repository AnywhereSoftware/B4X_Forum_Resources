B4J=true
Group=App
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Utility code module
'Version 3.20
Sub Process_Globals
	
End Sub

Private Sub ReturnSuccessScript (SimpleResponseEnable As Boolean, ExpectAccessToken As Boolean) As String
	If SimpleResponseEnable Then
		Return $"success: function (data, textStatus, xhr) {
					var content = JSON.stringify(data, undefined, 2)
					$("#alert" + id).fadeOut("fast", function () {
						$("#response" + id).val(content)
						$("#alert" + id).html(xhr.status + " " + textStatus)
						$("#alert" + id).removeClass("alert-danger")
						$("#alert" + id).addClass("alert-success")
						$("#alert" + id).fadeIn()
					})${IIf(ExpectAccessToken, $"
					// Json Web Token specific
					if (content) {
						if ("access_token" in data) {
							localStorage.setItem("access_token", data["access_token"])
							console.log("access token stored!")
						}
					}"$, "")}
				},"$
	Else
		Return $"success: function (data) {
					if (data.s == "ok" || data.s == "success") {
						var content = JSON.stringify(data.r, undefined, 2)
						$("#alert" + id).fadeOut("fast", function () {
							$("#response" + id).val(content)
							$("#alert" + id).html(data.a + " " + data.m)
							$("#alert" + id).removeClass("alert-danger")
							$("#alert" + id).addClass("alert-success")
							$("#alert" + id).fadeIn()
						})${IIf(ExpectAccessToken, $"
						// Json Web Token specific
						if (data.r.length > 0) {
							if ("access_token" in data.r[0]) {
								localStorage.setItem("access_token", data.r[0]["access_token"])
								console.log("access token stored!")
							}
						}"$, "")}
					}
					else {
						var content = JSON.stringify(data.r, undefined, 2)
						$("#alert" + id).fadeOut("fast", function () {
							$("#response" + id).val(content)
							$("#alert" + id).html(data.a + " " + data.e)
							$("#alert" + id).removeClass("alert-success")
							$("#alert" + id).addClass("alert-danger")
							$("#alert" + id).fadeIn()
						})
					}
				},"$
	End If
End Sub

Public Sub GenerateJSFileForHelp (DirName As String, FileName As String, SimpleResponse As SimpleResponse)
	Dim script1 As String = $"// Button click event for all verbs
$(".get, .post, .put, .delete").click(function (e) {
	e.preventDefault()
	const element = $(this)
	const id = element.attr("id").substring(3)
	makeApiRequest(id)
})"$
	Dim script2 As String = $"// Function to set options
function setOptions(id) {
	const element = $("#btn" + id)
	const headers = setHeaders(element)
	switch (true) {
		case element.hasClass("get"):
			return {
				type: "GET",
				headers: headers,
				${ReturnSuccessScript(SimpleResponse.Enable, False)}
				error: function (xhr, textStatus, errorThrown) {
					var content = xhr.responseText
					$("#alert" + id).fadeOut("fast", function () {
						$("#response" + id).val(content)
						$("#alert" + id).html(xhr.status + " " + errorThrown)
						$("#alert" + id).removeClass("alert-success")
						$("#alert" + id).addClass("alert-danger")
						$("#alert" + id).fadeIn()
					})
				}
			}
			break
		case element.hasClass("post"):
			return {
				type: "POST",
				data: $("#body" + id).val(),
				dataType: "json",
				headers: headers,
				${ReturnSuccessScript(SimpleResponse.Enable, True)}
				error: function (xhr, textStatus, thrownError) {
					var content = xhr.responseText
					$("#alert" + id).fadeOut("fast", function () {
						$("#response" + id).val(content)
						$("#alert" + id).html(xhr.status + " " + thrownError)
						$("#alert" + id).removeClass("alert-success")
						$("#alert" + id).addClass("alert-danger")
						$("#alert" + id).fadeIn()
					})
				}
			}
			break
		case element.hasClass("put"):
			return {
				type: "PUT",
				data: $("#body" + id).val(),
				dataType: "json",
				headers: headers,
				${ReturnSuccessScript(SimpleResponse.Enable, False)}
				error: function (xhr, textStatus, thrownError) {
					var content = xhr.responseText
					$("#alert" + id).fadeOut("fast", function () {
						$("#response" + id).val(content)
						$("#alert" + id).html(xhr.status + " " + thrownError)
						$("#alert" + id).removeClass("alert-success")
						$("#alert" + id).addClass("alert-danger")
						$("#alert" + id).fadeIn()
					})
				}
			}
			break
		case element.hasClass("delete"):
			return {
				type: "DELETE",
				headers: headers,
				${ReturnSuccessScript(SimpleResponse.Enable, False)}
				error: function (xhr, textStatus, thrownError) {
					var content = xhr.responseText
					$("#alert" + id).fadeOut("fast", function () {
						$("#response" + id).val(content)
						$("#alert" + id).html(xhr.status + " " + thrownError)
						$("#alert" + id).removeClass("alert-success")
						$("#alert" + id).addClass("alert-danger")
						$("#alert" + id).fadeIn()
					})
				}
			}
			break
		default: // unsupported verbs
			return {}
	}
}"$
	Dim script3 As String = $"// Function to return headers base on button class
function setHeaders(element) {
	// Using switch case for readibility
	switch (true) {
		case element.hasClass("basic"):
			return {
				"Accept": "application/json",
				"Authorization": "Basic " + btoa(localStorage.getItem("client_id") + ":" + localStorage.getItem("client_secret"))
			}
			break
		case element.hasClass("token"):
			return {
				"Accept": "application/json",
				"Authorization": "Bearer " + localStorage.getItem("access_token")
			}
			break
		default:
			return {
				"Accept": "application/json"
			}
	}
}"$
	Dim script4 As String = $"// Function to make API call using Ajax
function makeApiRequest(id) {
	const url = $("#path" + id).val()
	const options = setOptions(id)
	$.ajax(url, options)
}"$
	
	Dim HelpFile As String = $"${script1}
${script2}
${script3}
${script4}"$
	File.WriteString(DirName, FileName, HelpFile)
End Sub
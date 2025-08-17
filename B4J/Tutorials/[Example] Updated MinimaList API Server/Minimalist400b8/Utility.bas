B4J=true
Group=App
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Utility code module
'Version 4.00 beta 8
Sub Process_Globals
	Private Const RESPONSE_ELEMENT_CODE As String		= "code"
	Private Const RESPONSE_ELEMENT_ERROR As String 		= "error"
	Private Const RESPONSE_ELEMENT_STATUS As String 	= "status"
	Private Const RESPONSE_ELEMENT_MESSAGE As String	= "message"
	Private Const RESPONSE_ELEMENT_RESULT As String 	= "data"
	'Private Const RESPONSE_ELEMENT_TYPE As String 		= "type"
	Private PayloadType As String
	Private ContentType As String
	Private Verbose As Boolean
	Private XmlRoot As String = "root"
	Private XmlElement As String = "item"
End Sub

'Public Sub CurrentTimeStamp As String
'	Select Main.DBType.ToUpperCase
'		Case "MYSQL"
'			Return "NOW()"
'		Case "SQLITE"
'			Return "datetime('Now')"
'		Case Else
'			Return ""
'	End Select
'End Sub

'Public Sub CurrentTimeStampAddMinute (Value As Int) As String
'	Select Main.DBType.ToUpperCase
'		Case "MYSQL"
'			Return $"DATE_ADD(NOW(), INTERVAL ${Value} MINUTE)"$
'		Case "SQLITE"
'			Return $"datetime('Now', '+${Value} minute')"$
'		Case Else
'			Return ""
'	End Select
'End Sub

Private Sub AlertScript (AlertMessage As String, SuccessCode As Int, SubmitForm As Boolean) As String
	If Verbose = False Then
		If SubmitForm Then ' indent
			Return $"alert("${AlertMessage}")
          location.reload()"$
		Else
			Return $"alert("${AlertMessage}")
      location.reload()"$
		End If
	End If
	Select ContentType
		Case WebApiUtils.CONTENT_TYPE_XML
			Return $"const root = $(response).find("${XmlRoot}")
          const code = $(root).children("${RESPONSE_ELEMENT_CODE}").text()
          const error = $(root).children("${RESPONSE_ELEMENT_ERROR}").text()
          if (code == ${SuccessCode}) {
            alert("${AlertMessage}")
            location.reload()
          }
          else {
            alert(code + " " + error)
          }"$
		Case Else
			If SubmitForm Then ' indent
				Return $"const code = response.${RESPONSE_ELEMENT_CODE}
          const error = response.${RESPONSE_ELEMENT_ERROR}
          if (code == ${SuccessCode}) {
            alert("${AlertMessage}")
            location.reload()
          }
          else {
            alert(code + " " + error)
          }"$
			Else
				Return $"const code = response.${RESPONSE_ELEMENT_CODE}
      const error = response.${RESPONSE_ELEMENT_ERROR}
      if (code == ${SuccessCode}) {
        alert("${AlertMessage}")
        location.reload()
      }
      else {
        alert(code + " " + error)
      }"$
			End If
	End Select
End Sub

Private Sub HelpResponsePart (Verb As String) As String
	Dim script As String
	Select Verb
		Case "post"
			script = $"type: "${Verb}",
        data: $("#body" + id).val(),
        dataType: "${dataType}",
        headers: headers,
        success: function (response, textStatus, xhr) {
          showFadeAlertSuccess(id, xhr, textStatus, response)
          ${AccessTokenPart}
        },"$
		Case "put"
			script = $"type: "${Verb}",
        data: $("#body" + id).val(),
        dataType: "${dataType}",
        headers: headers,
        success: function (response, textStatus, xhr) {
          showFadeAlertSuccess(id, xhr, textStatus, response)
        },"$
		Case Else
			script = $"type: "${Verb}",
        dataType: "${dataType}",
        headers: headers,
        success: function (response, textStatus, xhr) {
          showFadeAlertSuccess(id, xhr, textStatus, response)
        },"$
	End Select
	Return script
End Sub

Private Sub AccessTokenPart As String
	Return $"// Access Token
	      let access_token = ""
          ${IIf(ContentType = WebApiUtils.CONTENT_TYPE_XML, _
          $"const result = ${IIf(Verbose, _
		  $"$(response).children("${RESPONSE_ELEMENT_RESULT}")"$, _
		  $"response"$)}
          access_token = $(result).find("token").text()"$, _
          $"const result = ${IIf(Verbose, _
		  $"response.${RESPONSE_ELEMENT_RESULT}"$, _
		  $"response"$)}"$)}
          if (result.length > 0) {
            if ("access_token" in result[0]) {
              access_token = result[0]["access_token"]
             }
           }
          if (access_token.length > 0) {
            localStorage.setItem("access_token", access_token)
            console.log("access token stored!")
          }
          //else {
          //  console.log("access token not found")	
          //}"$
End Sub

Private Sub dataType As String
	Select ContentType
		Case  WebApiUtils.CONTENT_TYPE_XML
			Return "xml"
		Case Else
			Return "json"
	End Select
End Sub

Private Sub script01 As String
	Return $"// Button click event for all verbs
$(".get, .post, .put, .delete").click(function (e) {
  e.preventDefault()
  const element = $(this)
  const id = element.attr("id").substring(3)
  makeApiRequest(id)
})"$
End Sub

Private Sub script02 As String
	Return $"// Function to set options
function setOptions(id) {
  const element = $("#btn" + id)
  const headers = setHeaders(element)
  switch (true) {
    case element.hasClass("get"):
      return {
        ${HelpResponsePart("get")}
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    case element.hasClass("post"):
      return {
        ${HelpResponsePart("post")}
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    case element.hasClass("put"):
      return {
        ${HelpResponsePart("put")}
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    case element.hasClass("delete"):
      return {
        ${HelpResponsePart("delete")}
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    default: // unsupported verbs
      return {}
  }
}"$
End Sub

Private Sub script03 As String
	Return $"// Function to return headers base on button class
function setHeaders(element) {
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
End Sub

Private Sub script04 As String
	Return $"// Function to make API call using Ajax
function makeApiRequest(id) {
  const url = $("#path" + id).val()
  const options = setOptions(id)
  $.ajax(url, options)
}"$
End Sub

Private Sub script05 As String
	Select ContentType
		Case WebApiUtils.CONTENT_TYPE_XML
			If Verbose Then
				Return $"function showFadeAlertSuccess (id, xhr, textStatus, response) {
  const root = $(response).find("${XmlRoot}")
  const status = $(root).children("${RESPONSE_ELEMENT_STATUS}").text()
  const code = $(root).children("${RESPONSE_ELEMENT_CODE}").text()
  const error = $(root).children("${RESPONSE_ELEMENT_ERROR}").text()
  const message = $(root).children("${RESPONSE_ELEMENT_MESSAGE}").text()
  //const result = $(root).children("${RESPONSE_ELEMENT_RESULT}")			
  if (status == "ok" || status == "success") {
    $("#alert" + id).fadeOut("fast", function () {
      $("#response" + id).val(xhr.responseText)
      $("#alert" + id).html(code + " " + message)
      $("#alert" + id).removeClass("bg-danger")
      $("#alert" + id).addClass("bg-success")
      $("#alert" + id).fadeIn()
    })
  }
  else {
    $("#alert" + id).fadeOut("fast", function () {
      $("#response" + id).val(xhr.responseText)
      $("#alert" + id).html(code + " " + error)
      $("#alert" + id).removeClass("bg-success")
      $("#alert" + id).addClass("bg-danger")
      $("#alert" + id).fadeIn()
    })
  }
}"$
			Else
				Return $"function showFadeAlertSuccess (id, xhr, textStatus, response) {
  $("#alert" + id).fadeOut("fast", function () {
    $("#response" + id).val(xhr.responseText)
    $("#alert" + id).html(xhr.status + " " + textStatus)
    $("#alert" + id).removeClass("bg-danger")
    $("#alert" + id).addClass("bg-success")
    $("#alert" + id).fadeIn()
  })
}"$
			End If
		Case Else
			If Verbose Then
				Return $"function showFadeAlertSuccess (id, xhr, textStatus, response) {
  if (response.${RESPONSE_ELEMENT_STATUS} == "ok" || response.${RESPONSE_ELEMENT_STATUS} == "success") {
    const content = JSON.stringify(response, undefined, 2)
    $("#alert" + id).fadeOut("fast", function () {
      $("#response" + id).val(content)
      $("#alert" + id).html(response.${RESPONSE_ELEMENT_CODE} + " " + response.${RESPONSE_ELEMENT_MESSAGE})
      $("#alert" + id).removeClass("bg-danger")
      $("#alert" + id).addClass("bg-success")
      $("#alert" + id).fadeIn()
    })
  }
  else {
    const content = JSON.stringify(response, undefined, 2)
    $("#alert" + id).fadeOut("fast", function () {
      $("#response" + id).val(content)
      $("#alert" + id).html(response.${RESPONSE_ELEMENT_CODE} + " " + response.${RESPONSE_ELEMENT_ERROR})
      $("#alert" + id).removeClass("bg-success")
      $("#alert" + id).addClass("bg-danger")
      $("#alert" + id).fadeIn()
    })
  }				
}"$
			Else
				Return $"function showFadeAlertSuccess (id, xhr, textStatus, response) {
  $("#alert" + id).fadeOut("fast", function () {
    const content = JSON.stringify(response, undefined, 2)
    $("#response" + id).val(content)
    $("#alert" + id).html(xhr.status + " " + textStatus)
    $("#alert" + id).removeClass("bg-danger")
    $("#alert" + id).addClass("bg-success")
    $("#alert" + id).fadeIn()
  })
}"$
			End If
	End Select
End Sub

Private Sub script06 As String
	Return $"function showFadeAlertError (id, xhr, errorThrown) {
  $("#alert" + id).fadeOut("fast", function () {
    const content = xhr.responseText
    $("#response" + id).val(content)
    $("#alert" + id).html(xhr.status + " " + errorThrown)
    $("#alert" + id).removeClass("bg-success")
    $("#alert" + id).addClass("bg-danger")
    $("#alert" + id).fadeIn()
  })
}"$
End Sub

Private Sub script07 As String
	Dim dollar As String = "$"
	Return $"$.ajax({
    type: "get",
    dataType: "${dataType}",
    url: "/${Main.conf.ApiName}/categories",
    success: function (response, status, xhr) {
      let data = []
      ${IIf(ContentType = WebApiUtils.CONTENT_TYPE_XML, _
      $"// XML format
      const root = $(response).find("${XmlRoot}")
      ${IIf(Verbose, _
	  $"const result = $(root).children("${RESPONSE_ELEMENT_RESULT}")"$, _
	  $"const result = $(root)"$)}
      const $items = $(result).children("${XmlElement}")
      $items.each(function () {
        const $item = $(this)
        data.push({
          id: $item.children("id").text(),
          category_name: $item.children("category_name").text()
        })
      })"$, _
      $"// JSON format
      ${IIf(Verbose, $"data = response.${RESPONSE_ELEMENT_STATUS} === "ok" ? response.${RESPONSE_ELEMENT_RESULT} : []"$, $"data = response"$)}"$)}
      let tblHead = ""
      let tblBody = ""
      if (data.length) {
        tblHead = `
  <thead class="bg-light">
    <th style="text-align: right; width: 50px">#</th>
    <th>Name</th>
    <th style="text-align: center; width: 90px">Actions</th>
  </thead>`
        tblBody = `
  <tbody>`
        $.each(data, function (i, item) {
          const id = item.id || ""
          const name = item.category_name || ""
		  //console.log(id, category_name)
          tblBody += `
    <tr>
      <td class="align-middle" style="text-align: right">${dollar}{id}</td>
      <td class="align-middle">${dollar}{name}</td>
      <td>
        <a href="#edit" class="text-primary mx-2" data-toggle="modal">
          <i class="edit fa fa-pen" data-toggle="tooltip"
          data-id="${dollar}{id}" data-name="${dollar}{name}" title="Edit"></i></a>
        <a href="#delete" class="text-danger mx-2" data-toggle="modal">
          <i class="delete fa fa-trash" data-toggle="tooltip"
          data-id="${dollar}{id}" data-name="${dollar}{name}" title="Delete"></i></a>
      </td>
    </tr>`
        })
        tblBody += `
  </tbody>`
      }
      else {
        tblBody = `
  <tbody>
    <tr>
      <td class="text-center">No results</td>
    </tr>
  </tbody>`
      }
      $("#results table").html(tblHead + tblBody)
    },
    error: function (xhr, ajaxOptions, errorThrown) {
      $(".alert").html("Error: " + errorThrown).fadeIn()
    }
  })"$
End Sub

Private Sub script08 As String
	Return $"$(document).on("click", ".edit", function (e) {
  const id = $(this).attr("data-id")
  const name = $(this).attr("data-name")
  $("#id1").val(id)
  $("#name1").val(name)
})"$
End Sub

Private Sub script09 As String
	Return $"$(document).on("click", ".delete", function (e) {
  const id = $(this).attr("data-id")
  const name = $(this).attr("data-name")
  $("#id2").val(id)
  $("#name2").text(name)
})"$
End Sub

Private Sub script10 As String
	Return $"$(document).on("click", "#add", function (e) {
  const form = $("#add_form")
  form.validate({
    rules: {
      name: {
        required: true
      },
      action: "required"
    },
    messages: {
      name: {
        required: "Please enter Category Name"
      },
      action: "Please provide some data"
    },
    submitHandler: function (form) {
      e.preventDefault()
      ${IIf(PayloadType = "xml", _
	  $"const data = convertFormToXML(form[0])"$, _
	  $"const data = JSON.stringify(convertFormToJSON(form), undefined, 2)"$)}
      $.ajax({
        type: "post",
        data: data,
        dataType: "${dataType}",
        url: "/${Main.conf.ApiName}/categories",
        success: function (response) {
          $("#new").modal("hide")
          ${AlertScript("New category added !", 201, True)}
        },
        error: function (xhr, ajaxOptions, errorThrown) {
          alert(errorThrown)
        }
      })
      // return false // required to block normal submit since you used ajax
    }
  })
})"$
End Sub

Private Sub script11 As String
	Return $"$(document).on("click", "#update", function (e) {
  const form = $("#update_form")
  form.validate({
    rules: {
      name: {
        required: true
      },
      action: "required"
    },
    messages: {
      name: {
        required: "Please enter Category Name"
      },
      action: "Please provide some data"
    },
    submitHandler: function (form) {
      e.preventDefault()
      ${IIf(PayloadType = "xml", _
	  $"const data = convertFormToXML(form[0])"$, _
	  $"const data = JSON.stringify(convertFormToJSON(form), undefined, 2)"$)}
      $.ajax({
        type: "put",
        data: data,
        dataType: "${dataType}",
        url: "/${Main.conf.ApiName}/categories/" + $("#id1").val(),
        success: function (response) {
          $("#edit").modal("hide")
          ${AlertScript("Category updated successfully !", 200, True)}
        },
        error: function (xhr, ajaxOptions, errorThrown) {
          alert(errorThrown)
        }
      })
      // Return False // required To block normal submit since you used ajax
    }
  })
})"$
End Sub

Private Sub script12 As String
	Return $"$(document).on("click", "#remove", function (e) {
  $.ajax({
    type: "delete",
    dataType: "${dataType}",
    url: "/${Main.conf.ApiName}/categories/" + $("#id2").val(),
    success: function (response) {
      $("#delete").modal("hide")
      ${AlertScript("Category deleted successfully !", 200, False)}
    },
    error: function (xhr, ajaxOptions, errorThrown) {
      alert(errorThrown)
    }
  })
})"$
End Sub

Private Sub script13 As String
	Select PayloadType
		Case "xml"
			' Credit to: Daestrum
			' Reference: https://www.b4x.com/android/forum/threads/solved-abmaterial-problem-with-in-string-literals.162280/#post-995431
			Dim dollar As String = "$"
			Return $"function convertFormToXML(form) {
  const formData = new FormData(form)
  let xml = `<root>\n`
  for (const [name, value] of formData.entries()) {
    xml += `  <${dollar}{name}>${dollar}{escapeXml(value)}</${dollar}{name}>\n`
  }
  xml += `</root>`
  return xml
}

// Utility function to escape special XML characters
function escapeXml(unsafe) {
  return unsafe.replace(/[<>&'"]/g, function (c) {
    switch (c) {
      case "<": return "&lt;"
      case ">": return "&gt;"
      case "&": return "&amp;"
      case "'": return "&apos;"
      case '"': return "&quot;"
    }
  })
}"$
	Case Else
		Return $"function convertFormToJSON(form) {
  const array = $(form).serializeArray() // Encodes the set of form elements as an array of names and values.
  const json = {}
  $.each(array, function () {
    json[this.name] = this.value || ""
  })
  return json
}"$
	End Select
End Sub

Private Sub script14 As String
	Return $"  $.ajax({
    type: "get",
    dataType: "${dataType}",
    url: "/${Main.conf.ApiName}/categories",
    success: function (response) {
      const $category1 = $("#category1")
      const $category2 = $("#category2")
      $category1.empty()
      $category2.empty()
      let data = []
      ${IIf(ContentType = WebApiUtils.CONTENT_TYPE_XML, _
	  $"const root = $(response).find("${XmlRoot}")
	  ${IIf(Verbose, _
	  $"const result = $(root).children("${RESPONSE_ELEMENT_RESULT}")"$, _
	  $"const result = $(root)"$)}
      const $items = $(result).children("${XmlElement}")
      $items.each(function () {
        const $item = $(this)
        data.push({
          id: $item.children("id").text(),
          category_name: $item.children("category_name").text()
        })
      })"$, _
	  $"data = ${IIf(Verbose, $"response.${RESPONSE_ELEMENT_RESULT}"$, "response")}"$)}
      // Append To both dropdowns
      data.forEach(function (item) {
        const option = $("<option />").val(item.id).text(item.category_name)
        $category1.append(option.clone())
        $category2.append(option)
      })
    },
    error: function (xhr, ajaxOptions, errorThrown) {
      alert(errorThrown)
    }
  })"$
End Sub

Private Sub script15 (Verb As String) As String
	Dim dollar As String = "$"
	Return $"  $.ajax({
	${IIf(Verb = "post", _
    $"  type: "post",
    data: data,"$, _
    $"  type: "get","$)}
    dataType: "${dataType}",
    url: "/${Main.conf.ApiName}/find",
    success: function (response, status, xhr) {
      let rows = []
      ${IIf(ContentType = WebApiUtils.CONTENT_TYPE_XML, _
      $"// XML format
      const root = $(response).find("${XmlRoot}")
      ${IIf(Verbose, _
	  $"const result = $(root).children("${RESPONSE_ELEMENT_RESULT}")"$, _
	  $"const result = $(root)"$)}
      const $items = $(result).children("${XmlElement}")
      $items.each(function () {
        const $item = $(this)
        rows.push({
          id: $item.find("id").text(),
          code: $item.find("code").text(),
          name: $item.find("name").text(),
          catid: $item.find("catid").text(),
          category: $item.find("category").text(),
          price: $item.find("price").text()
        })
      })"$, _
      $"// JSON format
      ${IIf(Verbose, _
	  $"rows = response.${RESPONSE_ELEMENT_STATUS} === "ok" ? response.${RESPONSE_ELEMENT_RESULT} : []"$, _
	  $"rows = response"$)}"$)}
      let tblHead = ""
      let tblBody = ""
      if (rows.length) {
        tblHead = `
  <thead class="bg-light">
    <th style="text-align: right; width: 50px">#</th>
    <th>Code</th>
    <th>Name</th>
    <th>Category</th>
    <th style="text-align: right">Price</th>
    <th style="text-align: center; width: 90px">Actions</th>
  </thead>`
        tblBody = `
  <tbody>`
        $.each(rows, function (i, item) {
          const id = item.id || ""
          const code = item.code || ""
          const name = item.name || ""
          const catid = item.catid || ""
          const category = item.category || ""
          const price = item.price || ""
		  //console.log(id, code, name, category, price)
          tblBody += `
    <tr>
      <td class="align-middle" style="text-align: right">${dollar}{id}</td>
      <td class="align-middle">${dollar}{code}</td>
      <td class="align-middle">${dollar}{name}</td>
      <td class="align-middle">${dollar}{category}</td>
      <td class="align-middle" style="text-align: right">${dollar}{price}</td>
      <td>
        <a href="#edit" class="text-primary mx-2" data-toggle="modal">
          <i class="edit fa fa-pen" data-toggle="tooltip"
          data-id="${dollar}{id}" data-code="${dollar}{code}" data-category="${dollar}{catid}"
          data-name="${dollar}{name}" data-price="${dollar}{price}" title="Edit"></i></a>
        <a href="#delete" class="text-danger mx-2" data-toggle="modal">
          <i class="delete fa fa-trash" data-toggle="tooltip"
          data-id="${dollar}{id}" data-code="${dollar}{code}" data-category="${dollar}{catid}"
          data-name="${dollar}{name}" title="Delete"></i></a>
      </td>
    </tr>`
        })
        tblBody += `
  </tbody>`
      }
      else {
        tblBody = `
  <tbody>
    <tr>
      <td class="text-center">No results</td>
    </tr>
  </tbody>`
      }
      $("#results table").html(tblHead + tblBody)
    },
    error: function (xhr, ajaxOptions, errorThrown) {
      $(".alert").html("Error: " + errorThrown).fadeIn()
    }
  })"$
End Sub

Private Sub script16 As String
	Select ContentType
		Case WebApiUtils.CONTENT_TYPE_XML
			Return $"$(document).on("click", ".edit", function (e) {
  const id = $(this).attr("data-id")
  const code = $(this).attr("data-code")
  const name = $(this).attr("data-name")
  const category = $(this).attr("data-category")
  const price = $(this).attr("data-price").replace(",", "")
  $("#id1").val(id)
  $("#code1").val(code)
  $("#name1").val(name)
  $("#category2").val(category)
  $("#price1").val(price)
})"$
		Case Else
			Return $"$(document).on("click", ".edit", function (e) {
  const id = $(this).attr("data-id")
  const category = $(this).attr("data-category")
  const code = $(this).attr("data-code")
  const name = $(this).attr("data-name")
  const price = $(this).attr("data-price").replace(",", "")
  $("#id1").val(id)
  $("#code1").val(code)
  $("#name1").val(name)
  $("#category2").val(category)
  $("#price1").val(price)
})"$
	End Select
End Sub

Private Sub script17 As String
	Return $"$(document).on("click", ".delete", function (e) {
  const id = $(this).attr("data-id")
  const code = $(this).attr("data-code")
  const name = $(this).attr("data-name")
  $("#id2").val(id)
  $("#code_name").text("(" + code + ") " + name)
})"$

End Sub

Private Sub script18 As String
	Return $"$(document).on("click", "#add", function (e) {
  const form = $("#add_form")
  form.validate({
    rules: {
      product_code: {
        required: true,
        minlength: 3
      },
      product_name: {
        required: true
      },
      action: "required"
    },
    messages: {
      product_code: {
        required: "Please enter Product Code",
        minlength: "Value must be at least 3 characters"
      },
      product_name: {
        required: "Please enter Product Name"
      },
      action: "Please provide some data"
    },
    submitHandler: function (form) {
      e.preventDefault()
      ${IIf(PayloadType = "xml", _
      $"const data = convertFormToXML(form[0])"$, _
      $"const data = JSON.stringify(convertFormToJSON(form), undefined, 2)"$)}
      $.ajax({
        type: "post",
        data: data,
        dataType: "${dataType}",
        url: "/${Main.conf.ApiName}/products",
        success: function (response) {
          $("#new").modal("hide")
          ${AlertScript("New product added !", 201, True)}
        },
        error: function (xhr, ajaxOptions, errorThrown) {
          alert(errorThrown)
        }
      })
    }
  })
})"$
End Sub

Private Sub script19 As String
	Return $"$(document).on("click", "#update", function (e) {
  const form = $("#update_form")
  form.validate({
    rules: {
      product_code: {
        required: true,
        minlength: 3
      },
      product_name: {
        required: true
      },
      action: "required"
    },
    messages: {
      product_code: {
        required: "Please enter Product Code",
        minlength: "Value must be at least 3 characters"
      },
      product_name: {
        required: "Please enter Product Name"
      },
      action: "Please provide some data"
    },
    submitHandler: function (form) {
      e.preventDefault()
      ${IIf(PayloadType = "xml", _
      $"const data = convertFormToXML(form[0])"$, _
      $"const data = JSON.stringify(convertFormToJSON(form), undefined, 2)"$)}
      $.ajax({
        type: "put",
        data: data,
        dataType: "${dataType}",
        url: "/${Main.conf.ApiName}/products/" + $("#id1").val(),
        success: function (response) {
          $("#edit").modal("hide")
          ${AlertScript("Product updated successfully !", 200, True)}
        },
        error: function (xhr, ajaxOptions, errorThrown) {
          alert(errorThrown)
        }
      })
    }
  })
})"$
End Sub

Private Sub script20 As String
	Return $"$(document).on("click", "#remove", function (e) {
  $.ajax({
    type: "delete",
    dataType: "${dataType}",
    url: "/${Main.conf.ApiName}/products/" + $("#id2").val(),
    success: function (response) {
      $("#delete").modal("hide")
      ${AlertScript("Product deleted successfully !", 200, False)}
    },
    error: function (xhr, ajaxOptions, errorThrown) {
      alert(errorThrown)
    }
  })
})"$
End Sub

Public Sub GenerateJSFileForHelp (DirName As String, FileName As String, StrContentType As String, BlnVerbose As Boolean)
	Verbose = BlnVerbose
	ContentType = StrContentType
	Dim Script As String = $"${script01}
${script02}
${script03}
${script04}
${script05}
${script06}"$
	File.WriteString(DirName, FileName, Script)
End Sub

Public Sub GenerateJSFileForCategory (DirName As String, FileName As String, StrContentType As String, BlnVerbose As Boolean)
	Verbose = BlnVerbose
	ContentType = StrContentType
		Dim Script As String = $"$(document).ready(function () {
  ${script07}
})
${script08}
${script09}
${script10}
${script11}
${script12}
${script13}"$
	File.WriteString(DirName, FileName, Script)
End Sub

Public Sub GenerateJSFileForSearch (DirName As String, FileName As String, StrContentType As String, BlnVerbose As Boolean)
	Verbose = BlnVerbose
	ContentType = StrContentType
	Dim Script As String = $"$(document).ready(function () {
${script14}
${script15("get")}
})
$("#btnsearch").click(function (e) {
  e.preventDefault()
  const form = $("#search_form")
  ${IIf(PayloadType = "xml", _
  $"const data = convertFormToXML(form[0])"$, _
  $"const data = JSON.stringify(convertFormToJSON(form), undefined, 2)"$)}
${script15("post")}
})
${script16}
${script17}
${script18}
${script19}
${script20}
${script13}"$
  File.WriteString(DirName, FileName, Script)
End Sub
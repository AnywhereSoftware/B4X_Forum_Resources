// Button click event for all verbs
$(".get, .post, .put, .delete").click(function (e) {
  e.preventDefault()
  const element = $(this)
  const id = element.attr("id").substring(3)
  makeApiRequest(id)
})
// Function to set options
function setOptions(id) {
  const element = $("#btn" + id)
  const headers = setHeaders(element)
  switch (true) {
    case element.hasClass("get"):
      return {
        type: "get",
        dataType: "xml",
        headers: headers,
        success: function (response, textStatus, xhr) {
          showFadeAlertSuccess(id, xhr, textStatus, response)
        },
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    case element.hasClass("post"):
      return {
        type: "post",
        data: $("#body" + id).val(),
        dataType: "xml",
        headers: headers,
        success: function (response, textStatus, xhr) {
          showFadeAlertSuccess(id, xhr, textStatus, response)
          // Access Token
	      let access_token = ""
          const result = response
          access_token = $(result).find("token").text()
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
          //}
        },
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    case element.hasClass("put"):
      return {
        type: "put",
        data: $("#body" + id).val(),
        dataType: "xml",
        headers: headers,
        success: function (response, textStatus, xhr) {
          showFadeAlertSuccess(id, xhr, textStatus, response)
        },
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    case element.hasClass("delete"):
      return {
        type: "delete",
        dataType: "xml",
        headers: headers,
        success: function (response, textStatus, xhr) {
          showFadeAlertSuccess(id, xhr, textStatus, response)
        },
        error: function (xhr, textStatus, errorThrown) {
          showFadeAlertError(id, xhr, errorThrown)
        }
      }
      break
    default: // unsupported verbs
      return {}
  }
}
// Function to return headers base on button class
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
}
// Function to make API call using Ajax
function makeApiRequest(id) {
  const url = $("#path" + id).val()
  const options = setOptions(id)
  $.ajax(url, options)
}
function showFadeAlertSuccess (id, xhr, textStatus, response) {
  $("#alert" + id).fadeOut("fast", function () {
    $("#response" + id).val(xhr.responseText)
    $("#alert" + id).html(xhr.status + " " + textStatus)
    $("#alert" + id).removeClass("bg-danger")
    $("#alert" + id).addClass("bg-success")
    $("#alert" + id).fadeIn()
  })
}
function showFadeAlertError (id, xhr, errorThrown) {
  $("#alert" + id).fadeOut("fast", function () {
    const content = xhr.responseText
    $("#response" + id).val(content)
    $("#alert" + id).html(xhr.status + " " + errorThrown)
    $("#alert" + id).removeClass("bg-success")
    $("#alert" + id).addClass("bg-danger")
    $("#alert" + id).fadeIn()
  })
}
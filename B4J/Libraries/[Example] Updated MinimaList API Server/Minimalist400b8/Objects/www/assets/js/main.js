/*!
 * Web API Server B4J Project Template v4.00 by @pyhoon (https://github.com/pyhoon/web-api-server-b4j)
 * Copyright (c) 2022-2025 Poon Yip Hoon (Aeric)
 * Licensed under MIT (https://github.com/pyhoon/web-api-server-b4j/blob/main/LICENSE)
 */
var coll = document.getElementsByClassName("collapsible")

var i

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function () {
    this.classList.toggle("active")
    var details = this.nextElementSibling
    if (details.style.maxHeight) {
      details.style.maxHeight = null
    } else {
      details.style.maxHeight = details.scrollHeight + "px"
    }
  })
}

var csrf_token = $('meta[name="csrf-token"]').attr('content')

function csrfSafeMethod(method) {
  // these HTTP methods do not require CSRF protection
  return (/^(GET|HEAD|OPTIONS)$/.test(method))
}

$.ajaxSetup({
  beforeSend: function (xhr, settings) {
    if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
      xhr.setRequestHeader("x-csrf-token", csrf_token)
    }
  }
})
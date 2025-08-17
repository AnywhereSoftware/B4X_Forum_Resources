$(document).ready(function () {
  $.ajax({
    type: "get",
    dataType: "xml",
    url: "/api/categories",
    success: function (response) {
      const $category1 = $("#category1")
      const $category2 = $("#category2")
      $category1.empty()
      $category2.empty()
      let data = []
      const root = $(response).find("root")
	  const result = $(root)
      const $items = $(result).children("item")
      $items.each(function () {
        const $item = $(this)
        data.push({
          id: $item.children("id").text(),
          category_name: $item.children("category_name").text()
        })
      })
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
  })
  $.ajax({
	  type: "get",
    dataType: "xml",
    url: "/api/find",
    success: function (response, status, xhr) {
      let rows = []
      // XML format
      const root = $(response).find("root")
      const result = $(root)
      const $items = $(result).children("item")
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
      })
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
      <td class="align-middle" style="text-align: right">${id}</td>
      <td class="align-middle">${code}</td>
      <td class="align-middle">${name}</td>
      <td class="align-middle">${category}</td>
      <td class="align-middle" style="text-align: right">${price}</td>
      <td>
        <a href="#edit" class="text-primary mx-2" data-toggle="modal">
          <i class="edit fa fa-pen" data-toggle="tooltip"
          data-id="${id}" data-code="${code}" data-category="${catid}"
          data-name="${name}" data-price="${price}" title="Edit"></i></a>
        <a href="#delete" class="text-danger mx-2" data-toggle="modal">
          <i class="delete fa fa-trash" data-toggle="tooltip"
          data-id="${id}" data-code="${code}" data-category="${catid}"
          data-name="${name}" title="Delete"></i></a>
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
  })
})
$("#btnsearch").click(function (e) {
  e.preventDefault()
  const form = $("#search_form")
  const data = JSON.stringify(convertFormToJSON(form), undefined, 2)
  $.ajax({
	  type: "post",
    data: data,
    dataType: "xml",
    url: "/api/find",
    success: function (response, status, xhr) {
      let rows = []
      // XML format
      const root = $(response).find("root")
      const result = $(root)
      const $items = $(result).children("item")
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
      })
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
      <td class="align-middle" style="text-align: right">${id}</td>
      <td class="align-middle">${code}</td>
      <td class="align-middle">${name}</td>
      <td class="align-middle">${category}</td>
      <td class="align-middle" style="text-align: right">${price}</td>
      <td>
        <a href="#edit" class="text-primary mx-2" data-toggle="modal">
          <i class="edit fa fa-pen" data-toggle="tooltip"
          data-id="${id}" data-code="${code}" data-category="${catid}"
          data-name="${name}" data-price="${price}" title="Edit"></i></a>
        <a href="#delete" class="text-danger mx-2" data-toggle="modal">
          <i class="delete fa fa-trash" data-toggle="tooltip"
          data-id="${id}" data-code="${code}" data-category="${catid}"
          data-name="${name}" title="Delete"></i></a>
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
  })
})
$(document).on("click", ".edit", function (e) {
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
})
$(document).on("click", ".delete", function (e) {
  const id = $(this).attr("data-id")
  const code = $(this).attr("data-code")
  const name = $(this).attr("data-name")
  $("#id2").val(id)
  $("#code_name").text("(" + code + ") " + name)
})
$(document).on("click", "#add", function (e) {
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
      const data = JSON.stringify(convertFormToJSON(form), undefined, 2)
      $.ajax({
        type: "post",
        data: data,
        dataType: "xml",
        url: "/api/products",
        success: function (response) {
          $("#new").modal("hide")
          alert("New product added !")
          location.reload()
        },
        error: function (xhr, ajaxOptions, errorThrown) {
          alert(errorThrown)
        }
      })
    }
  })
})
$(document).on("click", "#update", function (e) {
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
      const data = JSON.stringify(convertFormToJSON(form), undefined, 2)
      $.ajax({
        type: "put",
        data: data,
        dataType: "xml",
        url: "/api/products/" + $("#id1").val(),
        success: function (response) {
          $("#edit").modal("hide")
          alert("Product updated successfully !")
          location.reload()
        },
        error: function (xhr, ajaxOptions, errorThrown) {
          alert(errorThrown)
        }
      })
    }
  })
})
$(document).on("click", "#remove", function (e) {
  $.ajax({
    type: "delete",
    dataType: "xml",
    url: "/api/products/" + $("#id2").val(),
    success: function (response) {
      $("#delete").modal("hide")
      alert("Product deleted successfully !")
      location.reload()
    },
    error: function (xhr, ajaxOptions, errorThrown) {
      alert(errorThrown)
    }
  })
})
function convertFormToJSON(form) {
  const array = $(form).serializeArray() // Encodes the set of form elements as an array of names and values.
  const json = {}
  $.each(array, function () {
    json[this.name] = this.value || ""
  })
  return json
}
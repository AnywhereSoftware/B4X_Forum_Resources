### HTMX+Bootstrap5+MiniHTML+WebApiUtils+Server by aeric
### 01/27/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165263/)

This example uses B4X,  

- specifically [MiniHTML](https://www.b4x.com/android/forum/threads/b4x-web-minihtml.158846/) library
- cross over [HTMX](https://htmx.org/) to generate interactive HTML
- based on [Modal Dialogs in Bootstrap](https://htmx.org/examples/modal-bootstrap/) example on HTMX website
- to demonstrate mix usage of HTMX and [Bootstrap 5](https://getbootstrap.com/docs/5.0/getting-started/introduction/) javascript
- served by [B4J server](https://www.b4x.com/android/forum/threads/server-building-web-servers-with-b4j.37172/) through helper functions from [WebApiUtils v3](https://www.b4x.com/android/forum/threads/web-webapiutils-v3.165120/) library.

```B4X
Button.Text("Open Modal") _  
.hxGet("/modal") _  
.hxTarget("#modals-here") _  
.hxTrigger("click") _  
.attribute2(CreateMap("data-bs-toggle": "modal", "data-bs-target": "#modals-here")) _  
.addClass("btn btn-primary text-uppercase") _  
.up(div2)
```

  
  
Output:  

```B4X
<button hx-get="/modal" hx-target="#modals-here" hx-trigger="click" data-bs-toggle="modal" data-bs-target="#modals-here" class="btn btn-primary text-uppercase">Open Modal</button>
```
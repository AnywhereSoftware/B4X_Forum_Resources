### SimpleWebServer (com.sun.net.httpserver) by tchart
### 06/14/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171259/)

Another web server…  
  
I needed a very lightweight basic web server as a UI for a background service i.e. Windows service. This is based on com.sun.net.httpserver  
  
Docs; <https://help.qonda.app/b4x/simplewebserver/>  
  
**SimpleWebServer** embeds a lightweight HTTP or HTTP/HTTPS web server into your B4J application. It serves static files from a folder on disk and routes any unhandled requests to B4J subroutines, letting you build a web interface without an external server process.  
  
Requests for static files (HTML, CSS, JS, images) are served directly. If a requested path has no matching file, the library calls your SubName\_Get or SubName\_Post subroutine so your code can generate a dynamic response. The Content-Type header is set automatically based on the response you return.  
  
When using Initialize2, an HTTP server is started alongside the HTTPS server solely to issue 301 redirects, ensuring all traffic is sent over HTTPS.  
  
[HEADING=2]What it is[/HEADING]  

- An embedded HTTP/HTTPS server you start from inside your own B4J app, with no separate web server to install or run.
- A way to put a local web interface on a desktop or server application: admin panels, dashboards, configuration screens and lightweight internal tools.
- A simple bridge between web requests and B4J code: static files are served from a folder, and everything else is handed to your handler subroutines.
- Best suited to a small number of trusted users on a local machine or network, not the public internet.

[HEADING=2]What it is not[/HEADING]  
It is deliberately minimal and is *not* a replacement for a production web framework. In particular, it does not provide:  
  

- **High-throughput / high-concurrency serving** — suited to a handful of users, not a high-traffic public website. There is no connection tuning, load shedding or back-pressure.
- **Single-threaded in debug mode** — while release mode uses a thread pool, debug mode routes every request through the main B4J thread, so requests are handled one at a time during development.
- **No authentication or authorization** — there is no built-in login, sessions, cookies or access control. Anything you need must be implemented in your handler subs.
- **No request body parsing** — bodies arrive as a raw UTF-8 string. There is no automatic form, query-string or JSON parsing, and no multipart or file-upload handling.
- **Text responses only** — handler subs return a String, so dynamically generated binary content (images, PDFs, downloads) is not supported. Binary assets must be served as static files.
- **No WebSockets or streaming** — there is no support for WebSockets, server-sent events, chunked streaming or long-polling. Each request returns a single complete response.
- **No HTTP/2 or HTTP/3** — it speaks HTTP/1.1 only.
- **No compression or caching** — responses are not gzipped, and no ETag, Cache-Control or conditional-request handling is applied.
- **No routing framework** — routing is manual via Select Case in your handler subs. There are no path parameters, wildcards or middleware.
- **No virtual hosts or reverse proxying** — each instance serves one folder on one set of ports.

[HEADING=2]Features[/HEADING]  

- **Static file serving** — serves HTML, CSS, JS, images and other files directly from a folder on disk, with the URL path mapped straight to the file system.
- **Dynamic request routing** — unhandled GET and POST requests are routed to your SubName\_Get and SubName\_Post subroutines so your code can build responses on the fly.
- **Automatic Content-Type detection** — the response type is inferred from the returned string (JSON, HTML or plain text) and from the file extension for static files.
- **HTTPS support** — TLS via a standard Java keystore (JKS), with a companion HTTP server that 301-redirects all traffic to HTTPS.
- **Built-in redirects** — return "redirect:/path" from any handler to send a 302 redirect to a path or full URL.
- **Path traversal protection** — requests that try to escape the static files folder are blocked with a 403.
- **Automatic index** — a request for / is rewritten to /index.html when that file exists.
- **Optional thread pool** — request handling is serial by default; call SetThreadCount to enable concurrent handling via a fixed thread pool (debug mode is always routed to the main B4J thread).
- **Multiple instances** — run several independent server instances side by side in the same application.
- **Graceful shutdown** — Stop drains in-flight requests with a short timeout before closing.
- **Self-contained** — embeds directly into your B4J app with no external web server process to install or manage.

[HEADING=2]Quickstart[/HEADING]  
  

```B4X
Sub Process_Globals  
    Private WebServer As SimpleWebServer  
    Private StaticFilesFolder As String  
End Sub  
  
Sub AppStart(Args() As String)  
    StaticFilesFolder = File.Combine(File.DirApp, "www")  
    WebServer.Initialize(8080, StaticFilesFolder, "WebServer")  
    WebServer.Start  
End Sub  
  
Sub WebServer_Get(Path As String, QueryString As String) As String  
    Select Case Path  
        Case "", "/", "/index"  
            Return page_index.Handle(QueryString)  
        Case "/healthcheck"  
            Return $"{"status":"ok"}"$  
    End Select  
    Return Null  
End Sub  
  
Sub WebServer_Post(Path As String, Body As String) As String  
    Select Case Path  
        Case "/config"  
            Return page_config.Post(Body)  
    End Select  
    Return Null  
End Sub
```
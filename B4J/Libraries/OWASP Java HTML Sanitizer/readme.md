### OWASP Java HTML Sanitizer by tchart
### 11/12/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/124508/)

This is a wrapper for the [OWASP Java HTML Sanitizer](https://github.com/OWASP/java-html-sanitizer) library.  
  
"A fast and easy to configure HTML Sanitizer written in Java which lets you include HTML authored by third-parties in your web application while protecting against XSS."  
  
I needed a way to sanitize request inputs to a web app after this vulnerability was flagged by a QualsysGuard scan.  
  
The library does depend on the Guava library which adds about 3mb to your project. This is too big to upload to the forum so needs to be downloaded from here; <https://mvnrepository.com/artifact/com.google.guava/guava/30.0-jre>  
  
NOTE1: The Sanitize method (in the main library) encodes HTML e.g. in a query string. The Sanitize method in the wrapper has a boolean to set whether you want to decode the output. Ive also exposed the DecodeHtml method as this is handy for some other use cases.  
  
NOTE2: Only the default policies are implemented, these are BLOCKS, FORMATTING, IMAGES, LINKS, STYLES, TABLES.  
  
NOTE3: If you initialize with blank (ie "") then all HTML will be sanitized out except standard URL's (i.e. http, https)  
  
Sample code;  
  

```B4X
Dim h As HTMLSanitize  
     
    ' Can initialize with BLOCKS, FORMATTING, IMAGES, LINKS, STYLES, TABLES or blank    
    h.Initialize("FORMATTING") ' will leave formatting intact  
    Log(h.Sanitize("<script>function naughtyStuff(){}</script><b>Hello</b><a href='https://example.com'>",False))  
     
    h.Initialize("LINKS") ' will leave links intact  
    Log(h.Sanitize("<script>function naughtyStuff(){}</script><b>Hello</b><a href='https://example.com'>",False))    
     
    h.Initialize("") ' will only leave standard Url protocols intact (eg redirect URL's for OAuth)  
    Log(h.Sanitize("<script>function naughtyStuff(){}</script>f=json&token=XYZ",False))  
    Log(h.Sanitize("<script>function naughtyStuff(){}</script>f=json&token=XYZ",True))  
     
    Log(h.DecodeHtml("f&#61;json&amp;token&#61;XYZ"))
```
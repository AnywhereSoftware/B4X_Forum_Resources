### Http Interceptor by drgottjr
### 10/12/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/155189/)

we've had several recent threads relating to okhttputils2:  
1) delayed network access (erel suggested he might include his fix as part of the okhttputils2 b4xlib),   
2) okhttp's behavior in the case of redirects (this might also possibly be added to the library instead of an ad hoc fix, when needed)   
3) inability of okhttputils2 to monitor what it actually sends as a request.  
  
okhttputils2 is a fantastic general purpose http client. if you've ever tried to write one, you would know. it is, of course, an interface between b4a and square's okhttp3 client. that is, it implements in a single b4a library what okhttp3 implements in many discrete calls.  
  
logging http requests and responses is not part of okhttp3's default behavior. in a way, it shouldn't be necessary; you formulate the request, so you know what you're sending, and you see what the server sends back, so what else is there to see? well, for one thing, you can't see the default headers that accompany any headers you may have added. as far as okhttputils2 is concerned, you can only set headers, not see them. whether or not there is anything else to see, if you want to see it, you need what square calls a network interceptor.  
  
i've cobbled together a simple interceptor. it plugs it into okhttputils2 in the same way that erel suggested to modify okhttp3's default redirect behavior. there is a tiny bit of inline java required (at least in my implementation). you don't have to rebuild the okhttputils2 library.  
  
the attached example is self-documenting. if you run it as is, you see whatever it is that you see on your device. if you then, eg, set your own header and run the example, you will see slightly different output. i rest my case.  
  
this is a proof of concept. in addition to monitoring requests, it can also handle responses. in my example i only addressed the request side. how useful this is, i can't say, but it certainly addresses the concern posted by a forum member.  
.   
okhttputils2 and okhttp3 are both well written, and it was easy enough to get okhttp3's interceptor to work with b4a for those with a special use case. square's documentation will   
cover whatever other functions it offers (eg, the response).
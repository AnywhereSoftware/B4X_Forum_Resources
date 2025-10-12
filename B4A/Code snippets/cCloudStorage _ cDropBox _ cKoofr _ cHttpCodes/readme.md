### cCloudStorage / cDropBox / cKoofr / cHttpCodes by Robert Valentino
### 10/10/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168987/)

OK, I wrapped my cDropBox & cKoofr classes with cCloudStorage. Now I have one class that when you set SetAuthorization parameters will initialize the right class (DropBox or Koofr)  
  
If my user logs in one day and wants to use DropBox and gives me the right log in parameters boom, we are using DropBox, if they give me the right Koofr parameter(s) then we are using Koofr. WITHOUT a single line of code change to my program  
  
I put all the source in a B4XLib (attached) with the B4J test program I made to make sure it tests all the functions.  
  
NOT sure if the way I wrote cCloudStorage is the proper way for B4X, (in my C++ days I would have done it differently - but basic doesn't allow that)  
  
If I did something wrong give me a shout out (BE LOUD - only kidding - I am 75 and don't hear well anymore - LOL at least that's what I tell me wife)  
  
This is probably my last release of this (maybe not I need to make it all work on B4i and maybe add Firebase to it).   
  
It works nicely for me. Hope it helps someone
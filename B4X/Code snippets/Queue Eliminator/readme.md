###  Queue Eliminator by Star-Dust
### 06/12/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/121575/)

In [**post #9**](https://www.b4x.com/android/forum/threads/queue-eliminator.121575/post-829498) there is an B4x example (B4XPages) that uses WebSocket and the xHttpServer library  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
Today I didn't have much to do and starting from an idea of [USER=63206]@MarcoRome[/USER] (see [**this**](https://www.b4x.com/android/forum/threads/tv-box-android.76386/post-490944)) I wanted to make a software cut queue. (or delete/eliminator code, I don't know how to say exactly in English and google doesn't help)  
  
It will also have happened to you to queue at the post office, at the bank, at the pharmacy, in the bathroom.  
Where there is a queue eliminator, a shift number can be obtained, and the number served at that moment appears on the screen. The counter operator advances the number each time he has finished serving the customer.  
  
**So there are 3 front end.** (1) The progress of the number, (2) The request for the number and finally (3) The display of the current number in turn.  
  
I have come up with a solution that can work with a single application for all 3 front ends, but you can add 2 more applications if you wish. I thought of an html server, which runs on a windows pc that runs in the operator's station who will carry out the shift (but it can be easily created for b4a and b4i)  
The server will generate two dynamic html pages which will be viewed by 2 devices.  
On a device (which can be a tablet, but it's better if it's an android TV device) that will access an HTML page, with the internal browser, that will display the current shift. The second device, with the internal browser, will access another page that will allow you to request a number for your turn. (This could be a mobile device).  
  
I show you some screenshots of the operation and finally the source code attached.  
  
**SERVER B4J**  
  
![](https://www.b4x.com/android/forum/attachments/99093)  
  
  
Screen that displays the current shift (Tablet / Android TV / TV Box)  
<http://youaddress:51015/> (locale <http://127.0.0.1:51015/>)  
![](https://www.b4x.com/android/forum/attachments/99097)  
  
Turn request on mobile device  
<http://youaddress:51015/request> (locale <http://127.0.0.1:51015/request>)  
![](https://www.b4x.com/android/forum/attachments/99098)  
  
  
The number is missing. This can always be obtained in JavaScript or with a specific Client for the shift request. But we will see this in the next post, as soon as I have more free time
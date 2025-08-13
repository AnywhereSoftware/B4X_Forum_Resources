### B4A Welcomes SSE by drgottjr
### 12/04/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/144587/)

so, there's something called server side events (SSE).  
it apparently has something to do with notifications  
from a web server to a browser. i'm guessing it's what  
happens when you see an annoying pop-up message   
from a web server asking persmission to send you   
notifications. good luck with that; not!  
  
i noticed a thread earlier in the week relating to   
server side events (SSE), but for b4j.  
  
anyway, the thing is: mirabile dictu! it works with okhttputils2.   
that is, it doesn't interfere with okhttputils2 (at least not that  
i have seen); you can do your normal okhttputils2 business  
at 1 url while still receiving notifications from a totally   
different url. wait, what? for example, if you had a website   
that sent periodic world cup updates as notifications, you could   
receive them while downloading jpg's or updating your mysql   
database on another url. win-win, right?   
  
so, for what it's worth, i put it out there. i tested it with a   
website that allows test sse connections. it sends notifications   
out every few seconds. i capture in an event, so i have   
them flashing in a text label. while that's going on, i can download   
some other files and post some database updates using the  
same, declared okhttputils2 client. or so it seemed to me.  
  
you can turn off the notifications when you want without  
affecting your current okhttpclient (in fact you MUST turn them off  
when you exit your app). i haven't implemented a turn-back-on button.   
the library is mostly a proof of concept at this point, but i leave it up  
your vivid imaginations to see how it might be used, if at all.  
  
in addition to the library and its .xml file, you need to copy an attached  
okhttp-sse-related jar to your additional libraries folder. technical point:  
the jar's version is 4.9.3. it uses the standard okhttp3 jar of the same vintage.  
we have a slightly older okhttp3 jar in our b4a libraries folder, but the  
library seems to work ok with it. so i went with what we have.  
  
take a look at the attached image to see about setting things up and the   
notifications i received.  
  
you need to start the okhttpservice module first (normally, it is not started until you  
perform your first okhttp download or post. in this case, you need to start it early on.  
initialize the gsse library and tell it the url of the web server providing the updates.  
  
at that point, you don't have to do anything else. notifications should start hitting the  
gotEvent sub. do with the notification what you will.  
  
if you want to carry out some other okhttp routine, do it as normal.  
  
note: for whatever reason on my pixel 3a, there was a noticeable lag between the  
time i started the okhttputils2 service and when it was actually up and running. there  
is no "wait for" to indicate that the service is running. and if it isn't actually running,  
the sse setup will fail. i added a 5 second sleep and then check to see if the  
service is active. if it is, i continue with sse. you could try with less time.  
  
initially, i did the whole thing in inline java. then i decided to put it in a library for  
people who just want something to plug in.   
  
erel encountered a problem recently regarding okhttp and proxies. his solution   
involved his usual magic with javaobject calls. as the solution got more involved,   
he added some inline java. the same approach could probably be used for sse.  
i chose the way i did it because i was comfortable with it, but it isn't the only way.
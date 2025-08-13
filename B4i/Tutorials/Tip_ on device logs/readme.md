### Tip: on device logs by Erel
### 10/19/2023
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/156056/)

I'm not sure whether it is a new feature in iOS or I simply wasn't aware of it, but it is a very useful one.  
Apparently you can access the crash logs from the settings app. This helps when you want to debug a crash that happens in a store / release distribution.  
  
**Settings - Privacy & Security - Analytics & Improvements - Analytics Data** - and you will see a list of the crash logs.  
In my case it appeared under "result".  
  
Find the right one and send it to your PC.  
The interesting part is under "lastExceptionBacktrace". It is a json list. Copy it carefully from the opening square bracket to the closing one, and use a tool such as this one <https://jsonlint.com/> to format it.  
It is a bit verbose but it will help you find the crash point.
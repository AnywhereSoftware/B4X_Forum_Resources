### eventbus now departing gate 2. by drgottjr
### 08/14/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/142321/)

here's an interesting thing called an event library (for android). a forum member was having   
a problem raising an event in an activity that was in the background (or even killed). there are   
some workarounds (service, intent, startactivityforresult, sharedpreferences, shared resource,   
etc), which - for whatever reasons - he couldn't use in the project.   
  
here is another option he probably couldn't use: the eventbus. there are a few implementations   
out there, but i latched onto greenrobot's version and, after experimenting a bit in inline java, i   
cobbled a simple library together. the additional jars required are very small. after downloading   
and unarchiving the attached zip archive, copy any jars, aars or xml files to your additional libraries   
folder. the remaining bus2 folder holds an example project which you can build.  
  
to get started checking out the eventbus library (for android), navegate here:  
<https://greenrobot.github.io/EventBus/>. this is a typical graphic representation of what the  
event bus does:  
![](https://www.b4x.com/android/forum/attachments/132480)  
  
in the attached example, the main activity posts an event on the bus and then runs a second  
activity. when that activity launches, it retrieves the event automagically. if you read the  
abovementioned link, you'll see that the eventbus handles communications between  
activities, services, fragments, etc. and to read all the information out there, you'd think it was  
not possible to do anything serious without an eventbus. whatever.  
  
the so-called event can be any type of object. for purposes of simplicity, i chose a string  
"event". anyone on the eventbus will see the event automatically as it is posted (except for  
activities that are not in the foreground). i have chosen to employ "sticky" events so that dormant   
activities will receive them when they are launched or moved to the foreground. push notifications   
and named pipes/ipc come to mind.
### EventBus Departing Gate 3 by drgottjr
### 08/17/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/142368/)

in my previous release, i chose to limit the "event" to a string: put a string on the bus, and anyone  
registered for the bus received a string. since the event can be any object, i was trying to figure out   
how to enable b4a users to define and enable an event of their own chosing. no need; just post   
whatever object you want: string, int, list, map, bitmap. i tried them all. the eventbus sees an object.  
the subscriber knows what the object on the bus is, so she just unwinds it when the event is triggered.  
  
in other words, you post an object, and subscribers receive an object. publisher and subscriber   
simply agree on the object type. i think that's the way the system is desiged, but i also think that  
if the subscriber didn't know what the object was, it wouldn't be difficult to provide that  
information. (eg, if the subscriber were looking for a string when an event containing a map was   
triggered, it could be ignored. presumably, some subscriber somewhere was looking for an event   
with a map. i didn't test this, but an object's type can be derived.)  
  
the second release of the gbus library is attached, along with a example that sends a bitmap to  
another activity. pity we never need anything like that…
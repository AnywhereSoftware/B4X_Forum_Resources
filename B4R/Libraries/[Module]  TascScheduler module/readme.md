### [Module]  TascScheduler module by candide
### 08/17/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/133513/)

it is a basic task scheduler to manage multi-threading in B4R environment  
This one is based on a loop to check conditions of each thread and to launch it with Callsubplus in asynchronous mode  
  
multi-threating is based on a module TaskScheduler:  
 - In a loop, this module will launch each thread one by one depending of some criteria (Enable/Period/Watchdog)  
 - 15 threads are available in this module but it can be modified if more needed  
 - you can run only the number of threads needed  
 - this module is including GlobalStore version 2.00 to add storage   
 - data is saved in a global buffer with size set to 200. You can increase it if you face out of arrays exceptions.  
 - 15 variables are available to store data for each thread (one slot by thread, slot0 < slot14)  
 - each variable is an array of byte, you can store array or string  
  
this module can provide statistics about multi\_thread, we have 2 types of information:  
 \* for scheduler:  
 - it provides period between 2 run of Scheduler : Min/Med/Max   
 - it provides time needed for a run of Scheduler : Min/Med/Max   
 \* for each thread enabled:  
 - it provides period between 2 run of thread : Min/Med/Max   
 - it provides time needed for a run of thread : Min/Med/Max   
  
 \* functions available:  
 - TaskScheduler.initialize(14) ' if 15 threads 0<14  
  
 - TaskScheduler.statStart ' to start statistic collection and printing every 15mn  
 - TaskScheduler.statStop ' to stop statistic collection and printing  
  
 \* variables available:  
 - TaskScheduler.Task(i).Enabled = True ' <Boolean> to make active a thread after configuration (in AppStart)  
 - TaskScheduler.Task(i).Period = MyVar ' <Uint> to define period between thread running 2 times  
 - TaskScheduler.Task(i).Watchdog = Myvar ' <Uint> to define period maxi before activation of a thread  
 ' will run the thread with Tag 255 in this case  
 - TaskScheduler.Task(i).Tag ' <Byte> Tag is parameter sent to thread at launch  
 ' Several values of tag can be used to avoid Delay()  
 ' 255 is used in case of Watchdog activation   
 - TaskScheduler.Put(slot as Int, Value() As Byte) ' to save an Array of Byte to slot (0<14 possible)  
 - MyArray = TaskScheduler.Slot0 ' to read an Array of Byte from Slot0 (Slot0 < Slot14 possible)  
  
an example of project B4R with TaskScheduler module is included in Zip file
### Swift libraries by Erel
### 03/02/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/75691/)

B4i supports libraries written in Swift and compiled as frameworks.  
Note that adding swift frameworks makes the compilation process considerably more complicated and it is recommended to avoid swift libraries if there is an alternative.  
  
The B4i wrapper is written in Objective C. You can see an example here: <https://github.com/AnywhereSoftware/B4i_iSwiftyButton> (note the ~dependson attribute).  
  
Using a Swift library is not different than using an Objective C library. There are however a couple nuances that you should be familiar with:  
1. Swift runtime libraries - All applications with Swift code depend on Swift runtime libraries. They are added automatically during compilation. The runtime size is about 8mb.  
Note that the size of the ipa file, when you compile with a store provision profile in release mode, will be about 35mb. Still the app size when installed on the device will be around 8mb.  
  
2. Simulator not supported for now.  
  
3. If using a local Mac then you need to make sure to use B4i build server v6.51+ and you need to follow these instructions: <https://www.b4x.com/android/forum/threads/non-public-api-usage.101433/post-637293>
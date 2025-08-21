### B4XPages vs Activities, Bluetooth Example by swChef
### 08/04/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/120884/)

In the thread [BT Pages Example](https://www.b4x.com/android/forum/threads/b4xpages-bluetooth-chat-example.119014/#content), a new version of the BT example was created using Pages. Since I'm just looking at Pages for the first time, I popped the new and old versions into a code comparison utility (old version is linked in the new example post). However I found that, while with reason, the new Pages version had the Bluetooth Manager code integrated into the Page implementation. This made it more work to compare. I thought that might make it somewhat more potentially confusing to new folks.  
  
So I converted the Pages example back to using a BluetoothManager class, and also moved a bit of code here and there in both, so it aligns better in a code comparison utility. But be aware (for new folks) that when using a utility to compare, those applications try to match up file names. Between the two sample projects, the two sets of file names are not identical (ChatActivity vs ChatPage), and, some code formerly in "Main" is now in "B4XMainPage". So you'll have to manually drop in those two pairs of files in a utility in order to more easily see the differences. I didn't rename them to be the same as that could cause other confusion. You can also just launch two B4A IDEs, if you have enough display area.  
  
By the way, for folks new to coding, one such utility for code comparison is [WinMerge](https://winmerge.org/). There are others.  
  
Download the attachment. "Extract All" to a folder. Both versions were combined into the one zip.
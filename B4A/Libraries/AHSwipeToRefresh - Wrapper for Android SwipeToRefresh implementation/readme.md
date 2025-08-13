### AHSwipeToRefresh - Wrapper for Android SwipeToRefresh implementation by corwin42
### 01/14/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/39355/)

With the v19.1 version of the Android support library Google added a SwipeToRefresh view to the android system. This is usable with API version 4 and up but it needs the android-support-v4.jar library.  
  
Google uses two different implementations of the SwipeToRefresh usepattern in their own apps. This one is similar to the "Google Now" implementation. Nearly all other Google apps use another (in my opinion slightly nicer) solution but the Google Now version is, what made it into the official Android SDK.  
  
**Usage:**  
Add the AHSwipeToRefresh Object to the activity. This can be done manually or with the designer as a custom view.  
Then you have to add a view to the AHSwipeToRefresh object which then can be pulled to start the refresh process. You can only add one single view to the AHSwipeToRefresh object. This should be something like a ListView or ScrollView.  
When the user starts a refresh process the "Refresh" event is fired where you can start your refresh process (like loading some data over the net). When the refresh process is complete just set the Refresh property to false to stop the animation.  
  
**Installation:**  
Copy the AHSwipeToRefresh.jar and AHSwipeToRefresh.xml files to your custom libraries folder.  
  
Additionally you will need the android-support-v4.jar. Check with the Android SDK Manager if you have the latest Android Support Library (You will need at least v22) installed. You can find the library in the <SDK\_HOME>\extras\android\support\v4 folder. Copy the library to your custom libraries folder.  
  
**History:**  
V1.00  
- Initial version  
  
V1.10  
- Requires Support Library v22 or up  
- Fixed problems with UltimateListView (hopefully, simple example provided)  
- Added ability to change background color of the progress indicator  
- Added ability to set any number of colors for the progress indicator  
- Supports a larger progress indicator  
- New event (STR\_CanChildScrollUp) to determine when a swipe event should be triggered or not.  
- Support for multiple views (See example)  
- Added method to set the offset (position) of the progress indicator  
  
**Edit (Erel): new requirements: <https://www.b4x.com/android/forum/threads/ahswipetorefresh-wrapper-for-android-swipetorefresh-implementation.39355/post-1012127>** 
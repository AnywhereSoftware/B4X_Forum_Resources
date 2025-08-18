### [XUI] xImageSliderIG - Instagram style image and video slider by Biswajit
### 12/25/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/119402/)

This Instagram style image and video slider is compatible with B4A and B4I.  
  
**xImageSliderIG  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 2.02  
**Dependency:**  

1. **B4A:** JavaObject, XUI, GestureDetector, AHViewPager(ver. 3), OkHttpUtils2, ExoPlayer
2. **B4I:** iXUI, iHttpUtils2, iUI8

**Features:**  

1. Instagram like Image Counter
2. Instagram like Dot Indicator
3. Instagram like Pinch Zoom (only for image item)
4. Cover blank space with blurry image/color
5. Customizable Indicator color and animation duration
6. Single Tap and Double Tap
7. Fit / Fill / Stretch Image
8. Lazy loading for both image and video
9. Loading indicator
10. Support both local and remote items
11. Retry loading option for failed remote image
12. Update item list on runtime
13. Support video playback both local and remote (uri/dash/hls/smoothstream) **(NEW)**
14. Auto-pause while going offscreen **(NEW)**
15. Auto-resume while visible 85% **(NEW)**
16. Autoplay and start muted video **(NEW)**
17. Hide/Show (inside/outside) dot indicators **(NEW)**
18. Support video scaling (Fill / Fit / Stretch) **(NEW)**

**Method:**  

- **SetItems**(imgs As List)
*Set/Update items as a list to the slider along with the value as a map you want to receive on tap events*
***Image item map format:***
*data: your data that will be returned on tap  
image: bitmap / url  
**Video item map format:**  
data: your data that will be returned on double tap  
video: url / path (combined)  
 type: file/uri/dash/hls/smoothstream*- **SetZoomPanel**(ZoomPanelContainer As B4XView)
*Set zoom panel (Usually Activity / Root panel) to enable the pinch zoom feature*- **ShowNext**
*Show the next item*- **ShowPrev**
*Show the previous item*- **PauseCurrentVideo**
*Pause the current video item*- **PlayCurrentVideo**
*Play the current video item*- **ToggleMute**
*Toggle mute of the current video item*- **UpdatePlayback**
*Update the current playback state  
Required to pause the playback on activity\_pause / page\_disappear  
 And to resume the playback on activity\_resume / page\_appear*
**Property:**  

- **ActivityHasActionBar** As Boolean
*Set it to true if the activity/page has an Action bar (b4a) / Navigation bar (B4I). Default is False. Only needed if the pinch zoom is enabled.*- **CurrentIndex** As Int

**Designer Property**:  

- **Show Indicator Dots:** Show indicator dots. (OUTSIDE / INSIDE / HIDE) (Default: OUTSIDE)
- **Dots Color:** Change the inactive dot indicator color. (Default: #CCCCCC)
- **Active Dot Color:** Change the active dot color. (Default: #4286F4)
- **Scale Content:** Slider item scale type. (FIT / FILL / STRETCH) (Default: FIT)
- **Cover Free Space:** Show a blurry image around the slide image if there is any free space. Only applicable for image item and if FIT scale type is selected. (Default: TRUE)
- **Free Space Color:** Show a solid color around the slide item if there is any free space. Only applicable if Cover Free Space is unchecked for image items. (Default: #F4F4F4)
- **Item Count:** Show slide count label (Eg. 5/10) (Default: TRUE)
- **Dot Transition Duration:** Dots transition time in milliseconds. (Default: 500)
- **Zoom Actual View:** If checked the slide will be hidden while zooming (Like Instagram).
- **Autoplay Video:** If checked the video will be autoplayed on loading completion. (Default: TRUE)
- **Start Video Muted:** If checked the video will start muted on loading completion. (Default: TRUE)

**Events:**  

- **PageChanged**(CurrentIndex As Int)
- **VideoPlaying**(CurrentIndex As Int)
- **VideoPaused**(CurrentIndex As Int)
- **SingleTap**(CurrentIndex As Int, Data As Object)
***NOTE****: Only for image items. For video items single tap will toggle the video playback state.*- **DoubleTap**(CurrentIndex As Int, Data As Object)

  
**Usage:**   

1. Add this view from the Designer.
2. Copy the attached **ximageslider\_video** layout file to your project if you want to show video items.
3. Create a list having each item as a map. The map will contain a bitmap or URL and data (any object) (See Example). (For **Image** item)
4. Create a list having each item as a map. The map will contain a video URL or Path, video type, and data (any object) (See Example). (For **Video** item)
5. Set that list to the image slider.
6. Set zoom panel (optional)
7. On activity pause / page disappear event pause the current video playback (See Example)
8. On activity resume / page appear event update the current video playback (See Example)
9. If you are using multiple sliders in a clv, then call UpdatePlayback on ScrollChange event.

**For multiple sliders with CLV check the attached examples.  
  
Update 1.1:**  

1. Added support for lazy loading
2. Added support for remote image loading (Example attached)
3. New loading indicator and tap to retry option for failed remote image

**Update 1.20:**  

1. Fixed crash issue in Android 28.
2. Added support for updating the image list (Check updated example).

**Update 1.21:** Added new PageChanged event.  
**Update 1.22:** Fixed a crashing issue while using as a single slider with no ActionBar.  
**Update 2.00:**  

1. Fix item scaling issue
2. Support video playback both local and remote (uri/dash/hls/smoothstream)
3. Auto-pause while going offscreen
4. Auto-resume while visible 85%
5. Autoplay and start muted video
6. Hide/Show (inside/outside) dot indicators
7. Support image and video scaling (Fill / Fit / Stretch)
8. Added new events **VideoPlaying** and **VideoPaused**
9. Changed **SetImages** method name to **SetItems**
10. More accurate blurry cover image.
11. Now it depends upon **ExoPlayer** for B4A and **iUI8** for B4i

****Update 2.01:****   

1. Fixed an issue of ShowNext function (B4A)
2. Fixed double tap issue (B4i)

****Update 2.02:**** Fixed a crashing issue with a slow network connection while playing video.
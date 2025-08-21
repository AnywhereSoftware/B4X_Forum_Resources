###  B4XImageView - ImageView + resize modes by Erel
### 08/19/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/121359/)

B4XImageView is a new custom view, added to XUI Views **v2.40**.  
  
It adds several useful resize modes to the standard ImageView:  
  
![](https://www.b4x.com/android/forum/attachments/98780)  
  
(Images source:  
<https://www.b4x.com/android/forum/threads/compass-gm-a-gyro-magnetic-compass-app-featuring-true-and-magnetic-heading.121239/>  
<https://www.b4x.com/android/forum/threads/b4x-2-themes-dark-and-light-for-ide-code.121025/>)  
  
The bitmaps are never resized, only the internal ImageView is resized. This allows the actual image resizing to be done with hardware acceleration.  
  
All of the resize modes, except of FILL, preserve the image ratio.  
The modes are: FIT, FILL, FILL\_NO\_DISTORTIONS, FILL\_WIDTH, FILL\_HEIGHT and NONE.  
  
The attached example demonstrates all mode.  
B4XImageView also supports clipping the image to a circle. Note that there is a difference in the behavior of this feature between the platforms, when the view is not square.
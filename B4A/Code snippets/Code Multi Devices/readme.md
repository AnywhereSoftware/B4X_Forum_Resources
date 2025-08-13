### Code Multi Devices by Sailboat11
### 02/15/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159286/)

I make custom apps for sailors. Now and then I run into something that makes my programing easy. Scaling a map or any apps to fit on many different devices has been time consuming. Not the view’s location on the display, but what is inside the view. Almost all of my map tracking programs, and other GPS programs use an Image View to display the track. The device adjusts the Image View to fit the display and I have been adjusting my code to match the Image View. It’s a simple routine that checks for the height and width of the new device and modifies the code.  
  
FixV = PositionHeight  
If ImageView1.Height = 1691 Then  
  
Else If ImageView1.Height < 1691 Or ImageView1.Height > 1691 Then  
VertAdj = ImageView1.Height / 1691  
PositionHeight = FixV \* VertA  
  
This may be old news for some members, but new for others like me. I can currently program once and it works on everything. The little phone and the 8-inch tablet are using the same program in the picture. The little red dot is my location on both devices.  
  
  
  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/150890)
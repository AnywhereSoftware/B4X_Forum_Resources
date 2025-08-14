### EasyAR 3D Object Rendering by walterf25
### 07/08/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/167654/)

Hello everyone, it's been a while since I wrapped the [EasyAR SDK Library](https://www.easyar.com/) which can be found [here](https://www.b4x.com/android/forum/threads/easyar-augmented-reality-library-updated.110018/#content) I haven't had much time but I decided to create a small example to learn how to render 3D objects with the Camera Surface Tracking feature, please note I am not an expert, I relied heavily on ChatGPT especially for parsing the .gltf file to get what is needed in order to render a 3D object on your screen.  
  
This is only a proof of concept for an upcoming project I have, but so far I am very happy with the results, hope you guys also find this interesting.  
  
Also I made a small change to [USER=448]@agraham[/USER] 's OpenGL library, I added a a glDrawElements3 function which takes 4 parameters, int, int, int and Buffer, this is required when you want to pass the modelMatrix buffer. I have also added a private Static method named "GL\_UNSIGNED\_INT" as well as a "glVertexAttribPointer2" method  
  
Attached to this post I am providing the updated OpenGL library, and I have also updated the B4AEasyAR library on the main Post Thread.  
  
![](https://www.b4x.com/android/forum/attachments/165153)  
  
As time permits I will try to also support different 3D model files such as .obj files etc.  
Hope someone finds this useful and I can't wait to see what type of applications can be created with this.  
  
The source code for this example can be downloaded from my [github page](https://github.com/walterf25/EasyARSofaRender.git).  
  
Please pay attention to how the .gltf file is parsed, inside the Files directory you will find the .gltf file along with the .bin file and the texture files as well, also you will find the .vert and .frag files which are necessary to pass the texture and modelMatrix parameters so OpenGL can render the sofa properly on the screen.  
  
The menu on the bottom right side of the screen allows you to Scale the object up or down, you need to first click any of the 3 buttons to rotate along the X axis, or rotate along the Y axis and to scale up or down, you can also drag the object in any direction, I am using the Gesture Library found [here](https://www.b4x.com/android/forum/threads/lib-gesture-detector.21502/) created by [USER=22203]@Informatix[/USER], big thanks to both Agraham and Informatix for the OpenGL and Gesture Libraries.  
  
Enjoy  
  
Cheers.
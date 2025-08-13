###  Fitting a smooth curved line to a sequence of points by William Lancee
### 09/27/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/143178/)

This simple technique was mentioned in this thread  
<https://www.b4x.com/android/forum/threads/xchart-lib-dynamiclines-any-smoothing-option.143117/post-906813>  
  
It was not an appropriate solution for that thread, so I am presenting it here with a couple of examples where it is very effective.  
  
The first is where you want a line drawing based on some image. Sample points on the outline of the drawing and then use the algorithm to fit the line.  
  
![](https://www.b4x.com/android/forum/attachments/134117)  
  
  
The second example comes from my Virtual Trainset project. It was introduced in this thread.  
<https://www.b4x.com/android/forum/threads/b4j-b4xpages-artifying-an-image-creating-an-impressionistic-effect.143149/>  
The tracks are sampled from a railway map. The scene shows 4 trains (red, blue, 2 yellow) following the smoothed track.  
The image is a moment of time in the animation.  
  
![](https://www.b4x.com/android/forum/attachments/134118)  
  
  
  
Algorithm:  
  
Imagine three points. They form a corner. Cut the tip off the corner.  
You now have four points, and a smoother connection between the end points.  
  
Cutting close to the tip of the corner makes it less round.  
Cutting close to the midpoint of each edge makes it more round.  
  
Final smoothness is determined by the number of times the resulting curve is fed back into the smoothing process.  
Each iteration increases the number of points. For 3 starting points: 3, 4, 6, 10 … 2 + 2 \* (Ni - 2)  
It goes up quickly (I usually repeat it 3 or 4 times), but the process is fast enough to use in animations.  
  
It works on all point lists, even for complex curves that intersect themselves.  
The actual sub where the smoothing is done is small, but it depends on a custom type and requires a bit of explanation.  
The source code with the smoothing sub is included in the .zip file.
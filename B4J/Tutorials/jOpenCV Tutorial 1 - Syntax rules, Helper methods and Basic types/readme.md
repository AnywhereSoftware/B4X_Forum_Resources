### jOpenCV Tutorial 1 - Syntax rules, Helper methods and Basic types by JordiCP
### 03/21/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/128933/)

[SPOILER=Some notes about the tutorials]  
From time to time, jOpenCV examples will be referenced in this tutorial. You can find the donwload link in the first post of the [**jOpenCV library**](https://www.b4x.com/android/forum/threads/jopencv-library-computer-vision-with-b4j.128902/#post-808720) thread  
Syntax: when referencing classes, sometimes we'll use by their native OpenCV syntax, or their jOpenCV counterpart (with OCV prefix), since what is explained is general and applies to both. In those cases where it only applies to one of both worlds, I'll do my best so that the context is clear enough .  
[/SPOILER]  
  
In this first tutorial we'll learn the jOpenCV basic syntax rules compared to Java OpenCV, and deal with the basic Core Objects such as Mats, Scalars, Points, …  
  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
**[SIZE=5]Part 1: General jOpenCV syntax rules (compared with native OpenCV)[/SIZE]**  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
If you take the official OpenCV Java documentation as reference, you can easily know which will be the jOpenCV syntax for classes/methods with a few rules. Once you get used to it, it is very easy with these simple things in mind.  

- **"OCV" preffix**: Classes in jOpenCV are named exactly the same name as their native OpenCV Java counterparts, but adding an 'OCV' prefix. This is due to several reasons: quickly identify in code which classes belong to jOpenCV, and avoid conflicts with already existing B4x class names (for instance, Rect)
- **Initializators:** B4j initialize methods have been added for those classes that are insantiable.
- **Polymorphism**: OpenCV Java bindings expose several inputs for each class method. The way to overcome this has been to add numeric suffixes to each of them
- **Setters, getters**: they may have been treated a bit different in some classes depending on if the method has polymorphic variants. But they are all there.

  
OThers  

- (Useful if you are translating code/samples from other languages)

- namespaces: if you are translating a C++ example using Core::transpose(..), the jOpenCV syntax should be

- Dim mCore as OCVCore ' Declare it once, in the Class or process globals.
- mCore.transpose(…) ' Use any of its methods

- (\*) Earlier OpenCV versions had a mixed C/C++ syntax, so depending on the example code, syntax may be different. Also, at a given version, some methods were passed from ImgProc to Core and other changes.

- Translating from code B4A OpenCV library: if you had a working code made using the B4A OpenCV library, most of it will directly work since it is also based on the OpenCV Java bindings, even though in this case it was for a different OS / Platform ( Android / arm64)

  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
[SIZE=5]**Part 2. OCVHelper : Helper methods for a more compact syntax**[/SIZE]  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
**OCVHelper class is specific to jOpenCV**, and has been added to allow a more compact syntax in those cases where input params can be created in-place instead of declaring and initializing them in advance  
  
It contains several static constructors for the most used basic classes (OCMat, OCVPoint, OCVRect, OCVScalar,….)  
  
It only needs to be declared in the module's globals, and can be directly used.  

```B4X
Sub Process_Globals  
Dim OCV as OCVHelper  
End Sub
```

  
  
Examples  
[SPOILER=Create a OCVMat object with 2 rows, 4 columns and 3 planes]  
With 'classic syntax'  

```B4X
    Dim myMat as OCVMat  
    Dim myScalar3 as OCVScalar  
    myScalar3.initialize3( 100, 150, 200)  
    myMat.initialize3( 2, 3, mType.CV_8UC3, myScalar3)
```

  
[/SPOILER]  
  
With Helper methods  

```B4X
    Dim myMat as OCVMat = OCV.Mat.Create4(2, 4, mType.CV_8uC3, OCV.Scalar.Create3(100, 150, 200) )
```

  
[/SPOILER]  
  
[SPOILER= Sum 2 Points]  
With classic syntax  

```B4X
Dim myPoint1, myPoint2 as OCVPoint  
myPoint1.initialize( 1, 2 )  
myPoint2.initialize( 3, 4 )  
Dim myPoint3 as OCVPoint = mCore.addPoints( myPoint1, myPoint2)
```

  
With Helper methods:  

```B4X
       Dim myPoint3 as OCVPoint = mCore.addPoints( OCV.Point.Create( 1, 2 ), OCV.Point.Create( 3, 4 ) )
```

  
[/SPOILER]  
  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
[SIZE=5]**Part 3. OpenCV basic objects**[/SIZE]  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
The most common (j)OpenCV objects, which are commonly used by most of the other classes, are included in the Core module.  
  
**[SIZE=5]OCVMat[/SIZE]**  
Think of OCVMat (Mat) as a bidimensional array of any type of object, where you can place nearly everything, and directly perform all kind of manipulations and give it to other class methods so that they can work on it.  
  
**Understanding and feeling comfortable with OCVMats is the key to understand how OpenCV works.**  
  
The most basic usage of an OCVMat is to contain a frame (picture) pixels, in one plane (gray), 3 (RGB or others), or 4 (RGBA, for instance), but it can be in any color space. And, the most important, it doesn't need to contain an image. Sometimes they can be points, or just statistics.  
  
An OCVMat is basically defined by: the number of rows, cols and type (number of planes, and if each one is a byte, an int, a float, …)  
  
We can declare a Mat 4-row, 5-col Mat with 3-planes of unsigned chars  

```B4X
Dim myMat as OCVMat  
myMat.initialize(4, 5, mType.CV_8UC3)  
Log ( myMat.toString )                               ' <– get dimensions (rows, cols) and type of a given OCVMat  
Log (myMat.dump)                                    ' <– get all the contents of a OCVMat  
  
Dim mScalar as OCVScalar  
mScalar.initialize3( 50, 100, 150)  
myMat.setTo( mScalar )  
  
Dim myMat as OCVMat = OCV.CreateMat2(4, 5, mType.CV_8UC3, OCV.CreateScalar3(50, 100, 150) )
```

  
  
Most of the operations that can be performed with OCVMats belong to the same OCVMat class, OCVImgProc, or OCVCore  

```B4X
' Will perform a conversion from RGB to GRAY, and put the result in the same Mat.  
' The method will itself change its type and content  
mImgProc.cvtColor1( myMat, myMat, mImgProc.COLOR_RGB2GRAY )  
  
' Let's check now its Type. We'll see that now we only have 1 channel.  
Log( myMat.toString )  
  
' Dump Mat content. Useful for small mats.  
Log( myMat.dump )  
  
End Sub
```

  
  
It has several derived classes with some specific methods, such as OCVMathOfByte, OCVMatOfFLoat, OCVMatOfPoint, …..  
  
**[SIZE=5]OCVScalar[/SIZE]**  
OCVScalar is simply a 1-D to 4-D vector. It is just a container that is used quite often in OpencV.  
For instance, if a class method expects a 3-component color as one of its input parameters, we simply define a OCVScalar to encapsulate this.  
  

```B4X
   Dim myScalar as OCVScalar  
   myScalar.initialize3(30,40,50)  
   '…or, alternatively  
   Dim myScalar as OCVScalar = OCV.Scalar.create3(30,40,50)
```

  
  
**[SIZE=5]OCVRect[/SIZE]**  
Object defining a rectangle. Also frequently used to define ROIs (Regions of Interest) in a, OCVMat object  
  

```B4X
Dim myRect as OCVRect = OCV.Rect.create(10, 10, 20, 30)
```

  
  
**[SIZE=5]OCVSize[/SIZE]**  
2-dimensional vector that holds a pair of int values defining a [width, height] size  
  
**[SIZE=5]OCVPoint[/SIZE]**  
2-dimensional vector that holds a pair of float values defining a [x, y] 2D-point
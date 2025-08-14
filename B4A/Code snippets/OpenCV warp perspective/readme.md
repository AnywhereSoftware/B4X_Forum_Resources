### OpenCV warp perspective by jkhazraji
### 06/06/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167316/)

As I 've been searching for OpenCV in the web, I found an interesting tutorial (in Python) about the things OpenCV can do. One of them is warp perspective It took only 10 lines in Python to display the effect but in b4a OpenCV approach the logic is different.  

```B4X
import cv2  
import numpy as np  
img=cv2.imread("Resources/cards.png")  
width, height = 250,350  
pts1=np.float32([[50,99],[135,84],[71,222],[163,205]])  
pts2=np.float32([[0,0],[width,0],[0,height],[width,height]])  
matrix=cv2.getPerspectiveTransform(pts1, pts2)  
imgOutput=cv2.warpPerspective(img, matrix, (width,height))  
cv2.imshow("Cards",imgOutput)  
 cv2.waitKey(0)
```

  
Translating this code into b4a is a hard work:  
b4a code:  

```B4X
Sub Process_Globals  
     
    Dim srcBitmap,dstBitmap As Bitmap  
    Dim srcMat,matrix,dstMat As OCVMat  
    Dim pts_src,pts_dst As OCVMatOfPoint2f 'clockwise from top left.  
    Dim mCore As OCVCore  
    Dim mUtils As OCVUtils  
    Dim mImgProc As OCVImgproc  
    Dim mCvType As OCVCvType  
    Dim src_points(4), dst_points(4) As OCVPoint  
End Sub  
.  
.  
.  
  
Activity.LoadLayout("Layout")  
    
    ' Load source image  
    srcBitmap.Initialize(File.DirAssets, "cards2.png")  
    Dim ivSrc As ImageView  
    ivSrc.Initialize("ivSrc")  
    ivSrc.Bitmap=srcBitmap  
    Activity.AddView(ivSrc, 0%x, 0%y, 100%x, 60%y)  
        ' Convert bitmap to Mat  
    srcMat.Initialize2(srcBitmap.Width, srcBitmap.Height, mCvType.CV_8UC4)  
    mUtils.bitmapToMat(srcBitmap, srcMat,False)  
    
    src_points(0).Initialize(200, 46)    ' top-left  
    src_points(1).Initialize(325, 138)   ' top-right  
    src_points(2).Initialize(200, 313)  ' bottom-right  
    src_points(3).Initialize(74, 222)   ' bottom-left  
    
    pts_src.Initialize()  
    pts_src.fromArray(src_points)  
    
    ' Define destination points (same order as source points)  
    Dim wid As Double = 500  
    Dim hite As Double = 700  
    
    Dim dst_points(4) As OCVPoint  
    dst_points(0).Initialize(0, 0)          ' top-left  
    dst_points(1).Initialize(wid, 0)        ' top-right  
    dst_points(2).Initialize(wid, hite)      ' bottom-right  
    dst_points(3).Initialize(0, hite)        ' bottom-left  
    
    pts_dst.Initialize()  
    pts_dst.fromArray(dst_points)  
    
    ' Get perspective transform matrix  
    matrix = mImgProc.getPerspectiveTransform(pts_src, pts_dst)  
    
    ' Create destination Mat  
    dstMat.Initialize()  
    Dim size As OCVSize  
    size.Initialize(src_points(0))  
    size.width= wid  
    size.height= hite  
    ' Apply perspective warp  
    mImgProc.warpPerspective2(srcMat, dstMat, matrix, size)  
    
    ' Convert result back to bitmap  
    dstBitmap.InitializeMutable(wid, hite)  
    mUtils.matToBitmap(dstMat, dstBitmap, False)  
    
    ' Display the result  
    Dim iv As ImageView  
    iv.Initialize("iv")  
    Activity.AddView(iv, 0, 30%y, 100%x, 95%y)  
    iv.Bitmap = dstBitmap  
    
    ' Clean up (important for memory management)  
    pts_src.release()  
    pts_dst.release()  
    matrix.release()
```

  
  
![](https://www.b4x.com/android/forum/attachments/164606)
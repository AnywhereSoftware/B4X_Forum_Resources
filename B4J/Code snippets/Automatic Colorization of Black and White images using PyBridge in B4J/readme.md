### Automatic Colorization of Black and White images using PyBridge in B4J by jkhazraji
### 02/18/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165666/)

The libraries OpenCV, DNN, and Caffe were used in the Python code.  
You need to download 3 files.  

1. **colorization\_release\_v2.caffemodel**: the pre-trained model.
2. **colorization\_deploy\_v2.prototxt**:
3. **pts\_in\_hull.npy.**

**Edit: from** [**here**](https://github.com/dath1s/colorizor/tree/main)  
Place them in any folder ( E:/PyColorize in this example)  
Make two folder one for the BW images(test\_samples) and one for the output colored images (output\_images) in the same folder.  
Both the BW and colored images will be shown by Python GUI as the image is colored.  
![](https://www.b4x.com/android/forum/attachments/161814)![](https://www.b4x.com/android/forum/attachments/161815)  
The code:  

```B4X
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests  
  
'Ctrl + click to open Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Public Py As PyBridge  
End Sub  
  
Public Sub Initialize  
     
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Py.Initialize(Me, "Py")  
    Dim opt As PyOptions = Py.CreateOptions(File.Combine(File.DirApp, "Python/python/python.exe"))  
    Py.Start(opt)  
    Wait For Py_Connected (Success As Boolean)  
    If Success = False Then  
        LogError("Failed to start Python process.")  
        Return  
    End If  
     
    Py.RunNoArgsCode(ColorizePy)  
End Sub  
  
Private Sub B4XPage_Background  
    Py.KillProcess  
End Sub  
  
Private Sub Py_Disconnected  
    Log("PyBridge disconnected")  
End Sub  
  
Private Sub ColorizePy() As String  
    Dim Code As String =$"  
import numpy as np  
import matplotlib.pyplot as plt  
import cv2  
  
# Name of testing image  
image = 'scene.png'  
  
# Path of our caffemodel, prototxt, and numpy files  
prototxt = "E:/ColorizePy/colorization_deploy_v2.prototxt"  
caffe_model = "E:/ColorizePy/colorization_release_v2.caffemodel"  
pts_npy = "E:/ColorizePy/pts_in_hull.npy"  
  
test_image =  "E:/ColorizePy/test_samples/"+image  
  
# Loading our model  
net = cv2.dnn.readNetFromCaffe(prototxt, caffe_model)  
pts = np.load(pts_npy)  
   
layer1 = net.getLayerId("class8_ab")  
print(layer1)  
layer2 = net.getLayerId("conv8_313_rh")  
print(layer2)  
pts = pts.transpose().reshape(2, 313, 1, 1)  
net.getLayer(layer1).blobs = [pts.astype("float32")]  
net.getLayer(layer2).blobs = [np.full([1, 313], 2.606, dtype="float32")]  
  
# Converting the image into RGB and plotting it  
# Read image from the path  
test_image = cv2.imread(test_image)  
# Convert image into gray scale  
test_image = cv2.cvtColor(test_image, cv2.COLOR_BGR2GRAY)  
# Convert image from gray scale to RGB format  
test_image = cv2.cvtColor(test_image, cv2.COLOR_GRAY2RGB)  
# Check image using matplotlib  
plt.imshow(test_image)  
plt.show()  
  
# Converting the RGB image into LAB format  
# Normalizing the image  
normalized = test_image.astype("float32") / 255.0  
# Converting the image into LAB  
lab_image = cv2.cvtColor(normalized, cv2.COLOR_RGB2LAB)  
# Resizing the image  
resized = cv2.resize(lab_image, (224, 224))  
# Extracting the value of L for LAB image  
L = cv2.split(resized)[0]  
L -= 50   # OR we can write L = L - 50  
  
# Predicting a and b values  
# Setting input  
net.setInput(cv2.dnn.blobFromImage(L))  
# Finding the values of 'a' and 'b'  
ab = net.forward()[0, :, :, :].transpose((1, 2, 0))  
# Resizing  
ab = cv2.resize(ab, (test_image.shape[1], test_image.shape[0]))  
  
# Combining L, a, and b channels  
L = cv2.split(lab_image)[0]  
# Combining L,a,b  
LAB_colored = np.concatenate((L[:, :, np.newaxis], ab), axis=2)  
# Checking the LAB image  
plt.imshow(LAB_colored)  
#plt.title('LAB image')  
#plt.show()  
  
## Converting LAB image to RGB  
RGB_colored = cv2.cvtColor(LAB_colored,cv2.COLOR_LAB2RGB)  
# Limits the values in array  
RGB_colored = np.clip(RGB_colored, 0, 1)  
# Changing the pixel intensity back to [0,255],as we did scaling during pre-processing and converted the pixel intensity to [0,1]  
RGB_colored = (255 * RGB_colored).astype("uint8")  
# Checking the image  
plt.imshow(RGB_colored)  
plt.title('Colored Image')  
plt.show()  
  
# Saving the colored image  
# Converting RGB to BGR  
RGB_BGR = cv2.cvtColor(RGB_colored, cv2.COLOR_RGB2BGR)  
# Saving the image in desired path  
cv2.imwrite("E:/ColorizePy/output_images/"+image, RGB_BGR)  
"$  
    Return Code  
End Sub
```
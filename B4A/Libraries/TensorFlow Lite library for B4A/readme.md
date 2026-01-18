### TensorFlow Lite library for B4A by Deliang
### 01/13/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170010/)

I’d like to share a TensorFlow Lite library for B4A, based on version 2.16.1. Most of the APIs have been wrapped with their original names for consistency, and pointers have been converted to the long data type to ensure compatibility with B4A.  
  
tensorFlowLite.jar <https://ranoz.gg/file/Z0bShbqB>  
  
Usage example:  
  

```B4X
    Dim tfl As tensorFlowLite  
    Log("TfLiteVersion=" & tfl.TfLiteVersion)  
    Log("TfLiteExtensionApisVersion=" & tfl.TfLiteExtensionApisVersion)  
    Dim modelptr1 As Long  
    modelptr1 = tfl.TfLiteModelCreateFromFile("/storage/emulated/0/train/yolo11n_float16.tflite")  
    Dim options1 As Long  
    options1 = tfl.TfLiteInterpreterOptionsCreate  
    Dim numThreads As Int  
    numThreads = 4  
    tfl.TfLiteInterpreterOptionsSetNumThreads(options1, numThreads)  
    tfl.TfLiteInterpreterOptionsSetUseNNAPI(options1, True)  
    Dim interpreter1 As Long  
    interpreter1 = tfl.TfLiteInterpreterCreate(modelptr1,options1)  
    tfl.TfLiteInterpreterOptionsDelete(options1)  
    tfl.TfLiteSetAllowBufferHandleOutput(interpreter1,True)  
    Dim inputdim() As Int  
    inputdim = Array As Int(1,640,640,3)  
    If  tfl.TfLiteInterpreterResizeInputTensor(interpreter1, 0, inputdim, inputdim.Length) <> 0 Then  
        tfl.TfLiteInterpreterDelete(interpreter1)  
        tfl.TfLiteModelDelete(modelptr1)  
        interpreter1 = 0  
    Else  
        If tfl.TfLiteInterpreterAllocateTensors(interpreter1) <> 0 Then  
            tfl.TfLiteInterpreterDelete(interpreter1)  
            tfl.TfLiteModelDelete(modelptr1)  
            interpreter1 = 0  
        End If  
    End If  
    Wait For(cam.FocusAndTakePicture(MyTaskIndex)) Complete (Data() As Byte)  
    Dim bmp As Bitmap = cam.DataToBitmap(Data)  
    Dim bitmap2 As Bitmap  
    bitmap2 = bmp.Resize(640,640,False)  
  
    For i = 0 To 640*640 - 1  
        Dim row,col As Int  
        row = i / 640  
        col = i Mod 640  
        Dim pixint(1) As Int  
        pixint(0) = bitmap2.GetPixel(col,row)  
  
        Dim argb As Int = pixint(0)  
        Dim r As Int = Bit.And(Bit.ShiftRight(argb, 16), 0xFF)  
        Dim g As Int = Bit.And(Bit.ShiftRight(argb, 8), 0xFF)  
        Dim b As Int = Bit.And(argb, 0xFF)  
        inputdata(i*3)= r / 255  
        inputdata(i*3+1)=g / 255  
        inputdata(i*3+2)=b / 255  
    Next  
    bmp = Null  
    bitmap2 = Null  
    Dim inputTensor As Long  
    inputTensor = tfl.TfLiteInterpreterGetInputTensor(interpreter1,0)  
    tfl.TfLiteTensorCopyFromBuffer(inputTensor,inputdata,640 * 640 * 3 * 4)  
    tfl.TfLiteInterpreterInvoke(interpreter1)  
    Dim outputTensorCount As Int  
    outputTensorCount = tfl.TfLiteInterpreterGetOutputTensorCount(interpreter1)  
    Dim outputTensorIndex As Int  
    For outputTensorIndex = 0 To outputTensorCount-1  
        Dim outputTensor As Long  
        outputTensor = tfl.TfLiteInterpreterGetOutputTensor(interpreter1, outputTensorIndex)  
        Dim tensorByteSize As Int  
        tensorByteSize = tfl.TfLiteTensorByteSize(outputTensor)  
        Dim tensorNativeBufferPtr As Long  
        tensorNativeBufferPtr = tfl.AllocNativeBuffer(tensorByteSize)  
        tfl.TfLiteTensorCopyToBuffer(outputTensor,tensorNativeBufferPtr,tensorByteSize)  
        Dim output_buffer() As Float  
        output_buffer = tfl.TfLiteTensorGetFloatBuffer(tensorNativeBufferPtr,tensorByteSize)  
        'process tensor data  
        tfl.FreeNativeBuffer(tensorNativeBufferPtr)  
    Next
```
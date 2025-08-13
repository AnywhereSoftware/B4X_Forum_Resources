###  SelfieSegmentation with ML Kit by Erel
### 07/18/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/161499/)

![](https://www.b4x.com/android/forum/attachments/154326)  
[SIZE=2]Image source: [https://en.wikipedia.org/wiki/Selfie#/media/File:TWC\_Hokitika\_Gorge\_•\_Stewart\_Nimmo\_•\_MRD\_1.jpg](https://en.wikipedia.org/wiki/Selfie#/media/File:TWC_Hokitika_Gorge_%E2%80%A2_Stewart_Nimmo_%E2%80%A2_MRD_1.jpg)[/SIZE]  
  
A B4A + B4i selfie segmentation feature based on Google ML Kit: <https://developers.google.com/ml-kit/vision/selfie-segmentation>  
The result is a mask image. In the example it is overlayed over the original image using a semitransparent B4XImageView.  
  
Usage itself is quite straightforward. See the example.  
The configuration is a bit cumbersome.  
Please go over the *dependencies* sections in the text recognition tutorial: <https://www.b4x.com/android/forum/threads/b4x-textrecognition-based-on-mlkit.161210/#content>  
  
Don't miss:  
- B4i dependencies + #PlistExtra (for MediaChooser) in Main module.  
- B4i bundle files under Files\Special.  
- B4A dependencies in Main module.  
- B4A manifest editor. Snippets for MLKit and snippet for FileProvider (MediaChooser).
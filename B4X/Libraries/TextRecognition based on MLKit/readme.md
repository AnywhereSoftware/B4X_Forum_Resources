###  TextRecognition based on MLKit by Erel
### 11/23/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/161210/)

This is a B4A + B4i solution. It recognizes text in images based on Google ML Kit.  
  
![](https://www.b4x.com/android/forum/attachments/153853)  
  
  
Dependencies:  
  
- B4i (local Mac only): <https://www.b4x.com/b4i/files/MLKit.zip>  
  
Don't miss:  
  
- B4i dependencies + #PlistExtra (for MediaChooser) in Main module.  
- B4i bundle files under Files\Special. The example includes bundles for Latin and Chinese. Other bundles are available here: <https://www.b4x.com/b4i/files/MLKit_Bundles.zip>  
- B4A dependencies in Main module.  
- B4A manifest editor. 2 snippets for MLKit and one snippet for FileProvider (MediaChooser).  
  
Usage itself is very simple. See the example:  
<https://www.b4x.com/b4i/files/TextRecognition.zip>  
  
**Updates:**  
  
-v1.11: Dependencies in B4i updated to v10+ built-chain. Note that the local Mac dependencies were updated.  
- v1.10:  
Support for non-Latin languages added. There are 5 language models: Latin, Chinese, Devanagari, Japanese, Korean  
Recognizing non-Latin languages requires some configuration:  

- Initialize the recognizer with the correct model.
- B4A: add reference with #AdditionalJar: [plain]com.google.android.gms:play-services-mlkit-text-recognition-chinese[/plain] (replace *chinese* with the relevant lowercased model name).
- B4i: add the bundle of the relevant model: <https://www.b4x.com/b4i/files/MLKit_Bundles.zip>

Note that B4i MLKit package for local mac was updated as well as the #AdditionalLib list.
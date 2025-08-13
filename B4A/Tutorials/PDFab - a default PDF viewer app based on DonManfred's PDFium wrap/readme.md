### PDFab - a default PDF viewer app based on DonManfred's PDFium wrap by walt61
### 10/06/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/155094/)

I wanted a freeware pdf viewer without ads, tracking, data collection, and what have you. Besides, it wasn't obvious (to me at least) how to make an app that would be offered as default to open a certain type of file, especially a PDF. Time for some R&D fun, and here you go.  
  
**Prerequisites**: download these files provided by [USER=42649]@DonManfred[/USER] (thank you very much for those):  
- from <https://www.b4x.com/android/forum/threads/pdfium-pdfview2.102756/> : click the big red link that says 'Download HERE', download the zip (I fetched PDFiumV1.04.zip) and extract its files to your B4A Additional Libraries folder  
- from <https://www.b4x.com/android/forum/threads/android-pdf-viewer-aar-missing.128982/#post-825649> : download the aar file to your B4A Additional Libraries folder  
  
**The icon** was generated with <https://icon.kitchen/> (thank you [USER=44364]@Mashiane[/USER] for your post, that's a brilliant site). You'll find it in the attached 'icon.zip' file; put folder 'icon' inside the project folder.  
  
If you'd copy the code, make sure you  
- have a look at the **Manifest** too as it contains information without which this won't work  
- add the **'#AdditionalRes'** (for the icon) and **'#AdditionalJar'** lines you'll find in the Main module (and probably some other code too :))  
- take into account the PFDium license:  
> Copyright 2017 Bartosz Schiller  
>   
> Licensed under the Apache License, Version 2.0 (the "License");  
> you may not use this file except in compliance with the License.  
> You may obtain a copy of the License at  
>   
> <http://www.apache.org/licenses/LICENSE-2.0>  
>   
> Unless required by applicable law or agreed to in writing, software  
> distributed under the License is distributed on an "AS IS" BASIS,  
> WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
> See the License for the specific language governing permissions and  
> limitations under the License.

  
Tested on a Xiaomi Redmi Note 10, MIUI 14.0.5, Android 12.  
  
Enjoy!
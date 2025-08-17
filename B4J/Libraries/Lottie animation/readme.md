### Lottie animation by jkhazraji
### 11/16/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/164151/)

This is an attempt to bring lottie files to b4j. The .jar and .xml are there to be used. Put them in the additional libraries folder.  
Call from inside b4j (LottieView) as a custom view in the designer then set the path of the lottie file (.json) which is either  
-a local file must be in Objects folder (as travelling.json) or  
-a URL to the online json file as '<https://lottie.host/77b574f0-9dc3-4a9b-9ef0-59733c976fc9/sM7os2UHYj.json>'  
\*The following properties are currently available at design time:  
\***Lottie Path** (string)  
\***Lottie Speed** (Int)  
\***Autoplay** (Boolean)  
The other properties are still fragile.  
There is an example project which includes a [textFlow](https://www.b4x.com/android/forum/threads/class-textflow-similar-to-b4a-b4i-richstring.61237/) class taken from the forum and it can be used to add fun to the lottie display and beautify the UI.
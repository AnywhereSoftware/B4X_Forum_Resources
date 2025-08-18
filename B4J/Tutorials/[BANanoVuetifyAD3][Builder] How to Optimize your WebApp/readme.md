### [BANanoVuetifyAD3][Builder] How to Optimize your WebApp by Mashiane
### 08/05/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/141928/)

Hi  
  
[Download](https://github.com/Mashiane/BVAD3-Builder)  
  
**Please Note: You can run this process even before you develop your webapp so that it only uses the components you will use. In that case, just start on Step 3 below and then choose the components you will use beforehand.**  
  
As we aware, the BVAD3 library is a **large library**, with 184 components in total. All of these components might not be used in your projects. You might just use 5 and not the whole library.  
  
Removing the actual components (this is besides the CSS & JS files) is crucial to ensure that only the modules you need are used. Remember, as this is a BANano library, the b4x code has to be transpiled to JS/HTML/CSS before you get your final package. The B4xcode becomes the JS, HTML and CSS code for your webapp, including the b4xlib code and also your project source code, which is also transpiled to JS/HTML/CSS.  
  
To see how this works, run your project in debug mode and see the generated source code.  
  
BVAD3 has plugins also, but these just form a very small percentage of the overall source code, however, if you do not use any of the plugins, besides removing the JS/CSS not being used, you can now also exclude the underlying B4x code that is unused.  
  
The **BANanoVuetifyAD3 Builder** is the brother to the [BANanoVuetifyAD3 Package Manager](https://www.b4x.com/android/forum/threads/bananovuetifyad3-tree-shaking-your-bvad3-project-with-the-bvad3-package-manager.138417/#content) **but is more flexible.**  
  
So how will this work?  
  
**Preparing the BVAD3 Builder WebApp (Once Off)**  

1. From the GitHub repo in the download link above
2. Unzip the contents of **bvad3builderlip.zip** and run the project. DO NOT Compile to library.
3. Unzip the contents of **BVAD3Builder.zip**, and run the project, this will start the builder.

  
**Preparing your BVAD3 based WebApp (for every app built using BVAD3) that you want to tree-shake.  
  
Step 1:**  
In your project that uses BVAD3, please add  
  

```B4X
log(vuetify.UsageReport)
```

  
  
after Vuetify.Serve. This should be like…  
  
![](https://www.b4x.com/android/forum/attachments/132083)  
  
**Step 2:**  
  

1. Run your application (which is using the full BVAD3 library) and copy the | delimited string appearing in your console in its whole entirety.
2. Press Control+Shift+I to access the developer console of your app. The content to copy might look like this..

  
![](https://www.b4x.com/android/forum/attachments/132084)  
  
This report details the names of all the components that your app is using. This picks up all the components defined in Class/Process Globals. If you have a component that is not defined there but is used by your app, execute Vuetify.Use**ClassName** where class name is the name of that class e.g. BANanoPHP will be Vuetify.UseBANanoPHP.  
  
**Step 3**  
  

1. Run the BVAD3Builder Web Application from a PHP enabled Web Server.
2. Enter the name you wish to use for the new library. Click Next

  
![](https://www.b4x.com/android/forum/attachments/132086)  
  
On Components & PlugIns, paste the content you copied from the browser console. **Ignore this if you are building a lib from scratch to use on your project**  
  
![](https://www.b4x.com/android/forum/attachments/132087)  
Click the Fuse on the right ![](https://www.b4x.com/android/forum/attachments/132090) you will be prompted to comfirm. Choose 'Only Them'. This means only compile a library with these components only and nothing else.  
  
![](https://www.b4x.com/android/forum/attachments/132089)  
  
Continue to add via the switches the components you will use in your project.  
  
When done, go to Build tab and click the green Robot button. ![](https://www.b4x.com/android/forum/attachments/132091) this will compile your library.  
  
When the robot, is done, it will give you a download link, ![](https://www.b4x.com/android/forum/attachments/132092), click this link to download your new b4xlib.  
  
![](https://www.b4x.com/android/forum/attachments/132094)  
  
Unzip the new b4xlib and run the project, DO NOT compile to library. This will generate a new b4xlib.  
  
![](https://www.b4x.com/android/forum/attachments/132097)  
  
No go back to your project, remove the reference to BVAD3 and establish one for your project  
  
![](https://www.b4x.com/android/forum/attachments/132093)  
  
Run your project, it will use the new optimized library.  
  
Happy BVAD3 Library
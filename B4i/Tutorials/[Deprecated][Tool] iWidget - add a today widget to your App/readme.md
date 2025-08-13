### [Deprecated][Tool] iWidget - add a today widget to your App by JanPRO
### 09/18/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/92384/)

**[SIZE=6]Important: This project is deprecated and should no longer be used![/SIZE]**  
  
  
iWidget is a (experimental) tool which allows you to add a [today widget](https://developer.apple.com/ios/human-interface-guidelines/extensions/widgets/) to your B4i app.[SPOILER="iWidget"]![](https://www.b4x.com/android/forum/attachments/67209) [/SPOILER]  
[SPOILER="HelloWorld widget"]![](https://www.b4x.com/android/forum/attachments/67224) [/SPOILER]  
  
**How to use?**  

1. Download iWidget [here](https://bit.ly/2I1KNu1)
2. Close the B4i IDE
3. You need to fill in the following information
[INDENT]

- the path of the B4i installation directory
- the path of the B4i project you want to add the widget to
- the name of your App (corresponds to the *#ApplicationLabel*)
- the package name of your App (corresponds to the *Package* under the Build Configurations)
- a title for the widget
- choose a port for the logger (see the explanation of the logger in the notes section)

[/INDENT]4. Click on the Apply button
5. Open the B4i project
6. Add the attached modules (TodayWidget & WidgetContext) to your project
7. if you use the logger don't forget to set Logger\_Host & Logger\_Port variables
8. Start coding your widget :)

  
**Notes & tips:**  

- start with the attached HelloWorld project, for the first time it's possible that you have to add the widget manually by clicking on the circled edit button
- use a wildcard certificate for your project
- the minimum required iOS version is 10, so add: #MinVersion: 10 to your project attributes
- always keep in mind the consequences of the fact, that a widget is a totally new target. For example the widget can't access values of a variable, which were set in the main app
- the PerformUpdate event is invoked when the widget is loaded and it can also be called in the background. In this sub you need to check whether there is new data available and update your UI. From my experience you should do the same routine also in the Widget\_Appear sub
- I strongly recommend to create the UI with the designer and use anchors
- the normal Log method will be useless for widgets. Instead make use of the Wlog function in the TodayWidget module
- the logger will not catch errors: If your widget returns "Unable to load" there is a mistake in your code, use try-catch blocks to locate the issue. However, if you have a local mac, you can open the generated Xcode project and run the Widget target specifically (in this case you will be able to see the logs added with the normal Log method and also see errors)
- when working on a widget always test in release mode
- everytime you activate or deactivate iWidget you have to restart B4i
- when working on your widget project, keep iWidget open
- administrator rights are required for editing the Xcode template

  

- iWidget was tested with B4i v.4.81 + local mac builder (Xcode 9.2), I don't know whether the hosted builder has restrictions concerning the template file, just try it out ;)

  
Feel free to ask questions ;)
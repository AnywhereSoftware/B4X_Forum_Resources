###  Features that Erel recommends to avoid by Erel
### 12/06/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/133280/)

Many things have changed in B4X and also in the underlying platforms. I will try to list here all kinds of (old) features that have better alternatives.  
B4X is backward compatible so these features still work. The recommendations are more relevant for new projects or when implementing new features.  

1. (B4A) ListView -> xCustomListView:
ListView is difficult to work with and cannot be customized. It is also not cross platform.2. (B4i) TableView -> xCustomListView:
Same as above.3. CustomListView module -> xCustomListView library:
Using the module will break other libraries.4. Sub JobDone -> Wait For (j) JobDone:
[[B4X] OkHttpUtils2 with Wait For](https://www.b4x.com/android/forum/threads/79345/#content)5. Sub Smtp\_MessageSent (and others) -> Wait For …:
<https://www.b4x.com/android/forum/threads/b4x-net-library-ftp-smtp-pop-with-wait-for.84821/#content>6. DoEvents / Msgbox -> [DoEvents deprecated and async dialogs (msgbox)](https://www.b4x.com/android/forum/threads/79578/#content)
7. All kinds of custom dialogs -> B4XDialogs: B4XDialogs are cross platform and are fully customizable:
[[B4X] Share your B4XDialog + templates theming code](https://www.b4x.com/android/forum/threads/131243/#content)8. File.DirDefaultExternal -> RuntimePermissions.GetSafeDirDefaultExternal
Truth is that you shouldn't use both of them and use XUI.DefaultFolder instead.
<https://www.b4x.com/android/forum/threads/67689/#content>9. File.DirRootExternal -> ContentChooser / SaveAs
<https://www.b4x.com/android/forum/threads/132731/#content>10. File.DirInternal / DirCache / DirLibrary / DirTemp / DirData / DirDefaultExternal / GetSafeDirDefaultExternal -> XUI.DefaultFolder
11. Round2 -> NumberFormat, B4XFormatter:
Most usages of Round2 are to format numbers. Modifying the number is not the correct way.12. TextReader / TextWriter with network streams -> AsyncStreams:
Trying to implement network communication on the main thread will always result in bad results.13. TextReader / TextWriter -> File.ReadString / ReadList:
Two exceptions - non-UTF8 files or huge files (more relevant to B4J).14. Activities -> B4XPages:
This is a big change and it is the most important one. It is hard to explain how much simpler things are with B4XPages. The more complex the project the more important it is to use B4XPages. This is also true when building non-cross platform projects. [[B4X] [B4XPages] What exactly does it solve?](https://www.b4x.com/android/forum/threads/119078/#content)15. Platform specific API -> Cross platform API:
This is of course relevant when there is a cross platform API. Some developers have a misconception that the cross platform features have drawbacks compared to the platform specific API.

- Node / Pane / Button / … -> B4XView
- Canvas -> B4XCanvas
- All kinds of platform specific custom views -> cross platform custom views (such as XUI Views).
- EditText / TextField / TextArea / TextView -> B4XFloatTextField
- fx (and others) -> XUI
- MsgboxAsync / Msgbox2Async / (B4i) Msgbox -> XUI.MsgboxAsync / XUI.Msgbox2Async

16. CallSubDelayed to signal a completion of a resumable sub -> As ResumableSub:
[[B4X] Resumable subs that return values (ResumableSub)](https://www.b4x.com/android/forum/threads/82670/#content)17. CallSubDelayed / CallSubPlus to do something a bit later -> Sleep(x):
There are many other useful usages for CallSubDelayed.18. Multiple layout variants -> anchors + designer script:
When Android was first released there were very few screen sizes. This is no longer the case. You should build flexible layouts that fill any screen size. It is easier to do with anchors + designer script. It is difficult to maintain multiple variants.19. Building the layout programmatically -> using the designer when possible:
If you are only developing with B4A then building the layout programmatically is a mistake but not a huge one.
B4J and B4i handle screen resizes differently and it is much more difficult to handle the changes programmatically (there is video tutorial about it).
Most custom views can only be added with the designer (there are workarounds that allow adding them programmatically).
It is very simple to copy and paste designer layouts between different platforms and projects.20. Multiline strings with concatenation -> smart strings:
[[B4X] Smart String Literal](https://www.b4x.com/android/forum/threads/50135/#content)21. (SQL) Cursor -> ResultSet:
ResultSet is cross platform and is also a bit simpler to use.22. ExecQuery (non-parameterized queries) -> ExecQuery2:
Making non-parameterized queries is really unacceptable. See point #5 for more information: <https://www.b4x.com/android/forum/threads/b4x-code-smells-common-mistakes-and-other-tips.116651/#content>
It is also true for ExecNonQuery.23. ExecQuerySingleResult when it is possible that there are no results -> ExecQuery2
This is a historic design mistake. Nulls and Strings don't go together. If there is a possibility that ExecQuerySingleResult will return no results (=Null) then don't use it and use ExecQuery2 instead.24. Downloading / making http requests with any other library or source other than OkHttpUtils2 (=iHttpUtils2) -> OkHttpUtils2
OkHttpUtils2 is very powerful and can be extended in many ways, without modifying the source. It is also very simple to use.25. Shared modules folder -> referenced modules
The shared modules feature was useful in the early days of B4X. With the introduction of referenced modules, there is no good reason to use it. Referenced modules cover the same use cases and more.26. VideoView -> ExoPlayer
ExoPlayer is much more powerful and more customizable.27. StartServiceAt / StartServiceAtExact -> StartReceiverAt / [Exact](https://www.b4x.com/android/forum/threads/start-receiver-at-exact-time.148185/#content)
With a few exceptions, it is no longer possible to start services in the background.
Related thread: [[B4X] "Code Smells" - common mistakes and other tips](https://www.b4x.com/android/forum/threads/116651/#content)  
More to come.
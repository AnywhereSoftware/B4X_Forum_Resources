### CodeMirror Javascript Code editor wrapper on Android - A proof of concept by max123
### 07/16/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/160454/)

Hi all,  
  
based on this …  
<https://www.b4x.com/android/forum/threads/codemirror-javascript-code-editor-wrapper-proof-of-concept.124854/#post-779522>  
and this …  
<https://www.b4x.com/android/forum/threads/codemirror-wrapper-and-example.125775/#post-785682>  
  
… and this discussion:  
<https://www.b4x.com/android/forum/threads/codemirror-wrapper-display-issue.159840/>  
  
… this is a proof of concept to port codemirror code editor on Android platform.  
  
I want to thank [USER=9800]@stevel05[/USER] for his very interesting code, without it I probably would never have gotten around to writing this one.  
  
This is a working progress, there are some issues related to the fact that Codemirror 5 fit best on desktop devices vs mobile devices,  
but finally after a long work to adapt the CodeMirrorWrapper to the B4A WebView (that is completely different than B4J WebView),  
it works on Android pretty well.  
  
I completely rearranged the code, removed temporally a designer custom view and removed the library version check that I think is not really needed, actually the code recognize automatically the version by the name of it's folder inside the zip file. If you change with another version by recreate the zip file (5.x and not 6.x) it will recognize automatically the version.  
  
After these changes I've added some new functionalities as explained below.  
  
For now you can use it to just view hightlithed code on any language you want.  
You can even try to write some code and it will be recognized based on language you set, but due to differences from virtual keyboard  
and physical keyboard, and mouse vs touch, there are some issues to solve before it can be used to write code like a normal code editor.  
  
Note, I removed the Codemirror zip file because upload size limitation, please, download codemirror 5.65.16 from here and put to Asset files:  
[Codemirror](https://drive.google.com/file/d/1vle7AvSkw04RqfzHk4zd7lmBaoBmmmK3/view?usp=sharing)  
It contains some modifications, added B4X, B4S languages and more, so do not download it from the web, instead use this one.  
  
Personally I need this because I want to make a small HTML + CSS + JavaScript IDE on Android.  
  
Please, if you like it, **help to fix some issues so we have a working code editor and it can be used to write code and do not to just view it**.  
  
Note. I do not removed any comment in the code, may they can be useful to change something.  
  
I hope you enjoy it.  
Feel free to comment.  
  

---

  
  
Features:  

- Updated the distribution to latest Codemirror 5.65.16
- Support of 162 languages (even B4X syntax with b4x.js provided by [USER=9800]@stevel05[/USER])
- Support of 63 themes, Dark and Light. IHMO some are pretty unusable, but other are very cool, expecially dark themes.
- Support code folding.
- Support auto indentation. Only works on emulator by selecting code to indent (just a selection or a full document) and press the SHIFT + TAB keys.
- Support auto bracket recognition (if you pick on a bracket, quotes etc. the other end will be marked).
- Support auto tag recognition (if you pick on an HTML tag, the other end will be marked).
- Support auto closing brackets.
- Support auto closing tags, eg. if you type <div, when you press the > symbol, the </div> will be automatically printed out, and the cursor remains on center of the open and closed tag. This works for all tags, but actually only works on Android Emulator and only when use PC physical keyboard.
- Support HTML Mixed mode, in a single HTML file it recognizes and show highilights for HTML, CSS, JSON, JavaScript at same time. Note, only HTML show autocomplete.
- Support Lints (auto error recognition with Lint Markers). Show warnings, errors markers and popups for some languages, JavaScript, HTML, JSON, Python and others…
- Support Hints (auto recognition and autocompete for main languages). This no yet works due to keyboard issues to call autocompletion dialog or just complete words.
- I don't know what you may do with this, but it support Emoticons as normal text inside the code editor, probably because they are UTF8.
- Implemented markers for breakpoints, for now use these just to mark some code to best find it when scrolling. In future real breakpoints can be implemented. I think it return a list of lines marked by the user.
- Support selection of current active selected line.
- Implemented the SearchBox with Search, Replace and ReplaceAll, but currently commented due to keyboard issues calling it.

  

---

  
  
Known issues:  

1. The first issue is that it only works on SDK 29 and minor. For some strange reasons on SDK 30, 31, 33 the WebView refuses to load the HTML file saved to DirInternal. (SOLVED)
2. I implemented setters, but getters are no yet implemented, I don't know how to request and wait for JS response without implement getters one by one for any method. For this reason the code is not able to get values back from the editor. For this reason the check for save that compare initial code to the current one to check if save is needed will not work. Any request to get back any value from code editor will not works.
3. The WebView take some time to load the code editor page, not too much, some seconds, but probably this can be optimized to speed up the loading and decrease the overhead.
4. Sometime if error check is set, when load some code, if there are errors, it do not show up Lint Markers, to show all errors and/or warnings we need to force it by placing an error, this time all errors are correctly marked.
5. Android keyboard is inconsistent and won't work, some keyboard functions works on emulator only while use the PC physical keyboard, seem that key are mapped differently.. I tried to change Android GBoard keyboard settings, but none worked. Codemirror 6 is best optimized for mobile devices, but use completely different api.
6. Sometime when type some text, the cursor automatically forward and delete the typed text.
7. When delete some text and arrive to the first character of line, if I press Backspace, I assume it delete a line and cursor move to end of previous line. For some strange reasons this only happen on emulator when using PC physical keyboard and not while use Android virtual keyboard, even not happen on real devices.
8. The editor layout is a bit inconsistent. There are two different contents here, the WebView and the editor inside it. I've leaved the WebView Zoom, it is good to zoom in and out, but when this happen the editor no longer show the full document until the end, so the end of document is truncated. This not happen if I just increase or decrease the font size in the editor, the editor rezize it automatically, but this way the zoom will not work.
9. I use IME library to get the current height of view without the keyboard, it is not perfect, something is wrong. Even the editor should scroll to view a current line, instead I need to scroll manually.
10. When I pick on editor to set a cursor, something strange happen, the editor scroll horizzontally to left unless it reach gutters position. This is not good.
11. Is a bit slow to refresh the code when scrolled.

---

  
  
***Changelog:***  

- ***1.53** Initial release (for Android)*
- ***1.54** Now it works on SDK 33 (see post #2)*
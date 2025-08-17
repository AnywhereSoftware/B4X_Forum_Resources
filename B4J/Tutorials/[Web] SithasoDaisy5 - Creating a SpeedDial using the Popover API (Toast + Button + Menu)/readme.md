### [Web] SithasoDaisy5 - Creating a SpeedDial using the Popover API (Toast + Button + Menu) by Mashiane
### 04/26/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166757/)

Hi Fam  
  
Browsers now are able to use the popover api. You can read more about it from [here](https://developer.mozilla.org/en-US/docs/Web/API/Popover_API). There is no speed dial / FAB component in DaisyUI, so I thought why not create it as an example.  
  
To build a SpeedDial, one needs the SDUI5Toast, SDUI5Button and SDUI5Menu components.  
  
Toast - this is a component that can sit anywhere in your page using a position attribute. This could be top left, top center, bottom left, top right and bottom right.  
Button - this is the main button for our speed dial. This button can be a Floating Action Button if placed inside a toast. We will place this inside the toast  
Menu - we will use this to add the dial buttons. This can be placed anywhere. We will link it to the button by using the popover api settings.  
   
![](https://www.b4x.com/android/forum/attachments/163674)  
  
When executed, this speed dial looks like this..  
  
![](https://www.b4x.com/android/forum/attachments/163675)  
  
We have set the menu to be a popup so that when the button is clicked, it shows the menu. Clicking each button on the menu will fire an event and then close the popup.  
  

```B4X
mainspeed.AddMenuItemIconColor("check", "./assets/plus-solid.svg", "16px", "#473bb0")  
    mainspeed.AddMenuItemIconColor("code", "./assets/code-solid.svg", "16px", "#b1e202")  
    mainspeed.AddMenuItemIconColor("font", "./assets/font-solid.svg", "16px", "#4a471a")  
    mainspeed.AddMenuItemIconColor("gears", "./assets/gears-solid.svg", "16px", "#8b8de0")  
    mainspeed.AddMenuItemIconColor("gifts", "./assets/gifts-solid.svg", "16px", "#fcf67e")
```

  
  
  

```B4X
Private Sub mainspeed_ItemClick (item As String)  
    app.ShowToastInfo(item)  
End Sub
```

  
  
There is no click event for the button because automatically its linked to the menu popup. To link the button to the menu, thus making the menu a popover, we have set the PopOverTarget in the button.  
  
![](https://www.b4x.com/android/forum/attachments/163676)  
  
On the menu, we have set 2 important properties  
  
![](https://www.b4x.com/android/forum/attachments/163677)  
  
This tells the menu that it needs to act as a popover.  
  
I have added this speed-dial example in the Demo  
  
![](https://www.b4x.com/android/forum/attachments/163678)  
  
If we wanted to learn more about the pop-over api, we would look at the code. Lets explore what happened.  
  
The button HTML code includes two important properties. ***style=anchor-name*** *and* ***popovertarget***  
  

```B4X
<button id="btnmain" class="btn btn-circle shadow-lg btn-primary btn-xl inline-flex items-center text-white" data-shadow="lg" data-color="btn-primary" style="anchor-name: –mainspeed_anchor;" data-textcolor="text-white" popovertarget="mainspeed"><span id="btnmain_indicator" class="badge indicator-item hidden badge-error indicator-top indicator-end badge-xs" data-color="badge-error" data-position="indicator-top indicator-end" data-size="badge-xs"></span><span id="btnmain_loading" class="loading-spinner hidden"></span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" id="btnmain_lefticon" style="pointer-events: none; cursor: pointer; width: 50%; height: 50%;" fill="currentColor" data-js="enabled" class="" preserveAspectRatio="xMidYMid meet"><!–!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.–><path d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 144L48 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l144 0 0 144c0 17.7 14.3 32 32 32s32-14.3 32-32l0-144 144 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-144 0 0-144z"></path></svg><img id="btnmain_leftimage" src="" alt="" class="hidden bg-cover bg-center bg-no-repeat"><span id="btnmain_text" class="hidden"></span><svg-renderer id="btnmain_righticon" style="pointer-events:none;" fill="currentColor" data-js="enabled" class="hidden"></svg-renderer><img id="btnmain_rightimage" src="" alt="" class="hidden bg-cover bg-center bg-no-repeat"><div id="btnmain_badge" class="badge rounded-full hidden badge-sm" data-size="badge-sm"></div></button>
```

  
  
In the menu, two important attributes are added ***style=position-anchor*** and ***popover=true***  
  

```B4X
<ul id="mainspeed" class="menu flex-nowrap overflow-y-auto dropdown dropdown-top dropdown-center card card z-1 [&amp;_li>*]:rounded-none menu-vertical" popover="true" style="position-anchor:–mainspeed_anchor;"><li id="check" class="" style=""><a id="check_anchor" class="items-center btn btn-circle btn-md btn-ghost" style="border-radius: 50%;"><input id="check_check" value="check" type="checkbox" class="checkbox hidden checked:bg-success checked:border-success" data-checkedbgcolor="checked:bg-success" data-checkedborder="checked:border-success"><div id="check_avatar" class="avatar hidden"><div id="check_avatar_host"><img id="check_src" src=""></div></div><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" id="check_icon" data-js="enabled" fill="currentColor" class="" data-src="./assets/plus-solid.svg" width="16px" height="16px" style="fill: currentcolor; color: rgb(71, 59, 176); cursor: pointer;"><!–!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.–><path d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 144L48 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l144 0 0 144c0 17.7 14.3 32 32 32s32-14.3 32-32l0-144 144 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-144 0 0-144z"></path></svg><span id="check_text" class="hidden"></span><span id="check_badge" class="badge rounded-full hidden"></span></a></li><li id="code" class="" style=""><a id="code_anchor" class="items-center btn btn-circle btn-md btn-ghost" style="border-radius: 50%;"><input id="code_check" value="code" type="checkbox" class="checkbox hidden checked:bg-success checked:border-success" data-checkedbgcolor="checked:bg-success" data-checkedborder="checked:border-success"><div id="code_avatar" class="avatar hidden"><div id="code_avatar_host"><img id="code_src" src=""></div></div><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" id="code_icon" data-js="enabled" fill="currentColor" class="" data-src="./assets/code-solid.svg" width="16px" height="16px" style="fill: currentcolor; color: rgb(177, 226, 2); cursor: pointer;"><!–!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.–><path d="M392.8 1.2c-17-4.9-34.7 5-39.6 22l-128 448c-4.9 17 5 34.7 22 39.6s34.7-5 39.6-22l128-448c4.9-17-5-34.7-22-39.6zm80.6 120.1c-12.5 12.5-12.5 32.8 0 45.3L562.7 256l-89.4 89.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l112-112c12.5-12.5 12.5-32.8 0-45.3l-112-112c-12.5-12.5-32.8-12.5-45.3 0zm-306.7 0c-12.5-12.5-32.8-12.5-45.3 0l-112 112c-12.5 12.5-12.5 32.8 0 45.3l112 112c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256l89.4-89.4c12.5-12.5 12.5-32.8 0-45.3z"></path></svg><span id="code_text" class="hidden"></span><span id="code_badge" class="badge rounded-full hidden"></span></a></li><li id="font" class="" style=""><a id="font_anchor" class="items-center btn btn-circle btn-md btn-ghost" style="border-radius: 50%;"><input id="font_check" value="font" type="checkbox" class="checkbox hidden checked:bg-success checked:border-success" data-checkedbgcolor="checked:bg-success" data-checkedborder="checked:border-success"><div id="font_avatar" class="avatar hidden"><div id="font_avatar_host"><img id="font_src" src=""></div></div><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" id="font_icon" data-js="enabled" fill="currentColor" class="" data-src="./assets/font-solid.svg" width="16px" height="16px" style="fill: currentcolor; color: rgb(74, 71, 26); cursor: pointer;"><!–!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.–><path d="M254 52.8C249.3 40.3 237.3 32 224 32s-25.3 8.3-30 20.8L57.8 416 32 416c-17.7 0-32 14.3-32 32s14.3 32 32 32l96 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-1.8 0 18-48 159.6 0 18 48-1.8 0c-17.7 0-32 14.3-32 32s14.3 32 32 32l96 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-25.8 0L254 52.8zM279.8 304l-111.6 0L224 155.1 279.8 304z"></path></svg><span id="font_text" class="hidden"></span><span id="font_badge" class="badge rounded-full hidden"></span></a></li><li id="gears" class="" style=""><a id="gears_anchor" class="items-center btn btn-circle btn-md btn-ghost" style="border-radius: 50%;"><input id="gears_check" value="gears" type="checkbox" class="checkbox hidden checked:bg-success checked:border-success" data-checkedbgcolor="checked:bg-success" data-checkedborder="checked:border-success"><div id="gears_avatar" class="avatar hidden"><div id="gears_avatar_host"><img id="gears_src" src=""></div></div><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" id="gears_icon" data-js="enabled" fill="currentColor" class="" data-src="./assets/gears-solid.svg" width="16px" height="16px" style="fill: currentcolor; color: rgb(139, 141, 224); cursor: pointer;"><!–!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.–><path d="M308.5 135.3c7.1-6.3 9.9-16.2 6.2-25c-2.3-5.3-4.8-10.5-7.6-15.5L304 89.4c-3-5-6.3-9.9-9.8-14.6c-5.7-7.6-15.7-10.1-24.7-7.1l-28.2 9.3c-10.7-8.8-23-16-36.2-20.9L199 27.1c-1.9-9.3-9.1-16.7-18.5-17.8C173.9 8.4 167.2 8 160.4 8l-.7 0c-6.8 0-13.5 .4-20.1 1.2c-9.4 1.1-16.6 8.6-18.5 17.8L115 56.1c-13.3 5-25.5 12.1-36.2 20.9L50.5 67.8c-9-3-19-.5-24.7 7.1c-3.5 4.7-6.8 9.6-9.9 14.6l-3 5.3c-2.8 5-5.3 10.2-7.6 15.6c-3.7 8.7-.9 18.6 6.2 25l22.2 19.8C32.6 161.9 32 168.9 32 176s.6 14.1 1.7 20.9L11.5 216.7c-7.1 6.3-9.9 16.2-6.2 25c2.3 5.3 4.8 10.5 7.6 15.6l3 5.2c3 5.1 6.3 9.9 9.9 14.6c5.7 7.6 15.7 10.1 24.7 7.1l28.2-9.3c10.7 8.8 23 16 36.2 20.9l6.1 29.1c1.9 9.3 9.1 16.7 18.5 17.8c6.7 .8 13.5 1.2 20.4 1.2s13.7-.4 20.4-1.2c9.4-1.1 16.6-8.6 18.5-17.8l6.1-29.1c13.3-5 25.5-12.1 36.2-20.9l28.2 9.3c9 3 19 .5 24.7-7.1c3.5-4.7 6.8-9.5 9.8-14.6l3.1-5.4c2.8-5 5.3-10.2 7.6-15.5c3.7-8.7 .9-18.6-6.2-25l-22.2-19.8c1.1-6.8 1.7-13.8 1.7-20.9s-.6-14.1-1.7-20.9l22.2-19.8zM112 176a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zM504.7 500.5c6.3 7.1 16.2 9.9 25 6.2c5.3-2.3 10.5-4.8 15.5-7.6l5.4-3.1c5-3 9.9-6.3 14.6-9.8c7.6-5.7 10.1-15.7 7.1-24.7l-9.3-28.2c8.8-10.7 16-23 20.9-36.2l29.1-6.1c9.3-1.9 16.7-9.1 17.8-18.5c.8-6.7 1.2-13.5 1.2-20.4s-.4-13.7-1.2-20.4c-1.1-9.4-8.6-16.6-17.8-18.5L583.9 307c-5-13.3-12.1-25.5-20.9-36.2l9.3-28.2c3-9 .5-19-7.1-24.7c-4.7-3.5-9.6-6.8-14.6-9.9l-5.3-3c-5-2.8-10.2-5.3-15.6-7.6c-8.7-3.7-18.6-.9-25 6.2l-19.8 22.2c-6.8-1.1-13.8-1.7-20.9-1.7s-14.1 .6-20.9 1.7l-19.8-22.2c-6.3-7.1-16.2-9.9-25-6.2c-5.3 2.3-10.5 4.8-15.6 7.6l-5.2 3c-5.1 3-9.9 6.3-14.6 9.9c-7.6 5.7-10.1 15.7-7.1 24.7l9.3 28.2c-8.8 10.7-16 23-20.9 36.2L315.1 313c-9.3 1.9-16.7 9.1-17.8 18.5c-.8 6.7-1.2 13.5-1.2 20.4s.4 13.7 1.2 20.4c1.1 9.4 8.6 16.6 17.8 18.5l29.1 6.1c5 13.3 12.1 25.5 20.9 36.2l-9.3 28.2c-3 9-.5 19 7.1 24.7c4.7 3.5 9.5 6.8 14.6 9.8l5.4 3.1c5 2.8 10.2 5.3 15.5 7.6c8.7 3.7 18.6 .9 25-6.2l19.8-22.2c6.8 1.1 13.8 1.7 20.9 1.7s14.1-.6 20.9-1.7l19.8 22.2zM464 304a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"></path></svg><span id="gears_text" class="hidden"></span><span id="gears_badge" class="badge rounded-full hidden"></span></a></li><li id="gifts" class="" style=""><a id="gifts_anchor" class="items-center btn btn-circle btn-md btn-ghost" style="border-radius: 50%;"><input id="gifts_check" value="gifts" type="checkbox" class="checkbox hidden checked:bg-success checked:border-success" data-checkedbgcolor="checked:bg-success" data-checkedborder="checked:border-success"><div id="gifts_avatar" class="avatar hidden"><div id="gifts_avatar_host"><img id="gifts_src" src=""></div></div><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" id="gifts_icon" data-js="enabled" fill="currentColor" class="" data-src="./assets/gifts-solid.svg" width="16px" height="16px" style="fill: currentcolor; color: rgb(252, 246, 126); cursor: pointer;"><!–!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.–><path d="M200.6 32C205 19.5 198.5 5.8 186 1.4S159.8 3.5 155.4 16L144.7 46.2l-9.9-29.8C130.6 3.8 117-3 104.4 1.2S85 19 89.2 31.6l8.3 25-27.4-20c-10.7-7.8-25.7-5.4-33.5 5.3s-5.4 25.7 5.3 33.5L70.2 96 48 96C21.5 96 0 117.5 0 144L0 464c0 26.5 21.5 48 48 48l152.6 0c-5.4-9.4-8.6-20.3-8.6-32l0-224c0-29.9 20.5-55 48.2-62c1.8-31 17.1-58.2 40.1-76.1C271.7 104.7 256.9 96 240 96l-22.2 0 28.3-20.6c10.7-7.8 13.1-22.8 5.3-33.5s-22.8-13.1-33.5-5.3L192.5 55.1 200.6 32zM363.5 185.5L393.1 224 344 224c-13.3 0-24-10.7-24-24c0-13.1 10.8-24 24.2-24c7.6 0 14.7 3.5 19.3 9.5zM272 200c0 8.4 1.4 16.5 4.1 24l-4.1 0c-26.5 0-48 21.5-48 48l0 80 192 0 0-96 32 0 0 96 192 0 0-80c0-26.5-21.5-48-48-48l-4.1 0c2.7-7.5 4.1-15.6 4.1-24c0-39.9-32.5-72-72.2-72c-22.4 0-43.6 10.4-57.3 28.2L432 195.8l-30.5-39.6c-13.7-17.8-35-28.2-57.3-28.2c-39.7 0-72.2 32.1-72.2 72zM224 464c0 26.5 21.5 48 48 48l144 0 0-128-192 0 0 80zm224 48l144 0c26.5 0 48-21.5 48-48l0-80-192 0 0 128zm96-312c0 13.3-10.7 24-24 24l-49.1 0 29.6-38.5c4.6-5.9 11.7-9.5 19.3-9.5c13.4 0 24.2 10.9 24.2 24z"></path></svg><span id="gifts_text" class="hidden"></span><span id="gifts_badge" class="badge rounded-full hidden"></span></a></li></ul>
```
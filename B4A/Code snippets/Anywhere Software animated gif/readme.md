### Anywhere Software animated gif by LucaMs
### 12/27/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/112920/)

It would be a nice thing if you added this animated gif to your apps (better with also a link to B4X.com)  
  
![](https://www.b4x.com/android/forum/attachments/87363)  
  
  
EDIT - See [post #5](https://www.b4x.com/android/forum/threads/anywhere-software-animated-gif.112920/post-704348) - the gif below does not include the Apple logo:  
![](https://i.ibb.co/0Bjx0nq/Anywhere-Software-2.gif)  
  
  
V. 3  
As you can see, the gif above are not "perfect", there are "noises", due to the tool I used to create them "capturing" the screen part (b4j form), LICEcap.  
For this new version I used this new library (author: [USER=75340]@Blueforcer[/USER]):  
[Animated GIF encoder](https://www.b4x.com/android/forum/threads/animated-gif-encoder.107808/post-674064)  
  
and this is the result, without dirt, as you can see:  
![](https://i.ibb.co/HdpN7Mc/Anywhere-Software-3.gif)  
  
(the texts animation is different, I know, and maybe the first kind is nicer; for the moment I have had to do it this way.  
I have to check but this version is "heavier", 1,503,506 bytes). [SIZE=4]EDIT: Yes, this is four times heavier. I could use an optimization tool, I don't know how much you could save. [/SIZE]  
  
The real purpose of this new version was to test that very useful new library :). In addition, I had to change the method, in order to use the Views Snapshot method (now a panel contains all the ImageViews involved in the animation; before they, the text ones, scrolled on the Form)  
  
  
EDIT: Evidently I had already solved the "dirt" problem and I didn't remember it (or now my eyes are tired and I don't see it ?)  
  
[SIZE=3]NOTE: as you know, I am not a "staff member", not an "Anywhere Software" employee.[/SIZE]  
  
EDIT: at [USER=29385]@Beja[/USER]'s request, [SIZE=4]attached a builder project, BuildAnywsfGif.zip, which I hope is what I actually used for the first animation ?. Remeber that it only shows the animation; to create the animated gif I used LICEcap.[/SIZE]  
  
[SIZE=4]EDIT: Attached the builder project (BuildAnywsfGifEnc.zip), which uses this[/SIZE] [[SIZE=4]animated gif encoder library[/SIZE]](https://www.b4x.com/android/forum/threads/animated-gif-encoder.107808/post-674064) [SIZE=4]to create the animated gif.[/SIZE]
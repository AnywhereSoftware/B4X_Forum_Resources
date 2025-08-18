### B4XTable Column Resizing... (works for me) by Magma
### 07/08/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/139342/)

Hi there…  
  
Well many of us need/asking column resizing… but noone do the start… well I ve decided to start… but hey… need help.. I think is a good start… need a lot of fixes and your ideas…  
  
I am uploading an example - and give you my notes here…  
  
*What works….*  
- Resizing Columns… smooth (**in Release mode**)  
- Works only with columns had set their width, no auto-resize !!! Caution.  
- When Resizing form works ok…  
- Double-Click guideline hide column (width 1pixel)… double click again… restore width !!!  
  
*What not works…*  
- No with autoresizing columns / auto-width  
- No for the moment with changed order columns  
- When using scrollbar loosing the coordinates - you must go back…  
 (no b4xtable scrollbar event to check, a fix you can do is using timer and call every 500ms the enableresize, didn;t try it but i think will work)  
Thanks to LucaMs !! … :) fixed that too  
  
*What not tried…*  
- At B4A, B4I… please check them  
  
My programming mistakes..  
- Can't understand so good the b4xview and adding at root new items… so **removefromview** has errors… please fix it and tell me the way…  
Erel told me the way ! :)  
  
*Here a Video to see - how works… old-video now all working !*  
  
[MEDIA=youtube]3Jh0G71RFDg[/MEDIA]  
  
Is totally open-source - and ofcourse you can always donate me and B4X too.. Please share your code too… to make b4xtable stronger !  
  
Credits to: Erel, LucaMs, Mahares, aeric…  
  
⭐ [You can donate me (buy me a coffee, drink, etc) If you think I've helped you...](https://www.paypal.com/donate/?hosted_button_id=WX7LZ94QEY6UC)
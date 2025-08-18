### Creating Jigsaw Puzzles (B4XPages) by Marvel
### 12/28/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/137165/)

This is a very crude version of the code I'm using in a project to create a jigsaw puzzle. What it basically does is cut square images into jigsaw pieces. It's not very cleaned up, but feel free to use and extend as you want.  
  
![](https://www.b4x.com/android/forum/attachments/123515) ![](https://www.b4x.com/android/forum/attachments/123514)  
  
**What you can do with this code:**  

- Specify the puzzle row/column size. i.e if you specify a puzzle size of 7, it breaks the image into a 49 piece jigsaw puzzle (7 x 7)
- Cuts square images into jigsaw-shaped pieces
- Dynamically decides the edge shape of each piece. i.e no two generated puzzles will be the same
- Allows dragging of pieces but does not confirm placement. The information for the final position of each piece is saved, so it should not be difficult to confirm and lock the placement of pieces
- Can save each piece as an image *(this part is commented out in the code)*
- Can show the safe zone of each jigsaw piece. *i.e where other pieces cannot overlap. Because of the way jigsaw pieces are interlocked, each piece needs to overlap with neighbouring pieces*
- Tested it with 100x100 and it works. *I don't imagine anybody wants to solve a 10,000 piece puzzle though : ) at least not on a phone or computer*
- Can easily use with B4A too

  
**You won't be able to do these:**  

- Properly break down images that are not square. I did not incorporate that. The code will still work though but the image will be squished
- Create puzzles that are not square i.e you can only create 2x2, 3x3, 4x4…20x20 but not 2x4, 4x10 etc
- Change jigsaw shape. *Technically you can, if you edit the shape coordinates in the JigsawShape class, but I assume it will cause you some problems.*

  
**NOTE:** Download the jigsaw image here and place them in the files folder [Download images](https://drive.google.com/drive/folders/1R3KLTQ-qLH0k3ujpX_Ma1NooU_uxBqm3?usp=sharing), Of course, you can use your own images.  
  
  
Shoutout to [USER=27471]@ilan[/USER] I made use of some of the drag and drop codes he uses in his projects.
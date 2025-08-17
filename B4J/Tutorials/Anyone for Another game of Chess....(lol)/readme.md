### Anyone for Another game of Chess....(lol) by Johan Schoeman
### 03/29/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/147114/)

Just for the fun of it - I like to see what the UI of some Java projects looks like and how it reacts when in use. The easiest way (at least for me) is to kick start it via a simple B4J project making use of JavaObject once I have the Jar available.  
  
It is based on [**this Github posting**](https://github.com/alv31415/My-Chess). Have compiled the code of the Github project into a jar (attached) making use of Simple Library Compiler. Attached the following:  
1. b4jMyChess.zip - the B4J sample project. Note that it purely kick-starts the GUIBoard.java class inside the attached JAR.  
2. MyChess,jar - copy it to your additional library folder  
3. ChessPieces.zip - it has the images of the chess pieces.  
  
So, do the following:  
1. Download and copy MyChess.jar to your additional library folder  
2. Extract the B4J sample project to a folder (mine is called b4jMyChess)  
3. Run the B4J project (we need a Objects folder to be created by the B4J project when it is run the first time) - you should hopefully see a chess board but with no chess pieces  
4. Extract the images from ChessPieces.zip and copy them to the B4J Objects folder (see 3 above)  
5. Run the B4J project again - You should now see a chess board that is populated by the chess pieces (black and white)  
  
Play chess!  
  
From the Github posting - read this to understand how to move chess pieces:  
  
***Handling movements  
To make a move, the user needs to select a piece, and then select a destination square. I created a flag that would allow me to check whether the user has clicked twice, as this would represent a move. When the user clicks a square (JButton), I looped through the array of JButtons until I found the JButton that had been clicked. I then turned this information into a Coordinate, which then allowed me to find the Piece occupying the square. This then made it so the squares corresponding to the potential moves of the piece got illuminated. It also set the flag to true. Once there was a second click the program checked to see if the selected square corresponded to one of the potential moves of the piece. If so, the move was executed and the board was updated, resetting the flag. Otherwise, the potential moves of the selected piece would be shown.***  
  
![](https://www.b4x.com/android/forum/attachments/140723)
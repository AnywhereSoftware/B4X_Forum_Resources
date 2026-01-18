### jDragAndDrop2 - Drag and Drop by stevel05
### 01/11/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/76168/)

This library is an update to Andrews jDragandDrop to take advantage of the DragBorad.DragView available in JavaFX8. This allows displaying a graphic next to or behind the mouse cursor while dragging items.  
  
It's not quite a drop in replacement, but I tried to make it as close as possible.  
  
The differences are:  

1. The DragAndDrop class needs to be initialized with the Callback module.
2. The Transfer Mode does not support strings, it needs to be a TransferMode array, which are available as variables from the TransferMode static class.
3. The e.AcceptTransferMode call has changed to e.AcceptTransferModes.
4. There are two additional SetDragModeAndData methods to cater for setting the DragView.
5. I have exposed most of the Dragboard methods which make it easier to select the data you want to accept, and get the results from the dragboard, and most of the DragEvent methods. Existing code should work as is.
6. If you use sender to get the current EventSource (as opposed to the GestureSource) you will need to change it from sender to e.GetEventSource

The demo shows drag and drop from within the app, and from outside it for text and images.  
  
Issues:  
[INDENT]The only issue I found, and it may be a 'feature'. Is that if an image is being dragged, a copy of that image is used in place of whatever is set in the dragview. I would have preferred to be able to set a thumbnail, but it doesn't appear to work like that.[/INDENT]  
  
It's written as 4 code modules, you can compile it to a library if you prefer.  
Please let me know if you find any problems with it.  
  
Enjoy.  
  
Update v1.2 - Changed global variable Initialized to IInitialized to avoid issues with B4x V10.2 Beta. There is now only a B4xlib version.
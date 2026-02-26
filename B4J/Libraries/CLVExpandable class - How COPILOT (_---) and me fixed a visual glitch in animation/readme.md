### CLVExpandable class - How COPILOT (<---) and me fixed a visual glitch in animation by LucaMs
### 02/22/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170390/)

Related to: <https://www.b4x.com/android/forum/threads/b4x-clvexpandable-allows-expanding-or-collapsing-xcustomlistview-items.106148/>  
  
  
*[SIZE=5][Explanation created by Copilot][/SIZE]*  
  
  
**[SIZE=5]1. Description of the visual defect[/SIZE]**  
  
The original CLVExpandable implementation produced a noticeable visual glitch during expand/collapse animations. The issue appeared **only when the combined height of all item headers above the expanding item was smaller than the expanded panel height**.  
  
  
During the expand/collapse animation, the items above the expanding one visibly moved downward, but the expanded panel underneath them was already fully drawn. This created a double‑layer effect where the upper items appeared to slide over a panel that was already expanded.  
This created a “scrolling overlay” effect where the upper items appeared to move or float over the animated item, breaking the visual continuity of the list.  
  
The root cause was that the animation temporarily removed the item’s content from the CLV structure and animated a separate panel, causing the CustomListView to lose synchronization between:  

- the animated panel
- the actual CLV item height
- the scroll offset
- the internal layout of the list

This desynchronization became visible only when the expanding item was taller than the visible header stack above it.  
  
  
**[SIZE=5]2. Technical fix (new approach)[/SIZE]**  
  
The fix replaces the entire expand/collapse mechanism with a simpler and fully synchronized animation model.  
  
[HEADING=2]**[SIZE=4]Original approach (problematic)[/SIZE]**[/HEADING]  
The original class:  

1. created a temporary panel
2. moved all child views into it
3. animated that temporary panel
4. waited for the animation to finish
5. moved the views back into the original panel

This caused:  

- flickering
- layout jumps
- incorrect scroll offsets
- CLV not updating item layout during the animation
- the “headers sliding over the expanding item” effect

[HEADING=2]**[SIZE=4]New approach (stable and correct)[/SIZE]**[/HEADING]  
The fixed version removes the temporary panel entirely and animates the **real** item panel in place.  
  
Key changes:  
  
[HEADING=3]**✔ No more panel swapping**[/HEADING]  
All child views remain inside the original item panel. Nothing is moved in or out of the CLV structure.  
[HEADING=3]**✔ Parallel animation of both heights**[/HEADING]  
The animation updates:  

- the CLV item height (ResizeItem)
- the inner panel height (SetLayoutAnimated)

**at the same time**, ensuring perfect synchronization.  
  
[HEADING=3]**✔ Correct order for expand vs collapse**[/HEADING]  
To avoid clipping:  

- collapse: shrink inner panel first, then CLV item
- expand: enlarge CLV item first, then inner panel

This ensures the content is always visible and stable during the animation.  
  
[HEADING=3]**✔ No Sleep, no ScrollViewInnerPanel manipulation**[/HEADING]  
The animation is now deterministic and free of timing issues.  
  
[HEADING=1]**Result**[/HEADING]  
The new implementation:  

- keeps the CLV layout consistent at all times
- prevents headers from visually sliding over the expanding item
- eliminates flicker and jumps
- produces a smooth, stable expand/collapse animation
- is simpler, safer, and easier to port to B4A and B4i
### HTMLEditor Page Break/Paragraph Handling by Heuristx
### 12/13/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/136800/)

The HTMLEditor can be a useful component, but it has some annoying limitations and one behavioural problem that would be a deal-breaker if it could not be fixed.  
And that is the handling of line breaks.  
Try it out: if you start a new paragraph(or insert one between two existing lines) by pressing the Enter key, the editor will insert TWO blank lines. To add insult to injury, when you press the arrow up or some other keys while in the added blank line, the editor will add a THIRD blank line. This makes an annoying problem downright idiotic.  
  
This does not just happen with the JavaFX HTMLEditor; many HTML editors behave in a strange way with line breaks.  
The cause, I suspect, is the clumsy handling of block tags like <div …> … </div> and <p …> … </p>.  
  
Since the HTMLEditor has very few methods, one would be tempted to manipulate the .HTMLText directly, but then we lose the caret position and selection in the editor, as it exits the Editing mode.  
  
It could be perhaps recovered through the Document of the underlying WebView object, but it is rather messy. Feel free to investigate.  
  
For now, here is a poor man's solution, a somewhat lame fix that is at least simple and almost effortless.  
  
It consists of three steps:  
  
1) Turn off the block-like handling of the <div> and <p> tags in the editor by inserting global style classes in the header of the HTMLEditor's initial HTMLText:  
  
<style type="text/css">div {display: inline;} p {display: inline;}</style>  
  
2) This will, of course, kill the regular way of page break handling, so we must put back some way to make sure we **can** start new paragraphs. I don't know how many ways there are to do this, but it can be done with a Key event filter.  
  
On Key down, when the key pressed is the Enter key, we consume the event, but flag it so we can also consume it in the Keypress and Key up events. That's the job of the global variable CRComing.  
  
On Key up, we paste a CRLF **plus** a space with the AWTRobot. The extra space **after** CRLF is necessary, according to my tests.  
  
3) Almost there, but it introduces one smaller annoyance: now every new paragraph would start with a space. The cheap fix is to simulate an arrow left keypress, so the next character we type   
comes **before** the space, not after. This leaves an extra space hanging at the end of the new paragraph, but it is far easier to live with than with the original problem.  
  
For the whole source code, see the attached project. I tested it with B4J. If you know a better way, let us know, I can imagine there is a much more legitimate and simpler fix, but I know little about HTML generally and the HTMLEditor.
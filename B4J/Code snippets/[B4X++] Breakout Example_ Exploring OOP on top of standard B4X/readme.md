### [B4X++] Breakout Example: Exploring OOP on top of standard B4X by Toky Olivier
### 07/01/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171432/)

[HEADING=2]Hi everyone,[/HEADING]  
  
I would like to share a small example I am currently working on for **B4X++ (<https://github.com/soinalastudio/B4XPP>)**, a proof-of-concept preprocessor / transpiler that adds some OOP-oriented syntax on top of standard B4X.  
  
BTW, new realease here: <https://github.com/soinalastudio/B4XPP/releases/tag/v0.3.5>  
  
The goal is **not** to replace B4J, B4A, B4i or the B4X language. The idea is closer to how TypeScript works with JavaScript: write a slightly richer source syntax, then generate regular B4X code that can still be opened, compiled and debugged with the official B4X IDEs.  
  
For this new example, I created a small but runable **Breakout game in B4J + XUI**.  
  
![](https://www.b4x.com/android/forum/attachments/172137)  
  
The game is intentionally simple, but it demonstrates how OOP can make some projects easier to organize.  
  
[HEADING=2]Why Breakout?[/HEADING]  
Breakout is a good example because it has several natural “objects”:  
  

- a ball
- a paddle
- bricks
- a brick grid
- a score board
- a game controller
- reusable collision / math helpers

In classic B4X, we can of course write all of this in modules and classes manually. But with B4X++, the idea is to make the structure more expressive and reduce repeated boilerplate when building libraries, components or reusable logic.  
  
[HEADING=2]Example class structure[/HEADING]  
The example uses a base class:  
  

```B4X
#Class GameEntity Abstract Implements IRenderable  
  
  
  
#Property X As Float = 0  
  
#Property Y As Float = 0  
  
#Property Width As Float = 10  
  
#Property Height As Float = 10  
  
#Property Color As Int = 0  
  
#Property Visible As Boolean = True
```

  
  
Then specialized classes extend it:  
  

```B4X
#Class Paddle Extends GameEntity Final  
  
  
  
#Class Ball Extends GameEntity Final  
  
  
  
#Class Brick Extends GameEntity Final
```

  
  
This keeps common behavior in one place: position, size, bounds, rendering helpers and rectangle collision logic.  
  
For example, GameEntity contains common methods such as:  
  

```B4X
Public Sub Left As Float  
  
    Return getX  
  
End Sub  
  
  
  
Public Sub Right As Float  
  
    Return getX + getWidth  
  
End Sub  
  
  
  
Public Sub CollidesWithBox(aOtherLeft As Float, aOtherTop As Float, aOtherRight As Float, aOtherBottom As Float) As Boolean  
  
    Return BreakoutMath.Overlaps(Left, Top, Right, Bottom, aOtherLeft, aOtherTop, aOtherRight, aOtherBottom)  
  
End Sub
```

  
  
Then Ball, Paddle and Brick can focus only on their own behavior.  
  
[HEADING=2]Cleaner responsibilities[/HEADING]  
The example is divided like this:  
  
GameEntity  
Common position, size, visibility, rectangle helpers and default rendering.  
  
Paddle  
Mouse-controlled paddle movement.  
  
Ball  
Ball velocity, wall bounce, reset position and rendering as a circle.  
  
Brick  
Brick state, score value and hit logic.  
  
BrickGrid  
Creates and manages all bricks, checks ball/brick collisions.  
  
ScoreBoard  
Score, lives, running state and messages.  
  
BreakoutGame  
Main game orchestration: XUI surface, canvas, update loop, collision checks and drawing.  
  
This is the main advantage I wanted to show: the code becomes easier to reason about because each class has a focused responsibility.  
  
[HEADING=2]Property syntax[/HEADING]  
One thing I found important while building the example is readability.  
  
Instead of writing generated setter calls manually, B4X++ allows source code like:  
  

```B4X
#Constructor(aX As Float, aY As Float, aWidth As Float, aHeight As Float, aColor As Int)  
  
    X = aX  
  
    Y = aY  
  
    Width = aWidth  
  
    Height = aHeight  
  
    Color = aColor  
  
    Visible = True  
  
#End Constructor
```

  
  
The transpiler then generates normal B4X code:  
  

```B4X
setX(aX)  
  
setY(aY)  
  
setWidth(aWidth)  
  
setHeight(aHeight)  
  
setColor(aColor)  
  
setVisible(True)
```

  
  
So the .bx source stays readable, while the generated .bas remains compatible with the B4X IDE.  
  
[HEADING=2]Inheritance, but flattened output[/HEADING]  
B4X++ supports syntax such as:  
  

```B4X
#Class Ball Extends GameEntity Final
```

  
The generated .bas file is flattened, because standard B4X does not have this kind of inheritance between class modules.  
  
That means the final output is still regular B4X code. The inheritance exists at the B4X++ source level, then the transpiler copies / adapts the inherited members into the generated class.  
  
This is especially useful for library authors, where repeated code across several components can become hard to maintain.  
  
[HEADING=2]Override and specialization[/HEADING]  
The base class can define a default renderer:  
  

```B4X
Public Sub Render(aCvs As B4XCanvas)  
  
    If getVisible = False Then Return  
  
    aCvs.DrawRect(EntityRect, getColor, True, 0)  
  
End Sub
```

  
  
Then Ball overrides it:  
  

```B4X
#Override  
  
Public Sub Render(aCvs As B4XCanvas)  
  
    If getVisible = False Then Return  
  
    aCvs.DrawCircle(CenterX, CenterY, getRadius, getColor, True, 0)  
  
End Sub
```

  
  
So the common logic stays in the parent class, while the child class only changes what is specific to it.  
  
[HEADING=2]Static helper code[/HEADING]  
The example also uses a static helper module:  
  

```B4X
#StaticCode BreakoutMath
```

  
With helpers such as:  
  
  
  
This keeps reusable math / collision logic separated from the game objects.  
  
[HEADING=2]Why this is interesting[/HEADING]  
For small apps, classic B4X is already very productive.  
  
But for larger libraries, custom views, games or reusable components, some OOP features can help with:  
  

- reducing duplicated code
- grouping related behavior
- making examples easier to understand
- keeping a clean separation of responsibilities
- making reusable B4XLib components easier to maintain
- experimenting with inheritance and overrides without changing the B4X language itself

Again, this is only a proof of concept. It is not meant to make B4X more complex or force a new programming style. It is just an optional layer that generates normal B4X code.  
  
[HEADING=2]Current status[/HEADING]  
B4X++ is still experimental. While building this Breakout example, I had to handle several B4X-specific realities carefully:  
  

- avoiding B4X reserved words as method names
- avoiding variable names that conflict with module names
- generating safe setter calls for properties
- flattening inherited fields and methods correctly
- avoiding type assumptions that do not exist after flattening
- keeping the generated code readable and debuggable in B4J

That is actually one of the goals of the project: learning where the limits are, and making the generated code as friendly as possible for the official B4X IDE.  
  
[HEADING=2]Conclusion[/HEADING]  
This Breakout example shows how B4X++ can make a B4J + XUI project more structured while still producing standard B4X code.  
  
The interesting part is not the game itself, but the organization behind it: entities, inheritance, properties, overrides, helper modules and generated .bas files that remain compatible with B4J.  
  
I would be happy to hear feedback, especially from B4XLib authors and custom view developers. The project is still a proof of concept, so nothing is final yet.  
  
Regards,  
Toky
# XUI Breakout

`xui-breakout` is a B4J UI example written in B4X++.

It demonstrates how B4X++ can structure a real XUI game with small focused classes instead of one large B4X module.

## What it demonstrates

- B4J UI project generation with `#Project B4J-UI`.
- XUI rendering with `B4XCanvas`.
- Game loop with a `Timer`.
- Mouse input with a generated panel event.
- OOP entities: `GameEntity`, `Paddle`, `Ball`, `Brick`.
- Services: `BreakoutGame`, `BrickGrid`, `ScoreBoard`.
- Inheritance, `Override`, `Super.Initialize`, readable property assignment (`X = aX`) and a `#StaticCode` helper.

## Run it

1. Open this folder in VS Code.
2. Run `B4X++: Sync #Project`.
3. Open `b4x-ide-projects/B4XPPBreakout-b4j-ui/B4XPPBreakout.b4j` in B4J.
4. Make sure `jXUI` is selected in the B4J libraries tab.
5. Run the project.

Controls:

- Move the mouse to move the paddle.
- Click to launch or restart.

## B4X compatibility notes

The example avoids B4X reserved words such as `Step`, avoids using `Initialize2` as a first constructor call, and avoids local variable names that only differ from module names by case.


## B4J compatibility note

The example intentionally uses `CollidesWithBox(left, top, right, bottom)` instead of `Intersects(other As GameEntity)`. After B4X++ flattening, B4J class modules are not real subclasses at runtime, so passing `Paddle` or `Brick` to a parameter typed as `GameEntity` triggers B4J warning #22. Rectangle values avoid the warning while keeping the entity/collision model clear.

`Ball.ResetAt` uses `BallCenterX` / `BallCenterY` to avoid colliding with inherited `CenterX` / `CenterY` methods.


## Readability convention

This example intentionally uses argument names such as `aX`, `aWidth`, `aColor`, `aGameWidth`, and `aBallCenterX`. It avoids parameters named exactly like properties, classes, methods or B4X keywords. Inside classes, the source uses property assignment sugar such as `X = aX`; the transpiler generates the B4X setter call `setX(aX)`.

B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
	Private fx As JFX
	
End Sub

public Sub collisionWithWall(wall As Canvas, ball1 As Ball) 
	
	Dim ballMinX As Double = Main.cv.Left + ball1.radius
	Dim ballMinY As Double = Main.cv.Top + ball1.radius
	Dim ballMaxX As Double = Main.cv.width - ball1.radius
	Dim ballMaxY As Double = Main.cv.Height - ball1.radius
	If (ball1.x < ballMinX)  Then
		ball1.speedX = -ball1.speedX    'Reflect along normal
		ball1.x = ballMinX              'Re-position the ball at the edge
	else if  (ball1.x > ballMaxX) Then
		ball1.speedX = -ball1.speedX
		ball1.x = ballMaxX
	End If	   
	'May cross both x And y bounds
	If (ball1.y < ballMinY) Then
		ball1.speedY = -ball1.speedY
		ball1.y = ballMinY
	else if (ball1.y > ballMaxY) Then
		ball1.speedY = -ball1.speedY
		ball1.y = ballMaxY
	End If
	
End Sub

public Sub intersect(a As Ball, b As Ball)
	
	Dim xDist, yDist As Double
	xDist = a.x - b.x
	yDist = a.y - b.y
	Dim distSquared As Double = xDist * xDist + yDist * yDist
	'Check the squared distances instead of the the distances, same
	'result, but avoids a square root.
	If (distSquared <= (a.radius + b.radius) * (a.radius + b.radius)) Then
		Dim speedXocity As Double = b.speedX - a.speedX
		Dim speedYocity As Double = b.speedY - a.speedY
		Dim dotProduct As Double = xDist * speedXocity + yDist * speedYocity
		'Neat vector maths, used For checking If the objects moves towards
		'one another.
			If (dotProduct > 0)  Then
				Dim collisionScale As Double = dotProduct / distSquared
				Dim xCollision As Double = xDist * collisionScale
				Dim yCollision As Double = yDist * collisionScale
				'The Collision vector is the speed difference projected on the
				'Dist vector,
				'thus it is the component of the speed difference needed for
				'the collision.
				Dim combinedMass As Double = a.getMass() + b.getMass()
				Dim collisionWeightA As Double = 2 * b.getMass() / combinedMass
				Dim collisionWeightB As Double = 2 * a.getMass() / combinedMass
				a.speedX = a.speedX +  (collisionWeightA * xCollision)
				a.speedY  = a.speedY +  (collisionWeightA * yCollision)
				b.speedX = b.speedX - (collisionWeightB * xCollision)
				b.speedY = b.speedY - (collisionWeightB * yCollision)
			End If
	 End If
	
End Sub



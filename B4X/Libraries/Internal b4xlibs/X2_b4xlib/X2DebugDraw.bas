B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
'Used internally for debug drawing. Call X2.EnableDebugDraw to enable.
'Very useful for debugging.
Sub Class_Globals
	Private xui As XUI
	Public cvs As B4XCanvas
	Private panel As B4XView
	Private X2 As X2Utils
	Private ImageView As B4XView
	Private DebugScale As Float = 1/2
	Public MarkedPoints As List
End Sub

Public Sub Initialize (Parent As B4XView, vX2 As X2Utils)
	panel = xui.CreatePanel("")
	X2 = vX2
	panel.SetLayoutAnimated(0, 0, 0, X2.MainBC.mWidth * DebugScale, X2.MainBC.mHeight * DebugScale)
	Dim iv As ImageView
	iv.Initialize("")
	ImageView = iv
	ImageView.Enabled = False
	Parent.AddView(ImageView, 1dip, 1dip, 1dip, 1dip)
	cvs.Initialize(panel)
	MarkedPoints.Initialize
	Resize
End Sub

Public Sub Draw (gs As X2GameStep, VisibleBodies As Map)
	cvs.ClearRect(cvs.TargetRect)
	DrawGrid
	For Each body As B2Body In VisibleBodies.Keys
		If body.IsInitialized = False Then Continue
		Dim fixture As B2Fixture = body.FirstFixture
		Do While fixture <> Null
			DrawShape (body, fixture.Shape, body.Tag)
			fixture = fixture.NextFixture
		Loop
	Next
	DrawContactPoints
	DrawJoints
	DrawMarkedPoints
	X2.SetBitmapWithFitOrFill(ImageView, cvs.CreateBitmap)
End Sub

Private Sub DrawGrid
	Dim vec1, vec2 As B2Vec2
	Dim clr As Int
	For y = Ceil(X2.ScreenAABB.BottomLeft.Y) To Floor(X2.ScreenAABB.TopRight.Y)
		For x = Ceil(X2.ScreenAABB.BottomLeft.x) To Floor(X2.ScreenAABB.TopRight.x)
			vec1.X = x - 0.05
			vec2.X = x + 0.05
			vec1.Y = y
			vec2.Y = y
			If y = 0 Then clr = xui.Color_Blue Else clr = xui.Color_White
			DrawTwoVertices(vec1, vec2, clr)
			vec1.X = x
			vec2.X = x
			vec1.Y = y - 0.05
			vec2.Y = y + 0.05
			If x = 0 Then clr = xui.Color_Blue Else clr = xui.Color_White
			DrawTwoVertices(vec1, vec2, clr)
		Next
	Next
End Sub

Public Sub Resize 
	ImageView.SetLayoutAnimated(0, X2.mTargetView.Left, X2.mTargetView.Top, X2.mTargetView.Width, X2.mTargetView.Height)
End Sub

Private Sub DrawJoints
	Dim JointsColor As Int = 0xFF00F2FF
	Dim Joint As B2Joint = X2.mWorld.FirstJoint
	Do While Joint <> Null
		DrawTwoVertices(Joint.BodyA.Position, Joint.AnchorA, JointsColor)
		DrawTwoVertices(Joint.AnchorA, Joint.AnchorB, JointsColor)
		DrawTwoVertices(Joint.AnchorB, Joint.BodyB.Position, JointsColor)
		Joint = Joint.NextJoint
	Loop
End Sub

Private Sub DrawContactPoints
	Dim contact As B2Contact = X2.mWorld.FirstContact
	Dim wm As B2WorldManifold
	Do While contact <> Null
		contact.GetWorldManifold(wm)
		For i = 0 To wm.PointCount - 1
			Dim WorldPoint As B2Vec2 = wm.GetPoint(i)
			Dim vec As B2Vec2 = X2.WorldPointToMainBC(WorldPoint.X, WorldPoint.Y)
			vec.MultiplyThis(DebugScale)
			cvs.DrawCircle(vec.X, vec.Y, 3, 0xFFFF2E00, True, 0)
		Next
		contact = contact.NextContact
	Loop
End Sub

Private Sub DrawMarkedPoints
	For Each vec As B2Vec2 In MarkedPoints
		Dim v As B2Vec2 = X2.WorldPointToMainBC(vec.X, vec.Y)
		v.MultiplyThis(DebugScale)
		cvs.DrawCircle(v.X, v.Y, 3, 0xFF78FF71, True, 0)
	Next
	MarkedPoints.Clear
End Sub

Private Sub DrawShape (body As B2Body, shape As B2Shape, bw As X2BodyWrapper)
	Dim clr As Int = 0xFF0200FF
	If body.IsColliding Then
		clr = 0xFFFFC700
		If body.GetContactList(True).Size > 0 Then
			clr = 0xFFFF2E00
		End If
	End If
	If body.Awake = False Then
		clr = xui.Color_Green
	End If
	'center of mass
	Dim vec As B2Vec2 = body.WorldCenter
	vec = X2.WorldPointToMainBC(vec.X, vec.Y)
	vec.MultiplyThis(DebugScale)
	cvs.DrawCircle(vec.X, vec.Y, 1, clr, True, 0)
	vec = body.Position
	vec = X2.WorldPointToMainBC(vec.X, vec.Y)
	vec.MultiplyThis(DebugScale)
	cvs.DrawCircle(vec.X, vec.Y, 2, 0xFFFF0096, False, 2)
	If bw.DebugDrawColor <> 0 Then clr = bw.DebugDrawColor
	Select shape.ShapeType
		Case shape.SHAPE_CIRCLE
			Dim circle As B2CircleShape = shape
			Dim vec As B2Vec2 = body.GetWorldPoint(circle.SupportVertex)
			vec = X2.WorldPointToMainBC(vec.X, vec.Y)
			vec.MultiplyThis(DebugScale)
			cvs.DrawCircle(vec.X, vec.Y, X2.MetersToBCPixels(circle.Radius) * DebugScale, clr, False, 1)
		Case shape.SHAPE_EDGE
			Dim edge As B2EdgeShape = shape
			DrawTwoVertices(body.GetWorldPoint(edge.Vertex1), body.GetWorldPoint(edge.Vertex2), clr)
		Case shape.SHAPE_POLYGON
			Dim polygon As B2PolygonShape = shape
			Dim PrevVertex As B2Vec2 = body.GetWorldPoint(polygon.GetVertex(0))
			For i = 1 To polygon.VertexCount - 1
				Dim vertex As B2Vec2 = body.GetWorldPoint(polygon.GetVertex(i))
				DrawTwoVertices(PrevVertex, vertex, clr)
				PrevVertex = vertex
			Next
			DrawTwoVertices(PrevVertex, body.GetWorldPoint(polygon.GetVertex(0)), clr)
		Case shape.SHAPE_CHAIN
			Dim chain As B2ChainShape = shape
			Dim edge As B2EdgeShape
			edge.Initialize(Null, Null)
			For i = 0 To chain.EdgeCount - 1
				chain.GetEdge(i, edge)
				DrawTwoVertices(body.GetWorldPoint(edge.Vertex1), body.GetWorldPoint(edge.Vertex2), clr)
			Next
	End Select
End Sub

Private Sub DrawTwoVertices(vec1 As B2Vec2, vec2 As B2Vec2, clr As Int)

	vec1 = X2.WorldPointToMainBC(vec1.X, vec1.Y)
	vec1.MultiplyThis(DebugScale)
	vec2 = X2.WorldPointToMainBC(vec2.X, vec2.Y)
	vec2.MultiplyThis(DebugScale)
	cvs.DrawLine(vec1.X, vec1.Y, vec2.X, vec2.Y, clr, 1)
End Sub





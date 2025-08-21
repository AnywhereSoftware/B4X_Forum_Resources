B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
Sub Class_Globals
	Private parser As JSONParser
	Type X2InternalTileSet (TilesBC As BitmapCreator, Margin As Int, _
		Spacing As Int, Count As Int, TileWidth As Int, TileHeight As Int, Name As String, _
		Columns As Int, FirstGID As Int)
	Type X2InternalTileLayer (Name As String, Tiles() As X2Tile)
	Type X2TileObjectTemplate (Name As String, Props As Map, CustomProps As Map, FixtureDef As B2FixtureDef, _
		Id As Int, BodyDef As B2BodyDef, FirstTime As Boolean, ObjectLayer As X2ObjectsLayer, Position As B2Vec2, Tag As String)
	Type X2ObjectsLayer (Name As String, ObjectsById As Map, ObjectsByName As Map)
	Type X2Tile (CBC As CompressedBC, TileIdentifier As Int)
	Private TileSets As Map
	Public TileWidthMeters As Float
	Public TileHeightMeters As Float
	Private OriginalTileWidthPixels, OriginalTileHeightPixels As Int
	Private TileWidthPixels, TileHeightPixels As Int
	Private MetersToPixelsX, MetersToPixelsY As Float
	Private MapBottomYOriginalPixels As Int
	Public TilesPerRow As Int
	Public TilesPerColumn As Int
	Public SingleTileBC As BitmapCreator
	Public Layers As Map
	Private TilesCBC As Map
	Private MapRectPixels As B4XRect
	Private xui As XUI
	Private X2 As X2Utils
	Private const FLIPPED_HORIZONTALLY = 0x80000000, FLIPPED_VERTICALLY = 0x40000000, FLIPPED_DIAGONALLY_FLAG = 0x20000000 As Int
	Private su As StringUtils
	Private cs As CompressedStreams
	Private raf As RandomAccessFile
	Public MapXToMeter, MapYToMeter As Float
	Private DefaultCustomProperties As Map
	Private BackgroundColorBC As BitmapCreator
	Public MapAABB As B2AABB
	Public mTargetView As B4XView
	Private TargetViewBC(2) As BitmapCreator
	Private TargetViewBCIndex As Int
	Private ReuseTilesRect As B4XRect
	Private ReuseScreenCenter As B2Vec2
	Private ReuseTileTop, ReuseTileLeft As Int
	Private LastDrawnScreenCenterStarted, LastDrawnScreenCompleted As B2Vec2
	Private TileMapVersion As Float
End Sub

'Loads the TileMap json file. Must be json format and the data must be Base64 with compression.
'Make sure to call SetSingleTileDimension and PrepareObjectsDef.
'Pass Null to TargetView if not using a tile map for the background.
Public Sub Initialize (vX2 As X2Utils, Dir As String, FileName As String, TargetView As B4XView)
	X2 = vX2
	TileSets.Initialize
	Layers.Initialize
	Dim all As Map = ReadJson(Dir, FileName)
	Dim TileSetsList As List = all.Get("tilesets")
	For Each ts As Map In TileSetsList
		Dim fgid As Int = ts.Get("firstgid")
		If ts.ContainsKey("source") Then
			ts = ReadJson(Dir, ts.Get("source"))
		End If
		LoadTileSet (ts, fgid, Dir)
	Next
	'key = identifier, value = CBC
	TilesCBC.Initialize
	TilesPerRow = all.Get("width")
	TilesPerColumn = all.Get("height")
	OriginalTileWidthPixels = all.Get("tilewidth")
	OriginalTileHeightPixels = all.Get("tileheight")
	TileMapVersion = all.GetDefault("version", 1)
	MapBottomYOriginalPixels = OriginalTileHeightPixels * TilesPerColumn
	Dim LayersList As List = all.Get("layers")
	For Each layer As Map In LayersList
		If layer.ContainsKey("data") Then
			ParseTileLayer(layer)
		Else if layer.ContainsKey("objects") Then
			ParseObjectsLayer(layer)
		End If
	Next
	ReadObjectsTemplate
	mTargetView = TargetView
	ReuseTilesRect.Initialize(-1, -1, -1, -1)
	LastDrawnScreenCompleted.Set(-1, -1)
	LastDrawnScreenCenterStarted.Set(-1, -1)
End Sub

Private Sub ReadObjectsTemplate
	DefaultCustomProperties.Initialize
	parser.Initialize(File.ReadString(File.DirAssets, "objecttypes.json"))
	Dim l1 As List = parser.NextArray
	Dim m As Map = l1.Get(0)
	Dim props As List = m.Get("properties")
	For Each p As Map In props
		DefaultCustomProperties.Put(p.Get("name"), p.Get("value"))
	Next
	Log($"Loading objecttypes.json v${DefaultCustomProperties.Get("x2 tiled version")}"$)
End Sub

Private Sub ParseObjectsLayer (layer As Map)
	Dim ol As X2ObjectsLayer
	ol.Initialize
	ol.ObjectsById.Initialize
	ol.ObjectsByName.Initialize
	ol.Name = layer.Get("name")
	Dim objects As List = layer.Get("objects")
	'can't use For Each here as the iterator variable is reused and we want to store it.
	For i = 0 To objects.Size - 1
		Dim om As Map = objects.Get(i)
		If om.ContainsKey("gid") Then
			If om.Get("name") <> "" Then
				Log($"Skipping tile object: (${om.Get("name")})"$)
			End If
			Continue
		End If
		If om.Get("type") <> "x2" Then
			Log($"Type should be set to x2 (${om.Get("name")})"$)
			Continue
		End If
		Dim template As X2TileObjectTemplate
		template.Initialize
		template.ObjectLayer = ol
		template.Id = om.Get("id")
		template.Name = om.Get("name")
		template.Props = om
		If om.ContainsKey("properties") = False Then
			template.CustomProps.Initialize
		Else
			If TileMapVersion >= 1.2 Then
				template.CustomProps = ReadCustomProps(om.Get("properties"))
			Else
				template.CustomProps = ConvertMapToWritableMapIfNeeded(om.Get("properties"))
			End If
		End If
		template.FirstTime = True
		
		ol.ObjectsById.Put(template.Id, template)
		ol.ObjectsByName.Put(template.Name, template)
	Next
	Layers.Put(ol.Name, ol)
End Sub

Private Sub ReadCustomProps (list As List) As Map
	Dim res As Map
	res.Initialize
	For Each p As Map In list
		res.Put(p.Get("name"), p.Get("value"))
	Next
	Return res
End Sub

Private Sub ConvertMapToWritableMapIfNeeded (m As Map) As Map
#if B4I
	'in B4i the JSON parser returns read only maps. We need to convert them to writable map.
	If m.IsReadOnly Then
		Dim NewMap As Map
		NewMap.Initialize
		For Each key As Object In m.Keys
			NewMap.Put(key, m.Get(key))
		Next
		Return NewMap
	End If
#End If
	Return m
End Sub

Public Sub PrepareObjectsDef (Layer As String)
	Dim ol As X2ObjectsLayer = Layers.Get(Layer)
	For Each template As X2TileObjectTemplate In ol.ObjectsById.Values
		template.Position = MapXYToWorldVec(template.Props.Get("x"), template.Props.Get("y"))
		template.Tag = template.CustomProps.GetDefault("tag", "")
		If GetCustomProperty(template, "copy from id") = 0 Then 'ignore
			CreateBodyDefAndFixtureDef(template)
		End If
	Next
End Sub

Private Sub CreateBodyDefAndFixtureDef(template As X2TileObjectTemplate)
	Dim bodytype As String = GetCustomProperty(template, "body type")
	If bodytype = "dynamic" Then
		template.BodyDef.BodyType = template.BodyDef.TYPE_DYNAMIC
	Else If bodytype = "kinematic" Then
		template.BodyDef.BodyType = template.BodyDef.TYPE_KINEMATIC
	Else
		'static
		template.CustomProps.Put("angle interval", 1)
	End If
	template.BodyDef.Position = template.Position
	Dim RotationDegrees As Float = template.Props.Get("rotation")
	template.BodyDef.Angle = X2.DegreesToB2Angle(RotationDegrees)
	template.BodyDef.AllowSleep = GetCustomProperty(template, "allow sleep")
	template.BodyDef.FixedRotation = GetCustomProperty(template, "fixed rotation")
	template.BodyDef.GravityScale = GetCustomProperty(template, "gravity scale")
	If template.Props.ContainsKey("polygon") Then
		Dim polygon As B2PolygonShape
		polygon.Initialize
		polygon.Set(ListOfMapCoordinatesToListOfLocalVecs(template.Props.Get("polygon"), 0, 0))
		X2.GetShapeWidthAndHeight(polygon)
		Dim dx As Float = X2.ShapeAABB.Center.X
		Dim dy As Float = X2.ShapeAABB.Center.Y
		polygon.Set(ListOfMapCoordinatesToListOfLocalVecs(template.Props.Get("polygon"), -dx, -dy))
		
		'template.BodyDef.Position.AddToThis(X2.CreateVec2(dx, dy))
		template.BodyDef.Position.AddToThis(X2.CreateVec2(dy  * SinD(RotationDegrees) + dx  * CosD(RotationDegrees), _
			dy * CosD(RotationDegrees) - dx * SinD(RotationDegrees)))
		template.FixtureDef.Shape = polygon
	Else If template.Props.ContainsKey("polyline") Then
		Dim chain As B2ChainShape
		chain.Initialize
		chain.CreateChain(ListOfMapCoordinatesToListOfLocalVecs(template.Props.Get("polyline"), 0, 0))
		template.FixtureDef.Shape = chain
	Else If template.Props.GetDefault("ellipse", False) = True Then
		Dim circle As B2CircleShape
		Dim width As Float = template.Props.Get("width")
		Dim radius As Float = width * MapXToMeter / 2
		circle.Initialize(radius)
		template.BodyDef.Position.AddToThis(X2.CreateVec2(radius, -radius))
		template.FixtureDef.Shape = circle
	Else
		Dim rect As B2PolygonShape
		rect.Initialize
		Dim width As Float = template.Props.Get("width") * MapXToMeter
		Dim height As Float = template.Props.Get("height") * MapYToMeter
		'position for rectangles is top-left corner.
		template.BodyDef.Position.AddToThis(X2.CreateVec2(-height / 2  * SinD(RotationDegrees) + width / 2  * CosD(RotationDegrees), _
			-height / 2 * CosD(RotationDegrees) + -width / 2 * SinD(RotationDegrees)))
		rect.SetAsBox(width / 2, height / 2)
		template.FixtureDef.Shape = rect
	End If
	Dim GraphicFile As String = GetCustomProperty(template, "graphic file 1")
	Dim GraphicName As String = GetCustomProperty(template, "graphic name")
	If GraphicFile <> "" Then
		If GraphicName <> "" Then
			Log("Both 'graphic name' and 'graphic file' are set. 'graphic name' is ignored.")
		End If
		GraphicName = LoadGraphicForShape(template.FixtureDef.Shape, GraphicFile, template)
		
		template.CustomProps.Put("graphic name", GraphicName)
	End If
	template.FixtureDef.Density = GetCustomProperty(template, "density")
	template.FixtureDef.SetFilterBits(GetCustomProperty(template, "category bits"), GetCustomProperty(template, "mask bits"))
	template.FixtureDef.Friction = GetCustomProperty(template, "friction")
	template.FixtureDef.IsSensor = GetCustomProperty(template, "is sensor")
	template.FixtureDef.Restitution = GetCustomProperty(template, "restitution")
End Sub

Private Sub ParseTileLayer (layer As Map)
	If layer.GetDefault("encoding", "") <> "base64" Then
		Log("ERROR: Invalid encoding!!!")
		Return
	End If
	Dim compression As String = layer.GetDefault("compression", "")
	If compression <> "gzip" And compression <> "zlib" Then
		Log("ERROR: Invalid compression!!!")
		Return
	End If
	Dim bytes() As Byte = su.DecodeBase64(layer.Get("data"))
	bytes = cs.DecompressBytes(bytes, compression)
	raf.Initialize3(bytes, True)
	Dim tiles(TilesPerRow * TilesPerColumn) As X2Tile
	For y = 0 To TilesPerColumn - 1
		For x = 0 To TilesPerRow - 1
			tiles(y * TilesPerRow + x).TileIdentifier = raf.ReadInt(raf.CurrentPosition)
		Next
	Next
	Dim l As X2InternalTileLayer
	l.Initialize
	l.Name = layer.Get("name")
	l.Tiles = tiles
	Layers.Put(l.Name, l)
End Sub

'Must be called before any tile is retrieved from the map.
'Note that the exact tile size will be slightly different than the passed values. TileWidthMeters / TileHeightMeters will hold the exact values.
Public Sub SetSingleTileDimensionsInMeters (WidthMeters As Float, HeightMeters As Float)
	If mTargetView <> Null And mTargetView.IsInitialized Then
		TileWidthPixels = Round(WidthMeters * X2.mBCPixelsPerMeter)
		TileHeightPixels = Round(HeightMeters * X2.mBCPixelsPerMeter)
		SetSingleTileDimensionsInBCPixels(TileWidthPixels, TileHeightPixels)
	Else
		TileWidthMeters = WidthMeters
		TileHeightMeters = HeightMeters
		SetDimensionsShared
	End If
End Sub

'Alternative to SetSingleTileDimensionsInMeters. Sets the size based on "bc pixels".
Public Sub SetSingleTileDimensionsInBCPixels (WidthPixels As Int, HeightPixels As Int)
	TileWidthPixels = WidthPixels
	TileHeightPixels = HeightPixels
	TileWidthMeters = TileWidthPixels / X2.mBCPixelsPerMeter
	TileHeightMeters = TileHeightPixels / X2.mBCPixelsPerMeter
	SingleTileBC.Initialize(TileWidthPixels, TileHeightPixels)
	MetersToPixelsX = TileWidthPixels / TileWidthMeters
	MetersToPixelsY = TileHeightPixels / TileHeightMeters
	MapRectPixels.Initialize(0, 0, TileWidthPixels * TilesPerRow, TileHeightPixels * TilesPerColumn)
	SetDimensionsShared
	If mTargetView <> Null And mTargetView.IsInitialized Then
		BackgroundColorBC.Initialize(X2.MainBC.mWidth, X2.MainBC.mHeight)
		SetBackgroundColor(xui.Color_Transparent)
	End If
End Sub

Private Sub SetDimensionsShared
	MapXToMeter = TileWidthMeters / OriginalTileWidthPixels
	MapYToMeter = TileHeightMeters / OriginalTileHeightPixels
	MapAABB.Initialize2(X2.CreateVec2(0, 0), X2.CreateVec2(TileWidthMeters * TilesPerRow, TileHeightMeters * TilesPerColumn))
	Log($"TileMap: AABB: ${MapAABB}, Map Pixels (X) per Meter: $1.2{1/MapXToMeter}, Map Pixels (Y) per Meter: $1.2{1/MapYToMeter}"$)
End Sub

'Gets the object template based on the object id.
Public Sub GetObjectTemplate (Layer As String, Id As Int) As X2TileObjectTemplate
	Dim ol As X2ObjectsLayer = Layers.Get(Layer)
	Dim template As X2TileObjectTemplate = ol.ObjectsById.Get(Id)
	If template = Null Then
		Log($"ERROR: Template not found. Layer: ${Layer}, Id: ${Id}"$)
	End If
	Return template
End Sub

'Gets the object template based on the object name. Don't use if there are multiple objects with the same name.
Public Sub GetObjectTemplateByName (Layer As String, Name As String) As X2TileObjectTemplate
	Dim ol As X2ObjectsLayer = Layers.Get(Layer)
	Dim template As X2TileObjectTemplate = ol.ObjectsByName.Get(Name)
	If template = Null Then
		Log($"ERROR: Template not found. Layer: ${Layer}, Name: ${Name}"$)
	End If
	Return template
End Sub

'Creates a BodyWrapper with a Body based on the template.
Public Sub CreateObject (Template As X2TileObjectTemplate) As X2BodyWrapper
	Template.FirstTime = False
	Dim SourceTemplate As X2TileObjectTemplate = Template
	Dim CopyId As Int = GetCustomProperty(Template, "copy from id")
	If CopyId > 0 Then
		SourceTemplate = Template.ObjectLayer.ObjectsById.Get(CopyId)
		SourceTemplate.BodyDef.Position = Template.Position
	End If
	Dim bw As X2BodyWrapper = X2.CreateBodyAndWrapper(SourceTemplate.BodyDef, Null, Template.Name)
	bw.GraphicName = GetCustomProperty(SourceTemplate, "graphic name")
	bw.DestroyIfInvisible = GetCustomProperty(SourceTemplate, "destroy if invisible")
	bw.SwitchFrameIntervalMs = GetCustomProperty(SourceTemplate, "switch frame interval (ms)")
	bw.TimeToLiveMs = GetCustomProperty(SourceTemplate, "time to live (ms)")
	bw.TickIfInvisible = GetCustomProperty(SourceTemplate, "tick if invisible")
	bw.Id = Template.Id
	bw.DrawFirst = GetCustomProperty(SourceTemplate, "draw first")
	bw.DrawLast = GetCustomProperty(SourceTemplate, "draw last")
	bw.Tag = Template.Tag
	bw.TemplateCustomProperties = Template.CustomProps
	If SourceTemplate.FixtureDef.Shape.IsInitialized = False Then
		Log("ERROR: Shape is not initialized. Make sure to call PrepareObjectsDef.")
	End If
	bw.Body.CreateFixture(SourceTemplate.FixtureDef)
	Return bw
End Sub

'Shortcut to: TileMap.CreateObject(TileMap.GetObjectTemplate(Layer, Id))
Public Sub CreateObject2 (ObjectLayer As String, Id As Int) As X2BodyWrapper
	Return CreateObject(GetObjectTemplate(ObjectLayer, Id))
End Sub

'Shortcut to: TileMap.CreateObject(TileMap.GetObjectTemplateByName(Layer, Id))
Public Sub CreateObject2ByName (ObjectLayer As String, Name As String) As X2BodyWrapper
	Return CreateObject(GetObjectTemplateByName(ObjectLayer, Name))
End Sub

Private Sub LoadGraphicForShape (Shape As B2Shape, GraphicFile As String, Template As X2TileObjectTemplate) As String
	Dim ShapeSize As B2Vec2 = X2.GetShapeWidthAndHeight(Shape)
	Dim files As List
	files.Initialize
	files.Add(GraphicFile)
	Dim name As StringBuilder
	name.Initialize
	name.Append($"${GraphicFile}_$1.2{ShapeSize.X}x$1.2{ShapeSize.Y}"$)
	
	Dim i As Int = 2
	Do While Template.CustomProps.ContainsKey("graphic file " & i)
		Dim f As String = Template.CustomProps.Get("graphic file " & i)
		files.Add(f)
		name.Append(f)
		i = i + 1
	Loop
	If X2.GraphicCache.GetGraphicsCount(name) = 0 Then
		Dim NearestNeighbor As Boolean = GetCustomProperty(Template, "nearest neighbor scaling")
		Dim bmps As List
		Dim RowsAndColumns As String = GetCustomProperty(Template, "graphic sheet: rows, columns")
		Dim AngleInterval As Int = GetCustomProperty(Template, "angle interval")
		If RowsAndColumns <> "1, 1" Then
			Dim xy() As String = Regex.Split("[,\s]+", RowsAndColumns)
			If xy(0) <> "1" Or xy(1) <> "1" Then
				Dim bmp As B4XBitmap = xui.LoadBitmap(File.DirAssets, GraphicFile)
				If NearestNeighbor Then
					bmps = X2.ReadSpritesBCs(X2.BitmapToBC(bmp, 1), xy(0), xy(1), ShapeSize.X, ShapeSize.Y)
				Else
					bmps = X2.ReadSprites(bmp, xy(0), xy(1), ShapeSize.X, ShapeSize.Y)
				End If
			End If
		End If
		If bmps.IsInitialized = False Then
			Dim KeepAspectRatio As Boolean = GetCustomProperty(Template, "graphic keep aspect ratio")
			bmps.Initialize
			For Each f As String In files
				If NearestNeighbor Then
					Dim original As BitmapCreator = X2.BitmapToBC(xui.LoadBitmap(File.DirAssets, f), 1)
					bmps.Add(X2.NearestNeighborResize(original, original.TargetRect, X2.MetersToBCPixels(ShapeSize.X), X2.MetersToBCPixels(ShapeSize.Y), KeepAspectRatio))
				Else
					Dim sb As X2ScaledBitmap = X2.LoadBmp(File.DirAssets, f, ShapeSize.X, ShapeSize.y, KeepAspectRatio)
					bmps.Add(sb)
				End If
			Next
		End If
		If NearestNeighbor Then
			Dim data As X2SpriteGraphicData = X2.GraphicCache.PutGraphicBCs(name,bmps, GetCustomProperty(Template, "antialias"), AngleInterval)
		Else
			Dim data As X2SpriteGraphicData = X2.GraphicCache.PutGraphic2(name,bmps, GetCustomProperty(Template, "antialias"), AngleInterval)
		End If
		data.VerticalSymmetry = GetCustomProperty(Template, "vertical symmetry")
		data.HorizontalSymmetry = GetCustomProperty(Template, "horizontal symmetry")
	End If
	
	Return name
End Sub


Public Sub GetCustomProperty(Template As X2TileObjectTemplate, Key As String) As Object
	Dim o As Object = Template.CustomProps.Get(Key)
	If o = Null Then 
		o = DefaultCustomProperties.Get(Key)
	End If
	If o = Null Then
		Log($"Error: cannot find property: ${Key}"$)
	End If
	If o Is String Then
		Dim s As String = o
		Return s.Trim
	End If
	Return o
End Sub

Private Sub ListOfMapCoordinatesToListOfLocalVecs (points As List, OffsetXMeters As Float, OffsetYMeters As Float) As List
	Dim res As List
	res.Initialize
	For Each p As Map In points
		Dim x As Float = p.Get("x")
		Dim y As Float = p.Get("y")
		res.Add(X2.CreateVec2(x * MapXToMeter + OffsetXMeters, (-y) * MapYToMeter + OffsetYMeters))
	Next
	Return res
End Sub


Private Sub MapXYToWorldVec(x As Float, y As Float) As B2Vec2
	Return X2.CreateVec2(x * MapXToMeter, (MapBottomYOriginalPixels - y) * MapYToMeter)
End Sub

Private Sub ReadJson (Dir As String, FileName As String) As Map
	parser.Initialize(File.ReadString(Dir, FileName))
	Return parser.NextObject
End Sub

Private Sub LoadTileSet (m As Map, FirstGID As Int, Dir As String)
	
	Dim ts As X2InternalTileSet
	ts.Initialize
	ts.Columns = m.Get("columns")
	ts.Name = m.Get("name")
	If ts.Columns = 0 Then
		Log($"Skipping tile set: ${ts.Name}"$)
		Return
	End If
	ts.TilesBC = X2.BitmapToBC(xui.LoadBitmap(Dir, m.Get("image")), 1)
	ts.FirstGID = FirstGID
	ts.Margin = m.Get("margin")
	ts.Spacing = m.Get("spacing")
	ts.Count = m.Get("tilecount")
	ts.TileWidth = m.Get("tilewidth")
	ts.TileHeight = m.Get("tileheight")
	If TileSets.ContainsKey(ts.Name) Then
		Log("WARNING: Duplicate tile sets with same name: " & ts.Name)
		Return
	End If
	TileSets.Put(ts.Name, ts)
End Sub

Public Sub SetBackgroundColor (clr As Int)
	BackgroundColorBC.FillRect(clr, BackgroundColorBC.TargetRect)
End Sub

Public Sub SetBackgroundBitmap (bmp As B4XBitmap)
	BackgroundColorBC.CopyPixelsFromBitmap(bmp)
End Sub

'Returns the current BC used for the map drawing.
'Note that each call to DrawScreen or Draw changes the currently used BC.
Public Sub getCurrentBC As BitmapCreator
	Return TargetViewBC(TargetViewBCIndex)
End Sub

'Should be called from Game.DrawingComplete
Public Sub DrawingComplete
	If TargetViewBC(TargetViewBCIndex).IsInitialized = False Then Return
	If LastDrawnScreenCompleted.Equals(LastDrawnScreenCenterStarted) Then Return
	LastDrawnScreenCompleted = LastDrawnScreenCenterStarted.CreateCopy
	X2.SetBitmapWithFitOrFill(mTargetView, TargetViewBC(TargetViewBCIndex).Bitmap)
End Sub


'Draws the layers based on X2.ScreenAABB.
'Returns True if the screen needed an update.
Public Sub DrawScreen (LayersNames As List, Tasks As List) As Boolean
	If X2.gs.ShouldDraw = False Then Return False
	Dim DrawCenter As B2Vec2 = X2.ScreenAABB.Center
	If DrawCenter.Equals(LastDrawnScreenCenterStarted) Or DrawCenter.Equals(LastDrawnScreenCompleted) Then Return False
	LastDrawnScreenCenterStarted = DrawCenter.CreateCopy
	Draw(LayersNames, X2.ScreenAABB, Tasks)
	Return True
End Sub


'Draws a specific AABB from the tile map. Note that it doesn't actually draw. It just creates a list with the drawing tasks.
'This method shouldn't be called in normal usage.
Public Sub Draw (LayersNames As List, DrawAABB As B2AABB, Tasks As List)
	Dim DrawRect As B4XRect
	DrawRect.Initialize(Round(DrawAABB.BottomLeft.X * MetersToPixelsX), MapRectPixels.Bottom - Round(DrawAABB.TopRight.Y * MetersToPixelsY), 0, 0)
	TargetViewBCIndex = (TargetViewBCIndex + 1) Mod 2
	Dim TargetBC As BitmapCreator = TargetViewBC(TargetViewBCIndex)
	If TargetBC.IsInitialized = False Then
		TargetBC.Initialize(X2.MainBC.mWidth, X2.MainBC.mHeight)
	End If
	DrawRect.Width = TargetBC.mWidth
	DrawRect.Height = TargetBC.mHeight
	Dim backgroundtask As DrawTask = TargetViewBC(TargetViewBCIndex).CreateDrawTask(BackgroundColorBC, BackgroundColorBC.TargetRect, 0, 0, True)
	backgroundtask.TargetBC = TargetViewBC(TargetViewBCIndex)
	Tasks.Add(backgroundtask)
	Dim StartLeftPixels As Int = DrawRect.Left
	StartLeftPixels = - (StartLeftPixels Mod TileWidthPixels)
	Dim StartTopPixels As Int = DrawRect.Top
	StartTopPixels =  - (StartTopPixels Mod TileHeightPixels)
	Dim StartTileX As Int =  DrawRect.Left / TileWidthPixels
	Dim EndTileX As Int = DrawRect.Right / TileWidthPixels
	Dim StartTileY As Int = DrawRect.Top / TileHeightPixels
	Dim EndTileY As Int = DrawRect.Bottom / TileHeightPixels
	If ReuseScreenCenter.Equals(LastDrawnScreenCompleted) = False Then
		ReuseTilesRect.Bottom = -1
	End If
	Dim DrewPrevious As Boolean
	For Each LayerName As String In LayersNames
		Dim Layer As X2InternalTileLayer = Layers.Get(LayerName)
		For y = StartTileY To EndTileY
			Dim MovingLeftPixels As Int = StartLeftPixels
			Dim MovingTopPixels As Int = StartTopPixels + (y - StartTileY) * TileHeightPixels
			Dim TestReuse As Boolean = y >= ReuseTilesRect.Top And y <= ReuseTilesRect.Bottom
			For x = StartTileX To EndTileX
				If TestReuse And x >= ReuseTilesRect.Left And x < ReuseTilesRect.Right - 1 Then
					If DrewPrevious = False Then
						DrewPrevious = True
						DrawPrevious(x, y, MovingLeftPixels, MovingTopPixels, TargetBC, Tasks)
					End If
					x = ReuseTilesRect.Right
					MovingLeftPixels = StartLeftPixels + TileWidthPixels * (x - StartTileX + 1)
					Continue
				Else If x >= 0 And x < TilesPerRow And y >= 0 And y < TilesPerColumn Then
					Dim t As X2Tile = GetTileFromTileLayer(x, y, Layer)
					If t <> Null Then
						Dim dt As DrawTask = TargetBC.CreateDrawTask(t.CBC, t.CBC.TargetRect, MovingLeftPixels, MovingTopPixels, True)
						dt.IsCompressedSource = True
						dt.TargetBC = TargetBC
						Tasks.Add(dt)
					End If
				End If
				MovingLeftPixels = MovingLeftPixels + TileWidthPixels
			Next
		Next
	Next
	If EndTileY - StartTileY > 3 And EndTileX - StartTileX > 3 Then
		ReuseTileLeft = StartLeftPixels + TileWidthPixels
		ReuseTileTop = StartTopPixels + TileHeightPixels
		ReuseTilesRect.Initialize(StartTileX + 1, StartTileY + 1, EndTileX - 1, EndTileY - 1)
		ReuseScreenCenter = LastDrawnScreenCenterStarted.CreateCopy
	Else
		ReuseTilesRect.Initialize(-1, -1, -1, -1)
	End If
End Sub

Private Sub DrawPrevious (x As Int, y As Int, TargetLeft As Int, TargetTop As Int, TargetBC As BitmapCreator, Tasks As List)
	Dim PreviousBC As BitmapCreator = TargetViewBC((TargetViewBCIndex + 1) Mod 2)
	Dim dx As Int = x - ReuseTilesRect.Left
	Dim dy As Int = y - ReuseTilesRect.Top
	
	Dim rect As B4XRect
	rect.Initialize(ReuseTileLeft + dx * TileWidthPixels, ReuseTileTop + dy * TileHeightPixels, 0, 0)
	rect.Width = (ReuseTilesRect.Width + 1 - dx) * TileWidthPixels
	rect.Height = (ReuseTilesRect.Height + 1 - dy) * TileHeightPixels
	'PreviousBC.FillRect(xui.Color_Red, PreviousBC.TargetRect)
	Dim dt As DrawTask = TargetBC.CreateDrawTask(PreviousBC, rect, TargetLeft, TargetTop, True)
	dt.TargetBC = TargetBC
	Tasks.Add(dt)
End Sub



'Gets a single tile from the TileMap.
Public Sub GetTileFromTileLayer (MapX As Int, MapY As Int, Layer As X2InternalTileLayer) As X2Tile
	Dim tile As X2Tile = Layer.Tiles(MapY * TilesPerRow + MapX)
	If tile.TileIdentifier = 0 Then Return Null
	If tile.CBC <> Null Then Return tile
	If TilesCBC.ContainsKey(tile.TileIdentifier) Then
		tile.CBC = TilesCBC.Get(tile.TileIdentifier)
		Return tile
	End If
	Dim CleanIdentifier As Int = Bit.And(0x1FFFFFFF, tile.TileIdentifier)
	For Each ts As X2InternalTileSet In TileSets.Values
		If ts.FirstGID <= CleanIdentifier And ts.FirstGID + ts.Count > CleanIdentifier Then Exit
	Next
	Dim index As Int = CleanIdentifier - ts.FirstGID
	Dim row As Int = index / ts.Columns
	Dim col As Int = index Mod ts.Columns
	Dim x As Int = ts.Margin + col * (ts.TileWidth + ts.Spacing)
	Dim y As Int = ts.Margin + row * (ts.TileHeight + ts.Spacing)
	Dim h As Boolean = Bit.And(tile.TileIdentifier, FLIPPED_HORIZONTALLY) <> 0
	Dim v As Boolean = Bit.And(tile.TileIdentifier, FLIPPED_VERTICALLY) <> 0
	Dim d As Boolean = Bit.And(tile.TileIdentifier, FLIPPED_DIAGONALLY_FLAG) <> 0
	
	Dim src As B4XRect
	src.Initialize(x, y, x + ts.TileWidth, y + ts.TileHeight)
	SingleTileBC.FillRect(xui.Color_Transparent, SingleTileBC.TargetRect)
	X2.GraphicCache.DrawBitmapCreatorFlipped(SingleTileBC, ts.TilesBC, SingleTileBC.mWidth / ts.TileWidth, SingleTileBC.mHeight / ts.TileHeight, src, h, v, d)
	Dim cbc As CompressedBC = SingleTileBC.ExtractCompressedBC(SingleTileBC.TargetRect, X2.GraphicCache.CBCCache)
	TilesCBC.Put(tile.TileIdentifier, cbc)
	tile.CBC = cbc
	Return tile
End Sub




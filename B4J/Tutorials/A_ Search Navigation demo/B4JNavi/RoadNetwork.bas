B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	' Types are defined in Main.bas as Public and shared across modules
	Private nodes As List          ' List of all RoadNode objects
	Private edges As Map            ' Map: nodeId -> List of outgoing RoadEdge objects
	Private nodeIndex As Map        ' Map: nodeId -> RoadNode for quick lookup
	Private allRoads As List        ' Complete list of all roads for easy iteration
End Sub

'================================================================================
' Initialize - Sets up empty data structures for the road network
' Must be called before adding any nodes or roads
'================================================================================
Public Sub Initialize
	nodes.Initialize
	edges.Initialize
	nodeIndex.Initialize
	allRoads.Initialize
End Sub

'================================================================================
' AddNode - Adds an intersection/location to the road network
' id - Unique identifier for this node (0, 1, 2, ...)
' lat - GPS latitude coordinate
' lon - GPS longitude coordinate
' name - Human-readable name (e.g., "Main St & 1st Ave")
'================================================================================
Public Sub AddNode(id As Int, lat As Double, lon As Double, name As String)
	' Create new node object
	Dim node As RoadNode
	node.Initialize
	node.id = id
	node.lat = lat
	node.lon = lon
	node.name = name
	
	' Add to collections
	nodes.Add(node)
	nodeIndex.Put(id, node)
	
	' Initialize empty edge list for this node
	If Not(edges.ContainsKey(id)) Then
		Dim edgeList As List
		edgeList.Initialize
		edges.Put(id, edgeList)
	End If
End Sub

'================================================================================
' AddRoad - Connects two nodes with a road segment
' fromNodeId - Starting intersection ID
' toNodeId - Ending intersection ID
' speedLimit - Speed limit in km/h (e.g., 50, 100)
' roadName - Name of the road (e.g., "Main Street", "Highway 1")
' oneWay - True if road only allows travel in one direction, False for two-way
'
' For two-way roads, this automatically creates edges in both directions
'================================================================================
Public Sub AddRoad(fromNodeId As Int, toNodeId As Int, speedLimit As Int, roadName As String, oneWay As Boolean)
	Dim fromNode As RoadNode = nodeIndex.Get(fromNodeId)
	Dim toNode As RoadNode = nodeIndex.Get(toNodeId)
	
	' Calculate actual distance between nodes using Haversine formula
	Dim distance As Double = CalculateDistance(fromNode.lat, fromNode.lon, toNode.lat, toNode.lon)
	
	' Create forward edge (from -> to)
	Dim edge As RoadEdge
	edge.Initialize
	edge.fromNode = fromNodeId
	edge.toNode = toNodeId
	edge.distance = distance
	edge.speedLimit = speedLimit
	edge.roadName = roadName
	edge.oneWay = oneWay
	
	' Add to edges map and master road list
	Dim edgeList As List = edges.Get(fromNodeId)
	edgeList.Add(edge)
	allRoads.Add(edge)
	
	' If two-way road, create reverse edge (to -> from)
	If Not(oneWay) Then
		Dim reverseEdge As RoadEdge
		reverseEdge.Initialize
		reverseEdge.fromNode = toNodeId
		reverseEdge.toNode = fromNodeId
		reverseEdge.distance = distance
		reverseEdge.speedLimit = speedLimit
		reverseEdge.roadName = roadName
		reverseEdge.oneWay = False
		
		Dim reverseList As List = edges.Get(toNodeId)
		reverseList.Add(reverseEdge)
		allRoads.Add(reverseEdge)
	End If
End Sub

'================================================================================
' CalculateDistance - Haversine formula for distance between GPS coordinates
' lat1, lon1 - First GPS coordinate
' lat2, lon2 - Second GPS coordinate
' Returns: Distance in kilometers
' 
' Accounts for Earth's curvature to calculate accurate distances
' https://en.wikipedia.org/wiki/Haversine_formula
'================================================================================
Public Sub CalculateDistance(lat1 As Double, lon1 As Double, lat2 As Double, lon2 As Double) As Double
	Dim R As Double = 6371  ' Earth radius in km
	Dim PI As Double = 3.14159265359
	
	' Convert degrees to radians and calculate differences
	Dim dLat As Double = (lat2 - lat1) * PI / 180
	Dim dLon As Double = (lon2 - lon1) * PI / 180
	
	' Haversine formula
	Dim a As Double = Sin(dLat/2) * Sin(dLat/2) + _
	                   Cos(lat1 * PI / 180) * Cos(lat2 * PI / 180) * _
	                   Sin(dLon/2) * Sin(dLon/2)
	
	Dim c As Double = 2 * ATan2(Sqrt(a), Sqrt(1-a))
	
	Return R * c
End Sub

'================================================================================
' GetNode - Retrieves a node by its ID
' nodeId - The node's unique identifier
' Returns: RoadNode object with all node information
'================================================================================
Public Sub GetNode(nodeId As Int) As RoadNode
	Return nodeIndex.Get(nodeId)
End Sub

'================================================================================
' GetConnectedRoads - Gets all roads leaving from a specific intersection
' nodeId - The intersection to query
' Returns: List of RoadEdge objects representing outgoing roads
'
' Used by pathfinding algorithm to explore neighbors
'================================================================================
Public Sub GetConnectedRoads(nodeId As Int) As List
	If edges.ContainsKey(nodeId) Then
		Return edges.Get(nodeId)
	Else
		Dim emptyList As List
		emptyList.Initialize
		Return emptyList
	End If
End Sub

'================================================================================
' GetAllNodes - Returns complete list of all intersections in network
' Returns: List of all RoadNode objects
'================================================================================
Public Sub GetAllNodes As List
	Return nodes
End Sub

'================================================================================
' GetAllRoads - Returns complete list of all road segments in network
' Returns: List of all RoadEdge objects
'================================================================================
Public Sub GetAllRoads As List
	Return allRoads
End Sub

'================================================================================
' GetNodeCount - Returns total number of intersections in the network
' Returns: Integer count of nodes
'================================================================================
Public Sub GetNodeCount As Int
	Return nodes.Size
End Sub

'================================================================================
' GetRoadCount - Returns total number of road segments in the network
' Returns: Integer count of roads (includes both directions for two-way roads)
'================================================================================
Public Sub GetRoadCount As Int
	Return allRoads.Size
End Sub
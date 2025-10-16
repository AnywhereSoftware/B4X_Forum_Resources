B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private roadNetwork As RoadNetwork
	Private mDebugMode As Boolean = True
	
	' NavNode represents a state in the A* search
	' Contains current position, costs, and path taken to reach it
	Type NavNode(nodeId As Int, cost As Double, heuristic As Double, priority As Double, path As List)
	
	' Binary heap for efficient priority queue (O(log n) operations)
	Private mHeap As List
	Private mHeapSize As Int
End Sub

'================================================================================
' Initialize - Sets up the navigation system
' Call this before using the navigation system
'================================================================================
Public Sub Initialize
	mDebugMode = True
End Sub

'================================================================================
' SetRoadNetwork - Connects the navigation system to a road network
' network - The RoadNetwork object containing all intersections and roads
'================================================================================
Public Sub SetRoadNetwork(network As RoadNetwork)
	roadNetwork = network
End Sub

'================================================================================
' FindRoute - Main pathfinding function using A* algorithm
' startNodeId - ID of starting intersection
' endNodeId - ID of destination intersection
' optimizeFor - Optimization mode:
'   "distance" - Find shortest physical distance
'   "time" - Find fastest route considering speed limits
'   "avoid_highways" - Prefer local roads over highways
'
' Returns: Map containing:
'   "success" (Boolean) - Whether route was found
'   "route" (List) - List of RoadEdge objects forming the path
'   "distance" (Double) - Total distance in km
'   "time" (Double) - Estimated time in minutes
'   "directions" (List) - Turn-by-turn text directions
'================================================================================
Public Sub FindRoute(startNodeId As Int, endNodeId As Int, optimizeFor As String) As Map
	Dim result As Map
	result.Initialize
	result.Put("success", False)
	
	Dim startNode As RoadNode = roadNetwork.GetNode(startNodeId)
	Dim endNode As RoadNode = roadNetwork.GetNode(endNodeId)
	
	If mDebugMode Then
		Log("=== A* NAVIGATION ===")
		Log("From: " & startNode.name)
		Log("To: " & endNode.name)
		Log("Mode: " & optimizeFor)
	End If
	
	' Initialize A* algorithm structures
	InitHeap
	Dim closedSet As Map
	closedSet.Initialize
	
	' Create initial search node at starting position
	Dim initialPath As List
	initialPath.Initialize
	
	Dim initialNavNode As NavNode
	initialNavNode.Initialize
	initialNavNode.nodeId = startNodeId
	initialNavNode.cost = 0  ' No cost at start
	initialNavNode.heuristic = roadNetwork.CalculateDistance(startNode.lat, startNode.lon, endNode.lat, endNode.lon)
	initialNavNode.priority = initialNavNode.heuristic  ' f = g + h
	initialNavNode.path = initialPath
	
	HeapPush(initialNavNode)
	
	Dim nodesExplored As Int = 0
	
	' A* main search loop
	Do While mHeapSize > 0
		' Get node with lowest f-score (priority) - O(log n) with heap
		Dim current As NavNode = HeapPop
		Dim currentNodeId As Int = current.nodeId
		
		' Check if we reached the destination
		If currentNodeId = endNodeId Then
			If mDebugMode Then
				Log("Route found!")
				Log("Nodes explored: " & nodesExplored)
			End If
			
			' Build result with route information
			result.Put("success", True)
			result.Put("route", current.path)
			
			' Calculate total distance and time
			Dim totalDistance As Double = 0
			Dim totalTime As Double = 0
			For Each road As RoadEdge In current.path
				totalDistance = totalDistance + road.distance
				totalTime = totalTime + (road.distance / road.speedLimit * 60)
			Next
			
			result.Put("distance", totalDistance)
			result.Put("time", totalTime)
			result.Put("directions", GenerateDirections(current.path))
			
			Return result
		End If
		
		' Skip if already explored
		If closedSet.ContainsKey(currentNodeId) Then Continue
		closedSet.Put(currentNodeId, True)
		nodesExplored = nodesExplored + 1
		
		' Explore all roads leaving from current intersection
		Dim connectedRoads As List = roadNetwork.GetConnectedRoads(currentNodeId)
		
		For i = 0 To connectedRoads.Size - 1
			Dim road As RoadEdge = connectedRoads.Get(i)
			
			' Skip if destination already explored
			If closedSet.ContainsKey(road.toNode) Then Continue
			
			' Calculate cost for this road based on optimization mode
			Dim edgeCost As Double
			Select optimizeFor
				Case "distance"
					edgeCost = road.distance  ' Use actual distance
				Case "time"
					edgeCost = road.distance / road.speedLimit * 60  ' Time = distance/speed
				Case "avoid_highways"
					If road.speedLimit > 80 Then
						edgeCost = road.distance * 3  ' Heavy penalty for highways
					Else
						edgeCost = road.distance
					End If
			End Select
			
			' Calculate g (cost from start to this node)
			Dim newCost As Double = current.cost + edgeCost
			
			' Calculate h (estimated cost to goal - heuristic)
			Dim toNode As RoadNode = roadNetwork.GetNode(road.toNode)
			Dim heuristic As Double = roadNetwork.CalculateDistance(toNode.lat, toNode.lon, endNode.lat, endNode.lon)
			
			' Adjust heuristic based on optimization mode
			If optimizeFor = "time" Then
				heuristic = heuristic / 100 * 60  ' Assume highway speed for estimate
			End If
			
			' Build path to this neighbor
			Dim newPath As List
			newPath.Initialize
			For j = 0 To current.path.Size - 1
				newPath.Add(current.path.Get(j))
			Next
			newPath.Add(road)
			
			' Create search node for this neighbor
			Dim neighborNode As NavNode
			neighborNode.Initialize
			neighborNode.nodeId = road.toNode
			neighborNode.cost = newCost  ' g value
			neighborNode.heuristic = heuristic  ' h value
			neighborNode.priority = newCost + heuristic  ' f = g + h
			neighborNode.path = newPath
			
			' Add to priority queue
			HeapPush(neighborNode)
		Next
	Loop
	
	' No route found after exploring all reachable nodes
	If mDebugMode Then Log("No route found after exploring " & nodesExplored & " nodes")
	Return result
End Sub

'================================================================================
' GenerateDirections - Converts route (list of roads) to turn-by-turn text
' route - List of RoadEdge objects representing the path
' Returns: List of strings with human-readable directions
'
' Example output:
'   "Start at 1st Ave & Main St"
'   "Head out on Main Street"
'   "Continue on Main Street for 0.5 km"
'   "Turn left onto Oak Street"
'   "Arrive at 4th Ave & Oak St"
'================================================================================
Private Sub GenerateDirections(route As List) As List
	Dim directions As List
	directions.Initialize
	
	If route.Size = 0 Then Return directions
	
	' Starting point
	Dim firstRoad As RoadEdge = route.Get(0)
	Dim startNode As RoadNode = roadNetwork.GetNode(firstRoad.fromNode)
	directions.Add("Start at " & startNode.name)
	
	' Process road segments, combining consecutive segments on same road
	Dim currentRoadName As String = ""
	Dim segmentDistance As Double = 0
	
	For i = 0 To route.Size - 1
		Dim road As RoadEdge = route.Get(i)
		
		If road.roadName <> currentRoadName Then
			' Road name changed - new segment
			If currentRoadName <> "" Then
				' Output previous segment
				directions.Add("Continue on " & currentRoadName & " for " & Round2(segmentDistance, 2) & " km")
			End If
			
			' Determine turn direction
			If i > 0 Then
				Dim prevRoad As RoadEdge = route.Get(i - 1)
				Dim turnDir As String = GetTurnDirection(prevRoad, road)
				directions.Add(turnDir & " onto " & road.roadName)
			Else
				directions.Add("Head out on " & road.roadName)
			End If
			
			currentRoadName = road.roadName
			segmentDistance = road.distance
		Else
			' Same road - accumulate distance
			segmentDistance = segmentDistance + road.distance
		End If
	Next
	
	' Final segment
	If segmentDistance > 0 Then
		directions.Add("Continue on " & currentRoadName & " for " & Round2(segmentDistance, 2) & " km")
	End If
	
	' Destination
	Dim lastRoad As RoadEdge = route.Get(route.Size - 1)
	Dim endNode As RoadNode = roadNetwork.GetNode(lastRoad.toNode)
	directions.Add("Arrive at " & endNode.name)
	
	Return directions
End Sub

'================================================================================
' GetTurnDirection - Determines turn direction between two road segments
' prevRoad - The road we're coming from
' currentRoad - The road we're turning onto
' Returns: "Turn left", "Turn right", or "Continue straight"
'
' Uses cross product of direction vectors to determine turn angle
'================================================================================
Private Sub GetTurnDirection(prevRoad As RoadEdge, currentRoad As RoadEdge) As String
	' Get the three nodes involved in the turn
	Dim prevFrom As RoadNode = roadNetwork.GetNode(prevRoad.fromNode)
	Dim prevTo As RoadNode = roadNetwork.GetNode(prevRoad.toNode)
	Dim currTo As RoadNode = roadNetwork.GetNode(currentRoad.toNode)
	
	' Calculate direction vectors
	Dim v1X As Double = prevTo.lon - prevFrom.lon
	Dim v1Y As Double = prevTo.lat - prevFrom.lat
	Dim v2X As Double = currTo.lon - prevTo.lon
	Dim v2Y As Double = currTo.lat - prevTo.lat
	
	' Cross product determines turn direction
	' Positive = left turn, Negative = right turn, ~Zero = straight
	Dim cross As Double = v1X * v2Y - v1Y * v2X
	
	If Abs(cross) < 0.0001 Then
		Return "Continue straight"
	Else If cross > 0 Then
		Return "Turn left"
	Else
		Return "Turn right"
	End If
End Sub

'================================================================================
' Binary Heap Implementation for Priority Queue
' Provides O(log n) insert and extract-min operations
' Essential for efficient A* algorithm performance
'================================================================================

'================================================================================
' InitHeap - Initializes an empty priority queue
'================================================================================
Private Sub InitHeap
	mHeap.Initialize
	mHeapSize = 0
End Sub

'================================================================================
' HeapPush - Adds a node to the priority queue
' node - NavNode to add
' Maintains heap property with bubble-up operation - O(log n)
'================================================================================
Private Sub HeapPush(node As NavNode)
	mHeap.Add(node)
	mHeapSize = mHeapSize + 1
	HeapifyUp(mHeapSize - 1)
End Sub

'================================================================================
' HeapPop - Removes and returns node with lowest priority (f-score)
' Returns: NavNode with minimum priority value
' Maintains heap property with bubble-down operation - O(log n)
'================================================================================
Private Sub HeapPop As NavNode
	If mHeapSize = 0 Then
		Dim empty As NavNode
		empty.Initialize
		Return empty
	End If
	
	' Root has minimum priority
	Dim root As NavNode = mHeap.Get(0)
	mHeapSize = mHeapSize - 1
	
	If mHeapSize > 0 Then
		' Move last element to root and restore heap property
		mHeap.Set(0, mHeap.Get(mHeapSize))
		mHeap.RemoveAt(mHeapSize)
		HeapifyDown(0)
	Else
		mHeap.RemoveAt(0)
	End If
	
	Return root
End Sub

'================================================================================
' HeapifyUp - Restores heap property by bubbling node upward
' index - Position of node to bubble up
' Swaps with parent until heap property is satisfied
'================================================================================
Private Sub HeapifyUp(index As Int)
	Do While index > 0
		Dim parentIndex As Int = Floor((index - 1) / 2)
		Dim current As NavNode = mHeap.Get(index)
		Dim parent As NavNode = mHeap.Get(parentIndex)
		
		If current.priority < parent.priority Then
			' Swap child with parent
			mHeap.Set(index, parent)
			mHeap.Set(parentIndex, current)
			index = parentIndex
		Else
			Exit  ' Heap property satisfied
		End If
	Loop
End Sub

'================================================================================
' HeapifyDown - Restores heap property by bubbling node downward
' index - Position of node to bubble down
' Swaps with smallest child until heap property is satisfied
'================================================================================
Private Sub HeapifyDown(index As Int)
	Do While True
		Dim leftChild As Int = 2 * index + 1
		Dim rightChild As Int = 2 * index + 2
		Dim smallest As Int = index
		
		' Find smallest among node and its children
		If leftChild < mHeapSize Then
			Dim leftNode As NavNode = mHeap.Get(leftChild)
			Dim smallestNode As NavNode = mHeap.Get(smallest)
			If leftNode.priority < smallestNode.priority Then
				smallest = leftChild
			End If
		End If
		
		If rightChild < mHeapSize Then
			Dim rightNode As NavNode = mHeap.Get(rightChild)
			Dim smallestNode As NavNode = mHeap.Get(smallest)
			If rightNode.priority < smallestNode.priority Then
				smallest = rightChild
			End If
		End If
		
		If smallest <> index Then
			' Swap with smallest child
			Dim temp As NavNode = mHeap.Get(index)
			mHeap.Set(index, mHeap.Get(smallest))
			mHeap.Set(smallest, temp)
			index = smallest
		Else
			Exit  ' Heap property satisfied
		End If
	Loop
End Sub
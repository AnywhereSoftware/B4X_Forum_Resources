### A* Search Algorithm by Johan Schoeman
### 10/04/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168917/)

It is based on [**this web posting**](https://www.geeksforgeeks.org/dsa/a-search-algorithm/).  
  
"……To approximate the shortest path in real-life situations, like- in maps, games where there can be many hindrances……"  
  
It is done with some modified inline Java code to adapt it for use in B4J.  
1. Run the attached project  
2. Click on any cell to be your Starting Point - the cell color will turn RED  
3. Click on any other cell to be your End Point. the cell color will turn Green  
4. Then click on any other cells other than you start or end point cells. They will turn Black as are considered as obstacles between the start and end cells. Keep on clicking on more cells to add more obstacles  
5. Once you have selected your obstacle cells, Click on Button Solve. The A\* model will then find the shortest route between your Start and End cells and make the cells color of the shortest path yellow.  
  
No other libs or jars required other that standard B4J libs  
  
![](https://www.b4x.com/android/forum/attachments/167570)  
  
I have not added a "reset" or clicking on the same cell to enable/disable it as an obstacle or Start /End cell - leaving it up to you to do so.  
  
For testing purposes I have used the following Matrix from the original Java code on the link above:  
   

```B4X
{ 1, 0, 1, 1, 1, 1, 0, 1, 1, 1 },  
                         { 1, 1, 1, 0, 1, 1, 1, 0, 1, 1 },  
                         { 1, 1, 1, 0, 1, 1, 0, 1, 0, 1 },  
                         { 0, 0, 1, 0, 1, 0, 0, 0, 0, 1 },  
                         { 1, 1, 1, 0, 1, 1, 1, 0, 1, 0 },  
                         { 1, 0, 1, 1, 1, 1, 0, 1, 0, 0 },  
                         { 1, 0, 0, 0, 0, 1, 0, 0, 0, 1 },  
                         { 1, 0, 1, 1, 1, 1, 0, 1, 1, 1 },  
                         { 1, 1, 1, 0, 0, 0, 1, 0, 0, 1 } }
```

  
  
I have selected cell (8,0) as start and cell (0,0) as the end.  
All cells are originally set to 1 in the code matrix. Start and End cells will have a value of 1 and only change color when you select your start and end cells.  
When you add an obstacle the cell will be set to 0 in the grid array (you wont see it - it is in the code)  
  
So, setting up the above matric with start at 8,0, end at 0,0, and obstacles for each 0 in the matric above looks as follows:  
  
![](https://www.b4x.com/android/forum/attachments/167567)  
  
Once set up, click on button "Solve". The result will be (where the yellow cells indicate the shortest path between you selected start and end cells taking your obstacles into consideration :  
![](https://www.b4x.com/android/forum/attachments/167568)  
  
See the B4J log:  
  

```B4X
The destination cell is found  
The Path is  
-> (8, 0)-> (8, 1)-> (7, 2)-> (6, 1)-> (5, 2)-> (5, 3)-> (4, 4)-> (3, 4)-> (2, 4)-> (1, 4)-> (0, 3)-> (1, 2)-> (2, 1)-> (1, 0)-> (0, 0)  
here  
,(8,0),(8,1),(7,2),(6,1),(5,2),(5,3),(4,4),(3,4),(2,4),(1,4),(0,3),(1,2),(2,1),(1,0),(0,0)  
8,0;8,1;7,2;6,1;5,2;5,3;4,4;3,4;2,4;1,4;0,3;1,2;2,1;1,0;0,0
```

  
  
The result of the path calculation comes back to the B4J project via an Event - from here the UI is updated with the path result using various string manipulations.  
  
Sample code:  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
'https://www.geeksforgeeks.org/dsa/a-search-algorithm/  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Dim nativeMe As JavaObject  
    
    Dim lbl(9,10) As Label  
    Dim grid(9,10) As Int  
    
    Dim startSelected As Boolean  
    Dim endSelected As Boolean  
    
    Private Button1 As Button  
    
    Dim startTag, endTag As String  
    
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    
    startTag = ""  
    endTag = ""  
    
    For i = 0 To 8  
        For j = 0 To 9  
            grid(i,j) = 1  
        Next  
    Next  
    
    startSelected = False  
    endSelected = False  
  
    For i = 0 To 8  
        For j = 0 To 9  
            lbl(i,j).Initialize("label")  
            lbl(i,j).Text = i & "," & j  
            lbl(i,j).TextColor = fx.Colors.black  
            lbl(i,j).Alignment = "CENTER"  
            lbl(i,j).Tag = i & "," & j  
            CSSUtils.SetBackgroundColor(lbl(i,j), fx.Colors.White)  
            CSSUtils.SetBorder(lbl(i,j), 1dip, fx.Colors.Black, 0)  
            MainForm.RootPane.AddNode(lbl(i,j), j*50, i*50, 50dip, 50dip)  
        Next  
    Next  
    
    nativeMe = Me  
'    Dim start() As Int = Array As Int(8,0)  
'    nativeMe.RunMethod("setStart", Array(start))  
'   
'    Dim fin() As Int = Array As Int(0,0)  
'    nativeMe.RunMethod("setEnd", Array(fin))  
    
  
End Sub  
  
Sub label_MouseClicked (EventData As MouseEvent)  
    Dim l As Label  
    l = Sender  
  
    'Log(l.TextColor)  
    If startSelected = False And endSelected = False Then  
        startTag = l.Tag  
        startSelected = True  
        Dim s(2) As String = Regex.Split(",", l.Tag)  
        Dim row As Int = s(0)  
        Dim col As Int = s(1)  
        grid(row, col) = 1  
        l.TextColor = fx.Colors.White  
        CSSUtils.SetBackgroundColor(l, fx.Colors.Red)  
        Dim aa() As Int = Array As Int(row, col)  
        nativeMe.RunMethod("setStart", Array(aa))  
    else if startSelected = True And endSelected = False Then  
        endTag = l.Tag  
        endSelected = True  
        Dim s(2) As String = Regex.Split(",", l.Tag)  
        Dim row As Int = s(0)  
        Dim col As Int = s(1)  
        grid(row, col) = 1  
        l.TextColor = fx.Colors.White  
        CSSUtils.SetBackgroundColor(l, fx.Colors.Green)  
        Dim aa() As Int = Array As Int(row, col)  
        nativeMe.RunMethod("setEnd", Array(aa))  
    else if startSelected = True And endSelected = True Then  
        l.TextColor = fx.Colors.White  
        CSSUtils.SetBackgroundColor(l, fx.Colors.Black)  
        Dim s(2) As String = Regex.Split(",", l.Tag)  
        Dim row As Int = s(0)  
        Dim col As Int = s(1)  
        grid(row, col) = 0  
    End If  
'    l.TextColor = fx.Colors.Red  
'    CSSUtils.SetBackgroundColor(l, fx.Colors.Black)  
'    Log("Label :" & l.Tag)  
End Sub  
  
  
Private Sub Button1_Click  
    nativeMe.RunMethod("main1", Array(grid))  
End Sub  
  
Sub path_result(comp As Boolean, result As String)  
    Log("")  
    Log("here")  
    result = result.Replace("->", ",")  
    result = result.Replace(" ", "")  
    Log(result)  
  
    result = result.SubString2(1, result.Length)  
    result = result.Replace("),(", ";")  
    result = result.Replace("(", "")  
    result = result.Replace(")", "")  
    
    Dim split() As String = Regex.Split(";", result)  
    
    For i = 0 To 8  
        For j = 0 To 9  
            For k = 0 To split.Length - 1  
                If lbl(i,j).Tag = split(k) Then  
                    If lbl(i,j).Tag <> startTag And lbl(i,j).Tag <> endTag Then  
                        CSSUtils.SetBackgroundColor(lbl(i,j), fx.Colors.Yellow)  
                    End If   
                End If  
            Next  
        Next  
    Next  
    
    Log(result)  
  
    
End Sub  
  
  
#if Java  
  
import java.util.ArrayList;  
import java.util.Collections;  
import java.util.HashMap;  
import java.util.LinkedHashMap;  
import java.util.List;  
import java.util.Map;  
  
static class Cell {  
    int parent_i, parent_j;  
    double f, g, h;  
  
    Cell()  
    {  
        this.parent_i = 0;  
        this.parent_j = 0;  
        this.f = 0;  
        this.g = 0;  
        this.h = 0;  
    }  
}  
  
  
  
    private static final int ROW = 9;  
    private static final int COL = 10;  
    static int[] src;  
    static int[] dest;  
    static int[][] grid;  
    static String pad = "";  
  
    public static void main1(int[][] myIntArray) {   //  
  
        // Description of the Grid-  
        // 1–> The cell is not blocked  
        // 0–> The cell is blocked  
/*        int[][] grid = { { 1, 0, 1, 1, 1, 1, 0, 1, 1, 1 },  
                         { 1, 0, 1, 0, 1, 1, 1, 0, 1, 1 },  
                         { 1, 1, 1, 0, 1, 1, 0, 1, 0, 1 },  
                         { 0, 0, 1, 0, 1, 0, 0, 0, 0, 1 },  
                         { 1, 0, 0, 0, 1, 1, 1, 0, 1, 0 },  
                         { 1, 0, 1, 1, 1, 1, 0, 1, 0, 0 },  
                         { 1, 1, 0, 0, 0, 1, 0, 0, 0, 1 },  
                         { 0, 0, 1, 1, 1, 1, 0, 1, 1, 1 },  
                         { 1, 1, 1, 0, 0, 0, 1, 0, 0, 1 } }; */  
                        
            grid = myIntArray;  
                
  
        // Source is the left-most bottom-most corner  
        //int[] src = { 8, 0 };  
  
        // Destination is the left-most top-most corner  
        //int[] dest = { 0, 0 };  
  
        aStarSearch(grid, src, dest);  
    }  
    
    
    public static void setStart(int[] mysrc) {  
        src = mysrc;  
    }  
    
    public static void setEnd(int[] mydest) {  
        dest = mydest;  
    }  
  
    private static boolean isValid(int row, int col)  
    {  
        return (row >= 0) && (row < ROW) && (col >= 0)  
            && (col < COL);  
    }  
  
    private static boolean isUnBlocked(int[][] grid,  
                                       int row, int col)  
    {  
        return grid[row][col] == 1;  
    }  
  
    private static boolean isDestination(int row, int col,  
                                         int[] dest)  
    {  
        return row == dest[0] && col == dest[1];  
    }  
  
    private static double calculateHValue(int row, int col,  
                                          int[] dest)  
    {  
        return Math.sqrt((row - dest[0]) * (row - dest[0])  
                         + (col - dest[1])  
                               * (col - dest[1]));  
    }  
  
    private static void tracePath(Cell[][] cellDetails,  
                                  int[] dest)  
    {  
        System.out.println("The Path is ");  
        int row = dest[0];  
        int col = dest[1];  
  
        Map<int[], Boolean> path = new LinkedHashMap<>();  
  
        while (  
            !(cellDetails[row][col].parent_i == row  
              && cellDetails[row][col].parent_j == col)) {  
            path.put(new int[] { row, col }, true);  
            int temp_row = cellDetails[row][col].parent_i;  
            int temp_col = cellDetails[row][col].parent_j;  
            row = temp_row;  
            col = temp_col;  
        }  
  
        path.put(new int[] { row, col }, true);  
        List<int[]> pathList  
            = new ArrayList<>(path.keySet());  
        Collections.reverse(pathList);  
  
        pathList.forEach(p -> {  
            if (p[0] == 2 || p[0] == 1) {  
                System.out.print("-> (" + p[0] + ", "  
                                 + (p[1]) + ")");  
                                 pad = pad + "-> (" + p[0] + ", "  
                                 + (p[1]) + ")";  
            }  
            else {  
                System.out.print("-> (" + p[0] + ", " + p[1]  
                                 + ")");  
                                 pad = pad + "-> (" + p[0] + ", " + p[1]  
                                 + ")";  
            }  
        });  
        ba.raiseEvent(null, "path_result", true, pad);  
        System.out.println();  
    }  
  
    private static void aStarSearch(int[][] grid, int[] src,  
                                    int[] dest)  
    {  
        if (!isValid(src[0], src[1])  
            || !isValid(dest[0], dest[1])) {  
            System.out.println(  
                "Source or destination is invalid");  
            return;  
        }  
  
        if (!isUnBlocked(grid, src[0], src[1])  
            || !isUnBlocked(grid, dest[0], dest[1])) {  
            System.out.println(  
                "Source or the destination is blocked");  
            return;  
        }  
  
        if (isDestination(src[0], src[1], dest)) {  
            System.out.println(  
                "We are already at the destination");  
            return;  
        }  
  
        boolean[][] closedList = new boolean[ROW][COL];  
        Cell[][] cellDetails = new Cell[ROW][COL];  
  
        for (int i = 0; i < ROW; i++) {  
            for (int j = 0; j < COL; j++) {  
                cellDetails[j] = new Cell();  
                cellDetails[j].f  
                    = Double.POSITIVE_INFINITY;  
                cellDetails[j].g  
                    = Double.POSITIVE_INFINITY;  
                cellDetails[j].h  
                    = Double.POSITIVE_INFINITY;  
                cellDetails[j].parent_i = -1;  
                cellDetails[j].parent_j = -1;  
            }  
        }  
  
        int i = src[0], j = src[1];  
        cellDetails[j].f = 0;  
        cellDetails[j].g = 0;  
        cellDetails[j].h = 0;  
        cellDetails[j].parent_i = i;  
        cellDetails[j].parent_j = j;  
  
        Map<Double, int[]> openList = new HashMap<>();  
        openList.put(0.0, new int[] { i, j });  
  
        boolean foundDest = false;  
  
        while (!openList.isEmpty()) {  
            Map.Entry<Double, int[]> p  
                = openList.entrySet().iterator().next();  
            for (Map.Entry<Double, int[]> q :  
                 openList.entrySet()) {  
                if (q.getKey() < p.getKey()) {  
                    p = q;  
                }  
            }  
  
            openList.remove(p.getKey());  
  
            i = p.getValue()[0];  
            j = p.getValue()[1];  
            closedList[j] = true;  
  
            double gNew, hNew, fNew;  
  
            // 1st Successor (North)  
            if (isValid(i - 1, j)) {  
                if (isDestination(i - 1, j, dest)) {  
                    cellDetails[j].parent_i = i;  
                    cellDetails[j].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j]  
                         && isUnBlocked(grid, i - 1, j)) {  
                    gNew = cellDetails[j].g + 1;  
                    hNew = calculateHValue(i - 1, j, dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j].f  
                            == Double.POSITIVE_INFINITY  
  
                        || cellDetails[j].f > fNew) {  
                        openList.put(  
                            fNew, new int[] { i - 1, j });  
  
                        cellDetails[j].f = fNew;  
                        cellDetails[j].g = gNew;  
                        cellDetails[j].h = hNew;  
                        cellDetails[j].parent_i = i;  
                        cellDetails[j].parent_j = j;  
                    }  
                }  
            }  
  
            // 2nd Successor (South)  
            if (isValid(i + 1, j)) {  
                if (isDestination(i + 1, j, dest)) {  
                    cellDetails[j].parent_i = i;  
                    cellDetails[j].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j]  
                         && isUnBlocked(grid, i + 1, j)) {  
                    gNew = cellDetails[j].g + 1;  
                    hNew = calculateHValue(i + 1, j, dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j].f  
                            == Double.POSITIVE_INFINITY  
                        || cellDetails[j].f > fNew) {  
                        openList.put(  
                            fNew, new int[] { i + 1, j });  
  
                        cellDetails[j].f = fNew;  
                        cellDetails[j].g = gNew;  
                        cellDetails[j].h = hNew;  
                        cellDetails[j].parent_i = i;  
                        cellDetails[j].parent_j = j;  
                    }  
                }  
            }  
  
            // 3rd Successor (East)  
            if (isValid(i, j + 1)) {  
                if (isDestination(i, j + 1, dest)) {  
                    cellDetails[j + 1].parent_i = i;  
                    cellDetails[j + 1].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j + 1]  
                         && isUnBlocked(grid, i, j + 1)) {  
                    gNew = cellDetails[j].g + 1;  
                    hNew = calculateHValue(i, j + 1, dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j + 1].f  
                            == Double.POSITIVE_INFINITY  
                        || cellDetails[j + 1].f > fNew) {  
                        openList.put(  
                            fNew, new int[] { i, j + 1 });  
  
                        cellDetails[j + 1].f = fNew;  
                        cellDetails[j + 1].g = gNew;  
                        cellDetails[j + 1].h = hNew;  
                        cellDetails[j + 1].parent_i = i;  
                        cellDetails[j + 1].parent_j = j;  
                    }  
                }  
            }  
  
            // 4th Successor (West)  
            if (isValid(i, j - 1)) {  
                if (isDestination(i, j - 1, dest)) {  
                    cellDetails[j - 1].parent_i = i;  
                    cellDetails[j - 1].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j - 1]  
                         && isUnBlocked(grid, i, j - 1)) {  
                    gNew = cellDetails[j].g + 1;  
                    hNew = calculateHValue(i, j - 1, dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j - 1].f  
                            == Double.POSITIVE_INFINITY  
                        || cellDetails[j - 1].f > fNew) {  
                        openList.put(  
                            fNew, new int[] { i, j - 1 });  
  
                        cellDetails[j - 1].f = fNew;  
                        cellDetails[j - 1].g = gNew;  
                        cellDetails[j - 1].h = hNew;  
                        cellDetails[j - 1].parent_i = i;  
                        cellDetails[j - 1].parent_j = j;  
                    }  
                }  
            }  
  
            // 5th Successor (North-East)  
            if (isValid(i - 1, j + 1)) {  
                if (isDestination(i - 1, j + 1, dest)) {  
                    cellDetails[j + 1].parent_i = i;  
                    cellDetails[j + 1].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j + 1]  
                         && isUnBlocked(grid, i - 1,  
                                        j + 1)) {  
                    gNew = cellDetails[j].g + 1.414;  
                    hNew = calculateHValue(i - 1, j + 1,  
                                           dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j + 1].f  
                            == Double.POSITIVE_INFINITY  
                        || cellDetails[j + 1].f  
                               > fNew) {  
                        openList.put(  
                            fNew,  
                            new int[] { i - 1, j + 1 });  
  
                        cellDetails[j + 1].f = fNew;  
                        cellDetails[j + 1].g = gNew;  
                        cellDetails[j + 1].h = hNew;  
                        cellDetails[j + 1].parent_i  
                            = i;  
                        cellDetails[j + 1].parent_j  
                            = j;  
                    }  
                }  
            }  
  
            // 6th Successor (North-West)  
            if (isValid(i - 1, j - 1)) {  
                if (isDestination(i - 1, j - 1, dest)) {  
                    cellDetails[j - 1].parent_i = i;  
                    cellDetails[j - 1].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j - 1]  
                         && isUnBlocked(grid, i - 1,  
                                        j - 1)) {  
                    gNew = cellDetails[j].g + 1.414;  
                    hNew = calculateHValue(i - 1, j - 1,  
                                           dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j - 1].f  
                            == Double.POSITIVE_INFINITY  
                        || cellDetails[j - 1].f  
                               > fNew) {  
                        openList.put(  
                            fNew,  
                            new int[] { i - 1, j - 1 });  
  
                        cellDetails[j - 1].f = fNew;  
                        cellDetails[j - 1].g = gNew;  
                        cellDetails[j - 1].h = hNew;  
                        cellDetails[j - 1].parent_i  
                            = i;  
                        cellDetails[j - 1].parent_j  
                            = j;  
                    }  
                }  
            }  
  
            // 7th Successor (South-East)  
            if (isValid(i + 1, j + 1)) {  
                if (isDestination(i + 1, j + 1, dest)) {  
                    cellDetails[j + 1].parent_i = i;  
                    cellDetails[j + 1].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j + 1]  
                         && isUnBlocked(grid, i + 1,  
                                        j + 1)) {  
                    gNew = cellDetails[j].g + 1.414;  
                    hNew = calculateHValue(i + 1, j + 1,  
                                           dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j + 1].f  
                            == Double.POSITIVE_INFINITY  
                        || cellDetails[j + 1].f  
                               > fNew) {  
                        openList.put(  
                            fNew,  
                            new int[] { i + 1, j + 1 });  
  
                        cellDetails[j + 1].f = fNew;  
                        cellDetails[j + 1].g = gNew;  
                        cellDetails[j + 1].h = hNew;  
                        cellDetails[j + 1].parent_i  
                            = i;  
                        cellDetails[j + 1].parent_j  
                            = j;  
                    }  
                }  
            }  
  
            // 8th Successor (South-West)  
            if (isValid(i + 1, j - 1)) {  
                if (isDestination(i + 1, j - 1, dest)) {  
                    cellDetails[j - 1].parent_i = i;  
                    cellDetails[j - 1].parent_j = j;  
                    System.out.println(  
                        "The destination cell is found");  
                    tracePath(cellDetails, dest);  
                    foundDest = true;  
                    return;  
                }  
                else if (!closedList[j - 1]  
                         && isUnBlocked(grid, i + 1,  
                                        j - 1)) {  
                    gNew = cellDetails[j].g + 1.414;  
                    hNew = calculateHValue(i + 1, j - 1,  
                                           dest);  
                    fNew = gNew + hNew;  
  
                    if (cellDetails[j - 1].f  
                            == Double.POSITIVE_INFINITY  
                        || cellDetails[j - 1].f  
                               > fNew) {  
                        openList.put(  
                            fNew,  
                            new int[] { i + 1, j - 1 });  
  
                        cellDetails[j - 1].f = fNew;  
                        cellDetails[j - 1].g = gNew;  
                        cellDetails[j - 1].h = hNew;  
                        cellDetails[j - 1].parent_i  
                            = i;  
                        cellDetails[j - 1].parent_j  
                            = j;  
                    }  
                }  
            }  
        }  
  
        if (!foundDest)  
            System.out.println(  
                "Failed to find the destination cell");  
    }  
  
  
#End If
```
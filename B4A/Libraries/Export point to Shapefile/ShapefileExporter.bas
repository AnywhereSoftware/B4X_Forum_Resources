B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1.4
@EndOfDesignText@

' ============================================================================
' SHAPEFILE EXPORTER CLASS
' Version 1.01 - Fixed for Internal Storage
' This class handles exporting survey points to ESRI Shapefile format
' ============================================================================

Sub Class_Globals
    Private xui As XUI
    Private Const SHAPE_TYPE_POINT As Int = 1   ' Shapefile point type constant
End Sub

' ============================================================================
' INITIALIZATION
' ============================================================================

Public Sub Initialize
    ' Initialization code if needed - currently empty
End Sub

' ============================================================================
' MAIN EXPORT METHOD
' ============================================================================

' Main shapefile creator
' Parameters:
'   Dir - Directory path (e.g., File.DirInternal)
'   FileName - Base name for shapefile components
'   Points - List of point data arrays
'   Fields - List of field definitions for DBF
'   Charset - Character encoding (e.g., "UTF-8")
'   PrjWkt - WKT string for projection definition
' Returns: True if successful, False otherwise
Public Sub CreateShapefileFinal(Dir As String, FileName As String, Points As List, Fields As List, _
                               Charset As String, PrjWkt As String) As Boolean
    Try
        Dim recordCount As Int = Points.Size
        
        ' ===== CALCULATE BOUNDING BOX =====
        ' Initialize bounds to extreme values
        Dim minX As Double = 1e100
        Dim minY As Double = 1e100
        Dim maxX As Double = -1e100
        Dim maxY As Double = -1e100
        
        ' Loop through all points to find min/max coordinates
        For i = 0 To recordCount - 1
            Dim p() As Object = Points.Get(i)
            Dim x As Double = p(0)   ' X coordinate (Longitude)
            Dim y As Double = p(1)   ' Y coordinate (Latitude)
            If x < minX Then minX = x
            If y < minY Then minY = y
            If x > maxX Then maxX = x
            If y > maxY Then maxY = y
        Next
        
        ' ===== CREATE SHAPEFILE COMPONENTS =====
        ' Create the main .shp file (geometry)
        CreateSHPFinal(Dir, FileName & ".shp", Points, recordCount, minX, minY, maxX, maxY)
        
        ' Create the .shx index file
        CreateSHXFinal(Dir, FileName & ".shx", recordCount, minX, minY, maxX, maxY)
        
        ' Create the .dbf attribute file
        CreateDBFFinal(Dir, FileName & ".dbf", Points, recordCount, Fields, Charset)
        
        ' Create the .prj projection file
        CreatePrjFile(Dir, FileName, PrjWkt)
        
        ' Create the .cpg code page file
        CreateCpgFile(Dir, FileName, Charset)
        
        Return True
    Catch
        Log("Error in CreateShapefileFinal: " & LastException.Message)
        Return False
    End Try
End Sub

' ============================================================================
' SUPPORTING FILE CREATORS
' ============================================================================

' Create the .prj projection definition file
Private Sub CreatePrjFile(Dir As String, FileName As String, WktString As String)
    ' Standard B4A File Write
    File.WriteString(Dir, FileName & ".prj", WktString)
End Sub

' Create the .cpg code page (character encoding) file
Private Sub CreateCpgFile(Dir As String, FileName As String, Charset As String)
    File.WriteString(Dir, FileName & ".cpg", Charset)
End Sub

' ============================================================================
' SHP FILE (GEOMETRY) METHODS
' ============================================================================

' Create the main .shp file containing point geometries
Private Sub CreateSHPFinal(Dir As String, FileName As String, Points As List, RecordCount As Int, _
                           MinX As Double, MinY As Double, MaxX As Double, MaxY As Double)
    
    Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
    
    ' Calculate file length in 16-bit words (header + all records)
    Dim fileLengthWords As Int = 50 + (RecordCount * 14)
    
    ' Write the 100-byte header
    Dim headerBytes() As Byte = BuildCommonHeader(fileLengthWords, MinX, MinY, MaxX, MaxY)
    out.WriteBytes(headerBytes, 0, headerBytes.Length)
    
    ' Write each point record
    For i = 0 To RecordCount - 1
        Dim p() As Object = Points.Get(i)
        Dim recordBytes() As Byte = BuildPointRecord(i + 1, p(0), p(1))
        out.WriteBytes(recordBytes, 0, recordBytes.Length)
    Next
    
    out.Close
End Sub

' Build a single point record for .shp file
' recordNum: 1-based record number
' x: X coordinate (Longitude)
' y: Y coordinate (Latitude)
Private Sub BuildPointRecord(recordNum As Int, x As Double, y As Double) As Byte()
    Dim buffer As JavaObject
    Dim byteBuffer As JavaObject
    byteBuffer.InitializeStatic("java.nio.ByteBuffer")
    Dim byteOrder As JavaObject
    byteOrder.InitializeStatic("java.nio.ByteOrder")
    
    ' Allocate 28 bytes: 8 bytes header + 20 bytes content
    buffer = byteBuffer.RunMethod("allocate", Array(28))
    
    ' Write header in Big Endian (network byte order)
    buffer.RunMethod("order", Array(byteOrder.GetField("BIG_ENDIAN")))
    buffer.RunMethod("putInt", Array(recordNum))   ' Record number
    buffer.RunMethod("putInt", Array(10))          ' Content length in 16-bit words
    
    ' Write content in Little Endian (Intel byte order)
    buffer.RunMethod("order", Array(byteOrder.GetField("LITTLE_ENDIAN")))
    buffer.RunMethod("putInt", Array(SHAPE_TYPE_POINT))   ' Shape type (1 = point)
    buffer.RunMethod("putDouble", Array(x))               ' X coordinate
    buffer.RunMethod("putDouble", Array(y))               ' Y coordinate
    
    Return buffer.RunMethod("array", Null)
End Sub

' ============================================================================
' SHX FILE (INDEX) METHODS
' ============================================================================

' Create the .shx index file
Private Sub CreateSHXFinal(Dir As String, FileName As String, recordCount As Int, _
                           minX As Double, minY As Double, maxX As Double, maxY As Double)
    
    Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
    
    ' Calculate file length in 16-bit words (header + index records)
    Dim fileLengthWords As Int = 50 + (recordCount * 4)
    
    ' Write the 100-byte header (identical to .shp header)
    Dim headerBytes() As Byte = BuildCommonHeader(fileLengthWords, minX, minY, maxX, maxY)
    out.WriteBytes(headerBytes, 0, headerBytes.Length)
    
    ' Write index record for each point
    For i = 0 To recordCount - 1
        ' Calculate offset in 16-bit words
        Dim offsetWords As Int = 50 + (i * 14)
        Dim recBytes() As Byte = BuildSHXRecord(offsetWords)
        out.WriteBytes(recBytes, 0, recBytes.Length)
    Next
    
    out.Close
End Sub

' Build a single index record for .shx file
' offsetWords: Offset to the record in the .shp file (in 16-bit words)
Sub BuildSHXRecord(offsetWords As Int) As Byte()
    Dim buffer As JavaObject
    Dim byteBuffer As JavaObject
    byteBuffer.InitializeStatic("java.nio.ByteBuffer")
    Dim byteOrder As JavaObject
    byteOrder.InitializeStatic("java.nio.ByteOrder")
    
    ' Allocate 8 bytes per index record
    buffer = byteBuffer.RunMethod("allocate", Array(8))
    
    ' Write in Big Endian format
    buffer.RunMethod("order", Array(byteOrder.GetField("BIG_ENDIAN")))
    buffer.RunMethod("putInt", Array(offsetWords))   ' Offset to record
    buffer.RunMethod("putInt", Array(10))            ' Content length in 16-bit words
    
    Return buffer.RunMethod("array", Null)
End Sub

' ============================================================================
' SHAPEFILE HEADER METHODS
' ============================================================================

' Build the common 100-byte header for both .shp and .shx files
' fileLengthWords: Total file length in 16-bit words
' minX, minY, maxX, maxY: Bounding box coordinates
Private Sub BuildCommonHeader(fileLengthWords As Int, minX As Double, minY As Double, maxX As Double, maxY As Double) As Byte()
    Dim buffer As JavaObject
    Dim byteBuffer As JavaObject
    byteBuffer.InitializeStatic("java.nio.ByteBuffer")
    Dim byteOrder As JavaObject
    byteOrder.InitializeStatic("java.nio.ByteOrder")
    
    ' Allocate 100 bytes for the header
    buffer = byteBuffer.RunMethod("allocate", Array(100))
    
    ' ===== FIRST PART - BIG ENDIAN (20 bytes) =====
    buffer.RunMethod("order", Array(byteOrder.GetField("BIG_ENDIAN")))
    buffer.RunMethod("putInt", Array(9994))          ' File code (always 9994)
    
    ' Skip 5 integers (20 bytes) - unused fields
    For i = 0 To 4 : buffer.RunMethod("putInt", Array(0)) : Next
    
    buffer.RunMethod("putInt", Array(fileLengthWords))   ' File length
    
    ' ===== SECOND PART - LITTLE ENDIAN (80 bytes) =====
    buffer.RunMethod("order", Array(byteOrder.GetField("LITTLE_ENDIAN")))
    buffer.RunMethod("putInt", Array(1000))           ' Version (1000 for shapefile)
    buffer.RunMethod("putInt", Array(SHAPE_TYPE_POINT))   ' Shape type (1 = point)
    
    ' Bounding box coordinates
    buffer.RunMethod("putDouble", Array(minX))        ' X min
    buffer.RunMethod("putDouble", Array(minY))        ' Y min
    buffer.RunMethod("putDouble", Array(maxX))        ' X max
    buffer.RunMethod("putDouble", Array(maxY))        ' Y max
    
    ' Skip 4 doubles (32 bytes) - Z and M ranges (unused)
    For i = 0 To 3 : buffer.RunMethod("putDouble", Array(0.0)) : Next
    
    Return buffer.RunMethod("array", Null)
End Sub

' ============================================================================
' DBF FILE (ATTRIBUTE TABLE) METHODS
' ============================================================================

' Create the .dbf attribute file containing point metadata
Private Sub CreateDBFFinal(Dir As String, FileName As String, Points As List, _
                           recordCount As Int, fields As List, Charset As String)
    
    Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
    
    ' Calculate number of fields and record length
    Dim numberOfFields As Int = fields.Size
    Dim recordLength As Int = 1   ' Start with 1 byte for deletion flag
    
    ' Sum up field lengths to get total record length
    For i = 0 To fields.Size - 1
        Dim field() As Object = fields.Get(i)
        recordLength = recordLength + field(2)
    Next
    
    ' Write header (32 bytes)
    out.WriteBytes(BuildDBFHeader(recordCount, numberOfFields, recordLength), 0, 32)
    
    ' Write field descriptors (32 bytes per field)
    For i = 0 To fields.Size - 1
        Dim field() As Object = fields.Get(i)
        Dim fieldBytes() As Byte = BuildDBFField(field(0), field(1), field(2), field(3), Charset)
        out.WriteBytes(fieldBytes, 0, fieldBytes.Length)
    Next
    
    ' Write header terminator (0x0D)
    out.WriteBytes(Array As Byte(0x0D), 0, 1)
    
    ' Write all data records
    For i = 0 To recordCount - 1
        Dim p() As Object = Points.Get(i)
        Dim recordBytes() As Byte = BuildDBFRecordDynamic(p, fields, Charset)
        out.WriteBytes(recordBytes, 0, recordBytes.Length)
    Next
    
    ' Write end of file marker (0x1A)
    out.WriteBytes(Array As Byte(0x1A), 0, 1)
    
    out.Close
End Sub

' Build the 32-byte DBF file header
' recordCount: Number of records in the file
' numberOfFields: Number of fields in the table
' recordLength: Length of each record in bytes
Sub BuildDBFHeader(recordCount As Int, numberOfFields As Int, recordLength As Int) As Byte()
    Dim header(32) As Byte
    
    ' Version number (0x03 = dBASE Level 5)
    header(0) = 0x03
    
    ' Date of last update (YY, MM, DD) - using arbitrary date
    header(1) = 24 : header(2) = 1 : header(3) = 1
    
    ' Number of records (4 bytes, little endian)
    header(4) = Bit.And(recordCount, 0xFF)
    header(5) = Bit.And(Bit.ShiftRight(recordCount, 8), 0xFF)
    header(6) = Bit.And(Bit.ShiftRight(recordCount, 16), 0xFF)
    header(7) = Bit.And(Bit.ShiftRight(recordCount, 24), 0xFF)
    
    ' Header length (32 bytes + 32 bytes per field + 1 terminator)
    Dim headerLength As Int = 32 + (numberOfFields * 32) + 1
    header(8) = Bit.And(headerLength, 0xFF)
    header(9) = Bit.And(Bit.ShiftRight(headerLength, 8), 0xFF)
    
    ' Record length (2 bytes, little endian)
    header(10) = Bit.And(recordLength, 0xFF)
    header(11) = Bit.And(Bit.ShiftRight(recordLength, 8), 0xFF)
    
    ' Remaining header bytes are left as zeros (default values)
    
    Return header
End Sub

' Build a 32-byte field descriptor for DBF file
' fieldName: Name of the field (max 10 characters)
' fieldType: "N" for numeric, "C" for character
' length: Field length in bytes
' decimals: Number of decimal places (for numeric fields)
' Charset: Character encoding for field name
Sub BuildDBFField(fieldName As String, fieldType As String, length As Int, decimals As Int, Charset As String) As Byte()
    Dim field(32) As Byte
    
    ' Field name (11 bytes, but only first 10 are used)
    Dim nameBytes() As Byte = fieldName.GetBytes(Charset)
    For i = 0 To Min(nameBytes.Length - 1, 10) : field(i) = nameBytes(i) : Next
    
    ' Field type (byte 11)
    field(11) = Asc(fieldType)
    
    ' Field length (byte 16)
    field(16) = length
    
    ' Decimal count (byte 17)
    field(17) = decimals
    
    ' Remaining bytes are left as zeros (default values)
    
    Return field
End Sub

' Build a single data record for DBF file
' values: Array of values for each field (starting from index 2 after geometry)
' fields: List of field definitions
' Charset: Character encoding for text values
Sub BuildDBFRecordDynamic(values() As Object, fields As List, Charset As String) As Byte()
    ' Calculate record length
    Dim recordLength As Int = 1   ' Start with 1 byte for deletion flag
    For i = 0 To fields.Size - 1
        Dim field() As Object = fields.Get(i)
        recordLength = recordLength + field(2)
    Next
    
    ' Initialize record with spaces (0x20)
    Dim record(recordLength) As Byte
    For i = 0 To recordLength - 1 : record(i) = 32 : Next
    
    ' Deletion flag (0x20 = not deleted)
    record(0) = 32
    
    ' Write each field value
    Dim pos As Int = 1   ' Start after deletion flag
    
    For i = 0 To fields.Size - 1
        Dim field() As Object = fields.Get(i)
        Dim fieldType As String = field(1)
        Dim fieldLen As Int = field(2)
        Dim decimals As Int = field(3)
        Dim value As Object = values(i + 2)   ' Offset by 2 for geometry (X, Y)
        
        If fieldType = "N" Then   ' Numeric field
            Dim sValue As String
            If value Is Double Or value Is Float Then
                sValue = NumberFormat2(value, 1, decimals, decimals, False)
            Else
                sValue = value
            End If
            
            ' Truncate if too long
            If sValue.Length > fieldLen Then sValue = sValue.SubString(sValue.Length - fieldLen)
            
            ' Right-align numeric values
            Dim bValue() As Byte = sValue.GetBytes(Charset)
            Dim offset As Int = pos + fieldLen - bValue.Length
            For j = 0 To bValue.Length - 1 : record(offset + j) = bValue(j) : Next
            
        Else If fieldType = "C" Then   ' Character field
            Dim sValue As String = ""
            If value <> Null Then sValue = value
            
            ' Truncate if too long
            If sValue.Length > fieldLen Then sValue = sValue.SubString2(0, fieldLen)
            
            ' Left-align character values
            Dim bValue() As Byte = sValue.GetBytes(Charset)
            For j = 0 To bValue.Length - 1 : record(pos + j) = bValue(j) : Next
        End If
        
        pos = pos + fieldLen
    Next
    
    Return record
End Sub
B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.28
@EndOfDesignText@
'version 1.60
Sub Class_Globals
	Private xui As XUI
	Public cvs As B4XCanvas
	Private ModuleSize As Int
	Private GFSize As Int = 256
	Private ExpTable(GFSize) As Int
	Private LogTable(GFSize) As Int
	Private PolyZero() As Int = Array As Int(0)
	'7, 10, 13, 15, 16, 17, 18, 20, 22, 24, 26, 28, and 30
	Private Generator7() As Int = Array As Int(1, 127, 122, 154, 164, 11, 68, 117)
	Private Generator10() As Int = Array As Int(1, 216, 194, 159, 111, 199, 94, 95, 113, 157, 193)
	Private Generator13() As Int = Array As Int(1, 137, 73, 227, 17, 177, 17, 52, 13, 46, 43, 83, 132, 120)
	Private Generator15() As Int = Array As Int(1, 29, 196, 111, 163, 112, 74, 10, 105, 105, 139, 132, 151, 32, 134, 26)
	Private Generator16() As Int = Array As Int(1, 59, 13, 104, 189, 68, 209, 30, 8, 163, 65, 41, 229, 98, 50, 36, 59)
	Private Generator17() As Int = Array As Int(1, 119, 66, 83, 120, 119, 22, 197, 83, 249, 41, 143, 134, 85, 53, 125, 99, 79)
	Private Generator18() As Int = Array As Int(1, 239, 251, 183, 113, 149, 175, 199, 215, 240, 220, 73, 82, 173, 75, 32, 67, 217, 146)
	Private Generator20() As Int = Array As Int(1, 152, 185, 240, 5, 111, 99, 6, 220, 112, 150, 69, 36, 187, 22, 228, 198, 121, 121, 165, 174)
	Private Generator22() As Int = Array As Int(1, 89, 179, 131, 176, 182, 244, 19, 189, 69, 40, 28, 137, 29, 123, 67, 253, 86, 218, 230, 26, 145, 245) 
	Private Generator24() As Int = Array As Int(1, 122, 118, 169, 70, 178, 237, 216, 102, 115, 150, 229, 73, 130, 72, 61, 43, 206, 1, 237, 247, 127, 217, 144, 117)
	Private Generator26() As Int = Array As Int(1, 246, 51, 183, 4, 136, 98, 199, 152, 77, 56, 206, 24, 145, 40, 209, 117, 233, 42, 135, 68, 70, 144, 146, 77, 43, 94)
	Private Generator28() As Int = Array As Int(1, 252, 9, 28, 13, 18, 251, 208, 150, 103, 174, 100, 41, 167, 12, 247, 56, 117, 119, 233, 127, 181, 100, 121, 147, 176, 74, 58, 197)
	Private Generator30() As Int = Array As Int(1, 212, 246, 77, 73, 195, 192, 75, 98, 5, 70, 103, 177, 22, 217, 138, 51, 181, 246, 72, 25, 18, 46, 228, 74, 216, 195, 11, 106, 130, 150)


	Private TempBB As B4XBytesBuilder
	Private Matrix(0, 0) As Boolean
	Private Reserved(0, 0) As Boolean
	Private NumberOfModules As Int
	Private mBitmapSize As Int
	Type QRVersionData (Format() As Byte, Generator() As Int, MaxSize As Int, Version As Int, MaxUsableSize As Int, Alignments() As Int, _
		Group1Size As Int, Group2Size As Int, Block1Size As Int, Block2Size As Int, VersionName As String, VersionInformation() As Byte)
	Private versions As List
End Sub


Public Sub Initialize (BitmapSize As Int)
	TempBB.Initialize
	mBitmapSize = BitmapSize
	PrepareTables
	versions.Initialize
	'format information for masking pattern 0
	Dim L0() As Byte = Array As Byte(1,1,1,0,1,1,1,1,1,0,0,0,1,0,0)     'ECC Level L
	Dim M0() As Byte = Array As Byte(1,0,1,0,1,0,0,0,0,0,1,0,0,1,0)     'ECC Level M
	Dim Q0() As Byte = Array As Byte(0,1,1,0,1,0,1,0,1,0,1,1,1,1,1)     'ECC Level Q
	Dim H0() As Byte = Array As Byte(0,0,1,0,1,1,0,1,0,0,0,1,0,0,1)     'ECC Level H
	
	versions.Add(CreateVersionData(1, "1L", Generator7,  L0, 19 * 8, 17, Array As Int(), 1, 0, 19, 0, Null))
	versions.Add(CreateVersionData(1, "1M", Generator10, M0, 16 * 8, 14, Array As Int(), 1, 0, 16, 0, Null))
	versions.Add(CreateVersionData(1, "1Q", Generator13, Q0, 13 * 8, 11, Array As Int(), 1, 0, 13, 0, Null))
	versions.Add(CreateVersionData(1, "1H", Generator17, H0,  9 * 8,  7, Array As Int(), 1, 0,  9, 0, Null))
	
	versions.Add(CreateVersionData(2, "2L", Generator10, L0, 34 * 8, 32, Array As Int(6, 18), 1, 0, 34, 0, Null))
	versions.Add(CreateVersionData(2, "2M", Generator16, M0, 28 * 8, 26, Array As Int(6, 18), 1, 0, 28, 0, Null))
	versions.Add(CreateVersionData(2, "2Q", Generator22, Q0, 22 * 8, 20, Array As Int(6, 18), 1, 0, 22, 0, Null))
	versions.Add(CreateVersionData(2, "2H", Generator28, H0, 16 * 8, 14, Array As Int(6, 18), 1, 0, 16, 0, Null))

	versions.Add(CreateVersionData(3, "3L", Generator15, L0, 55 * 8, 53, Array As Int(6, 22), 1, 0, 55, 0, Null))
	versions.Add(CreateVersionData(3, "3M", Generator26, M0, 44 * 8, 42, Array As Int(6, 22), 1, 0, 44, 0, Null))
	versions.Add(CreateVersionData(3, "3Q", Generator18, Q0, 34 * 8, 32, Array As Int(6, 22), 2, 0, 17, 0, Null))
	versions.Add(CreateVersionData(3, "3H", Generator22, H0, 26 * 8, 24, Array As Int(6, 22), 2, 0, 13, 0, Null))
	
	versions.Add(CreateVersionData(4, "4L", Generator20, L0 , 80 * 8, 78, Array As Int(6, 26), 1, 0, 80, 0, Null))
	versions.Add(CreateVersionData(4, "4M", Generator18, M0 , 64 * 8, 62, Array As Int(6, 26), 2, 0, 32, 0, Null))
	versions.Add(CreateVersionData(4, "4Q", Generator26, Q0 , 48 * 8, 46, Array As Int(6, 26), 2, 0, 24, 0, Null))
	versions.Add(CreateVersionData(4, "4H", Generator16, H0 , 36 * 8, 34, Array As Int(6, 26), 4, 0,  9, 0, Null))
	
	versions.Add(CreateVersionData(5, "5L", Generator26, L0 , 108 * 8, 106, Array As Int(6, 30), 1, 0, 108,  0, Null))
	versions.Add(CreateVersionData(5, "5M", Generator24, M0 ,  86 * 8,  84, Array As Int(6, 30), 2, 0,  43,  0, Null))
	versions.Add(CreateVersionData(5, "5Q", Generator18, Q0 ,  62 * 8,  60, Array As Int(6, 30), 2, 2,  15, 16, Null))
	versions.Add(CreateVersionData(5, "5H", Generator22, H0 ,  46 * 8,  44, Array As Int(6, 30), 2, 2,  11, 12, Null))

	versions.Add(CreateVersionData(6, "6L", Generator18, L0 , 136 * 8, 134, Array As Int(6, 34), 2, 0, 68, 0, Null))
	versions.Add(CreateVersionData(6, "6M", Generator16, M0 , 108 * 8, 106, Array As Int(6, 34), 4, 0, 27, 0, Null))
	versions.Add(CreateVersionData(6, "6Q", Generator24, Q0 ,  76 * 8,  74, Array As Int(6, 34), 4, 0, 19, 0, Null))
	versions.Add(CreateVersionData(6, "6H", Generator28, H0 ,  60 * 8,  58, Array As Int(6, 34), 4, 0, 15, 0, Null))
	
	versions.Add(CreateVersionData(7, "7L", Generator20, L0 , 156 * 8, 154, Array As Int(6, 22, 38), 2, 0, 78,  0, Array As Byte(0,0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0)))
	versions.Add(CreateVersionData(7, "7M", Generator18, M0 , 124 * 8, 122, Array As Int(6, 22, 38), 4, 0, 31,  0, Array As Byte(0,0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0)))
	versions.Add(CreateVersionData(7, "7Q", Generator18, Q0 ,  88 * 8,  86, Array As Int(6, 22, 38), 2, 4, 14, 15, Array As Byte(0,0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0)))
	versions.Add(CreateVersionData(7, "7H", Generator26, H0 ,  66 * 8,  64, Array As Int(6, 22, 38), 4, 1, 13, 14, Array As Byte(0,0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0)))
	
	versions.Add(CreateVersionData(8, "8L", Generator24, L0 , 194 * 8, 192, Array As Int(6, 24, 42), 2, 0, 97,  0, Array As Byte(0,0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0)))
	versions.Add(CreateVersionData(8, "8M", Generator22, M0 , 154 * 8, 152, Array As Int(6, 24, 42), 2, 2, 38, 39, Array As Byte(0,0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0)))
	versions.Add(CreateVersionData(8, "8Q", Generator22, Q0 , 110 * 8, 108, Array As Int(6, 24, 42), 4, 2, 18, 19, Array As Byte(0,0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0)))
	versions.Add(CreateVersionData(8, "8H", Generator26, H0 ,  86 * 8,  84, Array As Int(6, 24, 42), 4, 2, 14, 15, Array As Byte(0,0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0)))
		
	versions.Add(CreateVersionData(9, "9L", Generator30, L0,  232 * 8, 230, Array As Int(6, 26, 46), 2, 0, 116, 0, Array As Byte(0,0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1)))
	versions.Add(CreateVersionData(9, "9M", Generator22, M0 , 182 * 8, 180, Array As Int(6, 26, 46), 3, 2, 36, 37, Array As Byte(0,0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1)))
	versions.Add(CreateVersionData(9, "9Q", Generator20, Q0 , 132 * 8, 130, Array As Int(6, 26, 46), 4, 4, 16, 17, Array As Byte(0,0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1)))
	versions.Add(CreateVersionData(9, "9H", Generator24, H0 , 100 * 8,  98, Array As Int(6, 26, 46), 4, 4, 12, 13, Array As Byte(0,0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1)))
	
	versions.Add(CreateVersionData(10, "10L", Generator18, L0,  274 * 8, 271, Array As Int(6, 28, 50), 2, 2, 68, 69, Array As Byte(0,0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1)))
	versions.Add(CreateVersionData(10, "10M", Generator26, M0 , 216 * 8, 213, Array As Int(6, 28, 50), 4, 1, 43, 44, Array As Byte(0,0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1)))
	versions.Add(CreateVersionData(10, "10Q", Generator24, Q0 , 154 * 8, 151, Array As Int(6, 28, 50), 6, 2, 19, 20, Array As Byte(0,0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1)))
	versions.Add(CreateVersionData(10, "10H", Generator28, H0 , 122 * 8, 119, Array As Int(6, 28, 50), 6, 2, 15, 16, Array As Byte(0,0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1)))

	versions.Add(CreateVersionData(11, "11L", Generator20, L0,  324 * 8, 321, Array As Int(6, 30, 54), 4, 0, 81,  0, Array As Byte(0,0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0)))
	versions.Add(CreateVersionData(11, "11M", Generator30, M0 , 254 * 8, 251, Array As Int(6, 30, 54), 1, 4, 50, 51, Array As Byte(0,0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0)))
	versions.Add(CreateVersionData(11, "11Q", Generator28, Q0 , 180 * 8, 177, Array As Int(6, 30, 54), 4, 4, 22, 23, Array As Byte(0,0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0)))
	versions.Add(CreateVersionData(11, "11H", Generator24, H0 , 140 * 8, 137, Array As Int(6, 30, 54), 3, 8, 12, 13, Array As Byte(0,0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0)))

	versions.Add(CreateVersionData(12, "12L", Generator24, L0,  370 * 8, 367, Array As Int(6, 32, 58), 2, 2, 92, 93, Array As Byte(0,0,1,1,0,0,0,1,1,1,0,1,1,0,0,0,1,0)))
	versions.Add(CreateVersionData(12, "12M", Generator22, M0 , 290 * 8, 287, Array As Int(6, 32, 58), 6, 2, 36, 37, Array As Byte(0,0,1,1,0,0,0,1,1,1,0,1,1,0,0,0,1,0)))
	versions.Add(CreateVersionData(12, "12Q", Generator26, Q0 , 206 * 8, 203, Array As Int(6, 32, 58), 4, 6, 20, 21, Array As Byte(0,0,1,1,0,0,0,1,1,1,0,1,1,0,0,0,1,0)))
	versions.Add(CreateVersionData(12, "12H", Generator28, H0 , 158 * 8, 155, Array As Int(6, 32, 58), 7, 4, 14, 15, Array As Byte(0,0,1,1,0,0,0,1,1,1,0,1,1,0,0,0,1,0)))

	versions.Add(CreateVersionData(13, "13L", Generator26, L0,  428 * 8, 425, Array As Int(6, 34, 62),  4, 0, 107, 0, Array As Byte(0,0,1,1,0,1,1,0,0,0,0,1,0,0,0,1,1,1)))
	versions.Add(CreateVersionData(13, "13M", Generator22, M0 , 334 * 8, 331, Array As Int(6, 34, 62),  8, 1, 37, 38, Array As Byte(0,0,1,1,0,1,1,0,0,0,0,1,0,0,0,1,1,1)))
	versions.Add(CreateVersionData(13, "13Q", Generator24, Q0 , 244 * 8, 241, Array As Int(6, 34, 62),  8, 4, 20, 21, Array As Byte(0,0,1,1,0,1,1,0,0,0,0,1,0,0,0,1,1,1)))
	versions.Add(CreateVersionData(13, "13H", Generator22, H0 , 180 * 8, 177, Array As Int(6, 34, 62), 12, 4, 11, 12, Array As Byte(0,0,1,1,0,1,1,0,0,0,0,1,0,0,0,1,1,1)))

	versions.Add(CreateVersionData(14, "14L", Generator30, L0,  461 * 8, 458, Array As Int(6, 26, 46, 66),  3, 1, 115, 116, Array As Byte(0,0,1,1,1,0,0,1,1,0,0,0,0,0,1,1,0,1)))
	versions.Add(CreateVersionData(14, "14M", Generator24, M0 , 365 * 8, 362, Array As Int(6, 26, 46, 66),  4, 5,  40,  41, Array As Byte(0,0,1,1,1,0,0,1,1,0,0,0,0,0,1,1,0,1)))
	versions.Add(CreateVersionData(14, "14Q", Generator20, Q0 , 261 * 8, 258, Array As Int(6, 26, 46, 66), 11, 5,  16,  17, Array As Byte(0,0,1,1,1,0,0,1,1,0,0,0,0,0,1,1,0,1)))
	versions.Add(CreateVersionData(14, "14H", Generator24, H0 , 197 * 8, 194, Array As Int(6, 26, 46, 66), 11, 5,  12,  13, Array As Byte(0,0,1,1,1,0,0,1,1,0,0,0,0,0,1,1,0,1)))

	versions.Add(CreateVersionData(15, "15L", Generator22, L0,  523 * 8, 520, Array As Int(6, 26, 48, 70),  5, 1, 87, 88, Array As Byte(0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0,0)))
	versions.Add(CreateVersionData(15, "15M", Generator24, M0 , 415 * 8, 412, Array As Int(6, 26, 48, 70),  5, 5, 41, 42, Array As Byte(0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0,0)))
	versions.Add(CreateVersionData(15, "15Q", Generator30, Q0 , 295 * 8, 292, Array As Int(6, 26, 48, 70),  5, 7, 24, 25, Array As Byte(0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0,0)))
	versions.Add(CreateVersionData(15, "15H", Generator24, H0 , 223 * 8, 220, Array As Int(6, 26, 48, 70), 11, 7, 12, 13, Array As Byte(0,0,1,1,1,1,1,0,0,1,0,0,1,0,1,0,0,0)))

	versions.Add(CreateVersionData(16, "16L", Generator24, L0,  589 * 8, 586, Array As Int(6, 26, 50, 74),  5,  1, 98, 99, Array As Byte(0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0,0)))
	versions.Add(CreateVersionData(16, "16M", Generator28, M0 , 453 * 8, 450, Array As Int(6, 26, 50, 74),  7,  3, 45, 46, Array As Byte(0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0,0)))
	versions.Add(CreateVersionData(16, "16Q", Generator24, Q0 , 325 * 8, 322, Array As Int(6, 26, 50, 74), 15,  2, 19, 20, Array As Byte(0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0,0)))
	versions.Add(CreateVersionData(16, "16H", Generator30, H0 , 253 * 8, 250, Array As Int(6, 26, 50, 74),  3, 13, 15, 16, Array As Byte(0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0,0)))
	
	versions.Add(CreateVersionData(17, "17L", Generator28, L0,  647 * 8, 644, Array As Int(6, 30, 54, 78),   1,  5, 107, 108, Array As Byte(0,1,0,0,0,1,0,1,0,0,0,1,0,1,1,1,0,1)))
	versions.Add(CreateVersionData(17, "17M", Generator28, M0 , 507 * 8, 504, Array As Int(6, 30, 54, 78),  10,  1,  46,  47, Array As Byte(0,1,0,0,0,1,0,1,0,0,0,1,0,1,1,1,0,1)))
	versions.Add(CreateVersionData(17, "17Q", Generator28, Q0 , 367 * 8, 364, Array As Int(6, 30, 54, 78),   1, 15,  22,  23, Array As Byte(0,1,0,0,0,1,0,1,0,0,0,1,0,1,1,1,0,1)))
	versions.Add(CreateVersionData(17, "17H", Generator28, H0 , 283 * 8, 280, Array As Int(6, 30, 54, 78),   2, 17,  14,  15, Array As Byte(0,1,0,0,0,1,0,1,0,0,0,1,0,1,1,1,0,1)))

	versions.Add(CreateVersionData(18, "18L", Generator30, L0,  721 * 8, 718, Array As Int(6, 30, 56, 82),   5,  1, 120, 121, Array As Byte(0,1,0,0,1,0,1,0,1,0,0,0,0,1,0,1,1,1)))
	versions.Add(CreateVersionData(18, "18M", Generator26, M0 , 563 * 8, 560, Array As Int(6, 30, 56, 82),   9,  4,  43,  44, Array As Byte(0,1,0,0,1,0,1,0,1,0,0,0,0,1,0,1,1,1)))
	versions.Add(CreateVersionData(18, "18Q", Generator28, Q0 , 397 * 8, 394, Array As Int(6, 30, 56, 82),  17,  1,  22,  23, Array As Byte(0,1,0,0,1,0,1,0,1,0,0,0,0,1,0,1,1,1)))
	versions.Add(CreateVersionData(18, "18H", Generator28, H0 , 313 * 8, 310, Array As Int(6, 30, 56, 82),   2, 19,  14,  15, Array As Byte(0,1,0,0,1,0,1,0,1,0,0,0,0,1,0,1,1,1)))

	versions.Add(CreateVersionData(19, "19L", Generator28, L0,  795 * 8, 792, Array As Int(6, 30, 58, 86),  3,  4, 113, 114, Array As Byte(0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1,0)))
	versions.Add(CreateVersionData(19, "19M", Generator26, M0 , 627 * 8, 624, Array As Int(6, 30, 58, 86),  3, 11,  44,  45, Array As Byte(0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1,0)))
	versions.Add(CreateVersionData(19, "19Q", Generator26, Q0 , 445 * 8, 442, Array As Int(6, 30, 58, 86), 17,  4,  21,  22, Array As Byte(0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1,0)))
	versions.Add(CreateVersionData(19, "19H", Generator26, H0 , 341 * 8, 338, Array As Int(6, 30, 58, 86),  9, 16,  13,  14, Array As Byte(0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1,0)))

	versions.Add(CreateVersionData(20, "20L", Generator28, L0,  861 * 8, 858, Array As Int(6, 34, 62, 90),  3,  5, 107, 108, Array As Byte(0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1,0)))
	versions.Add(CreateVersionData(20, "20M", Generator26, M0 , 669 * 8, 666, Array As Int(6, 34, 62, 90),  3, 13,  41,  42, Array As Byte(0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1,0)))
	versions.Add(CreateVersionData(20, "20Q", Generator30, Q0 , 485 * 8, 482, Array As Int(6, 34, 62, 90), 15,  5,  24,  25, Array As Byte(0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1,0)))
	versions.Add(CreateVersionData(20, "20H", Generator28, H0 , 385 * 8, 382, Array As Int(6, 34, 62, 90), 15, 10,  15,  16, Array As Byte(0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1,0)))

	versions.Add(CreateVersionData(23, "23L", Generator30, L0, 1094 * 8, 1091, Array As Int(6, 30, 54, 78, 102), 4, 5, 121, 122, _
		Array As Byte(0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0,0)))
	versions.Add(CreateVersionData(23, "23M", Generator28, M0, 860 * 8, 857, Array As Int(6, 30, 54, 78, 102), 4, 14, 47, 48, _
		Array As Byte(0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0,0)))	
	versions.Add(CreateVersionData(23, "23Q", Generator30, Q0, 614 * 8, 611, Array As Int(6, 30, 54, 78, 102), 11, 14, 24, 25, _
		Array As Byte(0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0,0)))
	versions.Add(CreateVersionData(23, "23H", Generator30, H0, 464 * 8, 461, Array As Int(6, 30, 54, 78, 102), 16, 14, 15, 16, _
		Array As Byte(0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0,0)))

	versions.Add(CreateVersionData(39, "39L", Generator30, L0,  2812 * 8, 2809, Array As Int(6, 26, 54, 82, 110, 138, 166),  20,   4, 117, 118, Array As Byte(1,0,0,1,1,1,0,1,0,1,0,1,0,0,0,0,0,1)))
	versions.Add(CreateVersionData(39, "39M", Generator28, M0 , 2216 * 8, 2213, Array As Int(6, 26, 54, 82, 110, 138, 166),  40,   7,  47,  48, Array As Byte(1,0,0,1,1,1,0,1,0,1,0,1,0,0,0,0,0,1)))
	versions.Add(CreateVersionData(39, "39Q", Generator30, Q0 , 1582 * 8, 1579, Array As Int(6, 26, 54, 82, 110, 138, 166),  43,  22,  24,  25, Array As Byte(1,0,0,1,1,1,0,1,0,1,0,1,0,0,0,0,0,1)))
	versions.Add(CreateVersionData(39, "39H", Generator30, H0 , 1222 * 8, 1219, Array As Int(6, 26, 54, 82, 110, 138, 166),  10,  67,  15,  16, Array As Byte(1,0,0,1,1,1,0,1,0,1,0,1,0,0,0,0,0,1)))

	versions.Add(CreateVersionData(40, "40L", Generator30, L0, 2956 * 8, 2953, Array As Int(6, 30, 58, 86, 114, 142, 170), 19, 6, 118, 119, _
		Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))
	versions.Add(CreateVersionData(40, "40M", Generator28, M0, 2334 * 8, 2331, Array As Int(6, 30, 58, 86, 114, 142, 170), 18, 31, 47, 48, _
		Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))
	versions.Add(CreateVersionData(40, "40Q", Generator30, Q0, 1666 * 8, 1663, Array As Int(6, 30, 58, 86, 114, 142, 170), 34, 34, 24, 25, _
		Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))
	versions.Add(CreateVersionData(40, "40H", Generator30, H0, 1276 * 8, 1273, Array As Int(6, 30, 58, 86, 114, 142, 170), 20, 61, 15, 16, _
		Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))
	
		
End Sub

Private Sub CreateVersionData (Version As Int, Name As String, Generator() As Int, Format() As Byte, MaxSize As Int, MaxUsableSize As Int, Alignments() As Int, _
		Group1Size As Int, Group2Size As Int, Block1Size As Int, Block2Size As Int, VersionInformation() As Byte) As QRVersionData
	Dim v As QRVersionData
	v.Initialize
	v.Version = Version
	v.VersionName = Name
	v.Generator = Generator
	v.Format = Format
	v.MaxSize = MaxSize
	v.MaxUsableSize = MaxUsableSize
	v.Alignments = Alignments
	v.Group1Size = Group1Size
	v.Group2Size = Group2Size
	v.Block1Size = Block1Size
	v.Block2Size = Block2Size
	v.VersionInformation = VersionInformation
	Return v
End Sub

Public Sub Create(Text As String) As B4XBitmap
	Dim Bytes() As Byte = Text.GetBytes("utf8") 'non-standard but still recommended
	Dim vd As QRVersionData
	For Each version As QRVersionData In versions
		If version.MaxUsableSize >= Bytes.Length Then
			vd = version
			Exit
		End If
	Next
	If vd.IsInitialized = False Then
		
		Log("Too long!")
		Return Null
	End If
	Log(vd.VersionName & ", Size: " & Bytes.Length)
	
	NumberOfModules = 17 + vd.Version * 4
	ModuleSize = mBitmapSize / (NumberOfModules + 8)
	
	mBitmapSize = ModuleSize * (NumberOfModules + 8)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, mBitmapSize, mBitmapSize)
	cvs.Initialize(p)
	
	
	Dim Matrix(NumberOfModules, NumberOfModules) As Boolean
	Dim Reserved(NumberOfModules, NumberOfModules) As Boolean
	
	Dim Mode() As Byte = Array As Byte(0, 1, 0, 0) 'byte mode
	Dim ContentCountIndicator() As Byte
	If vd.Version >= 10 Then
		ContentCountIndicator = IntTo16Bits(Bytes.Length)
	Else
		ContentCountIndicator = UnsignedByteToBits(Bytes.Length)
	End If
	Dim EncodedData As B4XBytesBuilder
	EncodedData.Initialize
	EncodedData.Append(Mode)
	EncodedData.Append(ContentCountIndicator)
	For Each b As Byte In Bytes
		EncodedData.Append(UnsignedByteToBits(Bit.And(0xff, b)))
	Next
	'add terminator
	Dim PadSize As Int = Min(4, vd.MaxSize - EncodedData.Length)
	Dim pad(PadSize) As Byte
	EncodedData.Append(pad)
	Do While EncodedData.Length Mod 8 <> 0 
		EncodedData.Append(Array As Byte(0))
	Loop
	
	Do While EncodedData.Length < vd.MaxSize
		EncodedData.Append(Array As Byte(1,1,1,0,1,1,0,0))
		If EncodedData.Length < vd.MaxSize Then EncodedData.Append(Array As Byte(0,0,0,1,0,0,0,1))
	Loop
	VersionWithTwoGroups(vd.Generator, vd.Group1Size, vd.Group2Size, vd.Block1Size, vd.Block2Size, EncodedData)
	AddFinders (vd)
	AddDataToMatrix(EncodedData.ToArray, vd)
	DrawMatrix
	cvs.Invalidate
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	cvs.Invalidate
	cvs.Release
	Return bmp
End Sub

Private Sub VersionWithTwoGroups (generator() As Int, Group1Size As Int, Group2Size As Int, Block1Size As Int, Block2Size As Int, EncodedData As B4XBytesBuilder)
	Dim ecs As List
	ecs.Initialize
	Dim dataBlocks As List
	dataBlocks.Initialize
	Dim PrevIndex As Int
	For block1 = 0 To Group1Size + Group2Size - 1
		Dim BlockSize As Int
		If block1 < Group1Size Then BlockSize = Block1Size Else BlockSize = Block2Size
		Dim Data() As Byte = EncodedData.SubArray2(PrevIndex * 8, (PrevIndex + BlockSize) * 8)
		PrevIndex = PrevIndex + BlockSize
		Dim DataAsInts(Data.Length / 8) As Int
		Dim i As Int
		For i = 0 To Data.Length - 1 Step 8
			DataAsInts(i / 8) = BitsToUnsignedByte(Data, i)
		Next
		dataBlocks.Add(DataAsInts)
		Dim ec() As Int = CalcReedSolomon(DataAsInts, generator)
		If ec.Length < generator.Length - 1 Then
			Dim ec2(generator.Length - 1) As Int
			IntArrayCopy(ec, 0, ec2,  generator.Length - 1 - ec.Length, ec.Length)
			ec = ec2
		End If
		ecs.Add(ec)
	Next
	Dim Interleaved As B4XBytesBuilder
	Interleaved.Initialize
	For i = 0 To Max(Block1Size, Block2Size) - 1
		For block1 = 0 To dataBlocks.Size - 1
			Dim ii() As Int = dataBlocks.Get(block1)
			If ii.Length > i Then
				Interleaved.Append(UnsignedByteToBits(ii(i)))
			End If
		Next
	Next
	For i = 0 To generator.Length - 2
		For block1 = 0 To dataBlocks.Size - 1
			Dim ii() As Int = ecs.Get(block1)
			Interleaved.Append(UnsignedByteToBits(ii(i)))
		Next
	Next
	EncodedData.Clear
	EncodedData.Append(Interleaved.ToArray)
End Sub



Private Sub AddDataToMatrix (Encoded() As Byte, vd As QRVersionData)
	Dim format() As Byte = vd.Format
	Dim order As List = CreateOrder
	'mask 0: (row + column) mod 2 == 0
	For Each b As Byte In Encoded
		Dim xy() As Int = GetNextPosition(order)
		Matrix(xy(0), xy(1)) = (b = 1)
		If (xy(1) + xy(0)) Mod 2 = 0 Then Matrix(xy(0), xy(1)) = Not(Matrix(xy(0), xy(1)))
	Next
	For i = 0 To 5
		Matrix(i, 8) = format(i) = 1
		Matrix(8, NumberOfModules - 1 - i) = format(i) = 1
	Next
	Matrix(7, 8) = format(6) = 1
	Matrix(8, NumberOfModules - 1 - 6) = format(6) = 1
	Matrix(8, 8) = format(7) = 1
	Matrix(8, 7) = format(8) = 1
	For i = 0 To 5
		Matrix(8, 5 - i) = format(i + 9) = 1
	Next
	For i = 0 To 7
		Matrix(NumberOfModules - 1 - 7 + i, 8) = format(7 + i) = 1
	Next
	If vd.Version >= 7 Then
		Dim VersionInformation() As Byte = vd.VersionInformation
		Dim c As Int = 18
		For x = 0 To 5
			For y = 0 To 2
				c = c - 1
				Matrix(x, NumberOfModules - 11 + y) = VersionInformation(c) = 1
				Matrix(NumberOfModules - 11 + y, x) = VersionInformation(c) = 1
			Next
		Next
	End If
End Sub

Private Sub GetNextPosition (order As List) As Int()
	Do While True
		Dim xy() As Int = order.Get(0)
		order.RemoveAt(0)
		If Reserved(xy(0), xy(1)) = False Then Return xy
	Loop
	Return Null
End Sub

Private Sub CreateOrder As List
	Dim Order As List
	Order.Initialize
	Dim x As Int = NumberOfModules - 1
	Dim y As Int = NumberOfModules - 1
	Dim dy As Int = -1
	Do While x >= 0 And y >= 0
		Order.Add(Array As Int(x, y))
		Order.Add(Array As Int(x - 1, y))
		y = y + dy
		If y = -1 Then
			x = x - 2
			y = 0
			dy = 1
		Else If y = NumberOfModules Then
			x = x - 2
			y = NumberOfModules - 1
			dy = -1
		End If
		If x = 6 Then x = x - 1
	Loop
	Return Order
End Sub

Private Sub DrawMatrix
	
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)
	Dim r As B4XRect
	For y = 0 To NumberOfModules - 1
		For x = 0 To NumberOfModules - 1
			r.Initialize((x + 4) * ModuleSize, (y + 4) * ModuleSize, 0, 0)
			r.Width = ModuleSize 
			r.Height = ModuleSize
			Dim clr As Int
			If Matrix(x, y) Then 
				clr = xui.Color_Black
				'cvs.DrawCircle(r.CenterX, r.CenterY, r.Width / 2, clr, True, 0)
				cvs.DrawRect(r, clr, True, 0)
				cvs.Invalidate
			End If
		Next
	Next
	cvs.Invalidate

End Sub



Private Sub BitsToUnsignedByte (b() As Byte, Offset As Int) As Int
	Dim res As Int
	For i = 0 To 7
		Dim x As Int = Bit.ShiftLeft(1, 7 - i)
		res = res + b(i + Offset) * x
	Next
	Return res
End Sub

Private Sub UnsignedByteToBits (Value As Int) As Byte()
	TempBB.Clear
	For i = 7 To 0 Step - 1
		Dim x As Int = Bit.ShiftLeft(1, i)
		Dim ii As Int = Bit.And(Value, x)
		If ii <> 0 Then
			TempBB.Append(Array As Byte(1))
		Else
			TempBB.Append(Array As Byte(0))
		End If
	Next

	Return TempBB.ToArray
End Sub

Private Sub IntTo16Bits (Value As Int) As Byte()
	TempBB.Clear
	For i = 15 To 0 Step - 1
		Dim x As Int = Bit.ShiftLeft(1, i)
		Dim ii As Int = Bit.And(Value, x)
		If ii <> 0 Then
			TempBB.Append(Array As Byte(1))
		Else
			TempBB.Append(Array As Byte(0))
		End If
	Next

	Return TempBB.ToArray
End Sub

Private Sub AddFinders (vd As QRVersionData)
	AddFinder(0, 0, 6)
	AddFinder(NumberOfModules - 7, 0, 6)
	AddFinder(0, NumberOfModules - 7, 6)
	AddAlignments(vd.Alignments)
	If vd.Version >= 7 Then
		For x = 0 To 2
			For y = 0 To 5
				Reserved(y, NumberOfModules - 11 + x) = True
				Reserved(NumberOfModules - 11 + x, y) = True
			Next
		Next
	End If
	
	For i = 8 To NumberOfModules - 8
		Matrix(i, 6) = (i Mod 2 = 0)
		Matrix(6, i) = (i Mod 2 = 0)
		Reserved(i, 6) = True
		Reserved(6, i) = True
	Next
	Matrix(8, NumberOfModules - 1 - 7) = True
	Reserved(8, NumberOfModules - 1 - 7) = True
	For i = 0 To 7
		Reserved(7, i) = True
		Reserved(7, NumberOfModules - 1 - i) = True
		Reserved(8, NumberOfModules - 1 - i) = True
		Reserved(NumberOfModules -1 - 7, i) = True
		Reserved(i, 7) = True
		Reserved(i,NumberOfModules -1 - 7) = True
		Reserved(NumberOfModules -1 - i, 7) = True
		Reserved(NumberOfModules -1 - i, 8) = True
	Next
	For i = 0 To 8
		Reserved(8, i) = True
		Reserved(i, 8) = True
	Next
End Sub

Private Sub AddAlignments (Positions() As Int)
	For Each left As Int In Positions
		For Each top As Int In Positions
			AddFinder (left - 2, top - 2, 4)
		Next
	Next
End Sub

Private Sub AddFinder (Left As Int, Top As Int, SizeMinOne As Int)
	For y = 0 To SizeMinOne
		For x = 0 To SizeMinOne
			If Reserved(Left + x, Top + y) Then 
				Return
			End If
		Next
	Next
	For y = 0 To SizeMinOne
		For x = 0 To SizeMinOne
			Dim value As Boolean
			If x = 0 Or x = SizeMinOne Or y = 0 Or y = SizeMinOne Then
				value = True
			Else if x <> 1 And y <> 1 And x <> SizeMinOne - 1 And y <> SizeMinOne - 1 Then
				value = True
			End If
			Matrix(Left + x, Top + y) = value
			Reserved(Left + x, Top + y) = True
		Next
	Next
End Sub

#Region ReedSolomon

Private Sub CalcReedSolomon (Input() As Int, Generator() As Int) As Int()
	Dim ecBytes As Int = Generator.Length - 1
	Dim InfoCoefficients(Input.Length) As Int
	IntArrayCopy(Input, 0, InfoCoefficients, 0, Input.Length)
	InfoCoefficients = CreateGFPoly(InfoCoefficients)
	InfoCoefficients = PolyMultiplyByMonomial(InfoCoefficients, ecBytes, 1)
	Dim remainder() As Int = PolyDivide(InfoCoefficients, Generator)
	Return remainder
End Sub


Private Sub PrepareTables
	Dim x = 1 As Int
	Dim Primitive As Int = 285
	For i = 0 To GFSize - 1
		ExpTable(i) = x
		x = x * 2
		If x >= GFSize Then
			x = Bit.Xor(Primitive, x)
			x = Bit.And(GFSize - 1, x)
		End If
	Next
	For i = 0 To GFSize - 2
		LogTable(ExpTable(i)) = i
	Next
End Sub

Private Sub CreateGFPoly(Coefficients() As Int) As Int()
	If Coefficients.Length > 1 And Coefficients(0) = 0 Then
		Dim FirstNonZero As Int = 1
		Do While FirstNonZero < Coefficients.Length And Coefficients(FirstNonZero) = 0
			FirstNonZero = FirstNonZero + 1
		Loop
		If FirstNonZero = Coefficients.Length Then
			Return Array As Int(0)
		End If
		Dim res(Coefficients.Length - FirstNonZero) As Int
		IntArrayCopy(Coefficients, FirstNonZero, res, 0, res.Length)
		Return res
	End If
	Return Coefficients
End Sub

Private Sub PolyAddOrSubtract(This() As Int, Other() As Int) As Int()
	If This(0) = 0 Then Return Other
	If Other(0) = 0 Then Return This
	Dim Small() As Int = This
	Dim Large() As Int = Other
	If Small.Length > Large.Length Then
		Dim temp() As Int = Small
		Small = Large
		Large = temp
	End If
	Dim SumDiff(Large.Length) As Int
	Dim LengthDiff As Int = Large.Length - Small.Length
	IntArrayCopy(Large, 0, SumDiff, 0, LengthDiff)
	For i = LengthDiff To Large.Length - 1
		SumDiff(i) = Bit.Xor(Small(i - LengthDiff), Large(i))
	Next
	Return CreateGFPoly(SumDiff)
End Sub

Private Sub IntArrayCopy(Src() As Int, SrcOffset As Int, Dest() As Int, DestOffset As Int, Count As Int)
	For i = 0 To Count - 1
		Dest(DestOffset + i) = Src(SrcOffset + i)
	Next
End Sub



Private Sub PolyMultiplyByMonomial (This() As Int, Degree As Int, Coefficient As Int) As Int()
	If Coefficient = 0 Then Return PolyZero
	Dim product(This.Length + Degree) As Int
	For i = 0 To This.Length - 1
		product(i) = GFMultiply(This(i), Coefficient)
	Next
	Return CreateGFPoly(product)
End Sub

Private Sub PolyDivide (This() As Int, Other() As Int) As Int()
	Dim quotient() As Int = PolyZero
	Dim remainder() As Int = This
	Dim denominatorLeadingTerm As Int = Other(0)
	Dim inverseDenominatorLeadingTerm As Int = GFInverse(denominatorLeadingTerm)
	Do While remainder.Length >= Other.Length And remainder(0) <> 0
		Dim DegreeDifference As Int = remainder.Length - Other.Length
		Dim scale As Int = GFMultiply(remainder(0), inverseDenominatorLeadingTerm)
		Dim term() As Int = PolyMultiplyByMonomial(Other, DegreeDifference, scale)
		Dim iterationQuotient() As Int = GFBuildMonomial(DegreeDifference, scale)
		quotient = PolyAddOrSubtract(quotient, iterationQuotient)
		remainder = PolyAddOrSubtract(remainder, term)
	Loop
	Return remainder
End Sub

Private Sub GFInverse(a As Int) As Int
	Return ExpTable(GFSize - LogTable(a) - 1)
End Sub

Private Sub GFMultiply(a As Int, b As Int) As Int
	If a = 0 Or b = 0 Then
		Return 0
	End If
	Return ExpTable((LogTable(a) + LogTable(b)) Mod (GFSize - 1))
End Sub

Private Sub GFBuildMonomial(Degree As Int, Coefficient As Int) As Int()
	If Coefficient = 0 Then Return PolyZero
	Dim c(Degree + 1) As Int
	c(0) = Coefficient
	Return c
End Sub

#End Region
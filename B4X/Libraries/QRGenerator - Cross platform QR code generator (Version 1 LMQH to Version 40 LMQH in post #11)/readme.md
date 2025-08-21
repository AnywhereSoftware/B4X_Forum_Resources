###  QRGenerator - Cross platform QR code generator (Version 1 LMQH to Version 40 LMQH in post #11) by Johan Schoeman
### 04/26/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/116891/)

This is based on [USER=1]@Erel[/USER]'s posting here:  
  
<https://www.b4x.com/android/forum/threads/b4x-qrgenerator-cross-platform-qr-code-generator.93092/>  
  
Have added all the required generator polynomial factors that are required for Version 1 to Version 40 QR Codes  
Changed the names of the array holding the generator polynomial factors to:  

```B4X
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
```

  
Have added additional "setup code" in Sub Initialize(….) so that it can support **Version 1 to Version 10 QR Codes for all 4 error correction levels (i.e Levels L, M, Q, H)**  
  
As it stands at present it supports:  
1. Version 1 to 10 QR Code (error correction level L, M, Q, H)  
2. Version 23H  
3. Version 40H  
4. Version 40L  
  
Sample code that I have added/amended/changed:  

```B4X
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
      
    versions.Add(CreateVersionData(23, "23H", Generator30, H0, 464 * 8, 461, Array As Int(6, 30, 54, 78, 102), 16, 14, 15, 16, _  
        Array As Byte(0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0,0)))  
          
    versions.Add(CreateVersionData(40, "40H", Generator30, H0, 1276 * 8, 1273, Array As Int(6, 30, 58, 86, 114, 142, 170), 20, 61, 15, 16, _  
        Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))  
          
    versions.Add(CreateVersionData(40, "40L", Generator30, L0, 2956 * 8, 2953, Array As Int(6, 30, 58, 86, 114, 142, 170), 19, 6, 118, 119, _  
        Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))  
          
End Sub
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/92635)
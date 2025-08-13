### LZ4 Fast Compress and Decompress by Magma
### 11/04/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143940/)

Hi there…  
  
I am in search for faster ways to compress/decompress images… bytes in general…  
  
So i ve done some work… not much, i am sharing here with you guys..  
  
Need some Inline java:  

```B4X
#if java  
  
import net.jpountz.lz4.LZ4Factory;  
import net.jpountz.lz4.LZ4Compressor;  
import net.jpountz.lz4.LZ4FastDecompressor;  
import java.util.Arrays;  
  
private static int decompressedLength;  
private static LZ4Factory factory = LZ4Factory.fastestInstance();  
private static LZ4Compressor compressor = factory.fastCompressor();  
  
public static byte[] compress(byte[] src, int srcLen) {  
    decompressedLength = srcLen;  
    int maxCompressedLength = compressor.maxCompressedLength(decompressedLength);  
    byte[] compressed = new byte[maxCompressedLength];  
    int compressLen = compressor.compress(src, 0, decompressedLength, compressed, 0, maxCompressedLength);  
    byte[] finalCompressedArray = Arrays.copyOf(compressed, compressLen);  
    return finalCompressedArray;  
}  
  
private static LZ4FastDecompressor decompressor = factory.fastDecompressor();  
  
public static byte[] decompress(byte[] finalCompressedArray, int decompressedLength) {  
    byte[] restored = new byte[decompressedLength];  
    restored = decompressor.decompress(finalCompressedArray, decompressedLength);  
    return restored;  
}  
  
#end if
```

  
  
some subs:  

```B4X
#AdditionalJar: lz4-java-1.8.0  
..  
Private jo As JavaObject  
…  
public Sub Compress(bytes1() As Byte,llnt As Int) As Byte()  
    Return jo.RunMethod("compress", Array(bytes1,llnt))  
End Sub  
  
public Sub UnCompress(bytes1() As Byte,llnt As Int) As Byte()  
    Return jo.RunMethod("decompress", Array(bytes1,llnt))  
End Sub
```

  
  
And you can use it like this:  

```B4X
'aa can be a byte array you wanna compress…  
  
    Dim bb() As Byte=Compress(aa,aa.Length)  
    Log("New Size: " & bb.Length)  
  
    Dim cc() As Byte=unCompress(bb,aa.Length) 'You must know the uncompressed size !!! caution !!!  
    Log("New Size Restored: " & cc.Length)
```

  
[You will need lz4-java... download from here..](https://search.maven.org/artifact/org.lz4/lz4-java/1.8.0/jar)  
  
Hope helps…
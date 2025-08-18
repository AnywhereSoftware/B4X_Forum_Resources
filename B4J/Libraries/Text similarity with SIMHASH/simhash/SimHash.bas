B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
Sub Process_Globals
End Sub

Private Sub Inline As JavaObject
	Return Me
End Sub

'formats the long parameter into a 64-character 01 string
Sub LongTo01String (h As Long) As String
	Return Inline.RunMethod("longTo01String",Array(h))
End Sub

'formats the parameter into a 16-character Hex string
Sub LongToHexString (h As Long) As String
	Return Inline.RunMethod("longToHexString",Array(h))
End Sub

' return the Hamming distance of the two long parameters (bit by bit)
Sub HammingDistance(hash1 As Long, hash2 As Long ) As Int
	Return Inline.RunMethod("hammingDistance", Array(hash1,hash2))
	'Return 1
End Sub

'returns the 64 bits hash of the string calculated by the SIMHASH algorithm
Sub SimHash64(s As String) As Long
	Return Inline.RunMethod("simHash64", Array(s))
End Sub

#if java 
import java.nio.ByteBuffer;
import java.nio.charset.Charset;

//** Hamming Distance
public static int hammingDistance(long hash1, long hash2) {
		long i = hash1 ^ hash2;
		i = i - ((i >>> 1) & 0x5555555555555555L);
		i = (i & 0x3333333333333333L) + ((i >>> 2) & 0x3333333333333333L);
		i = (i + (i >>> 4)) & 0x0f0f0f0f0f0f0f0fL;
		i = i + (i >>> 8);
		i = i + (i >>> 16);
		i = i + (i >>> 32);
		return (int) i & 0x7f;
}

//** Format Long to 01 String
public static String  longTo01String(long h) {
		return String.format("%64s", Long.toBinaryString(h)).replace(' ', '0');
}

//** Format Long to Hex String
public static String  longToHexString(long h) {
		return String.format("%016X", h);
}


//** MurmurHash
private static long hash64(String doc) {
		byte[] buffer = doc.getBytes(Charset.forName("utf-8"));
		return hash64(buffer, buffer.length, 0xe17a1465);
		
}


private static long hash64(final byte[] data, int length, int seed) {
        final long m = 0xc6a4a7935bd1e995L;
        final int r = 47;

        long h = (seed&0xffffffffl)^(length*m);

        int length8 = length/8;

        for (int i=0; i<length8; i++) {
            final int i8 = i*8;
            long k =  ((long)data[i8+0]&0xff)      +(((long)data[i8+1]&0xff)<<8)
                    +(((long)data[i8+2]&0xff)<<16) +(((long)data[i8+3]&0xff)<<24)
                    +(((long)data[i8+4]&0xff)<<32) +(((long)data[i8+5]&0xff)<<40)
                    +(((long)data[i8+6]&0xff)<<48) +(((long)data[i8+7]&0xff)<<56);
            
            k *= m;
            k ^= k >>> r;
            k *= m;
            
            h ^= k;
            h *= m; 
        }
        
        switch (length%8) {
        case 7: h ^= (long)(data[(length&~7)+6]&0xff) << 48;
        case 6: h ^= (long)(data[(length&~7)+5]&0xff) << 40;
        case 5: h ^= (long)(data[(length&~7)+4]&0xff) << 32;
        case 4: h ^= (long)(data[(length&~7)+3]&0xff) << 24;
        case 3: h ^= (long)(data[(length&~7)+2]&0xff) << 16;
        case 2: h ^= (long)(data[(length&~7)+1]&0xff) << 8;
        case 1: h ^= (long)(data[length&~7]&0xff);
                h *= m;
        };
     
        h ^= h >>> r;
        h *= m;
        h ^= h >>> r;

        return h;
}

//**  Generate 64 bit simhash for a string 
public static  long simHash64(String s) {
    long result = 0;
    int[] bitVector = new int[64];

    String[] words = s.split("[\\s()\\-\\/]+");
    for (String word : words) {
      if (word.isEmpty()) {
        continue;
      }
      long hash = hash64(word);
	
     for (int i = 0; i < bitVector.length; i++) {
        bitVector[i] += (hash & 1) == 1 ? 1 : -1;
        hash = hash >> 1;
      }
    }
    
    for (int i = 0; i < bitVector.length; i++) {
      result = result << 1;
      if (bitVector[i] > 0) {
        result += 1;
      }
    }
    return result;
  }


#end if

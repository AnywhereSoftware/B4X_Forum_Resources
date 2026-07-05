###  fixed Huffman coding - RFC 1951 sez. 3.2.6. by Star-Dust
### 07/02/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/171435/)

Sometimes you have communication problems such as with webSocket communications that don't use zlib (RFC 1950), which includes a 2-byte header + trailing Adler-32 checksum. The WebSocket permessage-deflate (RFC 7692) requires raw DEFLATE (RFC 1951), i.e. the compressed stream without any header/trailer, with windowBits = -15.  
  
In Android and Windows there are java ZIP libraries that allow you to compress with Huffman (RFC 1951) while in ios the native library uses (RFC 1950).  
  
I thought of developing a code that can work on all platforms in B4X by recreating the algorithm from scratch.  
  
**PS:** When they are the right choice:  

- WebSocket permission-deflate
- Custom TCP protocols
- Data exchange between B4X applications
- JSON/XML compression
- Reduction of network traffic
- Compact saving of large amounts of text
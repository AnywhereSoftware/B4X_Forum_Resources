### Zip4J - Library update - Version 2.10.0 by Claudio Oliveira
### 05/13/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/140533/)

Zip4J library, by [Srikanth Reddy Lingala](https://github.com/srikanth-lingala)  
  
Version 2.10.0 - 2022-03-28  
  
**Improvements:**  

- Use utf-8 by default when reading zip file names
- Add NoCompression deflate compression level

  
**Bug Fixes:**  

- Validate AES extra data record size
- Include pos in array copy length calculation
- Change IllegalArgumentException to ZipException
- Handle unexpected EOF when reading raw stream
- Handle unexpected EOF when reading compressed stream
- Fill NPE when aesKeyStrength is null
- Validate AES extra data record before calculating header size
- Throw exception when file name length is 0
- Replace RunTimeException with ZipException
- Fix NPE in ZipParameters when file name is either null or empty
- Minor improvement to canonical path check
- Set entry size in ZipParameters to 0 by default

  
Jar file available for download [HERE](https://repo1.maven.org/maven2/net/lingala/zip4j/zip4j/2.10.0/zip4j-2.10.0.jar).
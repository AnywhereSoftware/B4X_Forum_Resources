### NamedPipe by warwound
### 11/01/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/111010/)

This is a simple to use library that enables you to create a [NamedPipe](https://en.wikipedia.org/wiki/Named_pipe).  
Your NamedPipe can be used to send and receive bytes from one process to another process.  
  
**NamedPipe  
Version:** 1.00  

- **AutoCloseInputStream**
Methods:

- **MarkSupported As Boolean**
*Tests if this input stream supports the mark and reset methods.*- **Mark** (ReadLimit As Int)
*Marks the current position in this input stream.  
 The Readlimit argument tells this input stream to allow that many bytes to be read before the mark position gets invalidated.*- **IsInitialized As Boolean**
- **Read2** (Buffer() As Byte, Offset As Int, Length As Int) **As Int**
*Reads up to Length bytes of data at Offset from this input stream into Buffer.  
 Less than Length bytes will be read if the end of the data stream is reached or if Length exceeds the buffer size.*- **Read As Int**
*Reads the next byte of data or -1 if the end of the input stream is reached.  
 The value byte is returned as an Int in the range 0 to 255.*- **Skip** (Number As Long) **As Long**
- **Close**
*Closes this input stream and releases any system resources associated with the stream.*- **Reset**

**Properties:**

- **Available As Int** *[read only]*
Returns an estimate of the number of bytes that can be read (or skipped over) from the current underlying input stream
without blocking by the next invocation of a method for the current underlying input stream.
- **AutoCloseOutputStream**
Methods:

- **Write** (Bytes() As Byte)
*Writes Bytes.Length bytes from the specified byte array to this output stream.*- **Flush**
*Flushes this output stream and forces any buffered output bytes to be written out.*- **Write3** (Byte1 As Int)
*Writes Byte1 to this output stream.*- **Close**
*Closes this output stream and releases any system resources associated with this stream.*- **IsInitialized As Boolean**
- **Write2** (Bytes() As Byte, Offset As Int, Length As Int)
*Writes Length bytes from the specified byte array starting at Offset to this output stream.*
- **NamedPipe**
Methods:

- **Close**
*Closes both InputStream and OutputStream*- **IsInitialized As Boolean**
- **Initialize**

**Properties:**

- **InputStream As AutoCloseInputStream** *[read only]*
- **OutputStream As AutoCloseOutputStream** *[read only]*
- **FdOutput As Int** *[read only]*
Returns the native file descriptor (integer) for this Pipe's Output.- **FdInput As Int** *[read only]*
Returns the native file descriptor (integer) for this Pipe's Input.
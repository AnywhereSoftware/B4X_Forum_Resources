### PndFFmpegKit - FFmpeg Library by Pendrush
### 04/11/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/137426/)

[SIZE=6]This is a message from the official Github page:  
  
FFmpegKit has been officially retired. There will be no further ffmpeg-kit releases.  
  
All previously released ffmpeg-kit binaries will be REMOVED according to the following schedule.  
  
FFmpegKit Version - Available Until  
 Less than 6.0 - February 1st, 2025  
 6.0 - April 1st, 2025[/SIZE]  
  
  
FFmpegKit is a wrapper library that allows you to easily run FFmpeg/FFprobe commands in applications. It provides additional features on top of FFmpeg to enable platform specific resources, control how commands are executed and how the results are handled.  
Original library: <https://github.com/arthenica/ffmpeg-kit>  
  
Wrapper is based on v6.0.2 LTS version, supports Android API 16+  
Supported Android architectures: arm-v7a, arm-v7a-neon, arm64-v8a, x86, x86-64.  
You can use whatever command from FFmpeg, example app is just example how to use this lib/wrapper.  
If you find FFmpeg command with quotes **"** replace quotes **"** to single quote **'**, like in variable FFmpegCommand in Video to Gif example.  
  
Useful documentation and commands:  
<https://trac.ffmpeg.org/wiki>  
<https://ostechnix.com/20-ffmpeg-commands-beginners/>  
<https://ffmpeg.org/ffmpeg.html>  
<https://ffmpeg.org/ffmpeg-filters.html>  
  
> **PndFFmpegKit  
>   
> Author:** Author: Taner Şener - B4a Wrapper: Pendrush  
> **Version:** 6.02  
>
> - **PndFFmpegKit**
>
> - **Events:**
>
> - **Log** (FFmpegLog As PndFFmpegLog)
> - **MediaInfoSessionComplete** (Session As PndFFmpegSession)
> - **ProbeSessionComplete** (Session As PndFFmpegSession)
> - **SessionComplete** (Session As PndFFmpegSession)
> - **Statistics** (Stats As PndFFmpegStatistics)
>
> - **Functions:**
>
> - **CancelAll**
> *Cancels all running sessions.  
>  This method does not wait for termination to complete and returns immediately.*- **CancelSession** (SessionId As Long)
> *Cancels the session specified with sessionId.  
>  This method does not wait for termination to complete and returns immediately*- **ClearSessions**
> *Clears all, including ongoing, sessions in the session history.  
>  Note that callbacks cannot be triggered for deleted sessions*- **ExecuteAsync** (Command As String) As PndFFmpegSession
> *Starts an asynchronous FFmpeg execution for the given command. Space character is used to split the command into arguments. You can use single or double quote characters to specify arguments inside your command.  
>  Note that this method returns immediately and does not wait the execution to complete.*- **ExecuteWithArgumentsAsync** (Command As String()) As PndFFmpegSession
> *Starts an asynchronous FFmpeg execution with arguments provided.  
>  Note that this method returns immediately and does not wait the execution to complete.*- **GetMediaInformationAsync** (Path As String)
> *Starts an asynchronous FFprobe execution to extract the media information for the specified file.  
>  Note that this method returns immediately and does not wait the execution to complete.*- **Initialize** (EventName As String)
> *Initialize FFMpegKit   
>  FFmpegKit.Initialize("FFmpegKit")  
>  Dim InputFilePath As String = File.Combine(File.DirInternal, "1.mp4")  
>  Dim OutputFilePath As String = File.Combine(File.DirInternal, "2.mp4")  
>  Dim FFmpegCommand As String = "-i " & InputFilePath & " -c:v mpeg4 " & OutputFilePath  
>  FFmpegKit.ExecuteAsync(FFmpegCommand)*- **ListMediaInformationSessions** As List
> *Lists all MediaInformation sessions in the session history.*- **ListProbeSessions** As List
> *Lists all FFprobe sessions in the session history.*- **ListSessions** As List
> *Lists all FFmpeg sessions in the session history.*- **ProbeExecuteAsync** (Command As String) As PndFFmpegSession
> *Starts an asynchronous FFprobe execution for the given command. Space character is used to split the command into arguments. You can use single or double quote characters to specify arguments inside your command.  
>  Note that this method returns immediately and does not wait the execution to complete.*- **SetFontconfigConfigurationPath** (Path As String) As Int
> *Sets and overrides fontconfig configuration directory.  
>  Directory that contains fontconfig configuration (fonts.conf)  
>  Return zero on success, non-zero on error.*- **UpdateSession** (SessionId As Long) As PndFFmpegSession
> *Get update for SessionId.*
> - **Properties:**
>
> - **Abi** As String [read only]
> *Returns the ABI name loaded*- **AsyncConcurrencyLimit**
> *Returns the maximum number of async sessions that will be executed in parallel.*- **CpuAbi** As String [read only]
> *Returns the ABI name of the cpu running*- **LogLevel** As com.arthenica.ffmpegkit.Level [write only]
> *Sets the log level*- **SessionHistorySize**
> *Returns the session history size.*
> - **PndFFmpegLog**
>
> - **Properties:**
>
> - **Message** As String [read only]
> *Returns log message.*- **SessionId** As Long [read only]
> *Returns the session identifier.*
> - **PndFFmpegLogLevel**
>
> - **Fields:**
>
> - **LOG\_LEVEL\_DEBUG** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_ERROR** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_FATAL** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_INFO** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_PANIC** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_QUIET** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_STDERR** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_TRACE** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_VERBOSE** As com.arthenica.ffmpegkit.Level
> - **LOG\_LEVEL\_WARNING** As com.arthenica.ffmpegkit.Level
>
> - **PndFFmpegReturnCode**
>
> - **Fields:**
>
> - **VALUE\_CANCEL** As Int
> - **VALUE\_SUCCESS** As Int
>
> - **Functions:**
>
> - **IsValueCancel** As Boolean
> - **IsValueError** As Boolean
> - **IsValueSuccess** As Boolean
>
> - **Properties:**
>
> - **IsCancel** As Boolean [read only]
> - **IsSuccess** As Boolean [read only]
> - **Value** As Int [read only]
>
> - **PndFFmpegSession**
>
> - **Properties:**
>
> - **Command** As String [read only]
> *Returns command arguments as a concatenated string*- **CreateTime** As java.util.Date [read only]
> *Returns session create time.*- **Duration** As Long [read only]
> *Time taken to execute this session in milliseconds or zero (0) if the session is not over yet*- **EndTime** As java.util.Date [read only]
> *Returns session end time.*- **Output** As String [read only]
> *Returns the log output generated while running the session.*- **ReturnCode** As PndFFmpegReturnCode [read only]
> *Returns the return code for this session. Note that return code is only set for sessions that end with COMPLETED state. If a session is not started, still running or failed then this method returns null.*- **SessionId** As Long [read only]
> *Returns the session identifier.*- **SessionState** As String [read only]
> *Returns the state of the session.  
>  Possible values:  
>  CREATED  
>  RUNNING  
>  FAILED  
>  COMPLETED*
> - **PndFFmpegStatistics**
>
> - **Properties:**
>
> - **Bitrate** As Double [read only]
> *Returns bitrate*- **SessionId** As Long [read only]
> *Returns the session identifier.*- **Size** As Long [read only]
> *Returns file size.*- **Speed** As Double [read only]
> *Returns speed*- **Time** As Double [read only]
> *Returns curent video time.*- **VideoFps** As Float [read only]
> *Returns video FPS.*- **VideoFrameNumber** As Int [read only]
> *Returns video frame number.*- **VideoQuality** As Float [read only]
> *Returns video quality.*

  
 ![](https://www.b4x.com/android/forum/attachments/123975) ![](https://www.b4x.com/android/forum/attachments/123976) ![](https://www.b4x.com/android/forum/attachments/123977) ![](https://www.b4x.com/android/forum/attachments/123978) ![](https://www.b4x.com/android/forum/attachments/124017)  
  
Example app**:** <https://www.dropbox.com/s/z8z0iq9majtaill/FFmpegKitExample.zip?dl=0>  
Additional download: File **ffmpeg-kit-full-gpl-6.0-2.LTS.aar** is not hosted on GitHub any more, find it with [Google](https://www.google.com/search?q=%22ffmpeg-kit-full-gpl-6.0-2.LTS.aar%22) or with [DuckDuckGo](https://duckduckgo.com/?q=ffmpeg-kit-full-gpl-6.0-2.LTS.aar).  
Put file from additional download in Additional library folder together with files from FFmpegKitLibrary.zip
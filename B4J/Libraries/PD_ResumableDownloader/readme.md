### PD_ResumableDownloader by behnam_tr
### 08/28/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171933/)

b4j lib : PD\_ResumableDownloader - v1.0  
  
Features :  
- Resumable Download  
 - Auto-Resume After Interruption   
- Pause, Resume & Cancel   
- Already-Downloaded Detection   
- HTTP 416 (Range Not Satisfiable) Handling   
- Redirect Support (301, 302, 307, 308)   
- Automatic Retry   
- Delete on Cancel   
- Auto Filename Extraction (URL / Content-Disposition)   
- Smart Duplicate Filename Handling   
- Correct Resume for Folder Downloads   
- Real-Time Progress Tracking (Downloaded, Total, Remaining, Percent, Speed, ETA)   
- Accurate Percentage Calculation (Up to 100%)   
- Download Speed Limit (Bytes/sec or KB/MB/GB)   
- Free Disk Space Check   
- Minimum Free Space Control   
- Custom HTTP Headers   
- Configurable Connect/Read Timeouts & Buffer Size   
- Adjustable Progress Update Interval   
- State Tracking (Started, Paused, Canceled, Error, InsufficientSpace, Completed)   
- Formatting Helpers (FormatBytes, FormatSpeed, FormatETA)   
- Runtime Status Properties (IsRunning, IsPaused, IsCompleted, Speed, EtaSeconds, etc.)  
  
events :  
Private Sub EventName\_Progress(downloaded As Long, total As Long, remaining As Long, percent As Int, speed As Long, etaSeconds As Long)  
Private Sub EventName\_StateChanged(state As Int, data As DownloadEventData)  
 ├── STATE\_STARTED  
 ├── STATE\_PAUSED  
 ├── STATE\_CANCELED  
 ├── STATE\_ERROR  
 ├── STATE\_INSUFFICIENT\_SPACE  
 └── STATE\_COMPLETED
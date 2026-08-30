### New version ABVersionController 1.58 (for Patreons only) by alwaysbusy
### 08/27/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171919/)

New version 1.49 (for Patreons): <https://www.patreon.com/alwaysbusy/posts/b4j-snapshots-167826092>  
  
**Note:** take a backup of your previous BACKUP folder, just in case. Read especially 20. Full History Regenaration  
  
ABVersionController – snapshots, retention, source history, reports and optional Issues API  
Hi all,  
  
I have been working on a small version controller for my own B4J/B4X projects.  
  
The original idea was simple: whenever I reach a useful point while programming, I want to make a complete snapshot of the project before continuing.  
  
Over time it grew into something much more useful. 🙂  
  
ABVersionController now creates timestamped snapshots, applies automatic retention, compresses historical versions, keeps track of a deployed version, calculates source statistics, generates HTML comparison reports, and creates a visual project history.  
  
It is **not intended to replace Git**. I use it as an automatic local source snapshot/history system alongside my normal development workflow.  
  
The package consists of three B4J-related parts:  
  
![](https://www.b4x.com/android/forum/attachments/173192)  
  
The library defaults to keeping all of today's snapshots, 30 calendar days of Daily history and Weekly history indefinitely.  
  

---

  
[HEADING=2]1. What ABVersionController does[/HEADING]  
A normal push creates a timestamped snapshot such as:  
  
1.32.2026-08-27.06-12-07-393  
The application version is still yours:  
  
1.32  
while the rest of the name identifies the exact snapshot.  
  
That means you can push several times during the day without having to invent a new application version every time.  
  
For example:  
  
1.32.2026-08-27.08-15-22-151  
1.32.2026-08-27.09-03-44-912  
1.32.2026-08-27.11-27-31-450  

---

  
[HEADING=2]2. The project history[/HEADING]  
For every project, ABVersionController creates an INDEX.html.  
  
It gives an overview of the complete retained history.  
  
![](https://www.b4x.com/android/forum/attachments/173191)  
  
The history contains:  
  
Date  
Time  
Version  
Status  
Snapshot  
Total lines  
Lines (+ / ~ / -)  
Reports  
A row can therefore look like:  
  
2026-08-27 06:09:36 5.17 Today  
94653 total lines  
+63 / ~0 / -0  
Since previous | Since deployed  
The Total lines column is useful even when a push contains no changes because you can still see the size of the codebase at that point.  
  

---

  
[HEADING=2]3. Code evolution chart[/HEADING]  
The generated history also contains a compact chart showing the evolution of the total source-code line count.  
  
![](https://www.b4x.com/android/forum/attachments/173193)  
  
This makes larger changes very easy to notice.  
  
For example:  
  
94,590 lines  
 ↓  
94,653 lines  
is visible immediately instead of having to compare several rows manually.  
  

---

  
[HEADING=2]4. Added, modified and deleted source lines[/HEADING]  
ABVersionController stores statistics for each push in files such as:  
  
PUSHSTATS.5.17.2026-08-27.06-09-36-725.json  
An example contains:  
  
{  
 "version": "5.17.2026-08-27.06-09-36-725",  
 "dateTime": "2026-08-27T06:09:36.725",  
 "totalLines": 94653,  
 "addedLines": 63,  
 "modifiedLines": 0,  
 "deletedLines": 0,  
 "changedFiles": 0,  
 "addedFiles": 1,  
 "deletedFiles": 0  
}  
The same data is displayed in INDEX.html.  
  

---

  
[HEADING=2]5. Supported project types[/HEADING]  
Although I mainly use ABVersionController for B4X development, source detection and statistics are not limited to B4X.  
  
If no explicit source patterns are configured, ABVersionController detects the source type and recursively collects the relevant source files.  
  
Current source types include:  
  
B4X  
Java  
Python  
C#  
C/C++  
PHP  
TypeScript  
JavaScript  
Web  
For example:  
  
Java .java  
Python .py .pyw  
C# .cs  
C/C++ .c .cc .cpp .cxx .h .hh .hpp .hxx  
PHP .php .phtml  
TypeScript .ts .tsx  
JavaScript .js .jsx .mjs .cjs  
Web .html .htm .css .scss .sass .less  
B4X layouts can be included in comparison reports, but layout files are not counted as source-code lines.  
  

---

  
[HEADING=2]6. Quick start – direct configuration from B4J[/HEADING]  
The easiest way to understand the library is the included **ABVersionController B4J Test Project**.  
  
It doesn't use a configuration file.  
  
Everything is configured directly from B4J.  
  
A minimal setup looks like this:  
  

```B4X
Sub Process_Globals  
    Private VC As ABVersionController  
    Private Const APP_VERSION As String = "1.00"  
End Sub  
  
Sub AppStart (Args() As String)  
  
    Dim ProjectDir As String = _  
        File.GetFileParent(File.DirApp)  
  
    Dim BackupRoot As String = _  
        File.Combine(ProjectDir, "_ABVC_TEST_BACKUPS")  
  
    Dim MyIP As String = VC.GetMyIP  
  
    VC.Initialize( _  
        BackupRoot, _  
        Array(MyIP) _  
    )  
  
    VC.ShowLogs = True  
  
    VC.KeepAllToday = True  
    VC.KeepDailyVersions = 30  
    VC.KeepWeeklyVersions = -1  
    VC.KeepMarkedVersions = True  
  
    Dim Snapshot As String = VC.PushVersion( _  
        APP_VERSION, _  
        Array( _  
            "_ABVC_TEST_BACKUPS", _  
            "AutoBackups", _  
            "B4Xlibs", _  
            "bin", _  
            "logs", _  
            "Objects" _  
        ) _  
    )  
  
    Log("Snapshot created: " & Snapshot)  
  
End Sub
```

  
  
The main call is:  
  
VC.PushVersion(…)  

---

  
[HEADING=2]7. Why the IP list?[/HEADING]  
Initialize() takes a list of machines that are allowed to create pushes.  
  
For the test project I simply use:  
  
Array(VC.GetMyIP)  
For a real environment you could use fixed development-machine addresses instead:  
  

```B4X
VC.Initialize( _  
    BackupRoot, _  
    Array( _  
        "192.168.1.20", _  
        "192.168.1.21" _  
    ) _  
)
```

  
  
This is useful if the same code is also running on a production machine where you don't want source snapshots to be created accidentally.  
  

---

  
[HEADING=2]8. Excluding folders[/HEADING]  
The second parameter of PushVersion() contains folders that should not be copied into the snapshot.  
  
For example:  
  

```B4X
Array( _  
    "Objects", _  
    "AutoBackups", _  
    "logs", _  
    "bin" _  
)
```

  
  
You generally don't want compiled output, logs or backup folders copied into every source snapshot.  
  
And definitely don't forget to exclude the backup folder itself. 😉  
  

---

  
[HEADING=2]9. Retention[/HEADING]  
A development project can easily produce many snapshots.  
  
Keeping every push forever would use a lot of disk space, so ABVersionController automatically applies retention.  
  
A typical configuration is:  
  

```B4X
VC.KeepAllToday = True  
VC.KeepDailyVersions = 30  
VC.KeepWeeklyVersions = -1  
VC.KeepMarkedVersions = True
```

  
The important point is that KeepDailyVersions is based on **calendar days**, not on the number of days on which you happened to push. The JSON configuration parser uses the same meaning.  
  
So if today is:  
  
2026-08-27  
and:  
  
KeepDailyVersions = 30  
then the Daily period is roughly:  
  
2026-07-28 → 2026-08-26  
If you did no programming on a certain date, the retention window does not extend further backwards to compensate.  
  

---

  
[HEADING=2]10. Today / Daily / Weekly[/HEADING]  
The resulting history can therefore contain statuses such as:  
  
Today  
Daily  
Weekly  
Deployed  
Marked  
**[IMAGE 4 – INDEX.html showing Today, Daily and Weekly statuses]**  
  
A typical history might eventually look like:  
  
27 Aug Today  
26 Aug Daily  
25 Aug Daily  
…  
31 Jul Daily  
  
24 Jul Weekly  
17 Jul Weekly  
10 Jul Weekly  
…  

---

  
[HEADING=2]11. KeepAllToday[/HEADING]  
With:  
  
VC.KeepAllToday = True  
every snapshot created today remains available.  
  
So during one development session you may have:  
  
09:05  
10:18  
11:44  
13:27  
15:02  
all available as individual snapshots.  
  
Once that day becomes historical, ABVersionController consolidates the history according to the Daily/Weekly retention rules.  
  

---

  
[HEADING=2]12. Daily retention[/HEADING]  
The three meanings are:  
  
KeepDailyVersions = -1  
Keep Daily history indefinitely.  
  
KeepDailyVersions = 0  
Disable Daily historical retention.  
  
KeepDailyVersions = 30  
Keep Daily restore points inside the previous 30 calendar days.  
  

---

  
[HEADING=2]13. Weekly retention[/HEADING]  
After snapshots fall outside the Daily period, they can become Weekly restore points.  
  
VC.KeepWeeklyVersions = -1  
means:  
  
> keep one historical snapshot per ISO week indefinitely.

You can also use:  
  
VC.KeepWeeklyVersions = 12  
to keep only a limited number of Weekly restore points.  
  
Or:  
  
VC.KeepWeeklyVersions = 0  
to disable Weekly retention completely.  
  
[HEADING=1]ABVersionController control files[/HEADING]  
Besides the snapshots, HTML reports and JSON statistics, ABVersionController uses a few small .TXT files to keep track of the state and history of a project.  
You normally **do not need to manage these files manually**, with the exception of MARKEDVERSIONS.txt and DEPLOYEDVERSION.txt when you want to protect particular snapshots.  
[HEADING=2]LASTDEPLOYED.txt — currently deployed version[/HEADING]  
LASTDEPLOYED.txt contains the snapshot that ABVersionController considers to be the version currently deployed in production.  
For example:  
  
1.02.2026-08-25.10-21-29-036  
  
Only the snapshot name is needed. ABVersionController also accepts a value ending in .zip and internally converts it back to the logical snapshot name.  
This file has two important purposes.  
First, the deployed snapshot is **protected by the retention system**. Even when it would normally fall outside the Daily or Weekly retention period, ABVersionController keeps it. The deployed snapshot also remains unpacked because it is frequently needed as a comparison baseline.  
Second, it provides the baseline for the **Since deployed** reports:  
  
LASTDEPLOYED.txt  
 │  
 ▼  
deployed snapshot  
 │  
 └──────────────┐  
 ▼  
 current snapshot  
 │  
 ▼  
 SINCELASTDEPLOYED….html  
  
During a push, ABVersionController reads LASTDEPLOYED.txt and compares that snapshot with the newly created snapshot.  
This is what lets the dashboard show how much the project has changed since the production version.  
**Normally you should let ABVersionController maintain/use this file rather than editing it casually.**  

---

  
[HEADING=2]MARKEDVERSIONS.txt — snapshots that must be preserved[/HEADING]  
Sometimes retention rules aren't enough.  
For example, you may have a snapshot that represents:  

- an important release;
- a customer-specific version;
- the state before a large rewrite;
- a milestone you want to keep indefinitely.

Those snapshots can be listed in:  
  
MARKEDVERSIONS.txt  
  
One snapshot is placed on each line:  
  
1.00.2026-06-14.09-23-11-224  
1.01.2026-07-02.16-42-05-731  
1.02.2026-08-10.11-04-33-105  
  
Both forms are accepted:  
  
1.02.2026-08-10.11-04-33-105  
  
and:  
  
1.02.2026-08-10.11-04-33-105.zip  
  
The .zip suffix is removed internally. Blank lines and lines beginning with # are ignored, so the file can also contain comments.  
For example:  
  
# First public release  
1.00.2026-06-14.09-23-11-224  
  
# Version before database rewrite  
1.01.2026-07-02.16-42-05-731  
  
This works together with:  
  
"keepMarkedVersions": true  
  
When enabled, snapshots listed in MARKEDVERSIONS.txt are protected from the normal retention cleanup.  
So this is the one controller .TXT file that you may intentionally edit yourself.  

---

  
[HEADING=2]ACTIVITYLOG.txt — permanent push activity history[/HEADING]  
Retention creates an interesting problem: old snapshots are deliberately removed.  
That means you cannot determine the true historical number of pushes simply by counting the snapshots that still exist.  
For this reason ABVersionController maintains:  
  
ACTIVITYLOG.txt  
  
Every successful PushVersion() can append an entry containing the timestamp and snapshot version.  
The format used by the current library is:  
  
yyyy-MM-dd'T'HH:mm:ss.SSS|snapshotVersion  
  
For example:  
  
2026-08-12T08:21:44.513|1.7.6.2026-08-12.08-21-44-513  
  
This format is defined directly in the current controller.  
New entries are **appended** rather than replacing the existing file. If the file doesn't exist yet, it is created automatically.  
The root dashboard uses this information for its activity statistics. This means that even if retention eventually reduces:  
  
20 pushes  
  
to:  
  
1 Daily snapshot  
  
the controller still knows that 20 pushes actually occurred.  
For older projects where ACTIVITYLOG.txt does not yet exist, ABVersionController can fall back to estimating activity from the retained snapshots.  
**You should not edit or delete this file.** It is effectively the permanent lightweight activity history of the project.  

---

  
[HEADING=2]PUSHFINISHED.TXT — legacy push-completion marker[/HEADING]  
There is also code for:  
  
PUSHFINISHED.TXT  
  
At the beginning of PushVersion(), ABVersionController checks for an old PUSHFINISHED.TXT and removes it.  
However, there is an important detail in the current version of the library:  
**the code that creates a new PUSHFINISHED.TXT is currently commented out.**  
The old implementation would have written information such as the new version, first/previous version, deployed version and retention settings to the file.  
So for users of the current library, PUSHFINISHED.TXT is effectively **legacy/internal functionality and can be ignored**.  
I would actually mention it only briefly in the tutorial, because forum users don't need to do anything with it.  

---

  
[HEADING=1]Quick reference[/HEADING]  
[TABLE]  
[TR]  
[TH]File[/TH]  
[TH]Purpose[/TH]  
[TH]User should edit?[/TH]  
[/TR]  
[TR]  
[TD]LASTDEPLOYED.txt[/TD]  
[TD]Identifies the currently deployed snapshot and provides the baseline for **Since deployed** comparisons[/TD]  
[TD]Normally yes[/TD]  
[/TR]  
[TR]  
[TD]MARKEDVERSIONS.txt[/TD]  
[TD]Protects selected snapshots from retention cleanup[/TD]  
[TD]**Yes, when needed**[/TD]  
[/TR]  
[TR]  
[TD]ACTIVITYLOG.txt[/TD]  
[TD]Permanent record of successful pushes used for dashboard activity statistics[/TD]  
[TD]No[/TD]  
[/TR]  
[TR]  
[TD]PUSHFINISHED.TXT[/TD]  
[TD]Old/legacy push-completion marker; creation is currently disabled[/TD]  
[TD]No[/TD]  
[/TR]  
[/TABLE]  
[HEADING=2]Where are they stored?[/HEADING]  
These files belong to the **project's ABVersionController backup directory**, alongside its snapshots and reports.  
A typical project history can therefore look roughly like:  
  
AGGridAPI/  
│  
├── LASTDEPLOYED.txt  
├── MARKEDVERSIONS.txt  
├── ACTIVITYLOG.txt  
├── INDEX.html  
│  
├── 1.00.2026-08-25.10-21-29-036.zip  
├── 1.01.2026-08-26.15-42-11-201.zip  
├── 1.02.2026-08-27.08-13-55-722/  
│  
├── PUSHSTATS.1.00….json  
├── PUSHSTATS.1.01….json  
├── PUSHSTATS.1.02….json  
│  
├── SINCEFIRSTPUSH….  
├── SINCEPREVIOUSPUSH….  
└── SINCELASTDEPLOYED….  
  
The are **not part of the source project**. They are metadata maintained alongside the backed-up snapshots. In fact, the snapshot enumeration code explicitly excludes controller files such as LASTDEPLOYED.txt and MARKEDVERSIONS.txt from the version list.  
  
  

---

  
[HEADING=2]14. Historical ZIP files[/HEADING]  
Historical snapshots are compressed to ZIP files.  
  
So a backup folder may look like:  
  
5.17.2026-08-27.06-09-36-725  
5.17.2026-08-17.13-20-18-052.zip  
5.17.2026-08-16.18-35-06-869.zip  
5.17.2026-08-15.16-48-26-716.zip  
The current snapshot can remain directly accessible while older retained history takes considerably less storage.  
  
ABVersionController validates temporary ZIP extractions before removing their directories during maintenance.  
  
![](https://www.b4x.com/android/forum/attachments/173195)  
  

---

  
[HEADING=2]15. Marked versions[/HEADING]  
Sometimes a version is particularly important.  
  
For example:  
  
Before major refactoring  
Customer release  
Stable milestone  
Before database migration  
Marked snapshots can be protected from cleanup when:  
  
VC.KeepMarkedVersions = True  
This allows special versions to survive independently of Daily and Weekly retention.  
  

---

  
[HEADING=2]16. The deployed version[/HEADING]  
ABVersionController also keeps track of the deployed version.  
  
That snapshot is highlighted separately in INDEX.html.  
  
![](https://www.b4x.com/android/forum/attachments/173196)  
  
This is useful because development history then has a meaningful reference point:  
  
> What has changed since the version currently in production?

---

  
[HEADING=2]17. Since previous[/HEADING]  
A comparison report can show what changed since the previous relevant snapshot.  
  
Example:  
  
Since previous  
![](https://www.b4x.com/android/forum/attachments/173197)  
  
This is useful for reviewing one individual development step.  
  

---

  
[HEADING=2]18. Since deployed[/HEADING]  
Another report compares the current state with the deployed version:  
  
Since deployed  
  
For me this is one of the most useful views because it answers:  
  
> What exactly will be different if I deploy the current version?

---

  
[HEADING=2]19. Normal PushVersion is optimized[/HEADING]  
A normal PushVersion() is intended to be fast enough to use during development.  
  
It applies retention first, creates the current push and rebuilds only the history/reports that need to change.  
  
The idea is not to regenerate years of history for every push.  
  

---

  
[HEADING=2]20. Full history regeneration[/HEADING]  
There is also a maintenance method (handy if you used previous versions of ABVersionController):  
  
VC.RegenerateOldHtmlReportsForAllProjects  
This is intentionally different.  
  
It performs a complete maintenance rebuild: retention is applied first, surviving snapshots are rescanned, historical HTML reports are regenerated and INDEX.html is rebuilt.  
  
This is something you run occasionally, for example after changing the ABVersionController report generator itself.  
  
It is **not** something I call after every push.  
  
During this full-history regeneration, statistics aren't recreated for snapshots that are older than the deployed version, because comparing an older source snapshot to a newer deployed version would not be meaningful. The implementation has a dedicated full-regeneration mode separate from normal PushVersion().  
  

---

  
[HEADING=2]21. Configuration with abversioncontroller.json[/HEADING]  
ABVersionController can also be configured through a file named:  
  
abversioncontroller.json  
The file is expected in the source/project directory when configuration mode is used.  
  
This approach is useful if you want the version-controller settings to remain separate from the compiled B4J program. It is very useful for other language versioning (like java, python, etc)  
  
For example:  
  

```B4X
{  
   
  "sourcePatterns": [  
    "src/**/*.java",  
    "src/*.b4x_excluded",  
    "src/resources/**/*.bjl",  
    "src/resources/**/*.bal",  
    "src/resources/**/*.bil",  
    "src/resources/**/*.html",  
    ".project",  
    ".classpath"  
  ],  
  
  "allowedIPs": [  
    "192.168.19.143",  
    "192.168.86.150",  
    "172.19.208.1",  
    "192.168.112.1",  
    "192.168.19.123"  
  ],  
  
  "keepAllToday": true,  
  "keepDailyVersions": 30,  
  "keepWeeklyVersions": -1,  
  "keepMarkedVersions": true,  
  
  "exclude": [  
    ".svn",  
    ".settings",  
    "bin",  
    "doc"  
  ],  
  
  "publish": false,  
  
  "issuesApiUrl": "",  
  "issuesApiToken": "",  
  "dashboardPublishPath": ""  
}  


```B4X
[HEADING=2]publish and publishPath[/HEADING]  
These two settings are optional. They are only useful when you want ABVersionController to copy the generated HTML overview to another location after updating the version history.  
  
For example:  
  
"publish": true,  
"publishPath": "R:\\VersionController\\Published"  
With:  
  
"publish": true  
ABVersionController will publish/copy the generated output to the directory specified by publishPath.  
  
publishPath therefore specifies where the published version should go.  
  
For example, this could be:  


- a shared network folder;
- a web server directory;
- a folder synchronized to another machine;
- a central location where colleagues can view the generated HTML pages.

[HEADING=2]You normally don't need it[/HEADING]  
For normal use, you can simply use:  
  
"publish": false  
In that case, publishPath is effectively ignored and can be left empty:  
  
"publish": false,  
"publishPath": ""  
ABVersionController already creates the INDEX.html, reports, snapshots and statistics inside the project's version-controller backup directory. You can simply open the generated INDEX.html from there.  
  
So publishing has nothing to do with creating a version or keeping the version history. It is just an additional convenience for copying the generated presentation/output somewhere else.  
  
For most B4X users I'd recommend starting with:  
  
"publish": false,  
"publishPath": ""  
  
and only enabling it if they later have a reason to expose/copy the generated overview to another location.  
  
[HEADING=2]Example[/HEADING]  
A minimal configuration therefore does not need a meaningful publish path:  
  
{  
    "projectName": "MyB4JProject",  
    "version": "1.00",  
    "sourcePath": "C:\\B4X\\MyB4JProject",  
    "backupPath": "D:\\VersionController",  
    "publish": false,  
    "publishPath": ""  
}  
  
backupPath is important — publishPath is optional.  
  
backupPath is where ABVersionController maintains the actual version history. publishPath is merely an optional second destination for making the generated results available elsewhere.  


---

  
[HEADING=2]22. sourcePatterns[/HEADING]  
The optional:  
  
"sourcePatterns": […]  
array controls which source files are collected.  
  
Examples supported by the configuration code include patterns such as:  
  


```B4X
    "src/**/*.java",  
    "src/*.b4x_excluded",  
    "src/resources/**/*.bjl",  
    "src/resources/**/*.bal",  
    "src/resources/**/*.bil",  
    "src/resources/**/*.html",  
    ".project",  
    ".classpath
```

  
  
The configured paths are normalized internally so / can be used regardless of Windows/Linux path separators.  
  
A B4X project could use:  
  
{  
  "sourcePatterns": [  
    "*.b4j",  
    "*.bas",  
    "Files/*.bjl"  
  ]  
}  
If no explicit patterns are configured, the current source detection can automatically collect supported source types.  
  


---

  
[HEADING=2]23. allowedIPs[/HEADING]  
The JSON alternative to the direct Initialize() whitelist is:  
  
"allowedIPs": [  
  "192.168.1.20",  
  "192.168.1.21"  
]  
This provides the same safeguard against accidentally creating snapshots from machines that aren't intended to act as development machines.  
  


---

  
[HEADING=2]24. exclude[/HEADING]  
Excluded folders can also be defined in JSON:  
  
"exclude": [  
  "Objects",  
  "AutoBackups",  
  "logs",  
  "bin"  
]  
Nested paths can be used as well.  
  


---

  
[HEADING=2]25. Choosing direct configuration or JSON[/HEADING]  
Both approaches are valid.  
  
For a simple project I like the clarity of:  
  
VC.Initialize(…)  
VC.KeepDailyVersions = 30  
VC.PushVersion(…)  
For a larger installation, JSON can be convenient because retention/source settings can be changed without recompiling the B4J project.  
  
The included test project uses the direct form because it is the quickest way to understand the API.  
  


---

  
[HEADING=2]26. Optional Issues support[/HEADING]  
ABVersionController can also integrate a small issue tracker into the generated HTML reports.  
  
To enable it:  
  
VC.IssuesApiUrl = _  
    "http://127.0.0.1:5100/v1/issues"  
  
VC.IssuesApiToken = _  
    "YOUR_TOKEN"  
The library considers Issues configured when both the URL and token are present.  
  
The same settings can also be supplied through abversioncontroller.json using:  
  
{  
  "issuesApiUrl": "http://127.0.0.1:5100/v1/issues",  
  "issuesApiToken": "YOUR_TOKEN"  
}  
Those values are loaded by the configuration parser.  
  


---

  
[HEADING=2]27. ABVC Issues API[/HEADING]  
The third included project is a minimal B4J/MySQL server.  
  
It is optional.  
  
If you don't want Issues, ABVersionController works perfectly well without it.  
  
The server uses:  
  
B4J  
jServer  
jSQL  
Json  
MySQL  
and exposes:  
  
GET    /v1/issues  
POST   /v1/issues  
PUT    /v1/issues  
DELETE /v1/issues  
There is deliberately no project spider/discovery system in the simple version.  
  
The project name is stored directly with every issue.  
  


---

  
[HEADING=2]28. MySQL table[/HEADING]  
The included API creates its required table automatically with:  
  
CREATE TABLE IF NOT EXISTS abvc_issue (…)  
The main fields are:  
  
issue_id  
project_name  
issue_type  
title  
description  
issue_status  
priority  
tags  
created  
modified  
created_version  
resolved_version  
An issue therefore retains both its project and relevant version information.  
  


---

  
[HEADING=2]29. Example Issues API configuration[/HEADING]  
The B4J server contains settings similar to:  
  
Public Const API_TOKEN As String = _  
    "CHANGE_ME_TO_A_LONG_RANDOM_TOKEN"  
  
Public Const DB_DRIVER As String = _  
    "com.mysql.cj.jdbc.Driver"  
  
Public Const DB_URL As String = _  
    "jdbc:mysql://127.0.0.1:3306/abversioncontroller"  
  
Public Const DB_USER As String = "abvc"  
Public Const DB_PASSWORD As String = "CHANGE_ME"  
Use the same API token in the project using ABVersionController:  
  
VC.IssuesApiToken = _  
    "CHANGE_ME_TO_A_LONG_RANDOM_TOKEN"  


---

  
[HEADING=2]30. Why CORS is enabled in the Issues API[/HEADING]  
The generated ABVersionController HTML reports may simply be opened from disk:  
  
file:///…  
The browser then still needs to call the Issues API.  
  
For that reason the example API supports CORS and browser OPTIONS requests.  
  


---

  
[HEADING=2]31. Issues interface[/HEADING]  
When an Issues API is configured, the generated reports can show and edit project issues.  
  
![](https://www.b4x.com/android/forum/attachments/173198)  
  
![](https://www.b4x.com/android/forum/attachments/173199)  
  
Possible issue information includes:  
  
Type  
Title  
Description  
Status  
Priority  
Tags  
Created version  
Resolved version  


---

  
[HEADING=2]32. Five-minute test[/HEADING]  
The quickest way to try it is:  
  


1. Install/select the ABVersionController library.
2. Open the supplied B4J test project.
3. Run it.
4. Edit TestCode.bas.
5. Run again.
6. Open the generated INDEX.html.

You should now have two snapshots and a visible difference between them.  
  


---

  
[HEADING=2]34. A typical real-world setup[/HEADING]  
My own B4J usage can be as little as:  
  
Private VC As ABVersionController  
  
VC.Initialize( _  
    "K:\_ONETWO_VC", _  
    Array(VC.GetMyIP) _  
)  
  
VC.KeepAllToday = True  
VC.KeepDailyVersions = 30  
VC.KeepWeeklyVersions = -1  
VC.KeepMarkedVersions = True  
  
VC.PushVersion( _  
    "1.32", _  
    Array( _  
        "Objects", _  
        "AutoBackups", _  
        "logs" _  
    ) _  
)  
After that, the version controller takes care of most of the history management automatically.  
  


---

  
[HEADING=2]35. Why use this if Git exists?[/HEADING]  
Because I don't see them as competing tools.  
  
ABVersionController solves a much smaller and very practical problem:  
  

> Give me a complete restorable snapshot of this project now, automatically maintain a useful long-term history, and give me a readable HTML overview of what changed.

Once it is added to a project, the normal workflow is basically:  
  
VC.PushVersion(…)  
and continue programming.  
  
[HEADING=2]36. Search[/HEADING]  
A very handy search which will search in your last snapshots:  
  
![](https://www.b4x.com/android/forum/attachments/173200)  
  


---

  
[HEADING=2]37. Final result[/HEADING]  
After using it for a while, every project effectively gets its own little local history site.  
  
You can immediately see:  
  
current version  
deployed version  
source size  
recent changes  
Daily/Weekly history  
available ZIP snapshots  
comparison reports  
what changed since deployment  
What started as a simple "make a backup before I change something" helper has become a pretty useful companion to my B4X development workflow. 🙂  
  
Alwaysbusy
```
```
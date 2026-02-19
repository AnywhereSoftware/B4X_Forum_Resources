### Quartz Scheduler (Cron) - For enterprise grade task scheduling software by Peter Simpson
### 02/16/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170295/)

Hello everyone,  
I wrapped this last year whilst trying to learn Java, I then had to learn about cron expressions o\_O.  
Yesterday I cleaned up the code (a lot) and added the IDE tooltip for the community, I also created an extensive B4J example for developers to learn from, so read it carefully.  
  
Quartz is a **lightweight, embeddable job scheduler solution**. Its purpose is simple, it lets your program run tasks automatically at specific times or intervals, without relying on the operating system’s scheduler.  
  
[SIZE=4]Here is the essence of Quartz in plain terms.[/SIZE]  
[HEADING=2][SIZE=4]**What Quartz does**[/SIZE][/HEADING]  

- [SIZE=4]Runs jobs on a schedule (every minute, every hour, every day, cron expressions, etc.)[/SIZE]
- [SIZE=4]Manages recurring tasks reliably inside your application[/SIZE]
- [SIZE=4]Supports multiple jobs, triggers, calendars, and priorities[/SIZE]
- [SIZE=4]Can persist schedules in a database so they survive restarts (You have to add the database code of your choice)[/SIZE]
- [SIZE=4]Works in desktop applications, servers applications, and background worker services[/SIZE]

[HEADING=2][SIZE=4]**Why developers around the world use Quartz**[/SIZE][/HEADING]  

- [SIZE=4]Quarts is an industry standard scheduler solution[/SIZE]
- [SIZE=4]It's far more flexible than OS‑level schedulers[/SIZE]
- [SIZE=4]It handles complex timing rules (cron, exclusions, holidays) etc[/SIZE]
- [SIZE=4]It's stable and battle tested[/SIZE]

[HEADING=2][SIZE=4]**In one short paragraph**[/SIZE][/HEADING]  
[SIZE=4]Quartz is a powerful, programmable timer system that lets your application run tasks automatically and reliably according to any schedule you define. It can handle everything from writing to and reading from databases and files, to launching external applications using the Shell command, sending commands, processing data and much more. What Quartz actually does is simple. It fires your code at the exact times or intervals you specify, without you needing to manage timers, threads, or OS‑level schedulers.  
  
How you use that sort of power is entirely up to you. As a B4J developer, you can combine Quartz with your existing knowledge of file I/O, networking, SQL, APIs, or system automation to build anything from simple reminders to full industrial grade task automation solutions. With a bit of imagination and the help of the B4X search box when you need help, you can easily manipulate this library to its full potential.  
  
**Quartz Scheduler is used in industry grade solutions.**   
Quartz has been used for more than 20 years in production systems across finance, telecoms, logistics, healthcare, and enterprise Java platforms.  
  
**Hint:** Personally, I would create an SQLite or MySQL database to store all jobs and schedules, and then connect the database to the Quartz Scheduler.[/SIZE]  
  
**B4J library tab:**  
![](https://www.b4x.com/android/forum/attachments/169889)  
  
**Example B4J application:**  
![](https://www.b4x.com/android/forum/attachments/169888)  
  
**SS\_QuartzScheduler  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **QuartzScheduler**

- **Events:**

- **JobDeleted** (JobName As String)
- **JobError** (JobName As String, Error As String)
- **JobExecute** (JobName As String, Data As Map)
- **JobFinished** (JobName As String)
- **JobScheduled** (JobName As String)
- **JobStarted** (JobName As String)
- **SchedulerError** (Error As String)
- **SchedulerShutdown**
- **SchedulerStarted**

- **Functions:**

- **CancelJob** (jobName As String)
*Alias for DeleteJob.  
 jobName is the Job name.*- **ClearLog**
*Clears internal log entries.*- **DeleteGroup** (groupName As String)
*Deletes all jobs in a given group.  
 groupName is the Group name.*- **DeleteJob** (jobName As String)
*Deletes a job by name in any group.  
 jobName is the Job name.*- **GetJobData** (jobName As String) As Map
*Retrieves the Map of data associated with a job.  
 jobName is the Job name.  
 Returns a Map of job data (empty if job not found).*- **GetJobDetailInfo** (jobName As String) As Map
*Returns basic job detail metadata as Map: Name, Group, Description.  
 jobName is the Job name.  
 Returns a Map with keys "Name", "Group", "Description" (empty if job not found).*- **GetJobLog** (jobName As String) As List
*Returns logs related to a specific job name.  
 jobName is the Job name.  
 Returns a List of strings.*- **GetJobState** (jobName As String) As String
*Returns the current state of a job.  
 Possible values:  
 SCHEDULED  
 PAUSED  
 RUNNING  
 COMPLETE  
 NOT\_FOUND  
 jobName The job name.  
 Returns State string.*- **GetLog** As List
*Returns the full internal log of the scheduler.  
 Returns a List of strings.*- **GetNextRunTime** (jobName As String) As Long
*Returns the next scheduled execution time for a job.  
 jobName is the Job name.  
 Returns Next run time in milliseconds (0 if not found or no upcoming run).*- **GetTriggerInfo** (jobName As String) As List
*Returns detailed trigger information for a specific job.  
 Each item in the returned list is a Map containing trigger metadata.  
 jobName is the job name.  
 Returns A List of Maps describing the job's triggers.*- **Initialize** (eventName As String)
*Initialise synchronously.  
 Uses RAMJobStore.  
 eventName is the Event name prefix (e.g., "qs").*- **InitializeAsync** (eventName As String)
*Initialise asynchronously (wrapper entry point).  
 Uses RAMJobStore.  
 eventName is the Event name prefix (e.g., "qs").*- **InterruptJob** (jobName As String)
*Requests interruption of a running job (if it implements InterruptableJob).  
 jobName is the Job name.*- **JobExists** (jobName As String) As Boolean
*Checks whether a job with the given name exists in any group.  
 jobName is the Job name.  
 Returns true if the job exists, false otherwise.*- **ListGroups** As List
*Returns all job groups currently registered in the scheduler.  
 Returns A List of group names.*- **ListJobs** As List
*Returns a List of job names currently known to the scheduler.*- **PauseGroup** (groupName As String)
*Pauses all jobs in a given group.  
 groupName is the Group name.*- **PauseJob** (jobName As String)
*Pauses a job by name in any group.  
 jobName is the Job name.*- **ResumeGroup** (groupName As String)
*Resumes all jobs in a given group.  
 groupName is the Group name.*- **ResumeJob** (jobName As String)
*Resumes a previously paused job by name in any group.  
 jobName is the Job name.*- **RunJobNow** (jobName As String)
*Triggers a job to run immediately, searching all groups for the job name.  
 jobName is the Job name.*- **ScheduleCronJob** (jobName As String, cron As String, data As Map)
*Schedule a cron job synchronously (default group).  
 jobName is the Job name (unique).  
 cron is the Cron expression.  
 data is the Map of data to pass to job (can be null).*- **ScheduleCronJob2** (jobName As String, groupName As String, cron As String, data As Map)
*Schedule a cron job synchronously with group.  
 jobName is the Job name.  
 groupName is the Group name.  
 cron is the Cron expression.  
 data is the Map data.*- **ScheduleJobAsync** (jobName As String, cronOrNull As String, intervalSeconds As Long, repeatCount As Long, data As Map)
*Schedule job asynchronously on background thread (default group).  
 jobName is the Job name.  
 cronOrNull is the Cron expression or null.  
 intervalSeconds is the Interval seconds for repeating (ignored if cron provided).  
 repeatCount is the Repeat count for repeating (ignored if cron provided).  
 data is the Map data.*- **ScheduleJobAsync2** (jobName As String, groupName As String, cronOrNull As String, intervalSeconds As Long, repeatCount As Long, data As Map)
*Schedule job asynchronously on background thread with group.  
 jobName is the Job name.  
 groupName is the Group name.  
 cronOrNull is the Cron expression or null.  
 intervalSeconds is the Interval seconds for repeating (ignored if cron provided).  
 repeatCount is the Repeat count for repeating (ignored if cron provided).  
 data is the Map data.*- **ScheduleRepeatingJob** (jobName As String, intervalSeconds As Long, repeatCount As Long, data As Map)
*Schedule a repeating job synchronously (default group).  
 jobName is the Job name.  
 intervalSeconds is the Interval in seconds.  
 repeatCount Number of repeats (<= 0 => forever).  
 data is the Map data.*- **ScheduleRepeatingJob2** (jobName As String, groupName As String, intervalSeconds As Long, repeatCount As Long, data As Map)
*Schedule a repeating job synchronously with group.  
 jobName is the Job name.  
 groupName is the Group name.  
 intervalSeconds is the Interval in seconds.  
 repeatCount is the Number of repeats (<= 0 => forever).  
 data is the Map data.*- **SetJobChain** (jobNames As List)
*Define a simple chain of jobs: JobNames(0) -> JobNames(1) -> JobNames(2) …  
 When one finishes successfully, the next is triggered.  
 jobNames is the List of job names in execution order.*- **Shutdown**
*Shutdown scheduler synchronously. Waits for running jobs to complete.*- **ShutdownAsync**
*Shutdown scheduler on background thread. Returns immediately.*- **Start**
*Start scheduler synchronously.  
 Blocks until scheduler.start() returns.*- **StartAsync**
*Start scheduler on background thread.  
 Returns immediately.*
***Important:  
Always use the following methods to Initialize, Start, and Shutdown Quartz Scheduler. See the attached B4J example and also the examples in post #3 below:***  
 **InitializeAsync**  
 **StartAsync  
 ShutdownAsync**  
  
***I will be making the public non-async methods private in the next update, whenever that might be.***  
  
**PLEASE NOTE:   
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY JAVA DEPENDENCIES LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE** - Download Extra Libraries](https://www.dropbox.com/scl/fi/0pvo5e2h5l6luv7pnzqvp/Quartz-2.3.2.zip?rlkey=048mckwpj8rwmeex3ebbnyr25&dl=0) <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
**Enjoy…**
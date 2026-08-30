### Quartz Scheduler Cron Jobs - For enterprise grade task scheduling software by Peter Simpson
### 07/29/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170295/)

Hello everyone,  
I wrapped this last year whilst trying to learn Java, I then had to learn about cron expressions o\_O  
  
Yesterday I decided to cleaned up the code, fixed all known issues, and I added the IDE tooltips for the IDE. I also created an extensive B4J example for developers to learn from, so read it very carefully.  
  
This truly is **THE ONLY** 100% precise timing library that you need to use when it comes to scheduling tasks in your B4J projects  
  
Quartz Scheduler is a precise timing **lightweight**, embeddable job scheduler solution. Its purpose is simple, it lets your program run tasks automatically at specific times or intervals, without relying on the operating systems scheduler or complicated timer routines.  
  
[SIZE=4]Here is the essence of Quartz in plain terms.[/SIZE]  
[HEADING=2][SIZE=4]**What Quartz does**[/SIZE][/HEADING]  

- [SIZE=4]Runs jobs on a schedule (every few seconds, every minute, every hour, every day, every x days, etc) via cron expressions[/SIZE]
- [SIZE=4]Manages all recurring tasks reliably inside your application[/SIZE]
- [SIZE=4]Supports multiple jobs, triggers, calendars, and priorities[/SIZE]
- [SIZE=4]Can persist schedules in a database so they survive restarts (You have to add the database code of your choice), I removed SQLite for reliability purposes[/SIZE]
- [SIZE=4]Works in desktop applications, servers applications[/SIZE]
- [SIZE=4]Use in desktop applications or as a background worker service[/SIZE]

[HEADING=2][SIZE=4]**Why developers around the world use Quartz**[/SIZE][/HEADING]  

- [SIZE=4]Quarts is an industry standard scheduler solution[/SIZE]
- [SIZE=4]It's far more flexible than OS‑level schedulers[/SIZE]
- [SIZE=4]It handles complex timing rules (cron, exclusions, holidays) etc[/SIZE]
- [SIZE=4]It's stable and reliable[/SIZE]

[HEADING=2][SIZE=4]**In one short paragraph**[/SIZE][/HEADING]  
[SIZE=4]Quartz Scheduler is a powerful, programmable Quartz level timer system that lets your application run tasks automatically and reliably according to any schedule you define. Quartz can schedule everything from interacting with databases, processing files, to launching external applications using the Shell command, sending commands, processing data, working with I/O and much more. What Quartz actually does is simple. Quartz can fire your code at precise times or intervals that you specify, without you needing to manage timers, threads, or OS‑level schedulers.  
  
How you use that sort of power is entirely up to you. As a B4J developer, you can combine Quartz with your existing knowledge of file I/O, networking, SQL, APIs, or system automation to build anything from simple reminders to full industrial grade task automation solutions. With a bit of imagination and the help of the B4X search box when you need help, you can easily manipulate this library to its full potential.  
  
**Quartz Scheduler is used in industry grade solutions.**   
Quartz has been used for more than 20 years in production systems across finance, telecoms, logistics, healthcare, and enterprise Java platforms.  
  
**Hint:** Personally, I would create an external SQLite database to store all jobs and schedules, and then connect the database to the Quartz Scheduler. Jobs and schedules can also be hard-coded directly into your application.[/SIZE]  
  
**B4J library tab:**  
![](https://www.b4x.com/android/forum/attachments/169889)  
  
**Example B4J application:**  
![](https://www.b4x.com/android/forum/attachments/169888)  
  
**SS\_QuartzScheduler  
  
Author:** Peter Simpson  
**Version:** 1.11  

- **QuartzScheduler**

- **Events:**

- **ExecutorHealth** (Healthy As Boolean)
- **JobDeleted** (JobName As String)
- **JobError** (JobName As String, Error As String)
- **JobExecute** (JobName As String, Data As Map)
- **JobFinished** (JobName As String)
- **JobScheduled** (JobName As String)
- **JobStarted** (JobName As String)
- **SchedulerError** (Error As String)
- **SchedulerShutdown**
- **SchedulerStarted**

- **Fields:**

- **SetMaxLogEntries** As Int
*Sets the maximum number of log entries to retain.  
 Default entries is set to 1000.  
 Older entries are removed automatically.*
- **Functions:**

- **CancelJob** (jobName As String)
*Alias for PauseJob.  
 jobName is the Job name.*- **CheckExecutorHealth**
*Checks if the executor is alive and not shutdown.  
 Raises event: ExecutorHealth (Boolean)*- **ClearLog**
*Clears the internal log entries.*- **DeleteGroup** (groupName As String)
*Deletes all jobs in a given group on a background thread.  
 groupName is the Group name.*- **DeleteJob** (jobName As String)
*Deletes a job by name in any group on a background thread.  
 jobName is the Job name.*- **GetAllJobs** As List
*Returns a B4J List of all job names across all groups.  
 Each item is a Map with keys: "group" and "name".*- **GetJobData** (jobName As String)
*Retrieves the Map of data associated with a job.  
 jobName is the Job name.  
 Returns a Map of job data (empty if job not found).*- **GetJobDetailInfo** (jobName As String)
*Returns basic job detail metadata as Map: Name, Group, Description.  
 jobName is the Job name.  
 Returns a Map with keys "Name", "Group", "Description" (empty if job not found).*- **GetJobGroups** As List
*Returns a list of job group names.*- **GetJobLog** (jobName As String) As List
*Returns logs related to a specific job name.  
 jobName is the Job name.  
 Returns a List of strings.*- **GetJobNames** (groupName As String) As List
*Returns a list of job names for a given group.*- **GetJobState** (jobName As String)
*Returns the current state of a job.  
 Possible values: SCHEDULED, PAUSED, RUNNING, COMPLETE, NOT\_FOUND.  
 jobName The job name.  
 Returns State string.*- **GetLog** As List
*Returns the full internal log of the scheduler.  
 Returns a List of strings.*- **GetLogCount** As Int
*Returns the number of log entries currently stored.*- **GetLogs** As List
*Returns a copy of the internal log entries as a B4J List.  
 The returned list contains the log lines in chronological order (oldest first).*- **GetNextFireTime** (jobName As String) As java.util.Date
*Returns the next fire time for a given job (by name) as a Date, or Null if not found.  
 Searches across all groups for the job name.*- **GetNextRunTime** (jobName As String)
*Returns the next scheduled execution time for a job.  
 jobName is the Job name.  
 Returns Next run time in milliseconds (0 if not found or no upcoming run).*- **GetSchedulerState** As Map
*Returns a B4J Map with scheduler metadata: started(boolean), inStandby(boolean), shutdown(boolean)*- **GetTriggerInfo** (jobName As String)
*Returns detailed trigger information for a specific job.  
 Each item in the returned list is a Map containing trigger metadata.  
 jobName is the job name.  
 Returns A List of Maps describing the job's triggers.*- **InitializeAsync** (EventName As String)
*Initialise asynchronously, Uses RAMJobStore.  
 eventName is the Event name prefix ("QS", "Quartz", "Schedule" etc).*- **InterruptJob** (jobName As String)
*Requests interruption of a running job on a background thread.  
 jobName is the Job name.*- **IsStarted** As Boolean
*Returns true if the scheduler is started and not shutdown.*- **JobExists** (jobName As String)
*Checks whether a job with the given name exists in any group.  
 jobName is the Job name.  
 Returns true if the job exists, false otherwise.*- **ListGroups**
*Returns all job groups currently registered in the scheduler.  
 Returns A List of group names.*- **ListJobs**
*Returns a List of job names currently known to the scheduler.*- **PauseGroup** (groupName As String)
*Pauses all jobs in a given group on a background thread.  
 groupName is the Group name.*- **PauseJob** (jobName As String)
*Pauses a job by name in any group on a background thread.  
 jobName is the Job name.*- **ResumeGroup** (groupName As String)
*Resumes all jobs in a given group on a background thread.  
 groupName is the Group name.*- **ResumeJob** (jobName As String)
*Resumes a previously paused job by name in any group on a background thread.  
 jobName is the Job name.*- **RunJobNow** (jobName As String)
*Run a job immediately by name (helper used by chaining).*- **ScheduleCronJob** (jobName As String, cron As String, data As Map)
*Schedule a cron job (default group) on a background thread.  
 jobName is the Job name (unique).  
 cron is the Cron expression.  
 data is the Map of data to pass to job (can be null).*- **ScheduleCronJob2** (jobName As String, groupName As String, cron As String, data As Map)
*Schedule a cron job with group on a background thread.  
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
*Schedule a repeating job (default group) on a background thread.  
 jobName is the Job name.  
 intervalSeconds is the Interval in seconds.  
 repeatCount Number of repeats, zero or less means repeat forever.  
 data is the Map data.*- **ScheduleRepeatingJob2** (jobName As String, groupName As String, intervalSeconds As Long, repeatCount As Long, data As Map)
*Schedule a repeating job with group on a background thread.  
 jobName is the Job name.  
 groupName is the Group name.  
 intervalSeconds is the Interval in seconds.  
 repeatCount Number of repeats, zero or less means repeat forever.  
 data is the Map data.*- **SetJobChain** (jobNames As List)
*Define a simple chain of jobs: JobNames(0) -> JobNames(1) -> JobNames(2) …  
 When one finishes successfully, the next is triggered.  
 jobNames is the List of job names in execution order.*- **ShutdownAsync**
*Shutdown scheduler on background thread. Returns immediately.*- **StartAsync**
*Start the scheduler on a background thread.  
 The call returns immediately without waiting for the scheduler to start.*- **StopAsync**
*Stop the scheduler completely.  
 Deletes all scheduled jobs, shuts down Quartz,  
 clears internal state, and destroys the instance.*- **WatchdogStatus**
*Logs a watchdog snapshot of scheduler and executor health.*
  
**PLEASE NOTE:   
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY JAVA DEPENDENCIES LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE** - Download Extra Libraries](https://www.dropbox.com/scl/fi/0pvo5e2h5l6luv7pnzqvp/Quartz-2.3.2.zip?rlkey=048mckwpj8rwmeex3ebbnyr25&dl=0) <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
D = 123 + 166  
  
  
**Enjoy…**
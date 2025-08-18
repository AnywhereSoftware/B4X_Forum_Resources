### B4XPages - Simple tip for referencing pages by Jack Cole
### 10/02/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/134743/)

This is a tip to save you some time. It is just an easier way to access your B4XPages classes. In the Main module, I put the page declarations in a custom type. Here is an example:  
  

```B4X
Type PageContainerType (PageMainMenu As B4XPageMainMenu, PageSettings As B4XPageSettings, PageWelcome As B4XPageWelcome, PageEmailLogin As B4XPageEmailLogin, PageCreateEmailAccount As B4XPageCreateEmailAccount, PageSyncAdmin As B4XPageSyncAdmin, PageTasksToday As B4XPage_TodaysTasks, Task_Reading As B4XPageTask_Reading, Task_Video As B4XPageTask_Video, Task_SleepLog As B4XPageTask_SleepLog, Task_GetUpTime As B4XPageTask_GetUpTime, Task_Reminder As B4XPageTask_Reminder)
```

  
  
Then when you initialize the pages, do it like this:  
  

```B4X
    Pages.Initialize  
      
    Pages.PageMainMenu.Initialize  
    B4XPages.AddPage("Page Main Menu", Pages.PageMainMenu)  
    Pages.PageSettings.Initialize  
    B4XPages.AddPage("Settings Page", Pages.PageSettings)
```

  
  
Then it is easier to reference your pages from other modules.  
  
![](https://www.b4x.com/android/forum/attachments/119792)
### Web API Server v2 by aeric
### 01/09/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/147966/)

[TABLE]  
[TR]  
[TH]Note:[/TH]  
[/TR]  
[TR]  
[TD]This tutorial is based on Web API Server v2.02 and is deprecated.  
Please refer to [(B4J Tutorial) Web API Server v3](https://www.b4x.com/android/forum/threads/web-api-server-v3.163824/)[/TD]  
[/TR]  
[/TABLE]  
  
[SPOILER="Deprecated"]  
Introduction:  
  
This tutorial is based on [**Web API Server v2**](https://www.b4x.com/android/forum/threads/web-api-template-2.143310/).  
  
How to install:  
  
1. Download the template and copy it to B4J **Additional Library** folder.  
![](https://www.b4x.com/android/forum/attachments/142002)  
  
2. Open B4J and you will see the template when you select menu File->New.  
![](https://www.b4x.com/android/forum/attachments/142001)  
  
Getting Started  
  
1. To quick start, just run the project in debug mode.  
2. Browse to <http://127.0.0.1:8080/web/help> to test the API. You can also click on "Open API Documentation" button on home page.  
3. Click the first example [GET] /web/api/v2/data under DATA controller to expand the section.  
4. Click the green "Submit" buton to execute a call to the API.  
5. The Response texbox should display an empty list.  
6. You can proceed with other API examples.  
  
Basic Configuration  
  
The API server requires the following configuration in Main module and must be in the following order.  

```B4X
ConfigurePaths  
ConfigureElements  
ConfigureHandlers  
ConfigureControllers
```

  
Other configurations are optional and order are not important.  
  
ConfigurePaths  
First thing to configure  
This setting is determined by the values in Config.ini (inside Objects folder).  
For starting, just let the default values.  
You can then edit the Config.ini file using any Text Editor.  
  
ConfigureElements  
Configure this after ConfigurePaths  
This setting depends automatically by ConfigurePaths above.  
Nothing is needed to be configured here.  
  
ConfigureHandlers  
Configure this after ConfigureElements  
By default, ApiHandler is the only required handler.  
If WebHandler is enabled (uncommented), then we can use it to route non-API URL to show web front-end such as home page.  
If HelpHandler is enabled (by default), API documentation is available for debugging the API without client app or Postman.  
If HelpHandler is disabled (commented) then API documentation is not available for debugging. This handler is not required in release mode.  
  
ConfigureControllers  
Configure this after ConfigureHandlers  
If HelpHandler is used, this configuration includes which controller class to display on the API documentation page.  
By default, only DataController is added.  
When you have more controllers, you can add them here.  
You can hide some APIs using #Hide keyword  
[/SPOILER]  
  
**Note:** Please **do not** post your question in this thread. Start a new question and tag with **[Web API Server v2]** in the title.
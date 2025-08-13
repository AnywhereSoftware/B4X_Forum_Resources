### [Web] Beginning Telegram Mini Apps - CloudStorage aka CRUD Key-Value Store by Mashiane
### 08/09/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/162294/)

Hi Fam  
  
[Demo](https://t.me/SithasoHoldingsBot) (Open in Telegram Mobile App)  
  
[Source Code](https://github.com/Mashiane/SithasoTMA)  
  
Today we look at Telegram Cloud Storage, a key-value pair storage available on the Mini Apps. We will create a task manager to demonstrate this. This will have a done indicator, the task name and one will be able to edit and delete a task.  
  
Each bot can store up to 1024 items per user in the cloud storage.  
  
The final app works as task manager.  
  
<https://youtube.com/shorts/8cHubUIpW3I?si=vmxHGHxxAUYHKdif>  
  
  
  
![](https://www.b4x.com/android/forum/attachments/156000)  
  
![](https://www.b4x.com/android/forum/attachments/156001)  
  
![](https://www.b4x.com/android/forum/attachments/156002)  
  
  
  
To create our list of tasks, we will use the SDUIMenu and then a custom item. The template for each custom task item is like this.  
  

```B4X
<li id="taskitem">  
    <div id="taskrow" class="row px-2 py-0 grid-cols-12 grid">  
        <div id="taskcola" class="col col-span-2 sm:col-span-2 md:col-span-2 lg:col-span-2 xl:col-span-2 flex justify-center items-center">  
            <input id="taskdone" name="taskdone" type="checkbox" class="checkbox checkbox-success"></input>  
        </div>  
        <div id="taskcolb" class="col col-span-6 sm:col-span-6 md:col-span-6 lg:col-span-6 xl:col-span-6">  
            <p id="taskname">{task}</p>  
        </div>  
        <div id="taskcolc" class="col col-span-2 sm:col-span-2 md:col-span-2 lg:col-span-2 xl:col-span-2 flex justify-center items-center">  
            <div id="btntaskedit_indicator" class="indicator">  
                <button id="btntaskedit" class="btn btn-circle btn-sm btn-neutral tooltip-left">  
                    <span><i id="btntaskedit_icon" class="fa-solid fa-pencil fa-sm"></i></span>  
                </button>  
            </div>  
        </div>  
        <div id="taskcold" class="col col-span-2 sm:col-span-2 md:col-span-2 lg:col-span-2 xl:col-span-2 flex justify-center items-center">  
            <div id="btntaskdelete_indicator" class="indicator">  
                <button id="btntaskdelete" class="btn btn-circle btn-sm btn-neutral bg-[#ff0000] tooltip-left">  
                    <span><i id="btntaskdelete_icon" class="fa-solid fa-trash fa-sm"></i></span>  
                </button>  
            </div>  
        </div>  
    </div>  
</li>
```

  
  
We save this in our assets as **taskitem.txt** and then add the template to our app as..  
  

```B4X
BANano.Await(app.AddMyLayoutFile("taskitem", "./assets/taskitem.txt"))
```

  
   
Let's continue…
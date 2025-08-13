### [BANano] Using PocketBase (Firebase Alternative) for your Apps. by Mashiane
### 09/19/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/143589/)

Hi there.  
  
**Update: This class is based on the JavaScript SDK available here, <https://github.com/pocketbase/js-sdk>  
REST API calls are dont internal to the library, if you want to use pure REST API, use BANanoFetch, the documentation should be easy to follow.**  
  
I got to test the "Open Source backend for your next SaaS and Mobile app in 1 file" tech stack today. I must say its a very interesting project.  
  
![](https://www.b4x.com/android/forum/attachments/134937)  
  
I downloaded a single file from the [PocketBase](https://pocketbase.io/) website, opened my command prompt. Executed "pocketbase serve" where I unzipped the file.  
  
![](https://www.b4x.com/android/forum/attachments/134932)  
  
I then copied the "Admin UI" link provided to my browser and an admin panel was available where I created an account and ended up creating a collection to test it out. All this still locally.  
  
After everything was done, creating the schema of my "categories" to capture my "Expense Categories", I went to my folder…  
  
![](https://www.b4x.com/android/forum/attachments/134934)  
  
On the "pb\_public" folder you can actually deploy your website. I stopped my laragon dev web server. Copied my BANAno project to pb\_public.  
  
![](https://www.b4x.com/android/forum/attachments/134935)  
  
I then proceeded to open my browser and used the provided link, **<http://127.0.0.1:8090/>**, my web project came to life. I tested the TailwindCSS CRUD REST API based project I did (Under Backends). I'm impressed, this is my first Tailwind, my first PocketBase, my first DaisyUI project, and its going very well.  
  
This project is named [SithasoDaisy](https://www.b4x.com/android/forum/threads/sithasodaisy-tailwindcss-daisyui-toolbox-pre-flight.143549/#post-909876), its a pure javascript based project using the TailwindCSS utility classes, inspired by [DaisyUI](https://daisyui.com/).  
  
![](https://www.b4x.com/android/forum/attachments/134936)  
  
Interestingly enough, after deploying the same app to Netlify with the PocketBase server still running on my side, the web app on netlify was still able to execute all the CRUD commands to my local database. One of the nice features about PocketBase is the subscription model on CRUD transactions, indicating creation, updates and deletes, when you activate a subsciption.  
  
You can use BANanoFetch in their REST API and also there is a javascript lib that interfaces the REST API nicely for PocketBase. The docs are very simple to follow.  
  
Deployed on [Netlify](https://sithasodaisyui.netlify.app/)  
  
  
[MEDIA=youtube]2WQs7Em6dYw[/MEDIA]  
  
  
Happy BANano coding!
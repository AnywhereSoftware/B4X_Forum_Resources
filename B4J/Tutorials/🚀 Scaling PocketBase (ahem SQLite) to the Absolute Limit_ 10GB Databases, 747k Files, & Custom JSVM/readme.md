### 🚀 Scaling PocketBase (ahem SQLite) to the Absolute Limit: 10GB Databases, 747k Files, & Custom JSVM Hooks by Mashiane
### 08/09/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171760/)

Hello B4X Developers!  
  
If you are building client applications in B4A, B4i, or B4J, you constantly need a fast, reliable, and lightweight backend. Many of us have turned to **PocketBase**—the open-source Go backend with an embedded SQLite database, but a common question arises: *Can PocketBase truly scale for massive, production-level deployments?*  
  
Today, I want to share the anatomy of a massive PocketBase **v0.22.50** deployment and how you can optimize it to handle tremendous load without breaking a sweat.  
  
**The 10 Gigabyte Footprint**  
  
Many developers assume SQLite will choke under pressure. However, PocketBase solves this by strictly decoupling relational data from heavy binary file payloads. In a recent production deployment, we analyzed the following footprint:  

- **Database (pb\_data/data.db):** 2.88 GB handling robust relational querying.
- **Storage Directory (pb\_data/storage):** 6.49 GB containing over 747,100 files and 257,395 folders.

Despite having nearly a million files and a combined size of ~10GB, read and write queries remain highly performant. The framework utilizes dynamic SQLite PRAGMA optimizations, proving that an embedded database can punch well above its weight class if structured correctly.  
  
**Aggressive CRUD Optimization via JSVM**  
  
For highly demanding applications, standard CRUD operations might introduce slight overhead, particularly because PocketBase treats files as regular field values and processes multipart form data inherently.  
  
If your app frequently updates textual or relational data where file handling is completely unnecessary, you can aggressively optimize these endpoints using **JavaScript Virtual Machine (JSVM) hooks**.  
  
By placing \*.pb.js scripts inside your pb\_hooks directory, the goja engine allows you to intercept the request lifecycle entirely.  

- Using hooks like onRecordBeforeUpdateRequest (or onRecordUpdateRequest in newer versions), you can intercept HTTP requests before database locks occur.
- You can directly manipulate e.record to update only the specific fields required, explicitely save via $app.dao().saveRecord(), and halt the execution chain to completely bypass standard file-parsing overhead.

**Stability and the v0.23.0 Horizon**  
  
We specifically focus on **v0.22.50** because it represents a pinnacle of stability. If you are running a massive production app today, there is no immediate rush to upgrade. Critical bugs and security vulnerabilities for the v0.22.x branch are being backported.  
  
However, looking forward, **PocketBase v0.23.0** introduces massive architectural shifts. The Dao abstraction is completely removed (merged into the core $app instance), collections are flattened, and the entire routing system has been rewritten utilizing Go 1.22 mux enhancements. Migrating a heavily customized backend to v0.23+ will require significant manual rewrites of your JSVM hooks and API integrations.  
  
**The Learner Management App and The Labour Activation Programme being ran by our Government.**  
  
With Pocketbase, I have created and deployed an app using SithasoDaisy2. I talk about this here.  
  
<https://www.b4x.com/android/forum/threads/sithasodaisy2-the-learner-management-app-the-labour-activation-programme-being-ran-by-our-government.171759/>  
  
**Pocketbase for B4X**  
  
Alexander has created a b4x for this. Here is it. <https://www.b4x.com/android/forum/threads/b4x-pocketbase-open-source-backend-in-1-file.165213/>  
  
  
[MEDIA=youtube]ldV9IdYEp3Y[/MEDIA]  
  
**Have you pushed PocketBase to its limits in your B4X projects?** Let me know your deployment sizes and optimization strategies below!  
  
#SharingTheGoodness
### [SithasoDaisy5] Creating your Organogram / Family tree by Mashiane
### 03/25/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166307/)

Hi Fam  
  
With SithasoDaisy5, you will be able to create Organograms / Family Trees. Drop a SDUI5TreeSpider on your form and whala!  
  
This is wrapped from this [GitHub Project](https://github.com/paulosabayomi/treeSpider)  
  
![](https://www.b4x.com/android/forum/attachments/162916)  
  

```B4X
Sub Show(MainApp As SDUI5App)  
    app = MainApp  
    BANano.LoadLayout(app.PageView, "treespiderview")  
    pgIndex.UpdateTitle("SDUI5TreeSpider")  
    '  
    tsOrganogram.Clear  
    tsOrganogram.AddItem("", "1", "Abayomi Amusa", "Manager", "Lagos, Nigeria", "")  
    tsOrganogram.AddItem("1", "2", "Trey Anderson", "Product Manager", "California, United States", "")  
    tsOrganogram.AddItem("1", "3", "Troy Manuel", "Software Developer", "Alberta, Canada", "")  
    tsOrganogram.AddItem("1", "4", "Rebecca Oslon", "Software Developer", "London, United Kingdom", "")  
    tsOrganogram.AddItem("1", "5", "David Scheg", "Product Designer", "Jiaozian, China", "")  
    tsOrganogram.AddItem("2", "6", "James Zucks", "DevOps", "Accra, Ghana", "")  
    tsOrganogram.AddItem("2", "7", "Zu Po Xe", "Backend Developer", "Johanesburg, South Africa", "")  
    tsOrganogram.AddItem("2", "8", "Scott Ziagler", "FrontEnd Developer Intern", "", "")  
    tsOrganogram.AddItem("7", "9", "Xervia Allero", "FrontEnd Developer Intern", "", "")  
    tsOrganogram.AddItem("3", "10", "Adebowale Ajanlekoko", "Fullstack Developer", "", "")  
    tsOrganogram.Refresh  
End Sub
```

  
  
Enjoy!
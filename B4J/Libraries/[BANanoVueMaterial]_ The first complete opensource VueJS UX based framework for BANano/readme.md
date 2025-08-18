### [BANanoVueMaterial]: The first complete opensource VueJS UX based framework for BANano by Mashiane
### 02/02/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/113789/)

***\*START OF NOTICE***  
  
[SIZE=5]**As of 02 FEB 2021, this project is is no longer maintained as it has given birth to** [**BVAD3.**](https://www.b4x.com/android/forum/threads/bananovuetifyad-vuetify-websites-webapps-with-banano-for-dummies.124548/)[/SIZE]  
  
*This project was a joy to create, however like everything that has a start and an end, its time to move on and evolve. BVAD3 is faster, more simpler to implement and takes advantage of the Abstract Designer use.*  
  
[Subscribe to Telegram Channel](https://t.me/bananovuematerial)  
  
[[BANanoVuetifyAD] Vuetify WebSites & WebApps with BANano for Dummies](https://www.b4x.com/android/forum/threads/bananovuetifyad-vuetify-websites-webapps-with-banano-for-dummies.124548/)  
  
Ahoy!!!  
  
***\*END OF NOTICE*  
  
  
UPDATE 24 October 2020: The recommended methodology to create BANanoVuetify WebApp is being discussed here:** [**MealPrep**](https://www.b4x.com/android/forum/threads/bananovuematerial-mealprep-app.123795/#content)**. This covers most of what VueJS + Vuetify is all about in terms of the internals.  
  
Whilst you can use the designer to create your UX, you need to separate your concerns when creating the app just like its done on the MealPrep by using components and routers for the pages.   
  
DO NOT FOLLOW THE APPROACH USED IN CREATING THE BANANOVUEMATERIALDEMO WHEN CREATING YOUR APPS. THAT METHOD IS NO LONGER FEASIBLE.**  
  
[**Download**](https://github.com/Mashiane/BANanoVuetify)  
  
[**BANanoVuetifyAD - Prelease Playlist on Youtube**](https://www.youtube.com/playlist?list=PLXw1ldc5AxBM-z61dDNC1eBozxQzdvOiR)  
[**BANanoVueMaterial (Vuetify) Playlist on Youtube**](https://www.youtube.com/playlist?list=PLXw1ldc5AxBPbh1fNqeREw16EMTxZ_Ta6)  
  
[2020-05-20 Update: Important Update](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-738320)  
  
[**BANanoVueMaterial Designer Usage - Mock.Compile.Publish**](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/)  
  
[**BANanoVueMaterialCore (pure vuetify without extensions)**](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-734349)  
  
[**Exploring Components & Router Basics**](https://www.b4x.com/android/forum/threads/bananovuematerial-exploring-components-routers-basics.118959/#post-744094)  
  
[**How to ask questions, request help, report bugs and request enhancements + Telegram Channel**](https://www.b4x.com/android/forum/threads/bananovuematerial-how-to-ask-questions-request-help-report-bugs-and-request-enhancements-telegram-channel.121623/)  
  
Thanks to everyone who has been playing with this and highlighting issues and requesting features. You are stars!  
  
\*\*\* IMPORTANT: [Migrating to the new version](https://github.com/Mashiane/BANanoVuetify/blob/master/Migration.txt)  
  
Word. Moving from [VueMaterial](https://vuematerial.io/) to [Vuetify](https://vuetifyjs.com/en/) was inevitable and whilst both are Vue Material based frameworks, Vuetify has more strengths. If if was going to be possible, we would not be having a migration guide, however things changed and enhancements happened and some code rewrites took place. When doing the transition from the VueMaterial to Vuetify codebases, we tried to make the code transition to be as smooth as possible, thus our migration guide is as small as possible. We did not want to dictate how to use the lib, so we removed some things that were hard coded and fixed. This was specific to the side drawer. To test the migration, the old examples were converted to new examples (see below) and all of them work.  
  
BANanoVueMaterial is complete open source, so this means you can use it to your hearts content and adjust it and make it your own. If you enhance, send us word, we will merge. Make the code simple and comment it as much as you can. I cannot over-emphasize that Vuetify is LARGE, so check their website on how components are created and used to learn stuff. Do enjoy. TheMash. #IAmLovingThis  
  
**BANanoVuetify (recommended for new projects & migration notes attached)**  
  
[You can track our progress from here](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-vuejs-ux-based-framework-for-banano.113789/post-715255). All the components that we got from VueMaterial exists in Vuetify and more!!!  
  

- Copy all the files in the 1. External Libraries folder to your B4J external libraries folder
- If you want to explore the BANanoVuetify source code, open and run the project in 2. Library
- If you want to explore all the components in this version, open and run the project in 3. Demo
- You can also explore other specific examples from the 4. Examples folder

[Live Preview](https://mashiane.github.io/BANanoVuetify/)  
  
[MEDIA=youtube]cLbyAqwR-DQ[/MEDIA]  
  
  
**Tutorials (New)  
  
Mock.Compile.Publish**  
  
*NB: Download and Import the Project Components files for the Expense Tracker [here](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737933).  
  
1. Expense Tracker with BANanoSQL*  
  
[Expense Tracker Part 1](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-736839)  
[Expense Tracker Part 2](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-736885)  
[Expense Tracker Part 3](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-736913)  
[Expense Tracker Part 4](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737153)  
[Preparations for Part 5](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737321)  
[Expense Tracker Part 5.1](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737541)  
[Expense Tracker Part 5.2](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737644)  
  
*2. Expense Tracker with SQLite (**you need to understand all of 1. Expense Tracker with BANanoSQL first!**)*  
  
[Making your app use SQLite as a backend](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737656)  
[Mock.Compile.Publish Expense Tracker with SQLite as BackEnd Full Implementation](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737795)  
  
*3. Expenses Tracker with MSSQL **(you need to understand all of 1. & 2. above first!)***  
  
[Mock.Compile.Publish Expense Tracker with MSSQL as BackEnd](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-737920)  
  
*4. Expense Tracker with MySQL **(you need to understand all of 1. - 3. above first)***  
  
[Mock.Compile.Publish Expense Tracker with MySQL as BackEnd](https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-738062)  
  
**NEW NEW NEW!!!!** [Handling Events](https://www.b4x.com/android/forum/threads/bananovuematerial-handling-events.115831/)  
  
[Developing a grid with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-719423)  
[Developing forms with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-719978)  
[Designing text field controls with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720590)  
[Designing text area controls with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720684)  
[Designing password controls with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720686)  
[Designing images with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720687)  
[Designing file input with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720689)  
[Designing buttons with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720917)  
[Designing checkboxes with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720934)  
[Designing switches with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-720940)  
[Designing icons with Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-721691)  
[Designing labels with Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-721969)  
[Designing sliders with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-722549)  
[Designing select, combo and autocomplete with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-722901)  
[Designing radio boxes with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-723362)  
[Designing date & time pickers with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-723752) (NB: functionality works on your app)  
[Designing a parallax with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-724594)  
[Designing a container with the Designer](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-724800)  
[Designing the appbar, toolbars and systembar with the Designer - Part 1](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-725086)  
[Designing the appbar, toolbars and systembar with the Designer - Part 2](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-725369)  
[Drag n Drop Menu - Part 1](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-725370)  
[Drag n Drop Menu - Part 2](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-726354)  
[Drag n Drop Carousel](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-727989)  
[Drag n Drop Dialog](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-728737)  
[Drag n Drop Rating](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-728740)  
[Drag n Drop SpeedDial](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-728741)  
[DataTable multi selects](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-732441)  
[SetFocus(?)](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-732696)  
[Invisible File Selector](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-732751)  
[DataTable GetItemKeys](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-732792)  
[Drag n Drop Chips](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-733069)  
[Drag n Drop Badges](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-733257)  
[Drag n Drop Avatars](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-733272)  
[Exporting Component Schemas (Multi Development Mode)](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-732750)  
[Importing Component Schemas (Multi Development Mode)](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-733306)  
[Drag n Drop Lists](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-733643)  
[Drag n Drop Tabs](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-733663)  
[Drag n Drop Stepper](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-733713)  
[Drag n Drop ExpansionPanels (Accordion)](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-734041)  
[Drag n Drop Page](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-734254)  
[Setting Project Properties](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-734930)  
[Reading Text files (without upload to server)](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-735135)  
[Reading Excel files (without upload to server)](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-735151)  
  
**Reporting (New)**  
  
[Excel Client Side Reporting with OXML](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/post-723414)  
  
**Example Projects**  
  
[Hello World](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/1.%20Hello%20World)  
[Navigation (1 or more pages using v-show directive)](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/2.%20Navigation)  
[Login Screen](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/3.%20LoginDialog)  
[User Registration Screen](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/4.%20SignUpDialog)  
[Expenses.Show - MySQL+PHP+ChartKick CRUD](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/5.%20Expenses.Show)  
[Form Utilities - BANanoSQL CRUD](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/6.%20FormUtilities)  
[Calculations - using watch directives](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/8.%20Calculations)  
  
**IMPORTANT: Asking Questions about BANanoVueMaterial**  
  
1. Please do not ask questions on this thread as this is about updates and new developments about BANanoVueMaterial.  
2. When asking a question, please use the B4J Forum and prefix your question with [BANanoVueMaterial] Your Question  
3. As the author of this lib, I would recommend that in the content of your question you also address it to myself with [USER=44364]@Mashiane[/USER] (this will also help me find and attend to your questions faster as it will show in my personal notifications)  
  
**Related Content**  
  
[BANanoVue](https://www.b4x.com/android/forum/threads/bananovue-building-webapps-websites-with-vuejs.109579/#content) - a now updated CORE of BANanoVueMaterial  
[BANanoWired](https://www.b4x.com/android/forum/threads/bananowired-15-mockup-elements-for-your-prototypes.110473/#content) - a mockup framework build on BANanoVue (WIP)  
[BANanoPDFDesign](https://www.b4x.com/android/forum/threads/bananopdfdesign-wysiwyg-pdf-documents-designer.111443/#content) - a creation based on BANanoVueMaterial for PDF reporting (WIP)  
[BANanoVMDesign](https://www.b4x.com/android/forum/threads/bananovmdesign-drag-n-drop-wysiwyg-form-designer.112419/) - this intends to support BANanoVueMaterial design philosophy. (WIP)  
  
Have fun and enjoy!  
  
PS: BANanoVueMaterial uses an updated version of the BANanoPostProcessor library done by Kiffi.
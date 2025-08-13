### Create a B4X library with Android Studio - Step by step by zolive33
### 01/27/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/137737/)

Hi,  
  
I share with you my method to create a library for B4X, based on corwin42's post ([Create a wrapper library with Android Studio](https://www.b4x.com/android/forum/threads/create-a-wrapper-library-with-android-studio.82831/)).  
Feel free to improve it and share your modifications.  
  
  

[SIZE=6]? My great thanks to corwin42 ?[/SIZE]

  
  
  
⚠️ I work on Linux, so you may need to change the file separators. ⚠️  
  
[TABLE]  
[TR]  
[TD]**[SIZE=6]1 - Creating a new project [/SIZE]**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Select "Phone and Tablet" and "No Activity"  
  
Click 'Next'[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/124389)[/TD]  
[/TR]  
[TR]  
[TD]Select  

1. package name :
"myTestProject" (for this tutorial)2. save location
3. langage : java
4. minimum SDK API level your library :
21 (for this tutorial)
  
Click 'Finish'  
  

⚠️Wait for Gradle sync… (about 1 minute)

[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124390)[/TD]  
[/TR]  
[TR]  
[TD]**[SIZE=6]2 - Delete the default "app" module [/SIZE]**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]By default a module named "app" is created. We don't need this,  
so we can delete it.[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124391)[/TD]  
[/TR]  
[TR]  
[TD]

1. Select File/Project Structure…
<Ctrl+Alt+Maj+s>2. Select "app" in the modules list
3. Click the "-" button at the top of the list.
4. Confirm dialog
5. Click 'Ok'

[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124392)[/TD]  
[/TR]  
[TR]  
[TD]Delete directory app in project files.[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/124393)[/TD]  
[/TR]  
[TR]  
[TD]**[SIZE=6]3 - Add Core and B4AShared jar libraries [/SIZE]**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Select File->New->Directory  
Name it 'libs'[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/124395)[/TD]  
[/TR]  
[TR]  
[TD]Open 'libs' directory and add the following files, from your B4A installation folder  
(usually in the folder C:\Program Files (x86)\Anywhere Software\Basic4android\Libraries\) :  

- B4AShared.jar
- Core.jar

[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124394)[/TD]  
[/TR]  
[TR]  
[TD]**[SIZE=6]4 - Modify build.gradle for the project [/SIZE]**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Dependencies  

- Classpath : select lastest version 'of com.android.tools.build:gradle'

Allprojects / repositories  

- Remove jcenter()

Click 'Sync now'[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124396)[/TD]  
[/TR]  
[TR]  
[TD]**[SIZE=6]5 - Create your library [/SIZE]**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]

1. Select File->New->New module…
2. Select "Android Library"
3. Name your library (We use default name "mylibrary" for this tutorial)
4. Click Finish

[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124397)[/TD]  
[/TR]  
[TR]  
[TD]Change build method for your Library :  

1. Menu Build->Select Build Variant…
2. Select Release

[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124398)[/TD]  
[/TR]  
[TR]  
[TD]**[SIZE=6]6 - Delete files from testing framework [/SIZE]**[/TD]  
  
[TD]

[SIZE=5]⚠️The default project creates some code for the testing framework we don't need, so we delete these files/folders.⚠️[/SIZE]

[/TD]  
[/TR]  
[TR]  
[TD]Select the "Project" view and open the src tree. There are three subfolders.  
Main is our main source tree. androidTest and test folders can be deleted.  
Right click them and select Delete.[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124401)[/TD]  
[/TR]  
[TR]  
[TD]**[SIZE=6]7 - Add a dummy/myLib class [/SIZE]**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]B4A always expects a .jar file as a library. With our AS project we can only create .aar files. So we have to include a dummy class in our release.  
  
I declare Author, Version and DependsOn in this class, nothing else.[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124412)[/TD]  
[/TR]  
[TR]  
[TD]**[SIZE=6]8 - Under module mylibrary, Modify Build.gradle file[/SIZE]**[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Replace build.gradle for our library. You can use a full example at end of this document.  
  
You must adapt the follow definitions :   

- def BADoclet\_Path = '/home/olivier/Documents/01-projets/01-Java/BADoclet'
- def B4A\_AdditionalLibs = '/home/olivier/Documents/01-projets/02-Android/B4A\_OtherLibs'
- def Optional\_StaticClass = 'none'
- def Optional\_B44IgnoreClasses = 'none'

[/TD]  
  
[TD]![](https://www.b4x.com/android/forum/attachments/124413)[/TD]  
[/TR]  
[TR]  
[TD]Select the Spinner in the toolbar (it may show the "app" build configuration) and select "Edit Configuration…"[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/124414)  
[/TD]  
[/TR]  
[TR]  
[TD]Remove app[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/124415)  
[/TD]  
[/TR]  
[/TABLE]  
  

[SIZE=7]That's all folks ;)[/SIZE]

  
  
[SIZE=6]**Build.gradle for project:** [/SIZE]  

```B4X
// Top-level build file where you can add configuration options common to all sub-projects/modules.  
buildscript {  
    repositories {  
        google()  
        mavenCentral()  
    }  
    dependencies {  
        classpath "com.android.tools.build:gradle:4.2.2"  
   
        // NOTE: Do not place your application dependencies here; they belong  
        // in the individual module build.gradle files  
    }  
}  
   
allprojects {  
    repositories {  
        google()  
        mavenCentral()  
    }  
}  
   
task clean(type: Delete) {  
    delete rootProject.buildDir  
}
```

  
  
[SIZE=6]**Build.gradle for module :** [/SIZE]  

```B4X
apply plugin: 'com.android.library'  
   
   
def BADoclet_Path = '/home/olivier/Documents/01-projets/01-Java/BADoclet'  
def B4A_AdditionalLibs = '/home/olivier/Documents/01-projets/02-Android/B4A_OtherLibs'  
def Optional_B4AStaticClass = 'none'  
def Optional_B44IgnoreClasses = 'none'  
   
def buildTempLibs = "$buildDir" + File.separator + "tmp" + File.separator + "libs"  
def buildClasses = "$buildDir" + File.separator + "classes"  
   
android {  
    compileSdkVersion 30  
    buildToolsVersion "30.0.2"  
   
    buildFeatures {  
        buildConfig = false  
    }  
   
    defaultConfig {  
        minSdkVersion 14  
        targetSdkVersion 30  
        versionCode 1  
        versionName "1.0"  
   
    }  
    buildTypes {  
        release {  
            minifyEnabled false  
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'  
        }  
    }  
   
    compileOptions {  
        sourceCompatibility JavaVersion.VERSION_1_8  
        targetCompatibility JavaVersion.VERSION_1_8  
    }  
   
    sourceSets {  
        main {  
            java {filter.excludes = ["dummy/*.java"]}  
        }  
    }  
   
}  
   
dependencies {  
    implementation fileTree(include: ['*.jar'], dir: 'libs')  
    compileOnly files('../libs/b4a/Core.jar')  
    compileOnly files('../libs/b4a/B4AShared.jar')  
   // Implementation sample :  
    implementation 'com.github.rey5137:material:1.3.1'  
    implementation 'androidx.annotation:annotation:1.2.0'  
    implementation 'androidx.appcompat:appcompat:1.3.1'  
    implementation 'androidx.cardview:cardview:1.0.0'  
    implementation 'androidx.recyclerview:recyclerview:1.2.1'  
}  
   
configurations {  
   
    println("Check directories")  
    File BADocletPath = new File (BADoclet_Path)  
    if (!BADocletPath.exists()){  
    throw new FileNotFoundException('BADoclet path not found! Please, check BADoclet_Path.')  
}  
File B4xPath = new File (B4A_AdditionalLibs)  
if (!B4xPath.exists()){  
    throw new FileNotFoundException('B4X Additional Libraries path not found! Please, check B4A_AdditionalLibs.')  
}  
   
/* update Jan 26, 2024 : deleted because it causes an error  
    println("Copy api (jar file) into libs directory")  
    configurations.api.canBeResolved(true)  
    copy {  
        from configurations.api  
        into 'libs'  
    }  
*/  
   
    println("Prepare environment for Javadoc")  
    configurations.implementation.canBeResolved(true)  
    configurations.implementation  
            .each { archive ->  
                if (archive.name.endsWith('.aar')) {  
                    copy {  
                        from zipTree(archive)  
                        include "**"  + File.separator + "classes.jar"  
                        into buildTempLibs + File.separator + "${archive.name.replace('.aar', '')}"  
                    }  
                }  
                else {  
                    copy {  
                        from archive  
                        into buildTempLibs  
                    }  
                }  
            }  
    configurations.compileOnly.canBeResolved(true)  
    configurations.compileOnly  
            .each { archive ->  
                if (archive.name.endsWith('.aar')) {  
                    copy {  
                        from zipTree(archive)  
                        include "**" + File.separator + "classes.jar"  
                        into buildTempLibs + File.separator + "${archive.name.replace('.aar', '')}"  
                    }  
                }  
                else {  
                    copy {  
                        from archive  
                        into buildTempLibs  
                    }  
                }  
            }  
   
}  
   
tasks.register("b4xJavadoc", Javadoc) {  
    File javadocFile = new File(B4A_AdditionalLibs + File.separator + thisObject.getName() + ".xml")  
   
    classpath += project.files(android.getBootClasspath().join(File.pathSeparator))  
    classpath += fileTree(dir: buildTempLibs)  
   
    source = "src" + File.separator + "main" + File.separator + "java"  
   
    options.docletpath = [file(BADoclet_Path)]  
    options.doclet = "BADoclet"  
    options.addStringOption("b4atarget", javadocFile.absoluteFile.toString())  
    options.addStringOption("b4aignore", Optional_B44IgnoreClasses)  
}  
   
tasks.whenTaskAdded {  
    theTask ->  
        if (theTask.name.contains("assembleRelease")) {  
            theTask.dependsOn(b4xJavadoc)  
            doLast{  
                println("CreateDummyJar")  
                ant.mkdir(dir: buildClasses)  
                ant.javac(  
                        release: "8",  
                        srcdir: "src" + File.separator + "main" + File.separator + "java" + File.separator + "dummy",  
                        destdir: buildClasses,  
                        debug: "false",  
                        includeantruntime: "false",  
                        classpath: ".." + File.separator + "libs" + File.separator + "b4a" + File.separator + "B4AShared.jar"  
                )  
                ant.jar(  
                        basedir: buildClasses,  
                        jarfile: B4A_AdditionalLibs + File.separator + thisObject.getName() + '.jar'  
                )  
   
                println("Copy aar files to B4X Additional Libraries")  
                copy {  
                    from "$buildDir" + File.separator + "outputs" + File.separator + "aar" + File.separator + thisObject.getName() + "-release.aar"  
                    into B4A_AdditionalLibs  
                    rename(thisObject.getName() + '-release.aar', thisObject.getName() + '.aar')  
                }  
   
                println("Update Javadoc")  
                ant.replaceregexp(  
                        file: B4A_AdditionalLibs + File.separator + thisObject.getName() + '.xml',  
                        match: '\\<class\\>(\\n *\\<name\\>' + Optional_B4AStaticClass + '\\<\\/name\\>)',  
                        replace: '\\<class b4a_type=\'StaticCode\'\\>\\1',  
                        flags: 'g',  
                        byline: 'false'  
                )  
            }  
        }  
}
```

  
  
To build your library : Menu Build->Make Module…
### [BANanoVue] - Building WebApps/Websites with VueJS by Mashiane
### 09/15/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/109579/)

Ola  
  
The world has changing at a very lightning-fast speed. Gone are the days when websites were static. Ajax came for dynamic websites and soon React, Angular, Vue, the list is long.  
  
A couple of months ago I went for an interview. Do you React? Do you Angular? Do you Vue? Sadly I never got the job. Anyway. You don't need BANano to write VueJS apps, but I like BANano and it makes things easy for me. So let's get to it. If you are reading this great. Welcome to the club of exploring VueJS with BANano.  
  
**What is Vue?**  
  
Vue is an open source JavaScript framework geared towards building user interfaces, created by Evan You. It is said to be the progressive JavaScript framework that is approachable, versatile, and performant. This means…  
  
1. You can scale it up or down.  
2. If you know HTML, CSS, Javascript, you are good to go.  
3. There is an ecosystem, Vue\_CLI, VueX, Vue-Router, Vue-Test Utils  
4. Its uses Virtual DOM  
  
Etc, Etc.  
  
**So how do I use it?**  
  
So fire up B4J, create a new project, establish a reference to the BANano Library and…  
  

```B4X
BANano.Header.AddJavascriptFile("vue.min.js")
```

  
  
You can add any css framework you want by the way!  
  
Then, create a code module, let's call it pgIndex, add some initialization code and let's create a Hello Vue page.  
  
**What are we going to do?**  
  
1. We will create a Vue application.  
  

```B4X
new Vue({  
// options  
});
```

  
  
2. We will create div in our body and then tell Vue to "manage" the div as a Vue section.  
  

```B4X
new Vue({  
el: '#app',  
});
```

  
  
3. We will then change the state of the div content we created. Remember, Vue is a reactive framework.  
  

```B4X
new Vue({  
el: '#app',  
data: {  
greeting: 'Hello World!',  
},  
});
```

  
  
4. To change the state, we use something like Moustache syntax.  
  

```B4X
<html>  
<body>  
<div id="app">  
<h2>{{ greeting }}</h2>  
</div>  
</body>  
</html>
```

  
  
**Before we do this, let's run some silly assumptions**  
  
1. You have a development, webserver running. I am using [laragon](https://laragon.org). This means the publish folder is 'c:\laragon\www', if you are using xampp, change that to 'c:\xampp\httpdocs' I think. You can also use Google Webserver also it however does not play well with PHP.  
2. You have some know how about CSS, HTML and JavaScript.  
3. You have set up your dev environment for B4J + BANano dev.  
  
**Now that you have checked all the Silly Assumptions, let's Get ready, Set and Go!**  
We are still on the same page ja? (In a german accent). You still get the drift isn't it? ;) Cool!  
  
We are going to do this in 4 lines of code. Don't believe me? Check this out!  
  

```B4X
Sub Init  
    'initialize vue, this clears the body and adds an empty div identified with app.  
    Vue.Initialize  
    'set the default state  
    Vue.SetDefaultState("greeting", "Hello World!")  
     
    'let's update the app div  
    BANano.GetElement("#app").Append($"<h2>{{ greeting }}</h2>"$)  
     
    'execute the DOM rendering  
    Vue.ux  
End Sub
```

  
  
I told you… minus the comments its just 4 lines. Ha ha ha!  
  
I have activated the device mode in Google Chrome, it kinda looks cute. (you can turn it on /off if you want with Crtl +Shift + I)  
  
![](https://www.b4x.com/android/forum/attachments/83881)  
  
  
Now let's just get a few things out of the way.  
  
1. The used BP (BANanoPostProcessor) generates the logs to an external file. Find it in the attached zip. I have found it easier if I do that as at times the log becomes small to see errors, they scroll out of view at times, so an external file makes sense to me.  
  
2. With experience gained experimenting with React, thus the [BANanoReact](https://www.b4x.com/android/forum/threads/bananoreact-render-your-website-webapp-using-facebook-reactjs.108790/#content) which I am still exploring, my personal choice is Vue as the learning curve is not that steep.  
  
3. Mustache - <https://github.com/janl/mustache.js/>  
  
4. As this is still an experiment, expect things to change. They always do.  
  
5. This is going to be very short as I WONT explore CSS frameworks with it.  
  
Let's park this for later then.  
  
The Mash
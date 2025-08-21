### [BANanoReact] Render your Website/WebApp using Facebook ReactJS by Mashiane
### 02/17/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/108790/)

Hi there  
  
**DEPRECATED: THIS WAS JUST A PROOF OF CONCEPT** (now overtaken by BANanoWebix & BANanoVueMaterial)  
  
  
Before you embark on this journey, you might first want to look at [BANano4DummiesByExample](https://www.b4x.com/android/forum/threads/banano-for-dummies-by-example.108722/#content) first!  
  
You are going to need some resources from GitHub, here is the link, [BANanoReActApp](https://github.com/Mashiane/BANanoReActApp)  
  
![](https://www.b4x.com/android/forum/attachments/83572)  
Reproduction after you have downloaded  
  
1. Copy the contents of the Libraries folder to your B4J external libraries folder.  
2. If you want to recompile BANanoReact yourself, you can do that with the BANanoReact project.  
3. The demo project on using BANanoReact has 4 examples, these are on the BANanoReactDemo folder.  
4. BANanoReactMDL is a wrapper of [Google's MDL](https://getmdl.io/), whilst that framework is no longer supported by Google (they are working on V2 of it using MDC, it is stable to create websites & webapps.  
5. BANanoReactMDLDemo is a demo app based on BANanoReactMDL.  
  
When ran, the BANanoReactDemo should show something this similar. This has been ran inside Google Mobile Shell.  
  
\*\*\* IMPORTANT \*\*\*\*  
  
**NOT all React functionality has been wrapped for this library. The crux was just for view rendering.**  
  
The most updated source code for all examples is in the GitHub Repo.  
  
![](https://www.b4x.com/android/forum/attachments/83573)  
  
  
  
**Introducing React**  
  
At it’s most basic, React is a tool for rendering HTML with JavaScript. ReactDOM.render takes a ReactElement object describing what to render, adding the result to the given [DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction) node. But how do you create ReactElement objects? That’s where React.createElement comes in.  
  
React.createElement takes three parameters, and returns a ReactElement. From the [React documentation](https://facebook.github.io/react/docs/top-level-api.html#react.createelement):  
  
createElement(string/ReactClass type, [object props], [children …]) -> ReactElement  
  
The type argument lets us specify what type of HTML element to use; it also lets us specify *custom* elements. The props argument is a way of specifying which attributes are defined on the HTML element, e.g. href for anchors. Finally, the children arguments are strings or ReactElement objects (or arrays of the same) which will be used for the returned element’s content. By choosing to omit or specify children, you can return a single ReactElement or an entire tree.  
  
Since createElement is just plain JavaScript, you can mix in loops, if statements, and anything else JavaScript allows. You can also easily substitute in data stored in JSON.  
  
**About BANanoReact**  
  
BANanoReact seeks to wrap some React functionality to be able create **React** Apps using BANano **without JSX**. I wish this could be a community project. When it comes to ReAct, everyone is all about using [JSX](https://reactjs.org/docs/introducing-jsx.html) and for newbies this can get to be very overwhelming. The sad reality everywhere we go, most of the tech industry is talking about react. I recently went to a job interview and this is one of the things that was asked. Can you React? I responded No, but I can learn.  
  
One can develop apps using Facebook's React without JSX, however the documentation to do this is very scarce and limited. This has brought me to this point. I've just spent the last 3 hours googling and referencing and looking for easier methods of just creating a simple Hello World project using BANano.  
  
Apparently, there are JSX convectors which give one a vanilla javascript version of the code. Im yet to explore this.  
  
**Reproduction: Get the CDN version of the framework and add these in AppStart.**  
  

```B4X
BANano.Header.AddJavascriptFile("react.development.js")  
    BANano.Header.AddJavascriptFile("react-dom.development.js")
```

  
  
Add this code in Main.BANano\_Ready or in another code module..  
  

```B4X
'Static code module  
Sub Process_Globals  
    Private BANano As BANano  
    Private body As BANanoElement  
  
    Public React As BANanoObject  
    Public ReactDOM As BANanoObject  
End Sub  
  
Sub Show  
    'initialize the react library  
    React.Initialize("React")  
    'initialize the react dom library  
    ReactDOM.Initialize("ReactDOM")  
    '  
    'get the body of the page  
    body = BANano.GetElement("#body")  
    'clear the body  
    body.Empty  
  
    'create a parent container div on the body: recommended  
    Dim rootm As BANanoHTML  
    rootm.Initialize("div").SetID("react-root")  
  
    'add the div to the body, get it and convert it to an object  
    Dim root As BANanoObject = body.Append(rootm.HTML).Get("#react-root").ToObject  
  
    'execute react to create the element  
    Dim hw As BANanoObject = React.RunMethod("createElement", Array("div", CreateMap(), "Hello World!"))  
    'render the element  
    ReactDOM.RunMethod("render", Array(hw, root))  
End Sub
```

  
  
Looks simple isn't it?  
  
A lot can happen here, its a rabbit hole that we can explore…  
  
Enjoy!
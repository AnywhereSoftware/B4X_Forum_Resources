### [Web] Plug 'n Play external SVG Renderer (Loader) by Mashiane
### 03/02/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165916/)

Hi Fam  
  
As it is, I'm working on [SithasoDaisy5](https://www.b4x.com/android/forum/threads/web-sithasodaisy5-beta-create-websites-webapps-with-the-power-of-the-abstract-designer-opensource.165095/#content), the next iteration of SithasoDaisy. I have been wondering if there was a way to load **SVG files** and then update their properties, like color, width and height as and when needed. I did not want to use the Font Awesome css files as they are including the fonts, so I have been trying to use the img tag. Thing is, with this approach you cant change anything about the SVG file easily.  
  
Comes in the svg-loader.  
  
<https://github.com/shubhamjain/svg-loader>  
  
And it's very simple as ABC. Let's check this code out..  
  

```B4X
<!–  
    Include this script anywhere in your code, preferably <HEAD> so  
    icons can be fetched faster.  
–>  
<script type="text/javascript" src="svg-loader.min.js" async></script>  
  
<!– Use an external SVG –>  
<svg  
  data-src="https://unpkg.com/@mdi/svg@5.9.55/svg/star.svg"  
  width="50"  
  height="50"  
  fill="red"></svg>  
<svg  
  data-src="https://unpkg.com/@mdi/svg@5.9.55/svg/heart.svg"  
  width="50"  
  height="50"  
  fill="red"></svg>  
  
<svg  
  data-src="https://unpkg.com/@mdi/svg@5.9.55/svg/cog.svg"  
  width="50"  
  height="50"  
  fill="currentColor"  
  style="color: purple;"></svg>
```

  
  
For FontAwersome, if you want to host your SVG icons locally, when you have found your icon, you have to choose the SVG tab and then download your icon (top right). Then you will have to use it with the data-src.  
  
![](https://www.b4x.com/android/forum/attachments/162195)  
  
With the tests so far, things are happening well..  
  
![](https://www.b4x.com/android/forum/attachments/162196)  
  
To change the color of any SVG icon based on a file, you just update the style of the svg element as demonstrated below.  
  

```B4X
<svg  
  data-src="https://unpkg.com/@mdi/svg@5.9.55/svg/cog.svg"  
  width="50"  
  height="50"  
  fill="currentColor"  
  style="color: purple;"></svg>
```

  
  
  
Enjoy and have fun!
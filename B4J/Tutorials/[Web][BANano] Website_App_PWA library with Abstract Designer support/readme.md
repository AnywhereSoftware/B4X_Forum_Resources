### [Web][BANano] Website/App/PWA library with Abstract Designer support by alwaysbusy
### 12/16/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/99740/)

![](https://www.b4x.com/android/forum/attachments/126150)  
 **![](https://www.b4x.com/android/forum/attachments/119839)**

  
  
  
> **[SIZE=5]**Download the latest version here: <https://www.b4x.com/android/forum/threads/banano-a-sneak-peek-into-a-progressive-web-app-library.99740/#post-627764>**[/SIZE]**

  
**INTRO**  
  
BANano is a new B4J library to websites/webapps with (offline) [Progressive Web App](https://developers.google.com/web/progressive-web-apps/) support. Unlike its big brother [ABMaterial](https://www.b4x.com/android/forum/threads/abmaterial-framework-for-webapps.60072/), BANano does not rely on any particular framework like Materialize CSS. You will have to write that part yourself, but on the other hand, you have the choice to pick which one.  
  
Why a second framework? Well, from the start ABMaterial was build with a back server in mind. B4J has great support to setup a very powerful jServer to handle web requests. Which does mean all intelligence is at the server side and you have the full power of B4J to do whatever you want (secure database access, serial communication, cache control etc). With B4JS, some of this intelligence could be transferred to the browser side, but the app still needs internet/intranet access so this is as far as it could go.  
  
**INTRODUCTION PODCAST TO BANano (A.I. generated from the booklet)**  
  
<http://sndup.net/hncr6>  
  
**BANano** is a different animal. It can use a [Service Worker](https://developers.google.com/web/fundamentals/primers/service-workers/) to 'install' the web app in the browser, so it can also work when the user is offline. While ABMaterial builds the page from the server side, BANano builds it from the browser side. This means **EVERYTHING you write in B4J is transpiled to Javascript, HTML and CSS**.  
  
But with great power comes great responsibility! Unlike ABMaterial, some basic knowledge of HTML, CSS and to some extend Javascript is needed to build BANano apps. It makes excellent use of B4X's SmartStrings to create the HTML part of the app. BANano gives you a set of tools to write your own wrapper around any framework (MiniCSS, Skeleton, Spectre, Bootstrap, …), which then can be easily used to quickly build webapps/websites.  
  
**DEMO/EXAMPLES BANanoSkeleton UI library (70+ components)**  
  
<https://gorgeousapps.com/BANanoSkeleton/>  
  
**OVERVIEW**  
  
A quick overview to show the different uses of both frameworks:  
  
![](http://gorgeousapps.com/overview.png)  
So both frameworks have their specific target, both for the programmer and the app you want to make.  
  
**Abstract Designer support in v2.0+**  
  
![](http://gorgeousapps.com/BANano1.21.png)  
  
**LICENSE**  
  
> Freeware/Donationware License  
>   
> B4J is Copyright © 2010 - 2018 by Anywhere Software All Rights Reserved.  
> LIBRARY (Library/library): B4J library files BANano.jar and BANano.xml (by Alain Bailleul)  
> SOFTWARE (Software/software): Computer Software  
> APPLICATION (Application/application): Any end product as the result of compiling with an Anywhere Software product  
> SOURCE CODE: human-readable program statements written by a programmer or developer in a high-level or assembly language that are not directly readable by a computer and that need to be compiled into object code before they can be executed by a computer  
>   
> BY USING THIS LIBRARY, YOU AGREE TO BE BOUND BY THE TERMS OF THIS LICENSE.  
>   
> 1. THIS LIBRARY IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL ANY COPYRIGHT HOLDER/AUTHOR/DEVELOPER BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL,SPECIAL,INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE LIBRARY INCLUDING BUT NOT LIMITED TO LOSS OF DATA, FAILURE OF THE LIBRARY TO OPERATE WITH ANY OTHER PROGRAMS OR LIBRARY, EVEN IF COPYRIGHT HOLDER/AUTHOR/DEVELOPER HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  
>   
> 2. YOU MAY NOT COPY, SUB-LICENSE, REVERSE ENGINEER, DECOMPILE, DISASSEMBLE, OR MODIFY THIS LIBRARY IN ANY WAY.  
>   
> 3. YOU MAY NOT DISTRIBUTE THE LIBRARY ON ANY MEDIUM WITHOUT PRIOR NOTICE FROM ALAIN BAILLEUL ([EMAIL]alain.bailleul@telenet.be[/EMAIL]). YOU HAVE TO ASK FOR PERMISSION IN ORDER TO MAKE THIS LIBRARY AVAILABLE FOR DISTRIBUTION OVER THE INTERNET OR ANY OTHER DISTRIBUTABLE MEDIUM.  
>   
> 4. YOU AGREE NOT TO DISTRIBUTE FOR A FEE AN APPLICATION USING THE LIBRARY THAT, AS ITS PRIMARY PURPOSE, IS DESIGNED TO BE AN AID IN THE DEVELOPMENT OF SOFTWARE FOR YOUR APPLICATION'S END USER. SUCH APPLICATION INCLUDES, BUT IS NOT LIMITED TO, A DEVELOPMENT IDE OR A B4J SOURCE CODE GENERATOR.  
>   
> By possessing and/or using this library you are automatically agreeing to and show that you have read and understood the terms and conditions contained within this Freeware Software License Agreement. This Freeware Software License Agreement is then effective while you possess, use and continue to make use of these software products. If you do not agree with our Freeware Software License Agreement you must not possess or use our library products - this Freeware Software License Agreement will then not apply to you. This Freeware Software License Agreement is subject to change without notice.  
>   
> Violators of this agreement will be prosecuted to the full extent of the law.  
>   
> This library is free, however if you do enjoy it, please consider a donation to Alain Bailleul ([EMAIL]alain.bailleul@telenet.be[/EMAIL]) for his time and efforts to make this library possible.  
>   
> This license file (LICENSE.TXT) shall be included in all copies of the library or any distribution using the library in any form resulting from mechanical transformation or translation of the source form, including but not limited to compiled object code, generated documentation, and conversions to other media types.  
>   
> If you have any questions regarding this license, please contact [EMAIL]alain.bailleul@telenet.be[/EMAIL]

  
Cheers,  
  
Alain
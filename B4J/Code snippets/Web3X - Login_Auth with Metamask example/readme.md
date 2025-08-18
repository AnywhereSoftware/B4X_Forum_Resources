### Web3X - Login/Auth with Metamask example by jtare
### 01/15/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/137642/)

I've been using the Web3X library these past days and wonder how could it be used for authentication with Metamask. I put together this example but is not near perfect, I don't recommend using it in production since there are a lot of things I don't understand yet, but if your goal is to learn you could run this code.  
  
I took ideas from many sites to understand what should be done, mainly the web3js docs: <https://web3js.readthedocs.io/en/v1.5.2/>   
  
The code flow looks like this ([source](https://www.toptal.com/ethereum/one-click-login-flows-a-metamask-tutorial)):  
[SPOILER="Image"]![](https://www.b4x.com/android/forum/attachments/124240)  
[/SPOILER]  
  
You must run the b4j server and access it by localhost, otherwise the Metamask wallet will not be detected if you just open the index.html.  
  
The index.html file is just a button on the top left corner of the screen. When pressed we try to connect to the wallet, then get a random message from the server, sign the message and return it for verification, if passed, we get a token which will allow for fast authentication.  
  
The attached screenshots show the process from start to finish.   
  
**Disclaimer: After reading the permissions the Metamask chrome extension requires, I don't known how safe it is. For transparency, I created a VM running ubuntu just to play around with crypto apps, I do not run them on my main computer.**
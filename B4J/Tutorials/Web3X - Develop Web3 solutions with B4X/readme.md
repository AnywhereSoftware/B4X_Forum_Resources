### Web3X - Develop Web3 solutions with B4X by Erel
### 05/02/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/137350/)

![](https://www.b4x.com/basic4android/images/firefox_0Lzb5VCeAt.png)  
(image source: <https://ethereum.org/en/>)  
  
You have probably all heard about Bitcoin, Ethereum, NFT and other blockchain technologies. For the outside viewer these technologies might look like one big ponzi scheme. This is what I thought up to a few months ago.  
However, as I started to read and learn, I found a very interesting technology ecosystem. The Ethereum blockchain is especially interesting for us, the developers, as it is a blockchain with built-in programming language.  
I'm not an oracle and I don't know whether [Web3](https://en.wikipedia.org/wiki/Web3) will be a real thing in the near future. I do know that these technologies are very developer-centric and there can be interesting opportunities for creative developers.  
  
I've started with wrapping Web3j - an open source Java library for integration of Ethereum clients: <https://github.com/web3j/web3j>  
web3.js is a similar JavaScript library. It is more popular and I find it to be better documented: <https://web3js.readthedocs.io/en/v1.5.2/>  
  
The Web3 concept is made of several technologies. There are many online tutorials about these technologies. You should start with learning the basics, they aren't tied to any specific programming language.  
  
Web3X is an open source library written in B4X and based on Web3j. The source code is available here: <https://github.com/AnywhereSoftware/Web3X>  
This is a B4J and B4A library.  
  
Installation instructions:  
  
1. Download the complete project: <https://github.com/AnywhereSoftware/Web3X/archive/refs/heads/main.zip>  
2. Copy Web3X.b4xlib to the additional libraries folder.  
3. Unzip web3x\_dependencies.zip and copy to the additional libraries folder. Make sure to **keep** the web3 folder.  
4. Other dependencies:  
BigNumbers v1.3+: <https://www.b4x.com/android/forum/threads/bignumbers-library.9540/#content>  
OkHttp v1.5+: [www.b4x.com/android/files/okhttp-1.5.zip](http://www.b4x.com/android/files/okhttp-1.5.zip) (internal library)  
  
  
Supported features:  

- Creating and loading wallet files.
- Signing messages.
- Verifying signatures.
- Connecting to Ethereum node with Infura: <https://infura.io/> (trivial to add other providers)
- Ethereum methods: EthBlockNumber, EthGetBalance, EthGetGasPrice, EnsResolve (ens name -> address), EnsReverseResolve (address -> ens name)
- SendFunds
- Utilities to convert between wei, ether and other units.
- Utilities to create BigIntegers and BigDecimals. Most methods expect BigIntegers when dealing with numbers. The values, usually measured in weis, are too large to be held in the standard numeric types.
- More to come.

Most of the methods are asynchronous and should be called with Wait For.  
Example:  

```B4X
Wait For (utils.LoadWallet(WalletFile, Password)) Complete (Result As W3AsyncResult)  
If Result.Success Then  
 Dim credentials As W3Credentials = Result.Value  
 …  
End If  
Wait For (Web3MainNet.EthBlockNumber) Complete (Result As W3AsyncResult)  
If Result.Success Then  
    Dim BlockNumber As BigInteger = Result.Value  
    Log(BlockNumber)  
End If
```

  
The type of Result.Value is described in the methods documentation.  
  
**Security concerns:**  
  
- Never post your private key. Anyone with the private key can retrieve all the account funds.  
- Never lose the private key / wallet / password. They are non-recoverable.  
- Start with one of the testnets.  
- Use a test account during development.  
  
I will post more examples soon. Please feel free to start a new thread for any question or comment (general discussion here: <https://www.b4x.com/android/forum/threads/web3x-ethereum-questions.137353/>)  
  
The current version is 0.86 and it is considered a beta version.
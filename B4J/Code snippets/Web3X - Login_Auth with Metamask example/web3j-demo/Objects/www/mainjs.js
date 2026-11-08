
const loginButton = document.getElementById('myBtn')

function toggleButton() {
  if (!window.ethereum) {
    loginButton.innerText = 'MetaMask is not installed'
    return false
  }

  loginButton.addEventListener('click', getAccount)
}



window.addEventListener('DOMContentLoaded', () => {
  toggleButton()
});





web3 = new Web3(window.ethereum);

//we save our credentials here
account = "";
token = "";

//Get account access and sign server's message
async function getAccount() {

  accounts = await ethereum.request({ method: 'eth_requestAccounts' });
  account = accounts[0];


  //Get a message to sign from the server
  let url= new URL('http://localhost:51042/getmessage');
  url.searchParams.set('address', account);
  const req = new XMLHttpRequest();
  req.open("GET", url, true);

  req.onreadystatechange = (e) => {
    if (req.readyState == 4 && req.status == 200)
      {
        message = req.responseText;
      console.log(message)

      //Sign the server's message. Note: a "0x" is attached before the message. This could also be done in the server side too.
      web3.eth.personal.sign("0x"+message, account, function(error, promise){ 
        if (!error){
          console.log(promise)

          //Upload the signed message to the server to verify
          const req = new XMLHttpRequest();
          let url= new URL('http://localhost:51042/authenticate');
          url.searchParams.set('address', account);
          req.open("GET", url, true);

          //We also remove the 0x prefix of the signed message
          req.setRequestHeader('signature', web3.utils.stripHexPrefix(promise));

          req.onreadystatechange = (e) => {
           if (req.readyState == 4 && req.status == 200){
              response = JSON.parse(req.responseText);
              console.log(response)

              //If signature is verified, then save the access token and redirect to our account/profile site
              if (response.success == true){
                token = response.token;
                let url= new URL('http://localhost:51042/account');
                url.searchParams.set('address', account);
                url.searchParams.set('token', token); //pasing credentials through the headers is more secure. I don't know how do it yet.
                window.location.href = url.toString();
              }

            } 
          }
          req.send();
        }
        else{console.log(error)}
      })
    }
  }
  req.send();

  
}


//Not used
function hexToBytes(hex) {
    for (var bytes = [], c = 0; c < hex.length; c += 2)
        bytes.push(parseInt(hex.substr(c, 2), 16));
    return bytes;
}
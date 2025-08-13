B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim html As String = $"
	<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
 <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-auth.js"></script>
  <script src="b4j_ws.js"></script>
  
<style>
body {font-family: Arial, Helvetica, sans-serif;}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

/* Set a style for all buttons */
button {
  background-color: #04AA6D;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
}

button:hover {
  opacity: 0.8;
}

/* Extra styles for the cancel button */
.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
  position: relative;
}

img.avatar {
  width: 40%;
  border-radius: 50%;
}

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
  position: absolute;
  right: 25px;
  top: 0;
  color: #000;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: red;
  cursor: pointer;
}

/* Add Zoom Animation */
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
</style>
</head>
<body>

<h2>Test login with Firebase</h2>

<button onclick="signInWithGoogle()" style="width:auto;">Login</button>

<script>
    var firebaseConfig = {
      apiKey: "AIzaSyAll9RTPp5DPSiPspFMMKdMODFNgAKHfwo", 
      authDomain: "thienvienphuocson-69b69.firebaseapp.com",
      projectId: "thienvienphuocson-69b69",
      appId: "1:446316119043:web:32d538144d31f931343a36"
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  </script>
 
  <script>
 
function signInWithGoogle() {
  var provider = new firebase.auth.GoogleAuthProvider();
  firebase.auth().signInWithPopup(provider)
    .then((result) => {
      firebase.auth().currentUser.getIdToken(true).then(function(idToken) {
          var token = idToken;
          b4j_raiseEvent('event_register', {tk:token});
      }).catch(function(error) {
     
      });
    })
    .catch((error) => { 
   
    });
}
// Facebook sign-in function
function signInWithFacebook() {
  var provider = new firebase.auth.FacebookAuthProvider();
  firebase.auth().signInWithPopup(provider)
    .then((result) => {
      firebase.auth().currentUser.getIdToken(true).then(function(idToken) {
        var token = idToken;
        b4j_raiseEvent('event_register', {tk:token});
      }).catch(function(error) {
     
      });
    })
    .catch((error) => {   
    });
}

  </script>
  
  <script>
    $(document).ready(function() {
        b4j_connect("/firebase/backend");             
    });
    </script>
</body>
</html>
	"$
	
	resp.SetHeader("Access-Control-Allow-Origin", "*")
	resp.SetHeader("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE")
	resp.SetHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
	resp.Write(html)
End Sub
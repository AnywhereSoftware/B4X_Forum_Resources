var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var users = {};

// listen to port 5555
server.listen(5555, function(){
  console.log('listening on *:5555');
});


io.sockets.on('connection', function(socket){
	// on new socket connection
	socket.on('reg_user', function(data){
		// check if username is exist or not
		if(data in users) {
			socket.emit('is_connected',0); //if exist ask the user to change username
		}else{
			//if new user, then store the user to users array 
			socket.user_id=data;
			users[socket.user_id] = socket;
			
			socket.emit('is_connected',JSON.stringify(Object.keys(users))); //send success event
			io.emit('user_update',JSON.stringify(Object.keys(users))); //broadcast new username
			
			console.log('User connected : '+data);
			
		}
	});
	
	//send call request to the callee socket
	socket.on('call_out', function(data){
		data = JSON.parse(data);
		if(data.to in users) {
			users[data.to].emit('call_in', JSON.stringify(data), function(callback){
				if (callback == 0){
					socket.emit("call_status","busy");
				}
			});
		}else{
			socket.emit("call_status","is offline")
		}
	});	

	//send call request rejection notification to the caller 
	socket.on('call_reject', function(data){
		data = JSON.parse(data);
		if(data.to in users) {
			users[data.to].peer_id = null;
			users[data.to].emit("call_status","rejected");
		}
	});

	//send call accepted  notification to the caller and store both peer id to respective sockets
	socket.on('call_accept', function(data){
		data = JSON.parse(data);
		if(data.to in users) {
			socket.peer_id = data.to; //store caller id into callee socket
			users[data.to].peer_id = data.from; //store callee id into caller socket
			users[data.to].emit("call_status","accept");
		}
	});

	//send call ended notification to the other end from the socket who ended the call
	socket.on('call_end', function(data){
		data = JSON.parse(data);
		if(data.to in users) {
			socket.peer_id = null;
			socket.sendBuffer = [];
			users[data.to].peer_id = null;
			users[data.to].sendBuffer = [];
			users[data.to].emit("call_status","end");
		}
	});

	//deliver audio buffer to the other end
	socket.on('audio_received', function(data){
		if (socket.peer_id != null && socket.peer_id in users){
			users[socket.peer_id].sendBuffer = [];
			users[socket.peer_id].emit('audio_broadcast', data);
		}
	});

	//broadcast updated user list on any user's disconnection event
	socket.on('disconnect', function(data){
		delete users[socket.user_id];
		console.log('User disconnected : '+socket.user_id);
		io.emit('user_update',JSON.stringify(Object.keys(users)));
	});
});


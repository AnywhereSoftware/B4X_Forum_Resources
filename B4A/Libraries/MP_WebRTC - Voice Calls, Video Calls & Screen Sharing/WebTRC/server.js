const WebSocket = require("ws");

const PORT = 8443;
const wss = new WebSocket.Server({ port: PORT });

let users = []; // { ws, name }

wss.on("connection", ws => {

  console.log("Client connected");

  ws.on("message", message => {

    try {

      const data = JSON.parse(message.toString());
      const fromUser = getName(ws);

      console.log("RX:", data);

      switch (data.type) {

        case "join": {
          const name = data.username || data.userName || data.name || "Unknown";

          users = users.filter(u => u.ws !== ws);
          users = users.filter(u => u.name !== name);

          users.push({ ws, name });

          console.log("Joined:", name);

          broadcastUsers();
          break;
        }

        case "call_request": {
          sendToUser(data.to, {
            type: "incoming_call",
            from: fromUser
          });
          break;
        }

        case "call_response": {
          sendToUser(data.to, {
            type: "call_response",
            from: fromUser,
            accepted: !!data.accepted
          });
          break;
        }

        case "offer": {
          sendToUser(data.to, {
            type: "offer",
            from: fromUser,
            sdp: data.sdp
          });
          break;
        }

        case "answer": {
          sendToUser(data.to, {
            type: "answer",
            from: fromUser,
            sdp: data.sdp
          });
          break;
        }

        case "ice_candidate": {
          sendToUser(data.to, {
            type: "ice_candidate",
            from: fromUser,
            sdpMid: data.sdpMid,
            sdpMLineIndex: data.sdpMLineIndex,
            candidate: data.candidate
          });
          break;
        }

        case "hangup": {
          sendToUser(data.to, {
            type: "hangup",
            from: fromUser
          });
          break;
        }

        default:
          console.log("Unknown message type:", data.type);
          break;
      }

    } catch (e) {
      console.error("Message error:", e.message);
    }

  });

  ws.on("close", () => {
    const name = getName(ws);
    users = users.filter(u => u.ws !== ws);
    console.log("Client disconnected:", name);
    broadcastUsers();
  });

  ws.on("error", err => {
    console.log("Socket error:", err.message);
  });

});

function sendToUser(toName, message) {

  if (!toName) {
    console.log("sendToUser failed: empty target");
    return;
  }

  const target = users.find(u => u.name === toName);

  if (!target) {
    console.log("User not found:", toName);
    return;
  }

  if (target.ws.readyState === WebSocket.OPEN) {
    target.ws.send(JSON.stringify(message));
    console.log("TX to", toName + ":", message);
  }

}

function broadcastUsers() {

  const names = users.map(u => u.name);

  const msg = JSON.stringify({
    type: "users",
    users: names
  });

  users.forEach(u => {
    if (u.ws.readyState === WebSocket.OPEN) {
      u.ws.send(msg);
    }
  });

  console.log("Users:", names);

}

function getName(ws) {
  const user = users.find(u => u.ws === ws);
  return user ? user.name : "Unknown";
}

console.log(`Server running on ws://0.0.0.0:${PORT}`);

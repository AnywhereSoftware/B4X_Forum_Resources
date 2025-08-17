let isOpen = false;

window.onload = mainDo;

async function open(callback) {    
    let serverUrl = 'sd:ws://127.0.0.1:51042';
    if (!serverUrl) {
        alert('serverUrl cannot be empty!');
        return;
    }
    await SocketD.createClient(serverUrl.trim())
        .config(c => c
            .heartbeatInterval(1000*5)
            .fragmentSize(1024 * 1024)
            .metaPut("test","1"))
        .connectHandler(c=> {
            console.log("connect begin...");
            c.getConfig().metaPut("test","1");
            return c.connect();
        })
        .listen(SocketD.newEventListener()
            .doOnOpen(s=>{
                window.clientSession = s;                
            })
            .doOnMessage((s, m) => {            
        }))
        .open();    
    if (callback) callback();
}

function close(callback) {
    clientSession.close();
    if (callback) callback();
}

function mainDo() {
    open(() => {        
        isOpen = true;
    });
    
    let word = document.getElementById("word").value;  
    let push = document.getElementById("btsend");  
    let result =  document.getElementById("result");  
    push.addEventListener("click", () => {
        if (isOpen) {            
            console.log("send: " + word);
            clientSession.sendAndRequest("/palidigital", SocketD.newEntity(word).metaPut("WORD",word), 100_000).thenReply(reply => {                
                console.log("reply: " + reply.dataAsString());
                result.innerText = reply.dataAsString();
            }).thenProgress((isSend, val,max)=> {
                if(isSend){
                    appendToMessageList('Submit progress', val + "/" + max);
                }
            });
        }
    });
}

//Date formatting
function dateFormat(date,fmt) {
    //default format
    fmt = fmt ? fmt : 'yyyy-MM-dd hh:mm:ss';

    var o = {
        "M+" : date.getMonth()+1,                 
        "d+" : date.getDate(),                    
        "h+" : date.getHours(),                   
        "m+" : date.getMinutes(),                 
        "s+" : date.getSeconds(),                
        "q+" : Math.floor((date.getMonth()+3)/3), 
        "S+"  : date.getMilliseconds()             
    };
    if(/(y+)/.test(fmt)) {
        fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    for(var k in o) {
        if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) :
                RegExp.$1.length==2 ? (("00"+ o[k]).substr((""+ o[k]).length)) : (("000"+ o[k]).substr((""+ o[k]).length))
            );
        }
    }
    return fmt;
}

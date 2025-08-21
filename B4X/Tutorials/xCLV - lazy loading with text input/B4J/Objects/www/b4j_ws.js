//B4J WebSockets client library v0.91

/*jslint browser: true*/
/*global $, jQuery, WebSocket*/
/*jshint curly: false */
"use strict";
var b4j_ws;
var b4j_closeMessage = false;
//only called as a result of a server request that is waiting for result.
//this method should not be called in any other case.
function b4j_sendData(data) {
    b4j_ws.send(JSON.stringify({type: "data", data: data}));
}
function b4j_raiseEvent(eventName, parameters) {
    try {
        if (b4j_ws.readyState !== 1) {
            if (b4j_closeMessage === false) {
                window.console.error("connection is closed.");
				if (typeof ReconnectingWebSocket !== 'undefined')
					window.alert("Server is currently not available.");
				else
					window.alert("Connection is closed. Please refresh the page to reconnect.");
                b4j_closeMessage = true;
            }
        } else {
			b4j_closeMessage = false;
            b4j_ws.send(JSON.stringify({type: "event", event: eventName, params: parameters}));
        }
    } catch (e) {
        window.console.error(e);
    }
}
function b4j_addEvent(selector, event, eventName, preventDefault) {
    var obj = $(selector);
    if (obj.length > 0) {
        obj.on(event, function (e) {
            if (preventDefault) {
                e.preventDefault();
                e.stopPropagation();
            }
            b4j_raiseEvent(eventName, {which: e.which, target: e.target.id, pageX: e.pageX, pageY: e.pageY, metaKey: e.metaKey});
        });
    }
}
function b4j_addAutomaticEvents(data) {
    $.each(data, function (index, value) {
        b4j_addEvent("#" + value.id, value.event, value.id + "_" + value.event, true);
    });
}
function b4j_runFunction(func, params) {
    return window[func].apply(null, params);
}

function b4j_eval(params, script) {
    var f = new Function(script);
    return f.apply(null, params);
}

function b4j_connect(absolutePath) {
    if (typeof WebSocket === 'undefined') {
        window.alert("WebSockets are not supported by your browser.");
        return;
    }
    var l = window.location, fullpath;
    fullpath = ((l.protocol === "https:") ? "wss://" : "ws://") + l.hostname + ":" + l.port + absolutePath;
	if (typeof ReconnectingWebSocket === 'undefined')
		b4j_ws = new WebSocket(fullpath);
	else
		b4j_ws = new ReconnectingWebSocket(fullpath);
    b4j_ws.onmessage = function (event) {
        var ed = JSON.parse(event.data);
        if (ed.etype === "runmethod") {
            $(ed.id)[ed.method].apply($(ed.id), ed.params);
        } else if (ed.etype === "runmethodWithResult") {
            b4j_sendData($(ed.id)[ed.method].apply($(ed.id), ed.params));
        } else if (ed.etype === "setAutomaticEvents") {
            b4j_addAutomaticEvents(ed.data);
        } else if (ed.etype === "runFunction") {
            b4j_runFunction(ed.prop, ed.value);
        } else if (ed.etype === "runFunctionWithResult") {
            b4j_sendData(b4j_runFunction(ed.prop, ed.value));
        } else if (ed.etype === "eval") {
            b4j_eval(ed.value, ed.prop);
        } else if (ed.etype === "evalWithResult") {
            b4j_sendData(b4j_eval(ed.value, ed.prop));
        } else if (ed.etype === "alert") {
            window.alert(ed.prop);
        }
        
    };
}




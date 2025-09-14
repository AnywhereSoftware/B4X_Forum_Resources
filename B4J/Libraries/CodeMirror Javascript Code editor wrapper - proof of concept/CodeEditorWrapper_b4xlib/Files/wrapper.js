function getSelectionStartNode() {
    var node = document.getSelection().anchorNode;
    return (node.nodeType == 3 ? node.parentNode : node);
}
function getSelectionStartNode2() {
    var node = document.getSelection().anchorNode;
    return  node;
}
///////////////////////////////////////////////////////////////
// Run Command functions
///////////////////////////////////////////////////////////////
function command(name, arg) {
    let success;

    try {
        success = document.execCommand(name, false, arg);
    } catch (error) {
        alert(error);
    }

    if (!success) {
        const supported = isSupported(name);
        const message = supported ? 'Unknown error. Is anything selected?' : name + ' command is not supported by your browser.';
        alert(message);
    }

}

function isSupported(name) {
    return document.queryCommandSupported(name);
}

///////////////////////////////////////////////////////////////
// Query Caret functions
//////////////////////////////////////////////////////////////

function getCaretPositionWithinBody() {
    return getCaretCharacterOffsetWithin(document.body);
}

function getCaretCharacterOffsetWithin(element) {
    var caretOffset = 0;
    var doc = element.ownerDocument || element.document;
    var win = doc.defaultView || doc.parentWindow;
    var sel;
    if (typeof win.getSelection != "undefined") {
        sel = win.getSelection();
        if (sel.rangeCount > 0) {
            var range = win.getSelection().getRangeAt(0);
            var preCaretRange = range.cloneRange();
            preCaretRange.selectNodeContents(element);
            preCaretRange.setEnd(range.endContainer, range.endOffset);
            caretOffset = preCaretRange.toString().length;
        }
    } else if ((sel = doc.selection) && sel.type != "Control") {
        var textRange = sel.createRange();
        var preCaretTextRange = doc.body.createTextRange();
        preCaretTextRange.moveToElementText(element);
        preCaretTextRange.setEndPoint("EndToEnd", textRange);
        caretOffset = preCaretTextRange.text.length;
    }
    return caretOffset;
}

///////////////////////////////////////////////////////////////
// B4j interface functions
//////////////////////////////////////////////////////////////

function callB4j(funct, param1, param2) {

    if (param1 === undefined || param1 === null || param1 === "") {
        return b4j.callB4j("CallB4x", funct);
    } else {
        if (param2 === undefined || param2 === null || param2 === "") {
            return b4j.callB4j2("CallB4x2", funct, param1);
        } else {
            return b4j.callB4j3("CallB4x3", funct, param1, param2);
        }
    }
}
//Redirect the console.log to B4x
window.onload = function () {
	var oldLog = console.log;
    console.log = function (message) {
        callB4j("JsLog", message);
		oldLog.apply(console, arguments);
    };
};

function replaceElementClass(cl, orig, replace) {
    var nl = document.getElementsByClassName(cl);
    for (var i = 0; i < nl.length; i++) {
        console.log('replaceClass ' + nl[i]);
        replaceClass(nl[i], orig, replace);
    }
}

function removeElementClass(cl) {
    var nl = document.getElementsByClassName(cl);
    for (var i = 0; i < nl.length; i++) {
        console.log('removeClass ' + nl[i]);
        removeClass(nl[i], cl);
    }
}

///////////////////////////////////////////////////////////////
// Capture context menu request functions
///////////////////////////////////////////////////////////////

function updatecm() {

    "use strict";

    var imgItems = document.querySelectorAll(".img-div");
    console.log(imgItems);
    for (var i = 0, len = imgItems.length; i < len; i++) {
        var imgItem = imgItems[i];
        contextMenuListener(imgItem);
    }
}

function contextMenuListener(el) {
    if (typeof el === 'string') {
        el = document.getElementById(el);
    }
    el.removeEventListener('contextmenu', updatecm);
    el.addEventListener("contextmenu", function updatecm(e) {
        if(hasClass(el, 'selected')) {
            callB4j("ShowContextMenu", e, el);
        };
        e.preventDefault();
    });
}

///////////////////////////////////////////////////////////////
// Utility funcions
///////////////////////////////////////////////////////////////

function hasClass(ele, cls) {
    return ele.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
}

function addClass(ele, cls) {
    if (!this.hasClass(ele, cls))
        ele.className += " " + cls;
}

function removeClass(ele, cls) {
    if (hasClass(ele, cls)) {
        var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
        ele.className = ele.className.replace(reg, ' ');
    }
}

function replaceClass(ele, oldClass, newClass) {
    if (hasClass(ele, oldClass)) {
        removeClass(ele, oldClass);
        addClass(ele, newClass);
    }
    return;
}

function toggleClass(ele, cls1, cls2) {
    if (hasClass(ele, cls1)) {
        replaceClass(ele, cls1, cls2);
    } else if (hasClass(ele, cls2)) {
        replaceClass(ele, cls2, cls1);
    } else {
        addClass(ele, cls1);
    }
}
function getBoundingClientRect(el) {
    if (typeof el === 'string') {
        el = document.getElementById(el);
    }
    return el.getBoundingClientRect();
}

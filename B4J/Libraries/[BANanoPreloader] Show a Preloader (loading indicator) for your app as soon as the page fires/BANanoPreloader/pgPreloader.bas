B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.3
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private BANAno As BANano   'ignore
End Sub


#if css
.preloadcontainer {
    height: 100vh;
    width: 100vw;
    font-family: Helvetica
}

.loader {
    height: 20px;
    width: 250px;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto
}

.loader--dot {
    animation-name: loader;
    animation-timing-function: ease-in-out;
    animation-duration: 3s;
    animation-iteration-count: infinite;
    height: 20px;
    width: 20px;
    border-radius: 100%;
    background-color: #000;
    position: absolute;
    border: 2px solid #fff
}

.loader--dot:first-child {
    background-color: #8cc759;
    animation-delay: .5s
}

.loader--dot:nth-child(2) {
    background-color: #8c6daf;
    animation-delay: .4s
}

.loader--dot:nth-child(3) {
    background-color: #ef5d74;
    animation-delay: .3s
}

.loader--dot:nth-child(4) {
    background-color: #f9a74b;
    animation-delay: .2s
}

.loader--dot:nth-child(5) {
    background-color: #60beeb;
    animation-delay: .1s
}

.loader--dot:nth-child(6) {
    background-color: #fbef5a;
    animation-delay: 0s
}

.loader--text {
    position: absolute;
    top: 200%;
    left: 0;
    right: 0;
    width: 4rem;
    margin: auto
}

.loader--text:after {
    content: "Loading";
    font-weight: 700;
    animation-name: loading-text;
    animation-duration: 3s;
    animation-iteration-count: infinite
}

@keyframes loader {
    15% {
        transform: translateX(0)
    }

    45% {
        transform: translateX(230px)
    }

    65% {
        transform: translateX(230px)
    }

    95% {
        transform: translateX(0)
    }
}

@keyframes loading-text {
    0% {
        content: "Loading"
    }

    25% {
        content: "Loading."
    }

    50% {
        content: "Loading.."
    }

    75% {
        content: "Loading..."
    }
}
#End If

#if javascript
	var pl = document.createElement("div");
	pl.id = "preloader";
	pl.className = "preloadcontainer";
	var ldr = document.createElement("div");
	ldr.className = "loader";
	var dot = document.createElement("div");
	dot.className = "loader--dot";
	var lot = document.createElement("div");
	lot.className = "loader--text";
	ldr.appendChild(dot.cloneNode(true));
	ldr.appendChild(dot.cloneNode(true));
	ldr.appendChild(dot.cloneNode(true));
	ldr.appendChild(dot.cloneNode(true));
	ldr.appendChild(dot.cloneNode(true));
	ldr.appendChild(dot.cloneNode(true));
	ldr.appendChild(lot);
	pl.appendChild(ldr);
	document.body.appendChild(pl);
	 
	document.onreadystatechange = function() { 
            if (document.readyState !== "complete") { 
                document.querySelector("body").style.visibility = "hidden"; 
                document.querySelector("#preloader").style.visibility = "visible"; 
            } else { 
                // document.querySelector("#preloader").style.display = "none"; 
                // document.querySelector("body").style.visibility = "visible"; 
            } 
        }; 
#End If


'hide the body
private Sub HideBody
	Dim stylem As Map = CreateMap("visibility":"hidden")
	BANAno.GetElement("body").SetStyle(BANAno.ToJson(stylem))
End Sub


'show the body
private Sub ShowBody
	Dim stylem As Map = CreateMap("visibility":"visible")
	BANAno.GetElement("body").SetStyle(BANAno.ToJson(stylem))
End Sub

'show the preloader
Sub ShowPreloader
	Dim stylem As Map = CreateMap("visibility":"visible")
	BANAno.GetElement("#preloader").SetStyle(BANAno.ToJson(stylem))
	HideBody
End Sub

'hide thr preloader
Sub HidePreloader
	Dim stylem As Map = CreateMap("display":"none")
	BANAno.GetElement("#preloader").SetStyle(BANAno.ToJson(stylem))
	ShowBody
End Sub

'remove preloader
Sub RemovePreloader
	BANAno.GetElement("#preloader").Remove
End Sub
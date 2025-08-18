copy /y apperr.txt apperr.bak
wevtutil qe Application /c:1 /f:Text /rd:true >apperr.txt

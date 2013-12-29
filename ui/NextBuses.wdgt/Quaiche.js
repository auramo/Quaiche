runBgUpdate = false;

if (window.widget) { 
  widget.onshow = onshow; 
  widget.onhide = onhide;
}

function done(cmd) {
    if (cmd.outputString) {
	document.getElementById("data").innerHTML = cmd.outputString;
    } else {
	document.getElementById("data").innerHTML = '<span style="color: white;font-size: 8px">' + cmd.errorString + "</span>";	
    }
}

function getTimeTables() {
  widget.system("/usr/local/quaiche/run_content_provider.sh", done);

  if (runBgUpdate) {
    setTimeout("getTimeTables()", 10000);
  }
}

function onshow() {
  if (window.widget) {
    runBgUpdate = true;
    getTimeTables();
  }
} 

function onhide() {
  runBgUpdate = false;
}




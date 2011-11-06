runBgUpdate = false;

if (window.widget) { 
  widget.onshow = onshow; 
  widget.onhide = onhide;
}

function done(cmd) {
  document.getElementById("data").innerHTML = cmd.outputString;
}

function getTimeTables() {
  widget.system("/usr/local/quaiche/content_provider.rb", done);
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




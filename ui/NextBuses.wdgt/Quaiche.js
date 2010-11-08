if (window.widget) { 
    widget.onshow = onshow; 
}

function done(cmd) {
    document.getElementById("data").innerHTML = cmd.outputString;
}

function onshow() {
    if (window.widget) {
        widget.system("/usr/local/quaiche/content_provider.rb", done);
    }
} 



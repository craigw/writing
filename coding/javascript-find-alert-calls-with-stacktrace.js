// It can be annoying trying to track down those alert calls. Especially
// if they're coming from a billion lines of Javascript that you
// inherited. This gives you a stack trace so you can see exactly where
// the alert was generated.

var original_alert = window.alert;

var stacktrace = function() {
  var regex = /function\W+([\w-]+)/i;  

  var callee = arguments.callee;  
  var trace = "";  
  while(callee) {  
    trace += (regex.exec(callee))[1] + '(';   

    for (i = 0; i < callee.arguments.length - 1; i++) {
      trace += "'" + callee.arguments[i] + "', ";
    }

    if (arguments.length > 0) {
      trace += "'" + callee.arguments[i] + "'";  
    }

    trace += ")\n\n";

    callee = callee.arguments.callee.caller;  
  }
  original_alert(trace);
}

window.alert = function(msg) {
  stacktrace();
  original_alert(msg);
}
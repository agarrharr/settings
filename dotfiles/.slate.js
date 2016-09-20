var hyper = ':ctrl,alt,cmd,shift';

// Move current window
var pushLeft = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});
var pushRight = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});
var fullscreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});
slate.bind("left:alt", function(win) {
  win.doOperation(pushLeft);
});
slate.bind("right:alt", function(win) {
  win.doOperation(pushRight);
});
slate.bind("up:alt", function(win) {
  win.doOperation(fullscreen);
});

// Start screensaver
slate.bind('1:alt', function() {
  slate.shell('/usr/bin/osascript -e \'tell application "System Events" to start current screen saver\'');
});

// Spotify toggle
slate.bind('space'+hyper, function() {
  slate.shell('/usr/bin/osascript -e \'tell application "Spotify" to playpause\'');
}, false);

// Spotify previous
slate.bind(';'+hyper, function() {
  slate.shell('/usr/bin/osascript -e \'tell application "Spotify" to previous track\'');
}, false);

// Spotify next
slate.bind('\''+hyper, function() {
  slate.shell('/usr/bin/osascript -e \'tell application "Spotify" to next track\'');
}, false);

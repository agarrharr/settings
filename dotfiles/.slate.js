var pushRight = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});
var pushLeft = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});
var fullscreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

slate.bind("right:alt", function(win) {
  win.doOperation(pushRight);
});
slate.bind("left:alt", function(win) {
  win.doOperation(pushLeft);
});
slate.bind("up:alt", function(win) {
  win.doOperation(fullscreen);
});

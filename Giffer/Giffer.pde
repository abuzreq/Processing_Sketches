import gifAnimation.GifMaker;
 
PImage img;
String saveLocation;
int currentFrame = 0;
 
//Gif Animation Options
int playbackSpeed = 250;
int loopAnimation = 0;
int exportQaulity = 100;
String fileExportName = "GameBoyMe";
 
void folderSelected(File selection) {
  if (selection == null) {
    saveLocation = selection.getAbsolutePath();
    println("Default location selected");
  } else {
    saveLocation = selection.getAbsolutePath();
    println(saveLocation);
  }
}
 
//Save a shot of the current screen and increase the frame count.
void saveImage() {
  String frame = "frames/frame" + currentFrame + ".gif";
  saveFrame(frame);
  currentFrame ++;
}
 
//Loop through all our frames and add them to the gif.
void createAnimation() {
  GifMaker gifExport = new GifMaker (this, saveLocation + "/" + fileExportName + ".gif", exportQaulity);
  int framesCount = 0;
  gifExport.setRepeat(loopAnimation);
 
  while (framesCount < currentFrame ) {
    img = loadImage("frames/frame" + framesCount + ".gif");
    gifExport.addFrame(img);
    gifExport.setDelay(playbackSpeed);
    framesCount ++;
  }
  gifExport.finish();
  println("Animation Exported " + saveLocation);
}
 
//Keys for taking the frames and exporting the gif.
void keyPressed() {
  if (key == ' ') {
    saveImage();
  }
  if (key == 'q' || key == 'Q') {  
    createAnimation();
  }
}
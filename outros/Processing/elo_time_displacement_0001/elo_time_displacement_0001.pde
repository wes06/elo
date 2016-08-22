import processing.video.*;

Capture video;
int signal = 0;

int num = 1;

//the buffer for storing video frames
ArrayList frames = new ArrayList();

int a;
int b;

void setup() {

  size(1280, 960);

  video = new Capture(this, 640, 480);

  video.start();
}

void captureEvent(Capture camera) {

  camera.read();
  PImage img = createImage(640, 480, RGB);
  
  video.loadPixels();

  arrayCopy(video.pixels, img.pixels);
img.resize(1280,960);
  frames.add(img);

  // Once there are enough frames, remove the oldest one when adding a new one
  if (frames.size() > height) {
    frames.remove(0);
  }
}


int currentImage;

void draw() {

  if (mouseY>0 && mouseY<=480) {
    num = mouseY;
  } else {
    num=1;
  }

 // currentImage = 0;
 
 if(frames.size() > height/num){
   currentImage = frames.size() - height/num;
   //println("bla");
 }
 
// println(mouseY);

 loadPixels();
resize(1280,960);
  for (int y = 0; y < video.height; y+=num) {

    if (currentImage < frames.size()) {
      PImage img = (PImage)frames.get(currentImage);
      

      if (img != null) {
        img.loadPixels();

        for (int x = 0; x < video.width*2; x++) {
          for (int i =0; i<num; i++) {
            pixels[(x + (y+i) *1280)%1228800] = img.pixels[(x + (y+i) * 1280)%1228800];
          }
        }
      }
      // Increase the image counter
      currentImage++;
    } else {
      break;
    }
  }

  updatePixels();
 
}



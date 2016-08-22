import processing.video.*;

Capture video;
int signal = 0;

int num = 1;

//the buffer for storing video frames
ArrayList frames = new ArrayList();

int a;
int b;

void setup() {
 size(displayWidth, displayHeight);

  video = new Capture(this, 640, 480);

  video.start();
}

void captureEvent(Capture camera) {

  camera.read();
  PImage img = createImage(640, 480, RGB);
  
  
  
  video.loadPixels();

  

  arrayCopy(video.pixels, img.pixels);

img.resize(1280,800);

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

  for (int y = 0; y < video.height; y+=num) {

    if (currentImage < frames.size()) {
      print(frames.size()+"   ");
      print(num+"   ");
println(currentImage);
      PImage img = (PImage)frames.get(currentImage);

      if (img != null) {

        img.loadPixels();

        for (int x = 0; x < 1280/*video.width*/; x++) {
          for (int i =0; i<num; i++) {
            pixels[(x + (y+i) * 1280) % 1024000] = img.pixels[(x + (y+i) * 1280) % 1024000];
         //   a=x + (y+num) * width;
            //b=x + (y+num) * video.width;
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




void mouseClicked() {
  println(a);
  println(b);
}


/*
 * Time Displacement
 * by David Muth 
 * 
 * Keeps a buffer of video frames in memory and displays pixel rows
 * taken from consecutive frames distributed over the y-axis 
 */

import processing.video.*;

Capture video;
int signal = 0;

int barras=1;

int num = 1;

//the buffer for storing video frames
ArrayList frames = new ArrayList();

int a;
int b;

void setup() {

  size(640, 480);

  video = new Capture(this, 640, 480);

  video.start();
}

void captureEvent(Capture camera) {

  camera.read();
  // Copy the current video frame into an image, so it can be stored in the buffer
  PImage img = createImage(width, height, RGB);

  video.loadPixels();

  arrayCopy(video.pixels, img.pixels);

  frames.add(img);

  // Once there are enough frames, remove the oldest one when adding a new one
  if (frames.size() > height/num) {
    frames.remove(0);
  }
}

void draw() {

  // Set the image counter to 0
  int currentImage = 0;

  loadPixels();

  // Begin a loop for displaying pixel rows of 4 pixels height
  for (int y = 0; y < video.height; y+=num) {

    // Go through the frame buffer and pick an image, starting with the oldest one
    if (currentImage < frames.size()) {

      PImage img = (PImage)frames.get(currentImage);

      if (img != null) {

        img.loadPixels();

        for (int x = 0; x < video.width; x++) {
          for (int i =0; i<=num; i++) {
            pixels[x + (y+num) * width] = img.pixels[x + (y+num) * video.width];
            a=x + (y+num) * width;
            b=x + (y+num) * video.width;
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

  // For recording an image sequence
  //saveFrame("frame-####.jpg");
}


void mouseClicked() {
  println(a);
  println(b);
}



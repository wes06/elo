/**
 * This sketch demonstrates how to play a file with Minim using an AudioPlayer. <br />
 * It's also a good example of how to draw the waveform of the audio.
 * <p>
 * For more information about Minim and additional features, 
 * visit http://code.compartmental.net/minim/
 */

import ddf.minim.*;
import processing.serial.*;

Minim minim;
AudioPlayer player;

Serial myPort;  // Create object from Serial class



void setup()
{
  size(512, 200, P3D);
  //println(Serial.list());
String portName = "/dev/cu.usbserial-A9049MWS";//Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  //player = minim.loadFile("EDITADO_normal.wav");
  //player = minim.loadFile("julia_bocejo.wav");
  player = minim.loadFile("insp.wav");

  // play the file from start to finish.
  // if you want to play the file again, 
  // you need to call rewind() first.
  player.play();
  println(player.bufferSize());
}

float tot;
int avg;

float tot1;
int avg1 = 50;
int bg;

void draw()
{
  background(bg,bg,0);
  

  tot = 0;

  for (int i = 0; i < player.bufferSize() - 1; i++)
  {
    
    player.left.get(i);

    tot += abs(player.left.get(i));
  }


  //println(avg1);
  //  avg = int(tot*8);
  avg1 = int((avg1*9 + tot)/10);

  bg = constrain(avg1*30, 0, 255);
  myPort.write(bg);
  //println(bg);
  //   if(bg>254){println(abs(player.left.get(i))*2000);}
}


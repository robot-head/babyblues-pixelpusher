

import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;

import processing.core.*;
import java.util.*;

DeviceRegistry registry;

int stride = 240;
boolean use_weighted_get = true;

boolean ready_to_go = true;
String mode = "drips";

int canvasW = 640;
int canvasH = 480;
int bright = 127;
TestObserver testObserver;

int numStars = 200;

int radius = 5;
float theta = 3.0;

class Star {
  public int x;
  public int y;
  public int z;

  public Star() {
    x=0;
    y=int(random(height));
    z=20+int(random(width-20));
  }
};

Star[] galaxy;

void setup() {
  size(canvasW, canvasH, P2D);
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  registry.setAntiLog(true);
  //background(#000000);
  stroke(#ff0000);
  fill(#ff0000);
  galaxy = new Star[numStars];
  background(0);
  for (int i=0; i<numStars; i++)
    galaxy[i] = new Star();
}

void drips() {
  background(#0000FF);
  for (int i=0; i<numStars; i++) {
    ellipse(galaxy[i].x, galaxy[i].y, galaxy[i].z/40, galaxy[i].z/40);
    galaxy[i].x+=1+galaxy[i].z / 500;
    if (galaxy[i].x > width)
      galaxy[i] = new Star();
  }
}

void white() {
  background(#FFFFFF);
}

void draw() {
  if (mode.equals("drips")) 
    drips();
  if (mode.equals("white"))
    white();
  scrape();
}

void stop()
{
  super.stop();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      brighter();
    } 
    else if (keyCode == DOWN) {
      dimmer();
    }
  }
  if (key == 'd')
    mode = "drips";
  if (key == 'w')
    mode = "white";
}

void brighter() {
  if (bright < 255)
    bright++;
}

void dimmer() {
  if (bright > 0)
    bright--;
}


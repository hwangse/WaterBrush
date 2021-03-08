import controlP5.*; //<>//

/*
   Project by Sehyun Hwang
 
 * name : Water Brush
 * description : Water Brush is a project which describes what it would be like to have water as brush element.
                 Among the various characteristics of water, this project reflects the varies in water shape depending on temperature.
                 So you can experience various effects by changing temperature below.
 */

ArrayList<drop> drops;

// temperature
import controlP5.*;
ControlP5 cp5;
Slider sl;

int sliderWidth = 300;
int sliderHeight = 15;
int defaultTemp = 25;
int temperature = defaultTemp;
int minTemp = -20;
int maxTemp = 40;

// font
PFont font;

// image
PImage snow, sun;

void setup() {
  fullScreen();
  background(255);
  drops = new ArrayList<drop>();

  // text
  textSize(10);
  textAlign(CENTER);

  // control GUI
  cp5 = new ControlP5(this);
  sl = cp5.addSlider("temperature");
  sl.setPosition(width/2-sliderWidth/2, height * 0.93);
  sl.setSize(sliderWidth, sliderHeight);
  sl.setRange(minTemp, maxTemp);
  sl.setColorCaptionLabel(color(0));
  sl.setColorActive(color(220, 200, 180));
  sl.setColorForeground(color(240, 240, 200));
  sl.setCaptionLabel("");
  
  // font
  font = createFont("Montserrat-Light.ttf", 20);
  textFont(font);
  
  // icon image
  snow = loadImage("snow.png");
  sun = loadImage("sun.png");

  smooth();
}

void draw() {
  fill(232, 222, 202, 30); // background
  rect(0, 0, width, height);

  ////////////////////////slider and text///////////////////////
  fill(100);
  textSize(18);
  text("Water Brush", width * 0.5, height * 0.05);
  textSize(15);
  text("Current temperature is", width * 0.5, height * 0.87);
  textSize(23);
  text(" "+temperature+" °C", width * 0.5, height * 0.91);
  image(snow, width * 0.37, height * 0.92, 27, 27);
  image(sun, width * 0.61, height * 0.92, 30, 30);
  //////////////////////////////////////////////////////////////

  for (int i = 0; i < drops.size(); i++) {
    drop element =  drops.get(i);
    if (element.alpha < 0) drops.remove(i);

    element.clock();
    element.move();
    element.display();
  }
}

void mouseDragged() {
  drops.add(new drop(mouseX, mouseY, 1.5));
}

void keyPressed() {
  if (key == ' ') {
    drops.clear();
    background(255);
  }
}

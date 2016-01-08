PImage img;  // Declare variable "a" of type PImage
color c1, c2, c3, c4;

void setup() {
  size(1024,512);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  c1 = color(#17262E);
  c2 = color(#223341);
  c3 = color(#000000);
  c4 = color(#75A4DE);
  img = loadImage("cloud.png");  // Load the image into the program 
 noLoop();
  
}

void draw() {
  background(/*lerpColor(c1,c3,abs(sin(millis()/10000.0)))*/c3);
  //setGradient(1024,512,lerpColor(c1,c3,abs(sin(millis()/10000.0))),lerpColor(c2,c4,abs(sin(millis()/10000.0))));
  //image(img, ((millis()/50)%(1024+img.width/2))-img.width/2, 20, img.width/2, img.height/2);
  fill(#FFFFFF);
  noStroke();
  int terrainHeight = 100;
  beginShape();
  vertex(0, height);
  vertex(0, height - terrainHeight);
  float lastHeight = 0.0;
  int margin = 120;
  int douveWidth = 70;
  int douveDepth = 40;
  int pointCount = 3;
  for(int i=0; i < pointCount+1; i++){
     lastHeight = height - map(noise(i*margin/pointCount),0,1,terrainHeight-20,terrainHeight);
     vertex(i*margin/pointCount, lastHeight); 
  }
  vertex(margin, lastHeight);
  vertex(margin, height-douveDepth);
  vertex(margin+douveWidth*0.5, height - douveDepth+10);
  vertex(margin+douveWidth, height - douveDepth);
  vertex(margin+douveWidth, height - terrainHeight);
  vertex(width-(margin+douveWidth), height - terrainHeight);
  vertex(width-(margin+douveWidth), height - douveDepth);
  vertex(width-(margin+douveWidth*0.5), height - douveDepth+10);
  vertex(width-margin, height - douveDepth);
  
  
  for(int i=0; i < pointCount+1; i++){
   vertex(width-margin+i*margin/pointCount, height - map(noise(width-margin+i*margin/pointCount),0,1,terrainHeight-20,terrainHeight)); 
  }
  vertex(width, height - terrainHeight);
  vertex(width, height);
  
  endShape(CLOSE);
}

void setGradient(float w, float h, color c1, color c2 ) {
  noFill();
  for (int i = 0; i <= h; i++) {
      float inter = map(i, 0, h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c); 
      line(0, i, w, i);
    } 
}
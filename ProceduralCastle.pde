//Copyright Simon Rodriguez - 2016
int terrainHeight, margin,douveWidth, douveDepth,pointCount;
  
void setup() {
  randomParameters(0);
  size(1300,600);
  noLoop();
}

void randomParameters(int seed){
  //randomSeed(seed);
  //noiseSeed(seed);
  terrainHeight = 130 + (int)random(-10,10);
  margin = terrainHeight - 10;
  println("Terrain height: " + terrainHeight + ", margin: " + margin);
  douveWidth = 70 + (int)random(-5,5); 
  douveDepth = (int)((4.0/7.0)*douveWidth);
  println("Douve width: " + douveWidth + ", Douve depth: " + douveDepth);
  pointCount = 3 + (int)random(-1,1);
  println("Point count: " + pointCount);
}

void draw() {
  background(#000000);
   drawGround(false);
   drawBuildings();
}

void drawBuildings(){
  fill(#FFFFFF);
  stroke(#FF0000);
  
  rect(margin+douveWidth,height-douveDepth-100,width-2*(margin+douveWidth),100);
  rect(margin+douveWidth,height-douveDepth-100*2,width-2*(margin+douveWidth),100);
  rect(margin+douveWidth+150,height-douveDepth-100*3,width-2*(margin+douveWidth)-2*150,100);
  rect(margin+douveWidth+2*150,height-douveDepth-100*4,width-2*(margin+douveWidth)-4*150,100);
}

void drawGround(boolean withBase){
  fill(#FFFFFF);
  noStroke();
  beginShape();
  vertex(0, height);
  vertex(0, height - terrainHeight);
  float lastHeight = 0.0;
  
  for(int i=0; i < pointCount+1; i++){
     lastHeight = height - map(noise(i*margin/pointCount),0,1,terrainHeight-20,terrainHeight);
     vertex(i*margin/pointCount, lastHeight); 
  }
  vertex(margin, lastHeight);
  vertex(margin, height-douveDepth);
  vertex(margin+douveWidth*0.5, height - douveDepth+10);
  vertex(margin+douveWidth, height - douveDepth);
  if(withBase){
    vertex(margin+douveWidth, height - terrainHeight);
    vertex(width-(margin+douveWidth), height - terrainHeight);
  }
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

/*void setGradient(float w, float h, color c1, color c2 ) {
  noFill();
  for (int i = 0; i <= h; i++) {
      float inter = map(i, 0, h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c); 
      line(0, i, w, i);
    } 
}*/
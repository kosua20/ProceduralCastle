//Copyright Simon Rodriguez - 2016
int terrainHeight, margin,douveWidth, douveDepth,pointCount, roomHeight;

int roomMargin = 8;
/*enum TowerType {
  Pointy, Flat, Trapeze, Round;
}*/

void setup() {
  size(1300,600);
  drawScene();
}

void mouseClicked(){
  background(#000000);
  drawScene();
}

void randomParameters(int seed){
  if(seed >= 0){
    println("Seed: " + seed);
    randomSeed(seed);
    noiseSeed(seed);
  }
  terrainHeight = 130 + (int)random(-10,10);
  margin = terrainHeight - 10;
  println("Terrain height: " + terrainHeight + ", margin: " + margin);
  douveWidth = 70 + (int)random(-5,5); 
  douveDepth = (int)((4.0/7.0)*douveWidth);
  println("Douve width: " + douveWidth + ", Douve depth: " + douveDepth);
  pointCount = 3 + (int)random(-1,1);
  println("Point count: " + pointCount);
  roomHeight = 60;
}

void draw() {
  
}

void drawScene(){
  randomParameters(-1);
  background(#000000);
   drawGround(false);
   //Draw the base
   rect(margin+douveWidth,height-terrainHeight,width - 2*(margin+douveWidth),terrainHeight);
   drawBuildings();
   saveFrame("../Output/frame_" + month() +"_"+ day() +"_"+ hour() +"_"+ minute() +"_"+ second() + ".png");
}

void drawBuildings(){
  
  int height1 = (int)random(80,120);
  int height2 = height1 + (int)random(20,80);
  int height3 = height2 + (int)random(50,100);
  int fullWidth = width - 2*(margin+douveWidth);
  int width1 = fullWidth;
  int width2 = (int)(width1*random(0.4,0.65));
  int width3 = (int)(width2*random(0.2,0.4));
  
  float halfWidth1 = (width1-width2)*0.5;
  float halfWidth2 = (width2-width3)*0.5;
  
  
  //stroke(#FF0000);
  drawRing(margin+douveWidth,halfWidth1,height1);
  //stroke(#00FF00);
  drawRing(margin+douveWidth+halfWidth1,halfWidth2,height2);
  //stroke(#0000FF);
  drawCenter(width3,height3);
  
  addWell(100);
  
}

void drawCenter(float _width, float _height){
  fill(#FFFFFF);
  float x = (width-_width)*0.5;
  rect(x,height-terrainHeight-_height,_width,_height);
  fill(#000000);
 float bottom = 0.0;
  float top = -roomMargin;
  while(top < _height-roomMargin){
    
    bottom = top+roomMargin;
    top = top+roomMargin+roomHeight;
    if(min(top,_height-roomMargin)-bottom>0.3*roomHeight){
      rect(x+roomMargin,height-terrainHeight-min(top,_height-roomMargin),_width-2*roomMargin,min(top,_height-roomMargin)-bottom);
    }
  }
  
  fill(#FFFFFF);
  int type = (int)random(1,4);
  switch(type){
     case 1://Pointy
       triangle(x-7,height-terrainHeight-_height,x+0.5*_width,height-terrainHeight-_height-50,x+_width+7,height-terrainHeight-_height);
     break;
     case 2://Trapez
     quad(x-7,height-terrainHeight-_height,x+5,height-terrainHeight-_height-50,x+_width-5,height-terrainHeight-_height-50,x+_width+7,height-terrainHeight-_height);
     break;
     case 3: //Crenel
     rect(x-10,height-terrainHeight-_height-20,_width+20,20);
     float step = (_width+20)/15.0;
     for(int i=0;i<15;i+=2){
       rect(x-10+i*step,height-terrainHeight-_height-20-5,step,5);
     }
     break;
     default://Flat
     
  }
}

void drawRing(float x, float halfWidth, float blockHeight){
  int widthTower = (int)random(40,60);
  int heightTower = (int)(blockHeight+random(10,35));
  int type = (int)random(1,5);
  //Left block
  fill(#AAAAAA);
  rect(x,height-terrainHeight-blockHeight,halfWidth,blockHeight);
  drawTower(x,widthTower,heightTower,type);
  
  //Right block
  fill(#AAAAAA);
  rect(width-x-halfWidth,height-terrainHeight-blockHeight,halfWidth,blockHeight);
  
  drawTower(width-x-widthTower,widthTower,heightTower,type);
}


void drawTower(float x,float _width, float _height, int type){
  fill(#FFFFFF);
  rect(x,height-terrainHeight-_height,_width,_height);
  
  fill(#000000);
  float bottom = 0.0;
  float top = -roomMargin;
  while(top < _height-roomMargin){
    
    bottom = top+roomMargin;
    top = top+roomMargin+roomHeight;
    if(min(top,_height-roomMargin)-bottom>0.4*roomHeight){
      rect(x+roomMargin,height-terrainHeight-min(top,_height-roomMargin),_width-2*roomMargin,min(top,_height-roomMargin)-bottom);
    }
  }
    
  fill(#FFFFFF);
  switch(type){
     case 1://Pointy
       triangle(x-7,height-terrainHeight-_height,x+0.5*_width,height-terrainHeight-_height-30,x+_width+7,height-terrainHeight-_height);
     break;
     case 2://Round
     arc(x+0.5*_width,height-terrainHeight-_height,_width+10,_width+10,PI,TWO_PI);
     break;
     case 3://Trapez
     quad(x-7,height-terrainHeight-_height,x+5,height-terrainHeight-_height-24,x+_width-5,height-terrainHeight-_height-24,x+_width+7,height-terrainHeight-_height);
     break;
     case 4: //Crenel
     rect(x-10,height-terrainHeight-_height-15,_width+20,15);
     float step = (_width+20)/9.0;
     for(int i=0;i<9;i+=2){
       rect(x-10+i*step,height-terrainHeight-_height-15-5,step,5);
     }
     break;
     default://Flat
     
  }
}

void addWell(int x){
  fill(#FF0000);
  int _width = 15;
  rect(x-_width,height-terrainHeight-_width,2*_width,_width);
  fill(#00FF00);
  rect(x-_width,height-terrainHeight,2*_width,terrainHeight);
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
float y1 = 500;
float pijlX = 0;
float [] x1 = { 100, 150, 200,250,300};
 void setup() {
   size(500,500);
   println(x1[0]);
 }
 

 
 void draw(){
    background(100,100,255);
  y1 = y1 -10;
  pijlX = pijlX + 10;
 line(pijlX,mouseY,pijlX + 100, mouseY);
 ellipse(x1[0],y1,30,30);
 ellipse(x1[1],y1,30,30);
 ellipse(x1[2],y1,30,30);
 ellipse(x1[3],y1,30,30);
 ellipse(x1[4],y1,30,30);
 
 
 if (y1==0) {
 y1 =  height;
 }
  if (pijlX >=width){
    pijlX = 0;
  }
 }

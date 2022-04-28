 //<>// //<>// //<>// //<>// //<>//
void setup() {
  size(900, 900);
  background(255);
  noLoop();
}
void draw() {
  PImage img = loadImage("Image Dataset"+ "//" + "/Extra_900x900.jpg");
  histogram(img);
  PImage gs = grayScale(img, 'B');
  gs = gaussianBlur(gs,0.91);
 //gs =  sobel(gs);
 

  //mediaJanela(gs,7);
  //gs = gaussianBlur(gs,0.91);

}

import java.util.Queue;  //<>//
import java.util.LinkedList;
import java.awt.Point;

void setup() {
  size(900, 900);
  background(255);
  noLoop();
}
void draw() {
  PImage img = loadImage("Image Dataset"+ "//" + "/Kesley900x900.jpg");
  histogram(img);
  PImage gs = grayScale(img, 'R');
  gs = media4p(gs);
//  mediaJanela(gs, 3); //<>//
// gs = sobel(gs);
//  FloodFill(46,270,gs);
// histogram(gs);
 //limiar(gs, 150);
 gs = bright(gs,1.4);
 gs = media4p(gs);
 histogram(gs);
}

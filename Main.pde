 //<>// //<>// //<>// //<>//
void setup() {
  size(900, 900);
  background(255);
  noLoop();
}
void draw() {
  PImage img = loadImage("Image Dataset"+ "//" + "/Kesley900x900.jpg");
  histogram(img);
  PImage gs = grayScale(img, 'R');
   gs = mediaJanela(gs, 5);
  gs = media4p(gs);
  gs = passaAltas(gs);
  gs = mediana(gs);
  gs = mediaJanela(gs, 3);
    gs = gaussianBlur(gs, 0.79);
    for(int i = 0; i < 5; i++){gs = media4p(g);}
  gs = mediaJanela(gs, 3);
  for (int i = 0; i <3; i++) {
    gs = passaAltas(gs);
    gs = mediana(gs);
    gs = media4p(gs);
  }
  gs=bright(gs,1.03);

  limiar(gs, 150);
   // gs = mediaJanela(gs, 3);
}

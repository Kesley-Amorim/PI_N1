 //<>// //<>// //<>//
void setup() {
  size(900, 900);
  background(255);
  noLoop();
}
void draw() {
  PImage img = loadImage("Image Dataset"+ "//" + "/Kesley900.jpg");
  histogram(img);
  save("Processed" + "//" + "1.jpg");
  PImage gs = grayScale(img, 'R');
    save("Processed" + "//" + "2.jpg");
   gs = mediaJanela(gs, 5);
     save("Processed" + "//" + "3.jpg");
  gs = media4p(gs);
    save("Processed" + "//" + "4.jpg");
  gs = passaAltas(gs);
    save("Processed" + "//" + "5.jpg");
  gs = mediana(gs);
    save("Processed" + "//" + "6.jpg");
  gs = mediaJanela(gs, 3);
    save("Processed" + "//" + "7.jpg");
    gs = gaussianBlur(gs, 0.81);
      save("Processed" + "//" + "8.jpg");
    for(int i = 0; i < 5; i++){gs = media4p(g);}
      save("Processed" + "//" + "9.jpg");
  gs = mediaJanela(gs, 3);
    save("Processed" + "//" + "10.jpg");
  for (int i = 0; i <3; i++) {
    gs = passaAltas(gs);
    gs = mediana(gs);
    gs = media4p(gs);
  }
    save("Processed" + "//" + "11.jpg");
  gs = mediaJanela(gs,3);
    save("Processed" + "//" + "12.jpg");
  gs=bright(gs,1.03);
    save("Processed" + "//" + "13.jpg");
  gs = passaAltas(gs);
    save("Processed" + "//" + "14.jpg");
   gs = mediana(gs);
     save("Processed" + "//" + "15.jpg");
gs = mediaJanela(gs, 3);
  save("Processed" + "//" + "16.jpg");
  gs = media4p(gs);
   save("Processed" + "//" + "17.jpg");
  limiar(gs, 219);
     save("Processed" + "//" + "18.jpg");
}

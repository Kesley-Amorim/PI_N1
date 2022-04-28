float gauss(int x, int y, float param) {
return ((1/(2*PI*(param*param))) * (exp((-((x*x)+(y*y)))/2*(param*param))));
}

void setup() { 
  size(900, 900); 
  noLoop(); 
}

void draw() {
  PImage img = loadImage("James.jpg"); 
  img.loadPixels();
  
  PImage aux = createImage(img.width, img.height, RGB); 
  PImage aux2 = createImage(img.width, img.height, RGB);
  PImage aux3 = createImage(img.width, img.height, RGB);
     
    //Escala de Cinza
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;
      float media = blue(img.pixels[pos]);
      aux.pixels[pos] = color(media);
    }
  }
  image(aux, 0, 0);
  save("James1.jpg");
  
  float paramGauss = 0.8;
  //Kernel!
                
  float[][] gx = {{gauss(-1,-1, paramGauss), gauss(0,-1, paramGauss), gauss(1,-1, paramGauss)},
                  {gauss(-1,0, paramGauss), gauss(0,0, paramGauss), gauss(1,0, paramGauss)},
                  {gauss(-1,1, paramGauss), gauss(0,1, paramGauss), gauss(1,1, paramGauss)}};
                  
  float[][] gy = {{gauss(-1,-1, paramGauss), gauss(0,-1, paramGauss), gauss(1,-1, paramGauss)},
                  {gauss(-1,0, paramGauss), gauss(0,0, paramGauss), gauss(1,0, paramGauss)},
                  {gauss(-1,1, paramGauss), gauss(0,1, paramGauss), gauss(1,1, paramGauss)}};
  
  // Filtro Gaussiano
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int jan = 1;
      int pos = (y)*img.width + (x); /* acessa o ponto em forma de vetor */
      
      float mediaOx = 0, mediaOy = 0;
      int qtde = 0;
      
      // janela tamanho 1
      for(int i = jan*(-1); i <= jan; i++) {
        for (int j = jan*(-1); j <= jan; j++) {
          int disy = y+i;
          int disx = x+j;
          if(disy >= 0 && disy < img.height &&
             disx >= 0 && disx < img.width) {
              int pos_aux = disy * img.width + disx;
              float Ox = blue(aux.pixels[pos_aux]) * gx[i+1][j+1];
              float Oy = blue(aux.pixels[pos_aux]) * gy[i+1][j+1];
              mediaOx += Ox;
              mediaOy += Oy;
             }
        }
      }
      
      // Raiz da soma ao quadrado
      float mediaFinal = sqrt(mediaOx*mediaOx + mediaOy*mediaOy);      
      aux2.pixels[pos] = color(mediaFinal);
    }
  }
  
image(aux2, 0, 0);
save("James2.jpg");
  
  //Limiarização
for (int y = 0; y < img.height; y++) {
    for( int x = 0; x < img.width; x++) {
       int pos = y * img.width + x;
       if (blue(aux2.pixels[pos]) > 180 && y < 900){
         aux3.pixels[pos] = color(0);
       } else {
         aux3.pixels[pos] = color(255);
  }
}
}
 

  /* atualiza a imagem */ 
  image(aux3, 0, 0); /* exibe */
  save("James3.jpg");
}

import java.util.ArrayList;
import java.util.Collections;

void setup() {
  size(900, 900);
  background(255);
  noLoop();
}
void draw() {
  PImage img = loadImage("Lucas.jpg");
  histogram(img);
    
  PImage gs = grayScale(img, 'B');
    gs = passaAltas(gs);
    gs = mediana(gs);
    gs = mediaJanela(gs, 1);
    gs = gaussianBlur(gs, 1);
    for(int i = 0; i < 5; i++){gs = media4p(g);}
    gs = mediaJanela(gs, 2);
    for (int i = 0; i <3; i++) {
      gs = passaAltas(gs);
      gs = mediana(gs);
      gs = media4p(gs);
    }  
    gs=bright(gs,1.38);

    limiar(gs, 150);
   
   // Percorrer todas as posições da imagem 
    for(int y = 0; y < 52; y++) {
      for(int x = 0; x < gs.width; x++) {
        int pos = x * gs.width + y;
        gs.pixels[pos] = color(255);
      }
    }
    
    for(int y = 0; y < 900; y++) {
      for(int x = 880; x < gs.width; x++) {
        int pos = x * gs.width + y;
        gs.pixels[pos] = color(255);
        }
    }
    
    for(int y = 450; y < 900; y++) {
      for(int x = 800; x < gs.width; x++) {
        int pos = x * gs.width + y;
        gs.pixels[pos] = color(255);
        }
    }
    
    for(int y = 850; y < 900; y++) {
      for(int x = 0; x < gs.width; x++) {
        int pos = x * gs.width + y;
        gs.pixels[pos] = color(255);
        }
    }
  
     gs = limiar(gs, 150);
     image(gs, 0, 0);
}
  

//Histograma
private void histogram(PImage img) {
  background(255);
  int[] histR = new int[256];
  int[] histG = new int[256];
  int[] histB = new int[256];


  for (int i=0; i<256; i++) {
    histR[i]=histG[i]=histB[i]=0;
  }

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y*img.width + x;

      int valueR = round(red(img.pixels[pos]));
      histR[valueR]++;

      int valueG = round(green(img.pixels[pos]));
      histG[valueG]++;

      int valueB = round(blue(img.pixels[pos]));
      histB[valueB]++;
    }
  }

  int histMaxR = max(histR);
  int histMaxG = max(histG);
  int histMaxB = max(histB);
  int[] histMaxRGB = {histMaxR, histMaxG, histMaxB};
  int histMax = max(histMaxRGB);

  for (int k = 0; k < 256; k+=15) {
    textSize(9);
    fill(0);
    text(k, map(k+20, 0, 255, 0, 255), 860);
    line(300, 0, 300, 850);
    text(k, map(k+320, 0, 255, 0, 255), 860);
    line(600, 0, 600, 850);
    text(k, map(k+620, 0, 255, 0, 255), 860);
  }

  for (int i = 0; i < 256; i++) {
    int y = round(map(histR[i], 0, histMax, 0, 850));
    stroke(255, 0, 0);
    line(i+20, 850, i+20, 850-y);

    y = round(map(histG[i], 0, histMax, 0, 850));
    stroke(0, 255, 0);
    line(i+320, 850, i+320, 850-y);

    y = round(map(histB[i], 0, histMax, 0, 850));
    stroke(0, 0, 255);
    line(i+620, 850, i+620, 850-y);
  }
  save("Processed" + "//" + "hist.jpg");
}

//Escala de Cinza

private PImage grayScale(PImage img, char C) {
  img.loadPixels();
  PImage img_gs = createImage(img.width, img.height, RGB);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y* img.width + x;
      switch(C) {
      case 'R':
        img_gs.pixels[pos] = color(red(img.pixels[pos]));
        break;
      case 'G':
        img_gs.pixels[pos] = color(green(img.pixels[pos]));
        break;
      case 'B':
        img_gs.pixels[pos] = color(blue(img.pixels[pos]));
        break;
      case 'M':
        img_gs.pixels[pos] = color(int((red(img.pixels[pos]) + green(img.pixels[pos]) + blue(img.pixels[pos]))/3));
        break;
      }
    }
  }
  image(img_gs, 0, 0);
  save("Processed" + "//" + "img_gs.jpg");
  return img_gs;
}

//Gaussian Blur

// Função utilizada para construção do kernel
float gauss(int x, int y, float param) {
  float value;
  // Implementação da função gaussiana
  // pow -> Função para realizar potência - os parâmetros são a base e expoente, nessa ordem.
  // exp -> Número de Euler's (2.71828...). 
  value = (1/(2*PI*pow(param,2)) * (exp(-(pow(x,2) + pow(y,2))/2*pow(param,2))));
  return value;
}

private PImage gaussianBlur(PImage img, float paramGauss) {
  img.loadPixels();
  PImage aux = createImage(img.width, img.height, RGB); /* cria a imagem vazia do mesmo tamanho da img */

 //Criação dos Kernels em X e Y. (Eles são iguais).          
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
      
      // Percorrer a janela
      for(int i = jan*(-1); i <= jan; i++) {
        for (int j = jan*(-1); j <= jan; j++) {
          // Encontrar a nova coordenada
          int disy = y+i;
          int disx = x+j;
          // Condicional para verificar se a coordenada está dentro da imagem.
          if(disy >= 0 && disy < img.height &&
             disx >= 0 && disx < img.width) {
              int pos_aux = disy * img.width + disx;
              // Adiciona as parciais da convolução no eixo X e Y.
              float Ox = red(img.pixels[pos_aux]) * gx[i+1][j+1];
              float Oy = red(img.pixels[pos_aux]) * gy[i+1][j+1];
              mediaOx += Ox;
              mediaOy += Oy;
             }
        }
      }
      
      // Dado os dois vetores é necessário calcular a resultante. 
      // Há varias maneiras de se realizar:
      // Raiz da soma ao quadrado
      float mediaFinal = sqrt(mediaOx*mediaOx + mediaOy*mediaOy);
      
      //Absoluto de cada e soma
      //float mediaFinal = abs(mediaOx) + abs(mediaOy);
      
      // Absoluto da soma geral
      //float mediaFinal = abs(mediaOx + mediaOy);
      
      // Soma
      //float mediaFinal = mediaOx + mediaOy;
      
      // Multiplicação
      //float mediaFinal = mediaOx * mediaOy;
      
      // Valor calculado é atribuido para o pixel.
      aux.pixels[pos] = color(mediaFinal);
    }
  }

  // Exibe a imagem na janela de visualização.
  aux.updatePixels();
  image(aux, 0, 0);
  save("Processed" + "//" + "img_gaussian.jpg");
  return(aux);
}

private PImage mediaJanela(PImage img, int jan) {
  img.loadPixels();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;
      int qtde = 0;
      float media = 0;

      for (int i = jan*(-1); i <= jan; i++) {
        for (int j = jan*(-1); j <= jan; j++) {
          int ny = y + i;
          int nx = x + j;
          if (ny >= 0 && ny < img.height && nx >= 0 && nx < img.width) {
            int npos = ny*img.width+nx;
            float valor = blue(img.pixels[npos]);
            media += valor;
            qtde++;
          }
        }
      }
      media = media / qtde;
      img.pixels[pos] = color(media);
    }
  }
  img.updatePixels();
  // image(img, 0, 0);
  save("Processed" + "//" + "img_mediajanela.jpg");
  return(img);
}


// Média 4P
private PImage media4p(PImage img) {
  img.loadPixels();
  PImage img_aux = createImage(img.width, img.height, RGB);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;

      int qtd = 0;
      float r1 = 0, r2 = 0, r3 = 0, r4 = 0, media = 0;

      if (y != 0) {
        int pos1 = (y-1)*img.width+x;
        r1 = red(img.pixels[pos1]);
        media += r1;
        qtd++;
      }

      if (y != (img.height-1)) {
        int pos2 = (y+1)*img.width+x;
        r2 = red(img.pixels[pos2]);
        media += r2;
        qtd++;
      }

      if (x != 0) {
        int pos3 = (y)*img.width+(x-1);
        r3 = red(img.pixels[pos3]);
        media += r3;
        qtd++;
      }

      if (x != (img.width-1)) {
        int pos4 = y*img.width + (x+1);
        r4 = red(img.pixels[pos4]);
        media += r4;
        qtd++;
      }

      media = (media + red(img.pixels[pos])) / ++qtd; // ++qtd incrementa primeiro e depois executa a linha
      img_aux.pixels[pos] = color(media);
    }
  }
  image(img_aux, 0, 0);
  save("Processed" + "//" + "img_m4p.jpg");
  return(img_aux);
}

private PImage limiar(PImage img, int lim) {
  img.loadPixels();
  PImage img1 = createImage(img.width, img.height, RGB);
  ;
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;
      img1.pixels[pos] = blue(img.pixels[pos]) > lim ? color(0) : color(255);
    }
  }
  img1.updatePixels();
  image(img1, 0, 0);
  save("Processed" + "//" + "img_limiar.jpg");
  return img1;
}


private PImage bright(PImage img, float v) {
  img.loadPixels();
  PImage aux = createImage(img.width, img.height, RGB);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;
      float valor = red(img.pixels[pos])*v;
      if (valor > 255) valor = 255;
      else if (valor < 0) valor = 0;
      aux.pixels[pos] = color(valor);
    }
  }
  image(aux, 0, 0);
  save("Processed" + "//" + "img_brilho.jpg");
  return aux;
}

private PImage passaAltas(PImage img){  
    img.loadPixels();
// Kernel
float[][] kernel = {{ -1, -1, -1}, 
                    { -1,  9, -1}, 
                    { -1, -1, -1}};
                    
                    
  PImage edgeImg = createImage(img.width, img.height, RGB);
  // Loop through every pixel in the image.
  for (int y = 1; y < img.height-1; y++) { 
    for (int x = 1; x < img.width-1; x++) { 
      float sum = 0; // Soma do Kernel para o pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calcula pixels adjascentes
          int pos = (y + ky)*img.width + (x + kx);
         
          float val = red(img.pixels[pos]);
          // Multiplica valor do pixel com base no Kernel
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      edgeImg.pixels[y*img.width + x] = color(sum);
    }
  }

 // edgeImg.updatePixels();                 
  return(edgeImg);
}

private PImage mediana(PImage img){
  img.loadPixels();
  PImage aux = createImage(img.width, img.height, RGB);
  // Filtro de Mediana
  /* Percorre a imagem */ 
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int jan = 2;
      int pos = (y)*img.width + (x); 
      ArrayList<Integer> valores = new ArrayList<>();
      
      
      // janela tamanho 1
      for(int i = jan*(-1); i <= jan; i++) {
        for (int j = jan*(-1); j <= jan; j++) {
          int ny = y+i;
          int nx = x+j;
          if(ny >= 0 && ny < img.height &&
             nx >= 0 && nx < img.width) {
              int pos_aux = ny * img.width + nx;
              valores.add((int)(red(img.pixels[pos_aux])));
             }
        }
     }
     
     // Cálculo da Mediana
      Collections.sort(valores);
      aux.pixels[pos] = color(valores.get(valores.size()/2));
    }
  }
  return(aux);
  }

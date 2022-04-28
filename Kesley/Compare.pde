//Load images
/*
PImage img1 = loadImage("my_img.png");
 PImage img2 = loadImage("my_img.png");
 
 compareImages(img1,img2);
 
 */
private void compareImages(PImage img, PImage gt) {
  PrintWriter output = createWriter("comparisonData.txt");
  float per_fp = 0, per_fn = 0, accuracy =0;
  int accurate = 0, false_positives = 0, false_negatives = 0;
  //checking if images are the same size
  if (img.width == gt.width && img.height == gt.height) {
    for (int y = 0; y < img.width; y++) {
      for (int x = 0; x < img.height; x++) {
        int pos = y*img.width+x;
        if (red(img.pixels[pos]) == red(gt.pixels[pos])) {
          accurate++;
        } else if (red(img.pixels[pos]) == 0 && red(gt.pixels[pos]) == 255 ) {
          false_negatives++;
        } else if (red(img.pixels[pos]) == 255 && red(gt.pixels[pos]) == 0) {
          false_positives++;
        }
      }
    }
      per_fp = 100*(false_positives/(img.height*img.width));
      per_fn = 100*(false_negatives/(img.height*img.width));
     accuracy = 100*(accurate/(img.height*img.height));
    output.println("Total de acertos: "+accurate +"\nFalsos Positivos: "
      + false_positives + "\nFalsos Negativos: " + false_negatives +
      "\nPorcentagem de Falsos Positivos: " + per_fp + " %" + 
      "\nPorcentagem de Falsos Negativos: " + per_fn + " %" +
      "\nPorcentagem de Precisão: " + accuracy + " %");
    output.close();
  }
}

class Rect {

  int sWidth, sHeight, sPosX, sPosY;
  int fillColor;
  int offset = 4; // décalage par rapport à l'épaisseur du stroke


  Rect(int _sWidth, int _sHeight, int _sPosX, int _sPosY, color _fillColor) {

    sWidth = _sWidth;
    sHeight = _sHeight;
    sPosX = _sPosX;
    sPosY = _sPosY;
    fillColor = _fillColor;
  }

  void checkTopLeftCorner(int i) {
    // si le coin supérieur gauche (sPosX, sPosY) est dans un autre carré
    if (sPosX >= rects.get(i).sPosX && sPosX <= int(rects.get(i).sPosX+rects.get(i).sWidth) && sPosY >= rects.get(i).sPosY && sPosY <= int(rects.get(i).sPosY+rects.get(i).sHeight)) {
      createNoise(sPosX-20, sPosY-20);
    }
  }

  void checkTopRightCorner(int i) {
    // si le coin supérieur droit (sPosX+sWidth, sPosY) est dans un autre carré
    if (sPosX+sWidth >= rects.get(i).sPosX && sPosX+sWidth <= int(rects.get(i).sPosX+rects.get(i).sWidth) && sPosY >= rects.get(i).sPosY && sPosY <= int(rects.get(i).sPosY+rects.get(i).sHeight)) {
      //createNoise(sPosX+20, sPosY-20);
    }
  }

  void checkBottomLeftCorner(int i) {
    // si le coin inférieur gauche (sPosX, sPosY+sHeight) est dans un autre carré
    if (sPosX >= rects.get(i).sPosX && sPosX <= int(rects.get(i).sPosX+rects.get(i).sWidth) && sPosY+sHeight >= rects.get(i).sPosY && sPosY+sHeight <= int(rects.get(i).sPosY+rects.get(i).sHeight)) {
     createNoise(sPosX-20, sPosY+20);
    }
  }


  void checkBottomRightCorner(int i) {
    // si le coin inférieur droit (sPosX+sWidth, sPosY+sHeight) est dans un autre carré
    if (sPosX+sWidth >= rects.get(i).sPosX && sPosX+sWidth <= int(rects.get(i).sPosX+rects.get(i).sWidth) && sPosY+sHeight >= rects.get(i).sPosY && sPosY+sHeight <= int(rects.get(i).sPosY+rects.get(i).sHeight)) {
      createQuadrillage(sPosX+sWidth/2, sPosY+sHeight/2);
    }
  }

  void createNoise(int posX, int posY) {

    int threshold = 140;
    float randomXoff = random(0.01, 0.1);
    float randomYoff = random(0.01, 0.1);

    float red =0;
    float green = 0;
    float blue = 0;

    float xoff = random(0.01, 0.1);

    // on parcourt une zone de pixels autour du coin
    for (int x=posX; x<posX+sWidth && x<width && x>0; x+=1) {
      float yoff=0.0;
      for (int y=posY; y<posY+sHeight && y<height && y>0; y+=1) {

        float bright = map(noise(xoff, yoff), 0, 1, 0, 255);

        loadPixels();
        
        
        // on fait un thresold pour séparer les nuances de gris en deux couleurs
        if (bright > threshold) {
          red = red(pixels[posX+posY*width]);
          green = green(pixels[posX+posY*width]);
          blue = blue(pixels[posX+posY*width]);
        } else {
          // on fait en sorte d'avoir forcément une couleur différente pour la deuxième couleur
          if(color(red, green, blue) == backgroundColor) {
            red = red(squareColor);
            green = green(squareColor);
            blue = blue(squareColor);
          } else {
            red = red(backgroundColor);
            green = green(backgroundColor);
            blue = blue(backgroundColor);
          }
         
        }

        pixels[x+y*width] = color(red, green, blue);
        updatePixels();
        yoff+=randomYoff;
      }
      xoff+=randomXoff;
    }
    
    for (int x=posX; x<posX+sWidth && x<width && x>0; x++) {
      for (int y=posY; y<posY+sHeight && y<height && y>0; y++) {
        //pixellise(
      }
    }
    
  }




  void createQuadrillage(int posX, int posY) {

    int hauteur = int(random(3, 10));
    int largeur = int(random(3, 10));
    int compteur = 0;

    noStroke();

    for (int i=0; i<largeur*hauteur; i+=largeur) {
      if (compteur%2 == 0) {
        fill(fillColor);
      } else {
        fill(255);
      }
      rect(posX+i, posY, largeur, hauteur);
      if (compteur%2 == 0) {
        fill(255);
      } else {
        fill(fillColor);
      }
      rect(posX+i, posY+hauteur, largeur, hauteur);
      compteur++;
    }
  }

  void isOverlaid(int _j) {
    // on compare à chaque square déjà créé
    for (int i=0; i<rects.size(); i++) {
      // Pour ne pas comparer le carré avec lui même
      if (i == _j) {
        return;
      } else {
        checkBottomLeftCorner(i);
        checkBottomRightCorner(i);
        checkTopLeftCorner(i);
        checkTopRightCorner(i);
      }
    }
  }


  void createSquare() {
    stroke(fillColor);
    strokeWeight(8);
    noFill();
    if (sPosY%2 != 0) {
      sPosY+=1;
    }

    if (sPosX%2 != 0) {
      sPosX+=1;
    }

    // println("sPosX " + sPosX + " sPosY " + sPosY);
    rect(sPosX, sPosY, sWidth, sHeight); 
    // calcul du positionnement du carré du milieu par rapport au rectMode CORNER
    rect(sPosX+(sWidth*3/10), sPosY+(sHeight*3/10), sWidth*4/10, sWidth*4/10);
    // rect(sPosX+16, sPosY+16, 16, 16);
  }
}
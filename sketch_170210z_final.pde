/* 
Part of the ReCode Project (http://recodeproject.com)
Based on «Tapestry I» by Kenneth Knowlton
Originally published in «Computer Graphics and Art» v1n2, 1976
Copyright (c) 2017 Mathilde Buenerd / HEAD-Genève license (http://recodeproject/license).
*/


ArrayList<Rect> rects = new ArrayList<Rect>();

float blurValue;
int nbRects;

PGraphics bug;

color backgroundColor;
color squareColor;
int alphaAmount;

void setup() {

  size(600,600);
  colorMode(RGB);

  backgroundColor = color(0, 0, 0);
  squareColor = color(255, 255, 255, 255);
  alphaAmount = 255;
  background(backgroundColor);

  bug = createGraphics(width, height);

  noStroke();

  blurValue = 4;
  nbRects = 70;

  int initialPositionX = int(random(width));
  int initialPositionY = int(random(height));
  int offsetX = 25;
  int offsetY = 25;

  int counter = 0;
  // On crée les rectangles
  for (int i=0; i<nbRects; i++) {
    int squareWidth = 48; // default = 48
    int nbSquares = int(random(2, 7));

    rects.add(new Rect(squareWidth, squareWidth, initialPositionX, initialPositionY, squareColor));

    initialPositionX += offsetX;
    initialPositionY += offsetY;
    alphaAmount -= 30;

    if ((initialPositionX)-20 > width || (initialPositionY)-20 > height || counter%3 == (int(random(0, 2)))) {
      alphaAmount = 255;
      initialPositionX = int(random(width));
      initialPositionY = int(random(height));
      PVector randomNumber = new PVector(int(random(0, 2)), int(random(0, 2)));
      if (randomNumber.x == 0) {
        offsetX = -offsetX;
      } 
      if (randomNumber.y == 0) {
        offsetY = -offsetY;
      }
    }

    counter++;

    squareColor = color(red(squareColor), green(squareColor), blue(squareColor), alphaAmount);
  }


  // /!\ rectMode CENTER

  noStroke();

  // On dessine les rectangles
  for (int j=0; j<rects.size(); j++) {
    Rect aRect = rects.get(j);
    aRect.createSquare();
    aRect.isOverlaid(j);
    println("drawing square " + j + "/" + nbRects);
  }
  // filter(BLUR, 1);
  image(bug, 0, 0);
}

void draw() {

  // pixellise4();
  // decale();
  noLoop();
}



void pixellise4() {

  println("je pixelise");
  loadPixels();

  // boolean fair = true;
  for (int i = 0; i < (width*height)-width*2; i+=2) {

    float redAmount = 0;
    float greenAmount = 0;
    float blueAmount = 0;

    // on calcule la moyenne de rouge/vert/bleu dans 4 pixels adjacents
    redAmount += (red(pixels[i]) + red(pixels[i+1]) + red(pixels[i+width]) + red(pixels[i+width+1]))/4;
    greenAmount += (green(pixels[i]) + green(pixels[i+1]) + green(pixels[i+width]) + green(pixels[i+width+1]))/4;
    blueAmount += (blue(pixels[i]) + blue(pixels[i+1]) + blue(pixels[i+width]) + blue(pixels[i+width+1]))/4;

    // on crée une couleur basée sur cette moyenne
    color pixelColor = color(redAmount, greenAmount, blueAmount);

    // on l'applique à ces 4 pixels
    pixels[i] = pixelColor;
    pixels[i+1] = pixelColor;
    pixels[i+width] = pixelColor;
    pixels[i+width+1] = pixelColor;

    //chaque fois qu'on arrive au bout d'une ligne, on doit sauter 3 lignes
    if (i%width == 0) {
      i+=width;
    }
  }
  updatePixels();
}

void pixelliseColor() {

  println("je pixelise");
  loadPixels();

  // boolean fair = true;
  for (int i = 0; i < (width*height)-width*2; i+=2) {

    float redAmount = 0;
    float greenAmount = 0;
    float blueAmount = 0;

    // on calcule la moyenne de rouge/vert/bleu dans 4 pixels adjacents
    redAmount += (red(pixels[i]) + red(pixels[i+1]) + red(pixels[i+width]) + red(pixels[i+width+1]))/4;
    greenAmount += (green(pixels[i]) + green(pixels[i+1]) + green(pixels[i+width]) + green(pixels[i+width+1]))/4;
    blueAmount += (blue(pixels[i]) + blue(pixels[i+1]) + blue(pixels[i+width]) + blue(pixels[i+width+1]))/4;

    // conditions ternaires : si redAmount>128 alors redAmount=255, sinon redAmount=0
    redAmount = (redAmount >= 128) ? 255 : 0;
    greenAmount = (greenAmount >= 128) ? 255 : 0;
    blueAmount = (blueAmount >= 128) ? 255 : 0;
    
    

    // on crée une couleur basée sur cette moyenne
    color pixelColor = color(redAmount, greenAmount, blueAmount);

    // on l'applique à ces 4 pixels
    pixels[i] = pixelColor;
    pixels[i+1] = pixelColor;
    pixels[i+width] = pixelColor;
    pixels[i+width+1] = pixelColor;

    //chaque fois qu'on arrive au bout d'une ligne, on doit sauter 3 lignes
    if (i%width == 0) {
      i+=width;
    }
  }
  updatePixels();
}


void pixellise9() {
  loadPixels();

  for (int i = 0; i < (width*height)-width*12; i+=3) {

    float redAmount = 0;
    float greenAmount = 0;
    float blueAmount = 0;

    // on calcule la moyenne de rouge/vert/bleu dans 4 pixels adjacents
    redAmount += (red(pixels[i]) + red(pixels[i+1]) + red(pixels[i+2]) + red(pixels[i+width]) + red(pixels[i+width+1]) + red(pixels[i+width+2]) + red(pixels[i+width*2+1]) + red(pixels[i+width*2+2]))/9;
    greenAmount += (green(pixels[i]) + green(pixels[i+1]) + green(pixels[i+2]) + green(pixels[i+width]) + green(pixels[i+width+1]) + green(pixels[i+width+2]) + green(pixels[i+width*2+1]) + green(pixels[i+width*2+2]))/9;
    blueAmount += (blue(pixels[i]) + blue(pixels[i+1]) + blue(pixels[i+2]) + blue(pixels[i+width]) + blue(pixels[i+width+1]) + blue(pixels[i+width+2]) + blue(pixels[i+width*2+1]) + blue(pixels[i+width*2+2]))/9;

    color pixelColor = color(redAmount, greenAmount, blueAmount);

    pixels[i] = pixelColor;
    pixels[i+1] = pixelColor;
    pixels[i+2] = pixelColor;
    pixels[i+width] = pixelColor;
    pixels[i+width+1] = pixelColor;
    pixels[i+width+2] = pixelColor;
    pixels[i+width*2] = pixelColor;
    pixels[i+width*2+1] = pixelColor;
    pixels[i+width*2+2] = pixelColor;


    //chaque fois qu'on arrive au bout d'une ligne, on doit sauter 3 lignes
    if (i%width == 0) {
      i+=width*2;
    }
  }
  updatePixels();
}


void keyPressed() {

  if (key == 'a') {
    saveFrame("screenshot-" + int(random(0, 50)) + ".png");
  }

  if (key =='z') {
    pixelliseColor();
  }

  if (key =='e') {
    pixellise9();
  }
}
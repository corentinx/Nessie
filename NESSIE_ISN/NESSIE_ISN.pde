import processing.sound.*;
SoundFile musiqueDeFond;

PImage Pomme;
PImage Banane;
PImage LochNess;  
PImage Nessie;
PImage NessieG;
PImage Illuminati;
PImage Etoile;
PImage Cornemuse;
PImage Kilt;
PImage EtoileC;
float xRandom, yPomme, hPomme, wPomme, yBanane, wBanane, hBanane, yEtoile, wEtoile, hEtoile, xNessie, wNessie, yNessie, hNessie ;
float xIllu = -300;
float yC = -100;
float yK = -100;

int score, vies;
float xScore;
float xVies; 
float ydepart; 
float angle; 

boolean right, left;
int mode = 1;
float vitesse;
int f1 = #0DFF3B;
int f2 = #0DFF3B;
int f3 = #0DFF3B;
int f4 = #0DFF3B;
int NGD = 0;


void setup() {
  size(960, 678);
  imageMode(CENTER);
  initialisation();
  right = left = false;
  musiqueDeFond = new SoundFile(this, "968_Au_Pouliguen_il_y_a_une_jolie_brune.mp3");
  Pomme = loadImage("pomme.png");
  Pomme.resize((int) (Pomme.width *0.5), (int) (Pomme.height*0.5));
  Banane = loadImage("Banane.png");
  Banane.resize( (int) (Banane.width *0.5), (int) (Banane.height*0.5)  );
  Etoile = loadImage("Etoile.gif");
  Etoile.resize((int)(Etoile.width * 0.5), (int) (Etoile.height *0.5));
  Nessie = loadImage("Nessie2.png");
  Nessie.resize( (int) (Nessie.width *1.25), (int) (Nessie.height*1.25)  );
  Cornemuse = loadImage("cornemuse.png");
  Cornemuse.resize((int)(Cornemuse.width*0.5), (int) (Cornemuse.height*0.5));
  Kilt = loadImage("kilt.png");
  Kilt.resize((int)(Kilt.width*0.25), (int) (Kilt.height*0.25));
  NessieG = loadImage("NessieG2.png");
  NessieG.resize( (int) (NessieG.width *1.25), (int) (NessieG.height*1.25)  );
  LochNess = loadImage("Loch Ness.jpg");
  Illuminati = loadImage("illuminati.png");
  Illuminati.resize((int)(Illuminati.width * 0.5), (int) ( Illuminati.height * 0.5));
  musiqueDeFond.loop();
  //EtoileC = loadImage("etoile.jpg");
}




void draw() {
  if (mode == 1) { 
    drawMode1();
  }
  if (mode == 2) {
    drawMode2();
  }
  if (mode == 3) {
    drawMode3();
  }
}

void drawMode1 () {

  stroke(0, 0, 0);

 
  fill(f1);
  rect(0, 0, 320, 578);
  fill(f2);
  rect(320, 0, 320, 578);
  fill(f3);
  rect(640, 0, 320, 578);
  fill(f4);
  rect(0,578,960,678);
  
  


  if (mouseX < 320 && mouseY < 578) {
    f1 = #17E03D;
  } else {
    f1  = #0DFF3B;
  }
  if (mouseX > 320 && mouseX < 640 && mouseY < 578) {
    f2 = #17E03D;
  } else {
    f2  = #0DFF3B;
  }
  if (mouseX > 640 && mouseY < 578) {
    f3 = #17E03D;
  } else {
    f3  = #0DFF3B;
  }
  if (mouseY > 578) {
    f4 = #17E03D;
  } else {
    f4 = #0DFF3B;;
  }

  textSize(50);
  fill(0, 0, 0);
  text("Facile", width/9, height/2);
  text("Normal", width*3.75/9, height/2);
  text("Difficile", width*6.75/9, height/2);
  textSize(30);
  text(" Jeu #2 ", width/3, 628+15);


  if (mousePressed && mouseX<=320) {
    mode = 2;
    vitesse = 0.5;
  }
  if (mousePressed && mouseX>=320 && mouseX<=640) {
    mode = 2;
    vitesse = 1;
  }
  if (mousePressed && mouseX>=640) {
    mode = 2;
    vitesse = 1.5;
  }
  if (mousePressed && mouseY >578) {
    mode = 3;
  }
}

void drawMode2() {

  float PoBa = random(0, 1);

  if (right && xNessie <= width - (179*1.25)/2) { 
    xNessie += 8 * vitesse;
    NGD = 1;
  }
  if (left && xNessie >= (179*1.25)/2) { 
    xNessie += - 8 * vitesse;
    NGD = 0;
  }

  //Loch Ness :
  image(LochNess, 480, 339);

  // Nessie :
  if (NGD == 0) {
    image(NessieG, xNessie, yNessie);
  } else {
    image(Nessie, xNessie, yNessie);
  }

  //Pomme :
  //Descente :
  yPomme = yPomme + 5 * vitesse;
  // Rotation :
  angle = angle + 0.01;
  if (angle > 2*PI) angle = 0;
  pushMatrix();  
  translate(xRandom, yPomme); 
  rotate(angle); 
  image(Pomme, 0, 0); 
  popMatrix(); 
  // Collisions :
  if (xRandom + wPomme > xNessie &&
    xRandom < xNessie + wNessie &&
    yPomme + hPomme > yNessie &&
    yPomme < yNessie + hNessie) {
    score = score + 1;
    yPomme = 1000;
    xRandom = (int)random(50, 910);
    if (PoBa >=0.5) {
      yPomme = -100;
    }
    if (PoBa < 0.5 && PoBa >0.03) {
      yBanane = -100;
    }
    if (PoBa <= 0.03) {
      yEtoile = -100;
    }
  }
  // Bananes :
  // Descente :
  yBanane = yBanane + 8 * vitesse;
  //Rotation :
  angle = angle + 0.01;
  if (angle > 2*PI) angle = 0;
  pushMatrix();  
  translate(xRandom, yBanane);
  rotate(angle); 
  image(Banane, 0, 0); 
  popMatrix();
  // Collisions :
  if (xRandom + wBanane > xNessie &&
    xRandom < xNessie + wNessie &&
    yBanane + hBanane > yNessie &&
    yBanane < yNessie + hNessie) {
    score = score+2;
    yBanane = 1000;
    xRandom = (int)random(50, 910);
    if (PoBa >=0.5) {
      yPomme = -100;
    }
    if (PoBa < 0.5 && PoBa >0.03) {
      yBanane = -100;
    }
    if (PoBa <= 0.03) {
      yEtoile = -100;
    }
  }
  // Etoile
  //Descente : 
  yEtoile = yEtoile +3;
  // Rotation : 
  angle = angle + 0.01;
  if (angle > 2*PI) angle = 0;
  pushMatrix();  
  translate(xRandom, yEtoile);
  rotate(angle); 
  image(Etoile, 0, 0); 
  popMatrix();
  // Collisions : 
  if (xRandom + wEtoile > xNessie &&
    xRandom < xNessie + wNessie &&
    yEtoile + hEtoile > yNessie &&
    yEtoile < yNessie + hNessie) {
    vies = vies+1;
    yEtoile = 1000;
    xRandom = (int)random(50, 910);
    if (PoBa >=0.5) {
      yPomme = -100;
    }
    if (PoBa < 0.5 && PoBa >0.03) {
      yBanane = -100;
    }
    if (PoBa <= 0.03) {
      yEtoile = -100;
    }
  }
  // Apparition Fruit suivant si l'on rate le fruit :
  // Banane ratée :
  if (yBanane >= height && yBanane < 1000) {
    vies = vies - 1;
    yBanane = 1000;
    xRandom = (int)random(50, 910);
    if (PoBa >=0.5) {
      yPomme = -100;
    }
    if (PoBa < 0.5 && PoBa >0.03) {
      yBanane = -100;
    }
    if (PoBa <= 0.03) {
      yEtoile = -100;
    }
  }
  // Pomme ratée :
  if (yPomme >= height && yPomme < 1000) {
    vies = vies - 1;
    yPomme = 1000;
    xRandom = (int)random(50, 910);
    if (PoBa >=0.5) {
      yPomme = -100;
    }
    if (PoBa < 0.5 && PoBa >0.03) {
      yBanane = -100;
    }
    if (PoBa <= 0.03) {
      yEtoile = -100;
    }
  }
  // Etoile ratée :
  if (yEtoile >= height && PoBa >= 0.5 && yEtoile < 1000) {
    vies = vies - 1;
    yEtoile = 1000;
    xRandom = (int)random(50, 910);
    if (PoBa >=0.5) {
      yPomme = -100;
    }
    if (PoBa < 0.5 && PoBa >0.03) {
      yBanane = -100;
    }
    if (PoBa <= 0.03) {
      yEtoile = -100;
    }
  }
  // Texte :
  textSize(50);
  fill(255, 255, 255);
  text("Score : " + score, xScore, 50);
  text("Vies : " + vies, xVies, 50);

  // Victoire : 
  if (score >= 50) {
    text("Vous Avez Gagné", width/3 - 50, height*3/4);
    xNessie = width/2;
    yNessie = height/2;
    yPomme = 1000;
    yBanane = 1000;
    yK = yK + 5;
    yC = yC + 3;
    image(Kilt, xRandom, yK);
    image(Cornemuse, xRandom, yC);
    if (mousePressed) {
      mode = 1;
      initialisation();
  }
  }
  // Game Over :
  if (vies == 0) {
    text("GAME OVER", width/3, height/2);
    xNessie = 5000;
    yPomme = 1000;
    yBanane = 1000;
    yEtoile = 1000;
    musiqueDeFond.stop();
    //Illuminati :
    image(Illuminati, xIllu, height/2);
    xIllu = xIllu + 3;
    if (mousePressed) {
      mode = 1;
      initialisation();
    }
  }
}
  

void keyPressed() {
  if (keyCode == RIGHT) { 
    right = true;
  }
  if (keyCode == LEFT ) { 
    left = true;
  }
}
void keyReleased() {
  if (keyCode == LEFT) { 
    left = false;
  }
  if (keyCode == RIGHT) { 
    right = false;
  }
}

void initialisation() {
  
  xRandom = (int)random(50, 910);
  yPomme = -100; 
  wPomme = 157/2;
  hPomme = 200/2;
  yBanane = 1000;
  wBanane = 89.5;
  hBanane = 88;
  yEtoile = 1000;
  wEtoile = 400/2;
  hEtoile = 400/2;
  xNessie = 490;
  yNessie = 678 - (174/2*1.25);
  wNessie = 179*1.25;
  hNessie = 174*1.25;
 xIllu = -300;
 yC = -100;
 yK = -100;
 score = 0;
 xScore = 50;
 vies = 3;
 xVies = 760;
 ydepart = 0;
 angle = 0;
 
}

void drawMode3() {
int r =0;
int g =0;
int b =0;

if(mouseY>= 450) {
  r =255;
  g = 0;
  b = 0;
}
if(mouseY < 450 && mouseY > 225) {
  g = 255;
  r =0;
  b =0;
}
if(mouseY <= 225) {
  b = 255;
  r =0;
  g =0;
}

  background(255,255,255);
  strokeWeight(30);
  stroke(r,g,b);
  
  point(mouseX, mouseY);
  
for (int i =30 ; i <= 930 ; i=i+30) {
  point(i,100);
  point(i,200);
  point(i,300);
  point(i,400);
  point(i,500);
  point(i,600);
}

}

//import processing.sound.*;
//SoundFile file;
int rect1Y=250;
int rect2Y=250;
float ballX=400;
float ballY=250;
float ballXC;
float ballYC;
float ballA;
int ballS=8;
int rect1S=6;
int rect2S=5;
int point1=0;
int point2=0;
boolean won=false;
boolean lost=false;
int server=0;
boolean start=false;

void setup() {
  size(800, 500);
  serve();
}

void draw() {
  if (lost==false && won==false && start==false) {
    startScreen();
  } else if (start&& lost==false && won==false) {
    gameScreen();
  } else if (lost) {
    loseScreen();
  } else if (won) {
    winScreen();
  }
}

void gameScreen() {
  gameBackground();
  scoreBoard();
  mouseUpdate();
  rect1();
  rect2();
  rect2Update();
  ballUpdate();
  ball();
  ballOut();
}

void gameBackground() {
  background(0);
  for (int i=50; i<500; i+=50) {
    fill(255);
    rect(400, i, 5, 30);
  }
  stroke(255);
  strokeWeight(2);
  noFill();
  rect(400, 250, 750, 450);
  noStroke();
}

void rect1() {
  noStroke();
  fill(255);
  rectMode(CENTER);
  rect(50, rect1Y, 10, 100);
}

void rect2() {
  noStroke();
  fill(255);
  rectMode(CENTER);
  rect(750, rect2Y, 10, 100);
}

void serve() {
  if (server%2==1) {
    ballA=random(230, 310);
    ballX=600;
    ballY=250;
  } else {
    ballA=random(50, 130);
    ballX=200;
    ballY=250;
  }
  server++;
}

void ballUpdate() {
  ballA=ballA%360;
  ballWallCollide();
  ballPlatformCollide();
  if (ballA<=90) {
    ballXC=ballS*(sin(radians(ballA)));
    ballYC=-ballS*(cos(radians(ballA)));
    //println("uno");
  } else if (ballA<180) {
    ballXC=ballS*(cos(radians(ballA%90)));
    ballYC=ballS*(sin(radians(ballA%90)));
    //println("dos");
  } else if (ballA<270) {
    ballXC=-ballS*(sin(radians(ballA%90)));
    ballYC=ballS*(cos(radians(ballA%90)));
    //println("tres");
  } else if (ballA<360) {
    ballXC=-ballS*(cos(radians(ballA%90)));
    ballYC=-ballS*(sin(radians(ballA%90)));
    //println("quatro");
  }
  ballX+=ballXC;
  ballY+=ballYC;
}

void ballWallCollide() {
  if (ballY>450) {
    //println(ballA);
    if (ballA>180) {
      ballA=360-(ballA-180);
    } else {
      ballA=180-ballA;
    }
  } else if (ballY<=50) {
    //println(ballA);
    if (ballA>270) {
      ballA=270-(ballA-270);
    } else {
      ballA=180-ballA;
    }
  }
}

void ballPlatformCollide() {
  if (ballX<=60 && ballX>=45 && abs(ballY-rect1Y)<55) {
    if (ballY-rect1Y>5) {
      ballA=random(140, 160);
    } else if (ballY-rect1Y<5) {
      ballA=random(50, 70);
    }
    if (abs(ballY-rect1Y)<5) {
      //println("hi");
      ballA=random(85, 95);
    }
  }

  if (ballX>=740 && ballX<=755 && abs(ballY-rect2Y)<55) {
    if (ballY-rect2Y>20) {
      ballA=random(230, 250);
      //println("1");
    } else if (ballY-rect2Y<20) {
      ballA=random(320, 340);
      //println("2");
    } 
    if (abs(ballY-rect2Y)<5) {
      //println("hi");
      ballA=random(265, 275);
    }
  }
}

void ballOut() {
  if (ballX<5) {
    point2++;
    serve();
    if (point2==11) {
      println("YOU LOST HAHAHAHHAHAA");
      gameScreen();
      lost=true;
    }
  }
  if (ballX>795) {
    point1++;
    serve();
    if (point1==11) {
      println("u won ggs");
      gameScreen();
      won=true;
    }
  }
}

void ball() {
  fill(255);
  rect(ballX, ballY, 10, 10);
}

void scoreBoard() {
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(point1, 300, 100);
  text(point2, 500, 100);
  noFill();
}

void loseScreen() {
  fill(255);
  textSize(90);
  textAlign(CENTER, CENTER);
  text("YOU LOST", 400, 250);
  noFill();
}

void winScreen() {
  fill(255);
  textSize(90);
  textAlign(CENTER, CENTER);
  text("YOU WON", 400, 250);
  noFill();
}

void startScreen() {
  background(0);
  fill(255);
  textSize(90);
  textAlign(CENTER, CENTER);
  text("Pong", 400, 150);
  textSize(40);
  text("Made in 4 hours", 400, 250);
  textSize(20);
  text("Use mouse to control platform", 400, 310);
  textSize(20);
  text("Press space to start", 400, 350);
  stroke(255);
  strokeWeight(4);
  noFill();
  rectMode(CENTER);
  rect(400, 160, 300, 100);
  noStroke();
  fill(255);
  textSize(20);
  text("Created by Henry Zhang", 400, 450);
  noFill();
}

void keyPressed() {
  //println(keyCode);
  switch(keyCode) {
  case 87: //w
    if (rect1Y>80) {
      rect1Y-=10;
    }
    //println("up");
    break;
  case 83: //s
    if (rect1Y<420) {
      rect1Y+=10;
    }
    //println("down");
    break;
  case 32: //space
    start=true;
    /*
  case 38: //w=up
     if (rect2Y>80) {
     rect2Y-=10;
     }
     //println("up");
     break;
     case 40: //down
     if (rect2Y<420) {
     rect2Y+=10;
     }
     //println("down");
     break;*/
  }
}

void mouseUpdate() {
  if (mousePressed) {
    if (mouseY-rect1Y>rect1S) {
      if (rect1Y<405) {
        rect1Y+=rect1S;
      }
    } else if (mouseY-rect1Y<-rect1S) {
      if (rect1Y>90) {
        rect1Y-=rect1S;
      }
    }
  }
}

void rect2Update() {
  if (ballY-rect2Y>=rect2S) {
    if (rect2Y<405 && ballX>400) {
      rect2Y+=rect2S;
    }
  } else if (ballY-rect2Y<=-rect2S) {
    if (rect2Y>90 && ballX>400) {
      rect2Y-=rect2S;
    }
  }
}

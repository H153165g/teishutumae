//boolean mouseWasPressed = false;
Fruits draggedFruit = null;

public class Window {
  private float wx, wy, ww, wh;
  private PFont font;
  private color backgroundColor, black, white, yellow, blue, red;

  Window() {
    wx = width / 2;
    wy = height / 2;
    ww = 150;
    wh = 50;
    font = createFont("HGP創英角ポップ体", 30);
    black = color(0, 0, 0);
    white = color(255, 255, 255);
    yellow = color(255, 255, 0);
    blue = color(0, 0, 255);
    red = color(255, 0, 0);
    backgroundColor = color(200, 220, 255);
  }

  public void startWindow() {
    background(backgroundColor);

    textFont(font);
    textAlign(CENTER, CENTER);

    rectMode(CENTER);

    //startボタン
    if (!inOrOut(wx, wy + 60, ww, wh)) {
      fill(blue);
    } else {
      fill(yellow);
      //if (mousePressed) {
        //scene = 1;
      //}
    }
    rect(wx, wy + 60, ww, wh, 10);

    fill(white);
    textSize(30);
    text("Start", wx, wy + 60);

    //ruleボタン
    if (!inOrOut(wx, wy + 140, ww, wh)) {
      fill(blue);
    } else {
      fill(yellow);
      //if (mousePressed) {
        //scene = 2;
      //}
    }
    rect(wx, wy + 140, ww, wh, 10);

    fill(white);
    textSize(30);
    text("Rule", wx, wy + 140);

    //タイトル
    fill(black);
    textSize(60);
    text("フルーツゲーム", width/2, height/2 - 100);
  }

  /*
  public boolean inOrOut(float x, float y, float w, float h) {
   float left = x - w/2;
   float right = x + w/2;
   float top = y - h/2;
   float bottom = y + h/2;
   
   if (left <= mouseX && mouseX <= right && top <= mouseY && mouseY <= bottom) {
   return true;
   } else {
   return false;
   }
   }*/

  public void ruleWindow() {
    background(backgroundColor);

    textFont(font);
    textAlign(CENTER, CENTER);

    rectMode(CENTER);

    //startボタン
    if (!inOrOut(wx, wy + 60, ww, wh)) {
      fill(blue);
    } else {
      fill(yellow);
      //if (mousePressed) {
        //scene = 1;
      //}
    }
    rect(wx, wy + 60, ww, wh, 10);

    fill(white);
    textSize(30);
    text("Start", wx, wy + 60);

    //homeボタン
    if (!inOrOut(wx, wy + 140, ww, wh)) {
      fill(blue);
    } else {
      fill(yellow);
      //if (mousePressed) {
        //scene = 0;
      //}
    }
    rect(wx, wy + 140, ww, wh, 10);

    fill(white);
    textSize(30);
    text("Home", wx, wy + 140);

    //ruleのヘッダー
    fill(black);
    textSize(60); // 大きなフォントサイズでルールの見出しを強調
    text("ルール", width/2, height/2 - 100);

    textSize(20);
    text("落ちてくる果物をドラックアンドドロップして、籠に仕分けよう！", width / 2, height / 2 - 30);
  }

  public void gameWindow() {
    background(0);
    fill(0);
    text("game", width/2, height/2);

    generateFruit();
    for(int i=hands.size()-1;i>=0;i--){
      hand a=hands.get(i);
      a.display();
    }

    for (int i = fruits.size() - 1; i >= 0; i--) {
      Fruits fruit = fruits.get(i);
      fruit.fall();
      fruit.display();

      // Check collision with the wall
      if (wall.collision(fruit)) {
        mistakes++;
        bgm4.play();
        fruits.remove(i);
      } else {
        boolean collected = false;
        for (Basket basket : baskets) {
          if (basket.collect(fruit)) {
            if (basket.fallbackColor == fruit.fallbackColor) {
              score++;
            } else {
              mistakes++;
            }
            fruits.remove(i);
            collected = true;
            break;
          }
        }
      }
      if (mistakes >= 10) {
        //fill(255, 0, 0);
        //textSize(32);
        //text("Game Over", width/2 - 80, height/2);
        //noLoop();
        scene = 3;
        bgm5.play();
        bgm1.stop();
      }
    }

    for (Basket basket : baskets) {
      basket.display();
    }

    fill(255);
    textSize(16);
    text("Score: " + score, 10, 20);
    text("Mistakes: " + mistakes, 10, 40);
  }
  

  private void generateFruit() {
    if (frameCount % 60 == 0) {
      int r = int(random(4));
      PImage img = null;
      PImage img2=null;
      color fallbackColor;

      if (r == 0) {
        img = loadImage("apple.png");
        img2=loadImage("hotyou.png");
        fallbackColor = color(255, 0, 0);
      } else if (r == 1) {
        img = loadImage("grape.png");
        img2=loadImage("zugai.jpg");
        fallbackColor = color(128, 0, 128);
      } else if (r == 2) {
        img = loadImage("orange.png");
        img2=loadImage("doll.jpg");
        fallbackColor = color(255, 165, 0);
      } else {
        img = loadImage("pineapple.png");
        img2=loadImage("eye.png");
        fallbackColor = color(255, 255, 0);
      }

      fruits.add(new Fruits(random(width), 0, 2, 50, 50, img,img2, fallbackColor));
    }
  }

  public void endWindow() {
    
    background(50); // ダークグレーの背景で、メッセージを目立たせる

    textFont(font);
    textAlign(CENTER, CENTER);

    fill(red); // 赤い文字で「Game Over」を強調
    textSize(60); // 大きなフォントサイズで強調
    text("Game Over", width / 2, height / 2 - 100); // 画面中央より少し上に配置
    
    //restartボタン
    if (!inOrOut(wx, wy + 60, ww, wh)) {
      fill(red);
    } else {
      fill(yellow);
      //if (mousePressed) {
        //scene = 1;
      //}
    }
    rect(wx, wy + 60, ww, wh, 10);

    fill(white);
    textSize(30);
    text("Restart", wx, wy + 60);

    //homeボタン
    if (!inOrOut(wx, wy + 140, ww, wh)) {
      fill(red);
    } else {
      fill(yellow);
      //if (mousePressed) {
        //scene = 0;
      //}
    }
    rect(wx, wy + 140, ww, wh, 10);

    fill(white);
    textSize(30);
    text("Home", wx, wy + 140);

    // ゲームの状態をリセット
    
    score = 0;
    mistakes = 0;
  }
}

public boolean inOrOut(float x, float y, float w, float h) {
  float left = x - w/2;
  float right = x + w/2;
  float top = y - h/2;
  float bottom = y + h/2;

  if (left <= mouseX && mouseX <= right && top <= mouseY && mouseY <= bottom) {
    return true;
  } else {
    return false;
  }
}

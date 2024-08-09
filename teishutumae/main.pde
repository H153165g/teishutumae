import processing.sound.*;
ArrayList<hand> hands;
ArrayList<Basket> baskets;
ArrayList<Fruits> fruits;
Wall wall;
Window window;

SoundFile bgm1;
SoundFile bgm2;
SoundFile bgm3;
SoundFile bgm4;
SoundFile bgm5;
SoundFile bgm6;

PImage appleImg, grapeImg, orangeImg, pineappleImg, handImg, GameoverImg, horaImg, hotyouImg, zugaiImg, dollImg, eyeImg, backgroundImg;

int score;
int mistakes;
int scene;

boolean isPlaying = false;

int func; //これ何？

void setup() {
  size(800, 600);
  bgm1 = new SoundFile(this, "pom_pom_shower.mp3");
  bgm1.loop();
  bgm2=new SoundFile(this, "りんごをかじる音.mp3");
  bgm3=new SoundFile(this, "正解・ピンポン音.mp3");
  bgm4=new SoundFile(this, "3_ahhahha.wav");
  bgm5=new SoundFile(this, "arigato.wav");
  bgm6=new SoundFile(this, "グロテスクな音.mp3");

  func=20;
  fruits = new ArrayList<Fruits>();
  baskets = new ArrayList<Basket>();
  hands=new ArrayList<hand>();
  wall = new Wall(0, height, width, 1);
  window = new Window();

  appleImg = loadImage("apple.png");
  grapeImg = loadImage("grape.png");
  orangeImg = loadImage("orange.png");
  pineappleImg = loadImage("pineapple.png");
  handImg=loadImage("hand.jpg");
  GameoverImg=loadImage("Gameover.png");
  horaImg=loadImage("hora.jpg");
  hotyouImg=loadImage("hotyou.png");
  zugaiImg=loadImage("zugai.jpg");
  dollImg=loadImage("doll.jpg");
  eyeImg=loadImage("eye.png");

  color appleColor = color(255, 0, 0);
  color grapeColor = color(128, 0, 128);
  color orangeColor = color(255, 165, 0);
  color pineappleColor = color(255, 255, 0);

  baskets.add(new Basket(width/2 - 350, height - 100, 100, 100, "apple", appleImg, hotyouImg, appleColor));
  baskets.add(new Basket(width/2 - 150, height - 100, 100, 100, "grape", grapeImg, zugaiImg, grapeColor));
  baskets.add(new Basket(width/2 + 50, height - 100, 100, 100, "orange", orangeImg, dollImg, orangeColor));
  baskets.add(new Basket(width/2 + 250, height - 100, 100, 100, "pineapple", pineappleImg, eyeImg, pineappleColor));

  score = 0;
  mistakes = 0;
  scene = 0;
  //Fruits draggedFruit = null;
}

void draw() {
  //print(scene);
  if (scene == 0) {
    window.startWindow();
  } else if (scene == 1) {
    window.gameWindow();
  } else if (scene == 2) {
    window.ruleWindow();
  } else {
    window.endWindow();
  }
}

void mouseClicked() {
  if (scene == 0) {
    if (inOrOut(window.wx, window.wy + 60, window.ww, window.wh)) {
      scene=1;
    } else if (inOrOut(window.wx, window.wy + 140, window.ww, window.wh)) {
      scene=2;
    }
  } else if (scene == 2) {
    if (inOrOut(window.wx, window.wy + 60, window.ww, window.wh)) {
      scene=1;
    } else if (inOrOut(window.wx, window.wy + 140, window.ww, window.wh)) {
      scene = 0;
    }
  } else if (scene == 3) {
    if (inOrOut(window.wx, window.wy + 60, window.ww, window.wh)) {
      bgm1.play();
      scene=1;
    } else if (inOrOut(window.wx, window.wy + 140, window.ww, window.wh)) {
      scene = 0;
      bgm1.play();
    }
  }
}

void mousePressed() {
  for (Basket basket : baskets) {
    basket.fallbackColor = randomFruitColor(basket.fn);
    //basket.img = null; // 画像をクリアして色のみを表示
  }
  for (Fruits fruit : fruits) {
    // マウスの位置がフルーツの範囲内にある場合にドラッグを開始する
    if (fruit.x <= mouseX && mouseX <= fruit.x + fruit.fw &&
      fruit.y <= mouseY && mouseY <= fruit.y + fruit.fh) {
      fruit.startDragging();
      if (fruit.dragging) {
        draggedFruit = fruit; // ドラッグ中のフルーツを設定
        if (!isPlaying) {
          if (score>=func) {
            bgm1.stop();
            bgm6.play();
          } else {
            bgm2.play(); // ドラッグ開始時に音を再生
          }
        } else {
          bgm6.stop();
        }
        break;
      }
    }
  }
}

void mouseDragged() {
  if (draggedFruit != null) {
    draggedFruit.drag(); // ドラッグ中のフルーツをドラッグ
    isPlaying = true; // 音声の再生状態を更新
  }
}

void mouseReleased() {
  if (draggedFruit != null) {
    draggedFruit.stopDragging(); // ドラッグを終了
    draggedFruit = null; // ドラッグ中のフルーツをリセット
    isPlaying=false;
    if (score>=func) {
      hands.add(new hand(random(width), random(height), 2, 50, 50, handImg,handImg, color(255, 0, 0)));
    }
  }
}

color randomFruitColor(String fruitName) {
  if (fruitName.equals("apple")) return color(255, 0, 0);
  if (fruitName.equals("grape")) return color(128, 0, 128);
  if (fruitName.equals("orange")) return color(255, 165, 0);
  if (fruitName.equals("pineapple")) return color(255, 255, 0);
  return color(255); // デフォルトの色（白）
}

void keyPressed() {
  if (key == 'h' || key == 'H') {
    scene = 0;
  }
  if (key == 'r' || key == 'R') {
    scene = 1;
  }
}

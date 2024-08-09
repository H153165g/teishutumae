class Fruits extends Object {
  float x, y;
  int dy;
  int fw, fh;
  PImage img;
  PImage img2;
  color fallbackColor;
  boolean dragging = false; // ドラッグ中かどうかを示すフラグ
  float offsetX, offsetY; // ドラッグのオフセット

  Fruits(float x0, float y0, int dy0, int fw0, int fh0, PImage img0,PImage img1 ,color fallbackColor0) {
    x = x0;
    y = y0;
    dy = dy0;
    fw = fw0;
    fh = fh0;
    img = img0;
    img2=img1;
    fallbackColor = fallbackColor0;
  }

  void display() {
    if(score>=func){
      image(img2, x, y, fw, fh);
    } else {
      image(img,x,y,fw,fh);
    }
  }

  void fall() {
    if (!dragging) { // ドラッグ中は落下しない
      y += dy;
    }
  }

  boolean isCollidingWith(Basket basket) {
    return (x < basket.bx + basket.bw &&
      x + fw > basket.bx &&
      y + fh > basket.by &&
      y < basket.by + basket.bh);
  }

  boolean isCollidingWith(Wall wall) {
    return (x < wall.wx + wall.ww &&
      x + fw > wall.wx &&
      y < wall.wy + wall.wh &&
      y + fh > wall.wy);
  }

  void startDragging() {
    if (mouseX >= x && mouseX <= x + fw && mouseY >= y && mouseY <= y + fh) {
      dragging = true;
      offsetX = mouseX - x;
      offsetY = mouseY - y;
    }
  }

  void drag() {
    if (dragging) {
      x = mouseX - offsetX;
      y = mouseY - offsetY;
    }
  }

  void stopDragging() {
    dragging = false;
  }
}

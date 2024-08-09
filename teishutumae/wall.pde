class Wall {
  float wx, wy, ww, wh;

  Wall(float wx0, float wy0, float ww0, float wh0) {
    wx = wx0;
    wy = wy0;
    ww = ww0;
    wh = wh0;
  }

  boolean collision(Fruits fruit) {
    return (fruit.x + fruit.fw > wx && fruit.x < wx + ww && fruit.y + fruit.fh > wy && fruit.y < wy + wh);
  }
}

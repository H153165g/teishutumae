class Basket extends Object{
  float bx, by;
  int bw, bh;
  String fn;
  PImage img;
  PImage img2;
  color fallbackColor;

  Basket(float bx0, float by0, int bw0, int bh0, String fn0, PImage img0, PImage img1, color fallbackColor0) {
    bx = bx0;
    by = by0;
    bw = bw0;
    bh = bh0;
    fn = fn0;
    img = img0;
    img2 = img1;
    fallbackColor = fallbackColor0;
  }

  void display() {
    if (score < 20) {
      image(img, bx, by, bw, bh);
    } else {
      image(img2, bx, by, bw, bh);
    }
  }

  boolean collect(Fruits fruit) {
    // フルーツがバスケットの範囲内にあるかどうかをチェック
    return (fruit.x + fruit.fw > bx &&
      fruit.x < bx + bw &&
      fruit.y + fruit.fh > by &&
      fruit.y < by + bh);
  }
}

abstract class EffectAbstract {
  //生成された座標
  protected int x;
  protected int y;
  //色の値
  protected int g_c = 255;
  protected int b_c = 0;
  //薄くしていく値
  private int delta_g_c = 3;
  private int delta_b_c = 0;
  //外側の大きさ
  protected int r = 60;
  //内側の大きさ
  protected int in_r = 30;
  //大きくしていく値
  private int delta_r = 4;
  private int delta_in_r = 4;
  //線の太さ
  protected int line_width = 15;

  EffectAbstract(int temp_x, int temp_y) {
    this.x = temp_x;
    this.y = temp_y;
  }

  void display() {
    fill(0, this.g_c, this.b_c);
    this.displayFigure();
    this.r += this.delta_r;
    this.in_r += this.delta_in_r;
    this.g_c -= this.delta_g_c;
//    this.b_c -= this.delta_b_c;
  }

  abstract void displayFigure();

  boolean finished() {
    if (this.g_c <= 50) {
      return true;
    }
    else {
      return false;
    }
  }

  float getX(int deg) {
    return this.x - this.r * cos_list[deg];
  }

  float getY(int deg) {
    return this.y - this.r * sin_list[deg];
  }

  float getMinX(int deg) {
    return this.x - this.in_r * cos_list[deg];
  }

  float getMinY(int deg) {
    return this.y - this.in_r * sin_list[deg];
  }
}


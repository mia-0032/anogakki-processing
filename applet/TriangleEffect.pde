class TriangleEffect extends EffectAbstract{
  //半径rの円に内接する三角形
  private int r;
  private int current_deg;

  private int delta_c;
  private int delta_r;
  private int delta_deg;

  private int rotated_x;
  private int rotated_y;
  
  TriangleEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.r = 10;
    this.c = 255;
    this.current_deg = 0;
    this.delta_r = 10;
    this.delta_c = 5;
    this.delta_deg = 5;
  }
  
  void display(){
    stroke(0, this.c, this.c);
    triangle(this.getX(current_deg), this.getY(current_deg),
             this.getX(current_deg + 120), this.getY(current_deg + 120),
             this.getX(current_deg + 240), this.getY(current_deg + 240));
    this.r += this.delta_r;
    this.c -= this.delta_c;
    this.current_deg += this.delta_deg;
  }
  
  float getX(int deg){
    return this.x - this.r * cos(radians(deg));
  }
  
  float getY(int deg){
     return this.y - this.r * sin(radians(deg));
  }
}

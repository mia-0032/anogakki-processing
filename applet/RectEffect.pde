class RectEffect extends EffectAbstract{
  private int l;
  private int current_deg;

  private int delta_c;
  private int delta_l;
  private int delta_deg;

  private int rotated_x;
  private int rotated_y;
  
  RectEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.l = 10;
    this.c = 255;
    this.current_deg = 0;
    this.delta_l = 10;
    this.delta_c = 5;
    this.delta_deg = 5;
  }
  
  void display(){
    stroke(0, this.c, this.c);
    translate(this.x, this.y);
    rotate(radians(current_deg));
    rect(0, 0, this.l, this.l);
    resetMatrix();
    this.l += this.delta_l;
    this.c -= this.delta_c;
    this.current_deg += this.delta_deg;
  }
}

class CircleEffect extends EffectAbstract{
  private int r;
  private int delta_c;
  private int delta_r;
  
  CircleEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.r = 10;
    this.c = 255;
    this.delta_r = 20;
    this.delta_c = 5;
  }
  
  void display(){
    stroke(0, this.c, this.c);
    ellipse(this.x, this.y, this.r, this.r);
    this.r += this.delta_r;
    this.c -= this.delta_c;
  }
}

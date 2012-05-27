class N_PolygonEffect extends EffectAbstract {
  private int current_deg = 0;
  private int delta_deg = 3;
  private int side_num;
  private int side_angle;

  N_PolygonEffect(int temp_x, int temp_y, int temp_side_num) {
    super(temp_x, temp_y);
    //頂点数を格納
    this.side_num = temp_side_num;
    //頂点の角度
    this.side_angle = ceil(360/temp_side_num);
  }

  void displayFigure() {
    beginShape(QUADS);    
    vertex(this.getX(current_deg), this.getY(current_deg));
    vertex(this.getMinX(current_deg), this.getMinY(current_deg));
      
    for (int i = this.side_angle; i < 360; i+= this.side_angle) {
      int deg = current_deg + i;

      if(deg >= 360){
        deg -= 360;
      }
      vertex(this.getMinX(deg), this.getMinY(deg));
      vertex(this.getX(deg), this.getY(deg));
      vertex(this.getX(deg), this.getY(deg));
      vertex(this.getMinX(deg), this.getMinY(deg));
    }

    vertex(this.getMinX(current_deg), this.getMinY(current_deg));
    vertex(this.getX(current_deg), this.getY(current_deg));

    endShape();

    this.current_deg += this.delta_deg;
    if(this.current_deg >= 360){
      this.current_deg -= 360;
    }
  }
}


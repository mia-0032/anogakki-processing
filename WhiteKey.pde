class WhiteKey extends KeyAbstract {
//  private boolean hasBlack;

  WhiteKey(int temp_key_num, int temp_sound_num) {
    super(temp_sound_num);
    super.setX(white_key_width * temp_key_num, white_key_width * (temp_key_num + 1));
//    if (temp_key_num%7 != 0 && temp_key_num%7 != 3) {
//      this.hasBlack = true;
//    }
//    else {
//      this.hasBlack = false;
//    }
  }

  void display() {
    super.keyFill();
    beginShape(QUADS);
    vertex(this.x1, 0);
    vertex(this.x1, height);
    vertex(this.x2, height);
    vertex(this.x2, 0);
    endShape();
  }
}


class WhiteKey extends KeyAbstract {
  private boolean has_black;

  WhiteKey(int temp_key_num, int temp_sound_num) {
    super(temp_sound_num);
    super.setX(white_key_width * temp_key_num, white_key_width * (temp_key_num + 1));
    if (temp_key_num%7 != 2 && temp_key_num%7 != 6) {
      this.has_black = true;
    }
    else {
      this.has_black = false;
    }
  }

  void display() {
    super.keyFill();
    noStroke();
    beginShape();
    vertex(this.x1, 0);
    vertex(this.x1, height);
    vertex(this.x2, height);
    vertex(this.x2, 0);
    endShape(CLOSE);
    stroke(0, 80, 0);
    beginShape();
    if (this.has_black) {
      vertex(this.x2, half_height);
    }
    else {
      vertex(this.x2, 0);
    }
    vertex(this.x2, height);
    endShape(CLOSE);
  }
}


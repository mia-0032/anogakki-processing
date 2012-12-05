class BlackKey extends KeyAbstract {

  BlackKey(int temp_key_num, int temp_sound_num) {
    super(temp_sound_num);
    temp_key_num++;
    super.setX(white_key_width * temp_key_num - black_key_width/2, white_key_width * temp_key_num + black_key_width/2);
  }

  void display() {
    super.keyFill();
    stroke(0, 80, 0);
    rect(this.x1, 0, this.x2, half_height);
  }
}

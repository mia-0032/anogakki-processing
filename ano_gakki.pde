import promidi.*;

import processing.opengl.*;

//midi出力クラス
//SoundCipher sc;
MidiIO midiIO;
MidiOut midiOut;

//キャッシュ
float[] sin_list = new float[360];
float[] cos_list = new float[360];
int half_height;

//オクターブ数
int octave_num = 4;

//鍵盤数
int sum_key_num;
int white_key_num;
int black_key_num;

//鍵盤の幅
float white_key_width;
float black_key_width;

//エフェクト格納
ArrayList effects;
//鍵盤格納
ArrayList white_keys;
ArrayList black_keys;

void setup() {
  //画面初期化
  size(2000, 700, OPENGL);
  //各数値の計算
  half_height = ceil(height/2 * 0.9);
  sum_key_num = octave_num * 12 + 1;
  white_key_num = octave_num * 7 + 1;
  black_key_num = octave_num * 5;
  white_key_width = width / white_key_num;
  black_key_width = 0.8 * white_key_width;
  //オブジェクト格納変数初期化
  effects = new ArrayList();
  white_keys = new ArrayList();
  black_keys = new ArrayList();
  int j = 0;
  for (int i = 0;i < white_key_num;i++) {
    white_keys.add(new WhiteKey(i, j));
    j++;
    if (i%7 != 2 && i%7 != 6) {
      black_keys.add(new BlackKey(i, j));
      j++;
    }
  }
  //sinとcosの値をキャッシュ
  for (int i = 0;i < 360;i++) {
    sin_list[i] = sin(radians(i));
    cos_list[i] = cos(radians(i));
  }
  //midi出力
  midiIO = MidiIO.getInstance(this);
  midiIO.printDevices();
  midiOut = midiIO.getMidiOut(0,2);
}

void draw() {
  background(0);
  stroke(0, 80, 0);
  for (int i = 0;i < white_key_num;i++) {
    KeyAbstract white_key = (KeyAbstract) white_keys.get(i);
    white_key.display();
  }
  for (int i = 0;i < black_key_num;i++) {
    KeyAbstract black_key = (KeyAbstract) black_keys.get(i);
    black_key.display();
  }
  noStroke();
  for (int i = 0;i < effects.size(); i++) {
    EffectAbstract effect = (EffectAbstract) effects.get(i);
    effect.display();
    if (effect.finished()) {
      effects.remove(i);
    }
  }
}

void mousePressed() {
  checkKeyPress();
  switch(frameCount%6) {
    //  switch(3){
  case 0:
    effects.add(new CircleEffect(mouseX, mouseY));
    break;
  case 1:
    effects.add(new LineEffect(mouseX, mouseY));
    break;
  case 3:
    effects.add(new N_PolygonEffect(mouseX, mouseY, 3));
    break;
  case 4:
    effects.add(new N_PolygonEffect(mouseX, mouseY, 4));
    break;
  case 5:
    effects.add(new N_PolygonEffect(mouseX, mouseY, 5));
    break;
  default:
  }
  previous_x = mouseX;
}

int previous_x = 0;
void mouseDragged() {
  if (abs(mouseX - previous_x) > white_key_width) {
    checkKeyPress();
    effects.add(new N_PolygonEffect(mouseX, mouseY, 4));
    previous_x = mouseX;
  }
}

void checkKeyPress() {
  if (mouseY <= half_height) {
    for (int i = 0;i < black_key_num;i++) {
      KeyAbstract black_key = (KeyAbstract) black_keys.get(i);
      black_key.pressed(mouseX);
    }
  }
  else {
    for (int i = 0;i < white_key_num;i++) {
      KeyAbstract white_key = (KeyAbstract) white_keys.get(i);
      white_key.pressed(mouseX);
    }
  }
}

void mouseReleased() {
  previous_x = 0;
}


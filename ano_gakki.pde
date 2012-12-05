import promidi.*;

import processing.opengl.*;

//midi出力クラス
MidiIO midi_io;
MidiOut midi_out;

//キャッシュ
float[] sin_list = new float[360];
float[] cos_list = new float[360];
int half_height;

//オクターブ数
int octave_num = 2;

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

//前に押された鍵盤
int previous_key = -1;

void setup() {
  //画面初期化(あの楽器のディスプレイの大きさに合わせてある)
  size(2056, 700, P3D);
  noCursor();
  rectMode(CORNERS);
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
  midi_io = MidiIO.getInstance(this);
  midi_io.printDevices();
  midi_out = midi_io.getMidiOut(0, 2);
}

void draw() {
  background(0);
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
  if (checkKeyPress()) {
    switch(frameCount%5) {
    case 0:
      effects.add(new CircleEffect(mouseX, mouseY));
      break;
    case 1:
      effects.add(new LineEffect(mouseX, mouseY));
      break;
    case 2:
      effects.add(new N_PolygonEffect(mouseX, mouseY, 3));
      break;
    case 3:
      effects.add(new N_PolygonEffect(mouseX, mouseY, 4));
      break;
    case 4:
      effects.add(new N_PolygonEffect(mouseX, mouseY, 5));
      break;
    default:
    }
  }
}

void mouseDragged() {
    if (checkKeyPress()) {
      //ほんとは星とかきれいそう
      effects.add(new N_PolygonEffect(mouseX, mouseY, 4));
    }
}

/**
 * どの鍵盤が押されたかチェックする関数
 **/
boolean checkKeyPress() {
  boolean result = false;
  //上半分だと黒鍵盤、下半分だと白鍵盤
  if (mouseY <= half_height) {
    for (int i = 0;i < black_key_num;i++) {
      //マウスドラッグ時に同じ音が連続ででないようにする
      if (previous_key == i) {
        continue;
      }
      KeyAbstract black_key = (KeyAbstract) black_keys.get(i);
      result = black_key.pressed(mouseX);
      if (result == true) {
        previous_key = i;
        break;
      }
    }
  }
  else {
    for (int i = 0;i < white_key_num;i++) {
      //マウスドラッグ時に同じ音が連続ででないようにする
      if (previous_key == i) {
        continue;
      }
      KeyAbstract white_key = (KeyAbstract) white_keys.get(i);
      result = white_key.pressed(mouseX);
      if (result == true) {
        previous_key = i;
        break;
      }
    }
  }
  return result;
}

void mouseReleased() {
  //連続で同じ音を押すことはできる
  previous_key = -1;
}


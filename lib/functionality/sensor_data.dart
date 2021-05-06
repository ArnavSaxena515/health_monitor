import 'dart:math';

class SensorsData {
  Random random = new Random();
  int rateL() {
    int x;
    x = (random.nextInt(25) + 72);
    return x;
  }

  int rateH() {
    int x;
    x = (random.nextInt(50) + 90);
    return x;
  }

  int spo2() {
    int x;
    x = (random.nextInt(3) + 97);
    return x;
  }
}

import 'dart:math';

class UtilFunction {
  static String generateOTP() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 5; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    print(rndnumber);
    return rndnumber;
  }
}

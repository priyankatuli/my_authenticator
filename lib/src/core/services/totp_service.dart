import 'package:authenticator/src/app_config/imports/import.dart';

class TotpService{
  static String generate(String secret){
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      length: 6,
      algorithm: Algorithm.SHA1,
      isGoogle: true //--ensure google authenticator compatibility---///
    );
  }
}
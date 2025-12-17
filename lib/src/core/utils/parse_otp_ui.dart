import 'package:authenticator/src/model/otp_account_model.dart';

OtpAccountModel? parseOtpUri(String rawQrValue){
  try{
    final uri = Uri.parse(rawQrValue);
    if(uri.scheme != 'otpauth') return null;

    final type = uri.host ; //totp algorithm
    final label = Uri.decodeComponent(uri.path.substring(1)) ; //remove leading
    String issuerFormLabel = '';
    String accountName = '';

    if(label.contains(':')){
      final parts = label.split(':');
      issuerFormLabel = parts[0];
      accountName = parts[1];
    }else{
      accountName = label;
    }

    final secret = uri.queryParameters['secret'] ?? '';
    final issuer = uri.queryParameters['issuer'] ?? issuerFormLabel;

    if(secret.isEmpty) return null;

    return OtpAccountModel(
        secret: secret,
        issuer: issuer,
        accountName: accountName
    );
  }catch(e){
    return null;
  }

}







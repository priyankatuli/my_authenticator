import 'package:flutter/foundation.dart';

class OtpAccountModel{

  final String secret;
  final String issuer;
  final String accountName;

  OtpAccountModel({
      required this.secret, required this.issuer, required this.accountName
  });

//json conversion for multiple accounts
  Map<String,dynamic> toJson() => {
    'secret' : secret,
    'issuer' : issuer,
    'accountName' : accountName
  };

  factory OtpAccountModel.fromJson(Map<String,dynamic> json) => OtpAccountModel(
    secret: json['secret'],
    issuer: json['issuer'],
    accountName: json['accountName']);
}

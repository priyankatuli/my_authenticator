import 'dart:convert';
import 'package:authenticator/src/model/otp_account_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService{

  final FlutterSecureStorage _storage = FlutterSecureStorage(); //encrypted storage
  static const String _keyAccounts = 'otp_account_model'; ///


  //save account
Future<void> saveAccount(OtpAccountModel account) async {
    final accounts = await getAccounts();
    accounts.add(account);
    final encoded = jsonEncode(accounts.map((a) => a.toJson()).toList()); //encrypted
    await _storage.write(key: _keyAccounts, value: encoded);
}

//get all accounts
Future<List<OtpAccountModel>> getAccounts() async{
  final value = await _storage.read(key: _keyAccounts);
  if(value == null) return [];
  final List<dynamic> decoded = jsonDecode(value);
  return decoded.map((e) => OtpAccountModel.fromJson(e)).toList();
}

//delete an account by accountName or index
  Future<void> deleteAccount(String accountName) async{
     final accounts = await getAccounts();
     accounts.removeWhere((a) => a.accountName == accountName);
     final encoded = jsonEncode(accounts.map((a) => a.toJson()).toList());
     await _storage.write(key: _keyAccounts, value: encoded);
}

  //clear all accounts
Future<void> clearAllAccounts() async{
  await _storage.delete(key: _keyAccounts);
}

}
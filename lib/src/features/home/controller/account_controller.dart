import 'package:get/get.dart';
import 'package:authenticator/src/model/otp_account_model.dart';
import 'package:authenticator/src/core/services/secure_storage_service.dart';

class AccountsController extends GetxController {
  final storage = SecureStorageService();
  var accounts = <OtpAccountModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAccounts();
  }

  void loadAccounts() async {
    final loadedAccounts = await storage.getAccounts();
    accounts.assignAll(loadedAccounts);
  }

  void addAccount(OtpAccountModel account) async {
    await storage.saveAccount(account);
    accounts.add(account); // reactive update
  }

  void deleteAccount(String accountName) async {
    await storage.deleteAccount(accountName);
    accounts.removeWhere((a) => a.accountName == accountName);
  }
}

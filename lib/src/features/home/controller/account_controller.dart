import 'package:authenticator/src/core/constants/app_strings.dart';
import 'package:authenticator/src/core/widgets/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:authenticator/src/model/otp_account_model.dart';
import 'package:authenticator/src/core/services/secure_storage_service.dart';

class AccountsController extends GetxController {
  final storage = SecureStorageService();
  RxList accounts = <OtpAccountModel>[].obs;

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

    //duplicate check
    final isDuplicate = accounts.any((a) => a.accountName == account.accountName);
    if (isDuplicate) {
      AppSnackBar.error(
        AppStrings.alreadyAdded,
        message: AppStrings.alreadyAddedTitle,
      );
      return;
    } else {
      //save to storage
      await storage.saveAccount(account);
      //then update the reactive list
      accounts.add(account);
      AppSnackBar.success(AppStrings.accountAdded,
        message: account.accountName,
      );
    } // reactive update
  }
  void deleteAccount(String accountName) async {
    await storage.deleteAccount(accountName);
    accounts.removeWhere((a) => a.accountName == accountName);
    AppSnackBar.success(AppStrings.deleteTitle,message: accountName);
  }
}

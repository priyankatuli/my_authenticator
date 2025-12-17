import 'package:authenticator/src/core/constants/app_strings.dart';
import 'package:authenticator/src/core/services/secure_storage_service.dart';
import 'package:authenticator/src/core/utils/parse_otp_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanController extends GetxController{

  final isSelected = false.obs;

  Future<void> onDetect(BarcodeCapture capture) async{
    if(isSelected.value) return; //multiple scan off kora

    final barcodes = capture.barcodes;
    debugPrint('Barcodes length: ${barcodes.length}');
    if(barcodes.isEmpty) return;

    final rawValues = barcodes.first.rawValue;
    if(rawValues == null) return;

    isSelected.value = true;

    debugPrint('Raw Qr Values: $rawValues');
    final account = parseOtpUri(rawValues); //QR Parse

    if(account == null){
    debugPrint('Invalid Authenticator QR');
    Get.snackbar(
      'Invalid QR',
      'Please scan a valid authenticator QR',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    isSelected.value = false;
    return;
    }
    //valid authenticator QR
      print('SECRET : ${account.secret}');
      print('ISSUER : ${account.issuer}');
      print('ACCOUNT NAME : ${account.accountName}');

      final storage = SecureStorageService();
      await storage.saveAccount(account);
      Get.snackbar(AppStrings.accountAdded, account.accountName,snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
      await Future.delayed(Duration(seconds: 3));
      //close screen
      Get.back(result: account);
    }

    @override
  void onClose(){
    //controller will be disposed anyway
      isSelected.value = false;
      super.onClose();
    }
  }

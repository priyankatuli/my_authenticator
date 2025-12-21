import 'package:authenticator/src/core/utils/parse_otp_ui.dart';
import 'package:authenticator/src/core/widgets/app_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanController extends GetxController {


  final RxBool isProcessing = false.obs;
  final MobileScannerController cameraController = MobileScannerController();

  Future<void> onDetect(BarcodeCapture capture) async {
    if (isProcessing.value) return; //multiple scan off kora
    isProcessing.value = true;

    final barcodes = capture.barcodes;
    debugPrint('Barcodes length: ${barcodes.length}');
    if (barcodes.isEmpty) {
      isProcessing.value = false;
      return;
    }

    final rawValues = barcodes.first.rawValue;
    if (rawValues == null) {
      isProcessing.value = false;
      return;
    }

    debugPrint('Raw Qr Values: $rawValues');
    final account = parseOtpUri(rawValues); //QR Parse

    //invalid authenticator QR
    if (account == null) {
      debugPrint('Invalid Authenticator QR');

      //allow re-scan
      isProcessing.value = false;
      cameraController.start();
      return;
    }
    //valid authenticator QR
    print('SECRET : ${account.secret}');
    print('ISSUER : ${account.issuer}');
    print('ACCOUNT NAME : ${account.accountName}');

    //stop camera immediately
    cameraController.stop();
    //close screen with result
    Get.back(result: account);

  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}

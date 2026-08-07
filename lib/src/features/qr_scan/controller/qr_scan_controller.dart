import 'package:authenticator/src/app_config/imports/import.dart';

class QrScanController extends GetxController {


  final RxBool isProcessing = false.obs;
  final MobileScannerController cameraController = MobileScannerController();

  Future<void> onDetect(BarcodeCapture capture) async {
    if (isProcessing.value) return; //-------multiple scan off kora------------
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

    //---------invalid authenticator QR--------------///
    if (account == null) {
      debugPrint('Invalid Authenticator QR');
      //--------allow re-scan-----------------////
      isProcessing.value = false;
      cameraController.start();
      return;
    }
    //--------valid authenticator QR--------------///
    debugPrint('SECRET : ${account.secret}');
    debugPrint('ISSUER : ${account.issuer}');
    debugPrint('ACCOUNT NAME : ${account.accountName}');

    //------------stop camera immediately------------------///
    cameraController.stop();
    //----------close screen with result------------------////
    Get.back(result: account);
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}

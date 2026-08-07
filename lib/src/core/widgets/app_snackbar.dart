
import 'package:authenticator/src/app_config/imports/import.dart';

class AppSnackBar{

  static void success(String title, {String message = '', Duration duration = const Duration(seconds: 2)}){
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueGrey.shade200,
      colorText: Colors.white,
      duration: duration,
    );
  }

  static void error (String title, {String message = '', Duration duration = const Duration(seconds: 2)}){
    Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: duration
    );

  }
}
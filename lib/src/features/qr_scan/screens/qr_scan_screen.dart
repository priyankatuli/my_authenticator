import 'package:authenticator/src/core/constants/app_strings.dart';
import 'package:authenticator/src/features/qr_scan/controller/qr_scan_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanScreen extends StatelessWidget{
  const QrScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QrScanController controller = Get.put(QrScanController(),); //screen pop hole controller auto delete hobe

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.scanAppBarTitle,style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: MobileScanner(
            onDetect: controller.onDetect
        )
    );
  }
}
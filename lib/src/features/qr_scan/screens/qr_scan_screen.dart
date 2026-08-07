import 'package:authenticator/src/app_config/imports/import.dart';


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
            controller: controller.cameraController,
            onDetect: controller.onDetect
        )
    );
  }
}
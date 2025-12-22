import 'package:authenticator/src/core/services/totp_service.dart';
import 'package:authenticator/src/features/home/controller/account_controller.dart';
import 'package:authenticator/src/features/home/controller/totp_ticker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:authenticator/src/core/constants/app_strings.dart';
import 'package:authenticator/src/features/qr_scan/screens/qr_scan_screen.dart';
import 'package:authenticator/src/model/otp_account_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AccountsController accountsController = Get.put(AccountsController());
  final TotpTickerController totpTickerController = Get.put(TotpTickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.homeAppBarTitle,
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        final accounts = accountsController.accounts;
        if (accounts.isEmpty) {
          return Center(
              child: Text(AppStrings.noAccountsTitle,
                  style: GoogleFonts.roboto(fontSize: 17)));
        }
        return ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final acc = accounts[index];
            return Obx((){ //otp & remaining only depends on remaining seconds
              final otp = TotpService.generate(acc.secret);
              final remaining = totpTickerController.remainingSeconds.value;
               return ListTile(
                 title: Text(acc.issuer, style: GoogleFonts.roboto(
                     fontSize: 17, fontWeight: FontWeight.bold)),
                 subtitle: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       GestureDetector(
                         onLongPress: (){
                           Clipboard.setData(ClipboardData(text: otp));
                           Get.snackbar('Copied to clipboard', '',
                             snackPosition: SnackPosition.BOTTOM
                           );
                         },
                       child: Text(otp, style: GoogleFonts.roboto(
                           fontSize: 15, fontWeight: FontWeight.bold)),
                       ),
                       Text('$remaining s'),
                     ]
                 ),
                 trailing: IconButton(
                   icon: Icon(Icons.delete_outline_rounded,color: Colors.black54,),
                   onPressed: () {
                     accountsController.deleteAccount(acc.accountName);
                   },
                 ),
               );
             });
            });
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        backgroundColor: Colors.blueGrey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: () async {
          final result = await Get.to(QrScanScreen());
          if (result != null && result is OtpAccountModel) {
                accountsController.addAccount(result);
          }
        },
        child: Icon(Icons.add, color: Colors.black, size: 25),
      ),
    );
  }
}

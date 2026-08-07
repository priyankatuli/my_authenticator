
import 'package:authenticator/src/app_config/imports/import.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AccountsController accountsController = Get.put(AccountsController());
  final TotpTickerController totpTickerController = Get.put(
      TotpTickerController());

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
              return Obx(() { //otp & remaining only depends on remaining seconds
                final otp = TotpService.generate(acc.secret);
                final remaining = totpTickerController.remainingSeconds.value;
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),),
                    ],
                ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(acc.issuer,style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                onLongPress: () {
                                  Clipboard.setData(ClipboardData(text: otp));
                                  AppSnackBar.success(AppStrings.copyText, message: '');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blueGrey.shade50
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(otp,style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(width: 6,),
                                      Icon(Icons.copy_outlined,size: 14,color: Colors.grey,)
                                    ],
                                  ),
                                ),
                              )
                          ),
                          SizedBox(width: 8,),
                          IconButton(onPressed: (){
                            accountsController.deleteAccount(acc.accountName);
                          }, icon: Icon(Icons.delete_rounded, color: Colors.black54,))
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text('Remaining Time: $remaining s',style: GoogleFonts.roboto(
                           fontSize: 14,
                           fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                );
              });
            }
        );
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        backgroundColor: Colors.blueGrey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: () async {
          final result = await Get.to(QrScanScreen());
          if (result != null && result is OtpAccountModel) {
            accountsController.addAccount(result);
          }
        },
        child: Icon(Icons.add_circle_outline_outlined, color: Colors.white, size: 25),
      ),
    );
  }
}
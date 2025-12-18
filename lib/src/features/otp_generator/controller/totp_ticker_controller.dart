import 'dart:async';

import 'package:get/get.dart';


class TotpTickerController extends GetxController{

  //RxString otp = ''.obs;
  RxInt remainingSeconds = 30.obs;
  Timer ? _timer;

  @override
  void onInit(){
    super.onInit();
    _start();
  }


  void _start(){
    //_generateOtp(secret);
    remainingSeconds.value = 30;
    _timer =  Timer.periodic(Duration(seconds: 1), (_){
      print('Tick: ${remainingSeconds.value}');
        remainingSeconds.value--;
        if(remainingSeconds <= 0){
          remainingSeconds.value = 30;
          //_generateOtp(secret);
        }
    });
  }


  @override
  void onClose(){
     _timer?.cancel();
     super.onClose();
  }
}
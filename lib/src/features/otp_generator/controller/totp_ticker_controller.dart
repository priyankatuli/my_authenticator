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
    _updateRemaining(); //initial sync
    //remainingSeconds.value = 30;
    _timer =  Timer.periodic(Duration(seconds: 1), (_){
      print('Tick: ${remainingSeconds.value}');

        _updateRemaining();
        //remainingSeconds.value--;
        //if(remainingSeconds <= 0){
          //remainingSeconds.value = 30;

       // }
    });
  }

  void _updateRemaining(){
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000; //unix seconds
    remainingSeconds.value =  30 - (now%30); // real time sync hobe
  }

  @override
  void onClose(){
     _timer?.cancel();
     super.onClose();
  }

}
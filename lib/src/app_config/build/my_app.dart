import 'package:authenticator/src/app_config/imports/import.dart';


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return GetMaterialApp(
       title: "Authenticator App",
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      );
  }

}
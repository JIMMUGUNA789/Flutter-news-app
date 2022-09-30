import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newsapp/views/home.dart';
import 'package:flutter/gestures.dart';
import 'package:newsapp/views/home2.dart';
  List<String> testDeviceIds = ['013334DB17E755D3E5E912D63B7072E1'];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  RequestConfiguration configuration =
       RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Today',
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehaviour(),
      theme: ThemeData(       
        primarySwatch: Colors.blue,
      ),
      home: const Home2(),
    );
  }
}
class CustomScrollBehaviour extends MaterialScrollBehavior{
  @override
  Set<PointerDeviceKind> get dragDevices =>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.unknown,
  };
}

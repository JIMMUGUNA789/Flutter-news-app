import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/gestures.dart';
import 'package:newsapp/app_state_notifier.dart';

import 'package:newsapp/views/home2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> testDeviceIds = ['013334DB17E755D3E5E912D63B7072E1'];

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? theme = prefs.getBool("isDarkTheme");
  bool themevalue;
  if(theme !=null ){
    themevalue = theme;
  }else{
    themevalue = false;
  }
  MobileAds.instance.initialize();
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(isDarkMode:themevalue),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        title: 'News Today',
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehaviour(),
        theme: themeProvider.getTheme,
        home: const NewsToday(),
        
      );
    });
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
      };
}

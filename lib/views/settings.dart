import 'package:flutter/material.dart';
import 'package:newsapp/app_state_notifier.dart';
import 'package:newsapp/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Settings', context),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text("Application Settings",
                    style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500, )),
          ),
          ListTile(
              trailing: IconButton(
                icon: Icon(Icons.brightness_4),
                color: Colors.blue,
                onPressed: () {
                  ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  themeProvider.swapTheme();
                },
              ),
              title: Text(
                  "Dark Mode",
                  style: Theme.of(context).textTheme.headline1,
                ),

            ),
            const Divider(),
             Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text("General",
                    style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w400, )),
          ),
          ListTile(
              trailing: IconButton(
                icon: Icon(Icons.share),
                color: Colors.blue,
                onPressed: () {
                 Share.share("https://play.google.com/store/apps/details?id=com.muguna.newsapp");
                },
              ),
              title: Text(
                  "Share app",
                  style: Theme.of(context).textTheme.headline1,
                ),

            ),
            const Divider(),
               Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text("Send Feedback",
                    style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w400, )),
          ),
          ListTile(
              trailing: IconButton(
                icon: Icon(Icons.mail),
                color: Colors.blue,
                onPressed: () {
                 launchEmail();
                },
              ),
              title: Text(
                  "Report technical issues or suggest new features",
                  style: Theme.of(context).textTheme.headline1,
                ),

            ),
            const Divider(),
                Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text("Powered by NewsAPI",
                    style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w400, )),
          ),
          ListTile(
              
              title: InkWell(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline1,
                    children: <TextSpan>[
                      TextSpan(text: "News content is from "),
                      TextSpan(text: "NewsAPI ", style: TextStyle(color: Colors.blue)),
                      TextSpan(text: "source"),
                    ]
                      
                      
                    

                  ),
                  
                ),
                  onTap: (() {
                    launchUrl(Uri.parse('https://newsapi.org/'));
                  }),
              ),

            ),
            const Divider(),
        ],
      ) ,
        

    );
    
  }
  String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
  Future launchEmail() async {
    final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'mugunajim@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'NewsToday Feedback',
    }),
  );

  launchUrl(emailLaunchUri);
  }
}
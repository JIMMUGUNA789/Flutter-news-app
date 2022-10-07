
import 'package:flutter/material.dart';
import 'package:newsapp/views/article_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

bool _isInterstitialAdLoaded = false;
late InterstitialAd _interstitialAd;
void _initAd(){
    InterstitialAd.load(
      //adUnitId: 'ca-app-pub-3940256099942544/1033173712', 
            adUnitId: 'ca-app-pub-1155296088390494/8176660572',

      request: AdRequest(), 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
         onAdFailedToLoad: (error){})
      );
  } 
  void onAdLoaded(InterstitialAd ad){
    _interstitialAd = ad;
    _isInterstitialAdLoaded = true;
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        // todo: move to next screen
        _interstitialAd.dispose();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        //todo: also move to next screen
        _interstitialAd.dispose();
      },
    );
  }
 


//body
class BlogTile extends StatelessWidget {
  final imageUrl, title, desc, content, postUrl;
  const BlogTile({Key? key, required this.imageUrl, required this.title, required this.desc, this.content, this.postUrl}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom: 16,),
      child: Column(
        children: <Widget>[
          GestureDetector(
             onTap: (){
      _initAd();
          if(_isInterstitialAdLoaded){    
      _interstitialAd.show();
          
      Navigator.push(context,MaterialPageRoute(
        builder: (context)=>ArticleView(blogUrl: postUrl)));
          }
        if(!_isInterstitialAdLoaded){
           Navigator.push(context,MaterialPageRoute(
        builder: (context)=>ArticleView(blogUrl: postUrl)));
        }
       
      
    },
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0, left: 6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Icon(Icons.broken_image_outlined),
                      ),
                    );
                  },)),
            ),
          ),
           const SizedBox(height: 8,),
          Row(
            children: [
              Container(
                width:310,
                child: GestureDetector(
                   onTap: (){
      _initAd();
          if(_isInterstitialAdLoaded){    
      _interstitialAd.show();
          
      Navigator.push(context,MaterialPageRoute(
        builder: (context)=>ArticleView(blogUrl: postUrl)));
          }
        if(!_isInterstitialAdLoaded){
           Navigator.push(context,MaterialPageRoute(
        builder: (context)=>ArticleView(blogUrl: postUrl)));
        }
       
      
    },
                  child: Padding(
                    padding: const EdgeInsets.only(top:6.0, left: 6.0, right: 6.0),
                    child: Text(title, style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    ),),
                  ),
                ),
              ),
              Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            color: Colors.blue,
                            onPressed: () async {
                              Share.share(postUrl);
                              
                            },
                            icon: const Icon(Icons.share)),
                      ),
            ],
          ),
          const SizedBox(height: 8,),
          GestureDetector(
             onTap: (){
      _initAd();
          if(_isInterstitialAdLoaded){    
      _interstitialAd.show();
          
      Navigator.push(context,MaterialPageRoute(
        builder: (context)=>ArticleView(blogUrl: postUrl)));
          }
        if(!_isInterstitialAdLoaded){
           Navigator.push(context,MaterialPageRoute(
        builder: (context)=>ArticleView(blogUrl: postUrl)));
        }
       
      
    },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  desc, 
                  style: const TextStyle(
                  color:Colors.black54,
                  
                ),
                ),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
    
  }
}


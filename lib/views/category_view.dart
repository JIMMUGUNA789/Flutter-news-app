
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/views/article_view.dart';

import '../helpers/news.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class CategoryNews extends StatefulWidget {
  final String category;
  const CategoryNews({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  late BannerAd _inlineAd;
  bool _isInlineAdLoaded = false;
  List <ArticleModel> articles = <ArticleModel>[];
  bool _loading=true;
   @override
  void initState() {
    
    super.initState();
    getCategoryNews();
    _initBannerAd();
    _initInlineAdd();
  }
    _initBannerAd(){
    _bannerAd = BannerAd(
      size: AdSize.banner,
      //adUnitId: 'ca-app-pub-1155296088390494/9602189825',
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      listener: BannerAdListener(
       onAdLoaded: (ad) {
        _isAdLoaded = true;
  },
  onAdFailedToLoad: (ad, error) {
  
  },
),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }
  _initInlineAdd()async{
  _inlineAd = BannerAd(
    size: AdSize.mediumRectangle, 
    adUnitId: 'ca-app-pub-3940256099942544/6300978111', 
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          _isInlineAdLoaded = true;
        });
      },
      onAdFailedToLoad: ((ad, error) {
        ad.dispose();
        print('inline ad failed to load ${error.message}');
      })
    ), 
    request: AdRequest());
    await _inlineAd.load();
}

  getCategoryNews()async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget> [
             
             Text('NewsToday', style: TextStyle(color: Colors.white),),
          ],
        ),
        actions:<Widget>[
          Opacity
          (
            opacity: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.save)),
          )

        ],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ):
       //blogs
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            
                            itemCount: articles.length,
                            shrinkWrap: true,
                            controller: AdjustableScrollController(),
                            
                            
                            itemBuilder: (context, index){
                               if(_isInlineAdLoaded && index==1){
                          return Column(
                            children: [
                              Container(
                                child: AdWidget(ad: _inlineAd),
                                height: _inlineAd.size.height.toDouble(),
                                width: _inlineAd.size.width.toDouble(),
                              ),
                              const SizedBox(height: 20,),
                              BlogTile(imageUrl: articles[index].urlToImage,
                         title: articles[index].title,
                          desc:articles[index].description,
                          url:articles[index].url),
                            ],
                          );
                        }
                        else{
                              return BlogTile(imageUrl: articles[index].urlToImage,
                               title: articles[index].title,
                                desc:articles[index].description,
                                url:articles[index].url);
                            }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _isAdLoaded?
         
              Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ):
            
               
        const SizedBox()
      
    );
    
  }
}

//body
class BlogTile extends StatelessWidget {
  final imageUrl, title, desc, url;
  const BlogTile({Key? key, required this.imageUrl, required this.title, required this.desc, required this.url}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
          builder: (context)=>ArticleView(blogUrl: url)));
      },
      child: Container(
        margin:const EdgeInsets.only(bottom: 16,),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl:imageUrl)),
             const SizedBox(height: 8,),
            Text(title, style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            ),),
            const SizedBox(height: 8,),
            Text(desc, style: const TextStyle(
              color:Colors.black54,
            ),),
          ],
        ),
      ),
    );
    
  }
}
class AdjustableScrollController extends ScrollController {
  AdjustableScrollController([int extraScrollSpeed = 40]) {
    super.addListener(() {
      ScrollDirection scrollDirection = super.position.userScrollDirection;
      if (scrollDirection != ScrollDirection.idle) {
        double scrollEnd = super.offset +
            (scrollDirection == ScrollDirection.reverse
                ? extraScrollSpeed
                : -extraScrollSpeed);
        scrollEnd = min(super.position.maxScrollExtent,
            max(super.position.minScrollExtent, scrollEnd));
        jumpTo(scrollEnd);
      }
    });
  }
}


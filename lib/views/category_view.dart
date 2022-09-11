
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/views/article_view.dart';

import '../helpers/news.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  const CategoryNews({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List <ArticleModel> articles = <ArticleModel>[];
  bool _loading=true;
   @override
  void initState() {
    
    super.initState();
    getCategoryNews();
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
             Text('News '),
             Text('Today', style: TextStyle(color: Colors.white),),
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
                              return BlogTile(imageUrl: articles[index].urlToImage,
                               title: articles[index].title,
                                desc:articles[index].description,
                                url:articles[index].url);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
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
              child: Image.network(imageUrl)),
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


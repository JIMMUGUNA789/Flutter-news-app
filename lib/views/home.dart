import 'package:flutter/material.dart';
import 'package:newsapp/helpers/data.dart';
import 'package:newsapp/helpers/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';

// Try changing the scroll speed
import 'dart:math';
import 'package:flutter/rendering.dart';


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


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading =true;
  
  @override
  void initState() {
    
    super.initState();
    categories = getCategories();
    getNews();
  }
  getNews()async{
    News newsClass = News();
    await newsClass.getNews();
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
             Text('News'),
             Text('App', style: TextStyle(color: Colors.white),),
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body:
      _loading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ):
       Container(
        child:Column(
          children: <Widget>[ 
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryTile(
                  imageUrl: categories[index].imageUrl,
                  categoryName: categories[index].categoryName,
                );
              }),
            ),
            //blogs
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
                          desc:articles[index].description);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ) ,
        ),
        
        
    );
    
  }
}
//category
class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  const CategoryTile({Key? key, this.imageUrl, this.categoryName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget> [
            ClipRRect(borderRadius: BorderRadius.circular(6),
            child:Image.network(imageUrl, width: 120, height: 60, fit: BoxFit.cover,),),
            
            Container(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500),),),
          ],
        ),
    
      ),
    );
    
  }
}

//body
class BlogTile extends StatelessWidget {
  final imageUrl, title, desc;
  const BlogTile({Key? key, required this.imageUrl, required this.title, required this.desc}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.network(imageUrl),
          Text(title),
          Text(desc),
        ],
      ),
    );
    
  }
}


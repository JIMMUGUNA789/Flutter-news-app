import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/helpers/updated_data.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';




// Try changing the scroll speed
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:newsapp/views/article_view.dart';






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


class Home2 extends StatefulWidget {
   const Home2({Key? key}) : super(key: key);
  
 
  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  

  
  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();
  


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
        elevation: 0.0,
        //centerTitle: true,
        actions:  [
        IconButton(
          onPressed: () {
            newsController.country.value = '';
            newsController.category.value = '';
            newsController.searchNews.value = '';
            newsController.channel.value = '';
            newsController.cName.value = '';
            newsController.getAllNews(reload: true);
            newsController.getBreakingNews(reload: true);
            newsController.update();
          },
          icon: const Icon(Icons.refresh),
        ),
      ],
        
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        
        child:Column(
          children: <Widget>[ 
           
            //blogs
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //search bar
                    Flexible(
 child: Container(
   padding: const EdgeInsets.symmetric(horizontal: 8),
   margin: const EdgeInsets.symmetric(
       horizontal: 18, vertical: 16),
   decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(8)),
   child: Row(
     mainAxisSize: MainAxisSize.max,
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
       Flexible(
         fit: FlexFit.tight,
         flex: 4,
         child: Padding(
           padding: const EdgeInsets.only(left: 16),
           child: TextField(
             controller: searchController,
             textInputAction: TextInputAction.search,
             decoration: const InputDecoration(
                 border: InputBorder.none,
                 hintText: "Search News"),
             onChanged: (val) {
               newsController.searchNews.value = val;
               newsController.update();
             },
             onSubmitted: (value) async {
               newsController.searchNews.value = value;
               newsController.getAllNews(
                   searchKey: newsController.searchNews.value);
               searchController.clear();
             },
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
               newsController.getAllNews(
                   searchKey: newsController.searchNews.value);
               searchController.clear();
             },
             icon: const Icon(Icons.search_sharp)),
       ),
     ],
   ),
 ),
),

//Carousel to display breaking news
GetBuilder<NewsController>(
   init: NewsController(),
   builder: (controller) {
     return CarouselSlider(
       options: CarouselOptions(
           height: 200, autoPlay: true, enlargeCenterPage: true),
       items: controller.breakingNews.map((instance) {
         return controller.articleNotFound.value
             ? const Center(
                 child: Text("Not Found",
                     style: TextStyle(fontSize: 30)))
             : controller.breakingNews.isEmpty
                 ? const Center(child: CircularProgressIndicator())
                 : Builder(builder: (BuildContext context) {
                     try {
                       return Banner(
                         location: BannerLocation.topStart,
                         message: 'Top Headlines',
                         child: InkWell(
                           onTap: () => Get.to(() =>
                               ArticleView(blogUrl: instance.url)),
                           child: Stack(children: [
                             ClipRRect(
                               borderRadius:
                                   BorderRadius.circular(10),
                               child: Image.network(
                                 instance.urlToImage ?? " ",
                                 fit: BoxFit.fill,
                                 height: double.infinity,
                                 width: double.infinity,
                                // if the image is null
                                 errorBuilder:
                                     (BuildContext context,
                                         Object exception,
                                         StackTrace? stackTrace) {
                                   return Card(
                                     shape: RoundedRectangleBorder(
                                         borderRadius:
                                             BorderRadius.circular(
                                                 10)),
                                     child: const SizedBox(
                                       height: 200,
                                       width: double.infinity,
                                       child: Icon(Icons
                                           .broken_image_outlined),
                                     ),
                                   );
                                 },
                               ),
                             ),
                             Positioned(
                                 left: 0,
                                 right: 0,
                                 bottom: 0,
                                 child: Container(
                                   decoration: BoxDecoration(
                                       borderRadius:
                                           BorderRadius.circular(
                                               10),
                                       gradient: LinearGradient(
                                           colors: [
                                             Colors.black12
                                                 .withOpacity(0),
                                             Colors.black
                                           ],
                                           begin:
                                               Alignment.topCenter,
                                           end: Alignment
                                               .bottomCenter)),
                                   child: Container(
                                       padding: const EdgeInsets
                                               .symmetric(
                                           horizontal: 5,
                                           vertical: 10),
                                       child: Container(
                                           margin: const EdgeInsets
                                                   .symmetric(
                                               horizontal: 10),
                                           child: Text(
                                             instance.title,
                                             style: const TextStyle(
                                                 fontSize: 16,
                                                 color:
                                                     Colors.white,
                                                 fontWeight:
                                                     FontWeight
                                                         .bold),
                                           ))),
                                 )),
                           ]),
                         ),
                       );
                     } catch (e) {
                       if (kDebugMode) {
                         print(e);
                       }
                       return Container();
                     }
                   });
       }).toList(),
     );
   }),

                    // ListView.builder(
                      
                    //   itemCount: articles.length,
                    //   shrinkWrap: true,
                    //   controller: AdjustableScrollController(),
                      
                      
                    //   itemBuilder: (context, index){                    
                       
                                             
                    //     return BlogTile(imageUrl: articles[index].urlToImage,
                    //      title: articles[index].title,
                    //       desc:articles[index].description,
                    //       url:articles[index].url);
                    //     }
                    //   ,
                    // ),
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


//body
class BlogTile extends StatelessWidget {
  final imageUrl, title, desc, content, posturl;
  const BlogTile({Key? key, required this.imageUrl, required this.title, required this.desc, this.content, this.posturl}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
          //    Navigator.push(context,MaterialPageRoute(
          // builder: (context)=>ArticleView(blogUrl: url)));
          
         
        
      },
      child: Container(
        margin:const EdgeInsets.only(bottom: 16,),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
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
                },
              )),
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


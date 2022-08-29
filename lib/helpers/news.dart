import 'dart:convert';

import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];
  Future<void> getNews()async{
    String url1 = "https://newsapi.org/v2/top-headlines?country=us&apiKey=57ee8c828be84296ba105eb0b4e61e48";
    String authority = "newsapi.org";
    String path = "/v2/top-headlines";
    final params = { "country" : "us",
    "apikey" : "57ee8c828be84296ba105eb0b4e61e48" };
    final uri =  Uri.https(authority, path, params);  
 
    //var response = await http.get(uri);
    http.Response response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=57ee8c828be84296ba105eb0b4e61e48'));
    print (response);

    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element['urlToImage']!=null&&element['description']!=null){
          ArticleModel articleModel = ArticleModel(author:element['author'],
           title: element['title'], 
           description:element['description'], 
           url:element['url'], 
           urlToImage:element['urlToImage'],
           content:element['content']);
           news.add(articleModel);
        }
      });
    }

  }
}
import 'package:newsapp/models/source_model.dart';

class ArticleModelV2 {
 ArticleModelV2(this.source, this.author, this.title, this.description, this.url,
     this.urlToImage, this.publishedAt, this.content);

 String? author, description, urlToImage, content;
 String title, url, publishedAt;
 SourceModel source;

 Map<String, dynamic> toJson() {
   return {
     'author': author,
     'description': description,
     'urlToImage': urlToImage,
     'content': content,
     'title': title,
     'url': url,
     'publishedAt': publishedAt,
     'source': source,
   };
 }

 factory ArticleModelV2.fromJson(Map<String, dynamic> json) => ArticleModelV2(
       SourceModel.fromJson(json['source'] as Map<String, dynamic>),
       json['author'],
       json['title'],
       json['description'],
       json['url'],
       json['urlToImage'],
       json['publishedAt'],
       json['content'],
     );
}
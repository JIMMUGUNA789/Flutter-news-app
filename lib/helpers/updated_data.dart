
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/models/article2model.dart';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/news_model.dart';

class NewsController extends GetxController{
  List<ArticleModelV2> allNews = <ArticleModelV2>[];
// for carousel
List<ArticleModelV2> breakingNews = <ArticleModelV2>[];
ScrollController scrollController = ScrollController();
RxBool articleNotFound = false.obs;
RxBool isLoading = false.obs;
RxString cName = ''.obs;
RxString country = ''.obs;
RxString category = ''.obs;
RxString channel = ''.obs;
RxString searchNews = ''.obs;
RxInt pageNum = 1.obs;
RxInt pageSize = 10.obs;
String baseUrl = "https://newsapi.org/v2/top-headlines?"; 
static const newsApiKey = '57ee8c828be84296ba105eb0b4e61e48';

@override
void onInit() {
 scrollController = ScrollController()..addListener(_scrollListener);
 getAllNews();
 getBreakingNews();
 super.onInit();
}
  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      getAllNews();
    }
  }


// function to retrieve a JSON response for all news from newsApi.org
getAllNewsFromApi(url) async {
 //Creates a new Uri object by parsing a URI string.
 http.Response res = await http.get(Uri.parse(url));

 if (res.statusCode == 200) {
   //Parses the string and returns the resulting Json object.
   NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

   if (newsData.articles.isEmpty && newsData.totalResults == 0) {
     articleNotFound.value = isLoading.value == true ? false : true;
     isLoading.value = false;
     update();
   } else {
     if (isLoading.value == true) {
       // combining two list instances with spread operator
       allNews = [...allNews, ...newsData.articles];
       update();
     } else {
       if (newsData.articles.isNotEmpty) {
         allNews = newsData.articles;
         // list scrolls back to the start of the screen
         if (scrollController.hasClients) scrollController.jumpTo(0.0);
         update();
       }
     }
     articleNotFound.value = false;
     isLoading.value = false;
     update();
   }
 } else {
   articleNotFound.value = true;
   update();
 }
}


// function to retrieve a JSON response for breaking news from newsApi.org
getBreakingNewsFromApi(url) async {
 http.Response res = await http.get(Uri.parse(url));

 if (res.statusCode == 200) {
   NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

   if (newsData.articles.isEmpty && newsData.totalResults == 0) {
     articleNotFound.value = isLoading.value == true ? false : true;
     isLoading.value = false;
     update();
   } else {
     if (isLoading.value == true) {
       // combining two list instances with spread operator
       breakingNews = [...breakingNews, ...newsData.articles];
       update();
     } else {
       if (newsData.articles.isNotEmpty) {
         breakingNews = newsData.articles;
         if (scrollController.hasClients) scrollController.jumpTo(0.0);
         update();
       }
     }
     articleNotFound.value = false;
     isLoading.value = false;
     update();
   }
 } else {
   articleNotFound.value = true;
   update();
 }
}


// function to load and display all news and searched news on to UI
getAllNews({channel = '', searchKey = '', reload = false}) async {
 articleNotFound.value = false;

 if (!reload && isLoading.value == false) {
 } else {
   country.value = '';
   category.value = '';
 }
 if (isLoading.value == true) {
   pageNum++;
 } else {
   allNews = [];

   pageNum.value = 2;
 }
 // ENDPOINT
 baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";
 // default country is set to USA
 baseUrl += country.isEmpty ? 'country=in&' : 'country=$country&';
 // default category is set to Business
 baseUrl += category.isEmpty ? 'category=business&' : 'category=$category&';
 baseUrl += 'apiKey=${newsApiKey}';
 // when a user selects a channel the country and category will become null 
 if (channel != '') {
   country.value = '';
   category.value = '';
   baseUrl =
       "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${newsApiKey}";
 }
 // when a user enters any keyword the country and category will become null
 if (searchKey != '') {
   country.value = '';
   category.value = '';
   baseUrl =
       "https://newsapi.org/v2/everything?q=$searchKey&from=2022-07-01&sortBy=popularity&pageSize=10&apiKey=${newsApiKey}";
 }
 print(baseUrl);
 // calling the API function and passing the URL here
 getAllNewsFromApi(baseUrl);
}



// function to load and display breaking news on to UI
getBreakingNews({reload = false}) async {
 articleNotFound.value = false;

 if (!reload && isLoading.value == false) {
 } else {
   country.value = '';
 }
 if (isLoading.value == true) {
   pageNum++;
 } else {
   breakingNews = [];

   pageNum.value = 2;
 }
 // default language is set to English
 
 baseUrl =
     "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&";
 // default country is set to US
 baseUrl += country.isEmpty ? 'country=us&' : 'country=$country&';
 //baseApi += category.isEmpty ? '' : 'category=$category&';
 baseUrl += 'apiKey=${newsApiKey}';
 print([baseUrl]);
 // calling the API function and passing the URL here
 getBreakingNewsFromApi(baseUrl);
}

}
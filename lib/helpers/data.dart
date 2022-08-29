import 'package:newsapp/models/category_model.dart';

List<CategoryModel> getCategories(){
  List <CategoryModel> category = <CategoryModel>[];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl = "https://media.istockphoto.com/photos/huge-multi-sports-collage-athletics-tennis-soccer-basketball-etc-picture-id1364045027";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Politics";
  categoryModel.imageUrl = "https://media.istockphoto.com/photos/democrat-vs-republican-poll-democratic-decision-and-primary-voting-picture-id1183053829?s=612x612";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = "https://media.istockphoto.com/photos/businessman-using-a-computer-for-analysis-seo-search-engine-ranking-picture-id1360521208?s=612x612";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Education";
  categoryModel.imageUrl = "https://images.unsplash.com/photo-1521587760476-6c12a4b040da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Weather";
  categoryModel.imageUrl = "https://media.istockphoto.com/photos/weather-forecast-concept-picture-id531889697?s=612x612";
  category.add(categoryModel);
  categoryModel = CategoryModel();
  return category;
}
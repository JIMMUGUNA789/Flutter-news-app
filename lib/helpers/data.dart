import 'package:newsapp/models/category_model.dart';

List<CategoryModel> getCategories(){
  List <CategoryModel> category = <CategoryModel>[];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "General";
  categoryModel.imageUrl = "https://media.istockphoto.com/id/1294416288/photo/rolled-newspaper-pages-abstract-background.webp?s=612x612&w=is&k=20&c=BeD33E_VuDmOx3ArqAfSRO5FuQmB8aAIeh44hF1wCxs=";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.imageUrl = "https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=876&q=80";
  category.add(categoryModel);
  categoryModel = CategoryModel();


  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = "https://media.istockphoto.com/photos/businessman-using-a-computer-for-analysis-seo-search-engine-ranking-picture-id1360521208?s=612x612";
  category.add(categoryModel);
  categoryModel = CategoryModel();

   categoryModel.categoryName = "Science";
  categoryModel.imageUrl = "https://media.istockphoto.com/photos/digital-study-of-gene-structure-of-cell-picture-id1309608690";
  category.add(categoryModel);
  categoryModel = CategoryModel();

 

  categoryModel.categoryName = "Entertainment";
  categoryModel.imageUrl = "https://media.istockphoto.com/id/494388654/photo/this-partys-on-fire.webp?s=2048x2048&w=is&k=20&c=uyq_oAh7qKjWnDsYRi4Lz8LJE7lry1GkG0mcs-TjuQs=";
  category.add(categoryModel);
  categoryModel = CategoryModel();



  categoryModel.categoryName = "Health";
  categoryModel.imageUrl = "https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl = "https://media.istockphoto.com/photos/huge-multi-sports-collage-athletics-tennis-soccer-basketball-etc-picture-id1364045027";
  category.add(categoryModel);
  categoryModel = CategoryModel();
  return category;
}
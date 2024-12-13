// To parse this JSON data, do
//
//     final categoryEntity = categoryEntityFromJson(jsonString);

import 'dart:convert';

List<CategoryEntity> categoryEntityFromJson(String str) =>
    List<CategoryEntity>.from(
        json.decode(str).map((x) => CategoryEntity.fromJson(x)));

String categoryEntityToJson(List<CategoryEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryEntity {
  String catName;
  String categoryValue;
  List<CategoryEntity>? categoriesArray;
  List<String> tagCodes;

  CategoryEntity({
    required this.catName,
    required this.categoryValue,
    this.categoriesArray,
    required this.tagCodes,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        catName: json["CatName"],
        categoryValue: json["CategoryValue"],
        categoriesArray: json["CategoriesArray"] == null
            ? []
            : List<CategoryEntity>.from(json["CategoriesArray"]!
                .map((x) => CategoryEntity.fromJson(x))),
        tagCodes: List<String>.from(json["tagCodes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "CatName": catName,
        "CategoryValue": categoryValue,
        "CategoriesArray": categoriesArray == null
            ? []
            : List<dynamic>.from(categoriesArray!.map((x) => x.toJson())),
        "tagCodes": List<dynamic>.from(tagCodes.map((x) => x)),
      };

}

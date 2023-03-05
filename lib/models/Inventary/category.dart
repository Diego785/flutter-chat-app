// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
    CategoryResponse({
        required this.ok,
        required this.categories,
    });

    bool ok;
    List<Category> categories;

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        ok: json["ok"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": name,
    };
}

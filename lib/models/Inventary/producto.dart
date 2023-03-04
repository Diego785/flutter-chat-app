// To parse this JSON data, do
//
//     final productosResponse = productosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat/models/Inventary/lote.dart';

ProductosResponse productosResponseFromJson(String str) =>
    ProductosResponse.fromJson(json.decode(str));

String productosResponseToJson(ProductosResponse data) =>
    json.encode(data.toJson());

class ProductosResponse {
  ProductosResponse({
    required this.ok,
    required this.myProducts,
  });

  bool ok;
  List<Producto> myProducts;

  factory ProductosResponse.fromJson(Map<String, dynamic> json) =>
      ProductosResponse(
        ok: json["ok"],
        myProducts: List<Producto>.from(
            json["myProducts"].map((x) => Producto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "myProducts": List<dynamic>.from(myProducts.map((x) => x.toJson())),
      };
}

class Producto {
  Producto(
      {required this.id,
      required this.foto,
      required this.nombre,
      required this.categoria,
      required this.descripcion,
      categorySelected});

  String id;
  String foto;
  String nombre;
  Categoria categoria;
  String descripcion;
  String categorySelected = 'Todos';

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["_id"],
        foto: json["foto"],
        nombre: json["nombre"],
        categoria: Categoria.fromJson(json["categoria"]),
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "foto": foto,
        "nombre": nombre,
        "categoria": categoria.toJson(),
        "descripcion": descripcion,
      };
}

CategoryResponse categoriesResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoriesResponseToJson(ProductosResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  CategoryResponse({
    required this.ok,
    required this.categories,
  });

  bool ok;
  List<Categoria> categories;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        ok: json["ok"],
        categories: List<Categoria>.from(
            json["categories"].map((x) => Categoria.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Categoria {
  Categoria({
    required this.id,
    required this.nombre,
  });

  String id;
  String nombre;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["_id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
      };
}

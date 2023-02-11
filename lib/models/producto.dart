// To parse this JSON data, do
//
//     final productosResponse = productosResponseFromJson(jsonString);

import 'dart:convert';

ProductosResponse productosResponseFromJson(String str) => ProductosResponse.fromJson(json.decode(str));

String productosResponseToJson(ProductosResponse data) => json.encode(data.toJson());

class ProductosResponse {
    ProductosResponse({
        required this.ok,
        required this.myProducts,
    });

    bool ok;
    List<Product> myProducts;

    factory ProductosResponse.fromJson(Map<String, dynamic> json) => ProductosResponse(
        ok: json["ok"],
        myProducts: List<Product>.from(json["myProducts"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "myProducts": List<dynamic>.from(myProducts.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        required this.id,
        required this.nombre,
        required this.fechaCreacion,
        required this.fechaVencimiento,
        required this.foto,
    });

    String id;
    String nombre;
    DateTime fechaCreacion;
    DateTime fechaVencimiento;
    String foto;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        nombre: json["nombre"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaVencimiento: DateTime.parse(json["fechaVencimiento"]),
        foto: json["foto"],

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaVencimiento": fechaVencimiento.toIso8601String(),
        "foto": foto,

    };
}

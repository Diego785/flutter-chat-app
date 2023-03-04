// To parse this JSON data, do
//
//     final productos = productosFromJson(jsonString);

import 'dart:convert';

Productos productosFromJson(String str) => Productos.fromJson(json.decode(str));

String productosToJson(Productos data) => json.encode(data.toJson());

class Productos {
    Productos({
        required this.ok,
        required this.myProducts,
    });

    bool ok;
    List<MyProduct> myProducts;

    factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        ok: json["ok"],
        myProducts: List<MyProduct>.from(json["myProducts"].map((x) => MyProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "myProducts": List<dynamic>.from(myProducts.map((x) => x.toJson())),
    };
}

class MyProduct {
    MyProduct({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    factory MyProduct.fromJson(Map<String, dynamic> json) => MyProduct(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
    };
}

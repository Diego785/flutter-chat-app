// To parse this JSON data, do
//
//     final productosResponse = productosResponseFromJson(jsonString);

import 'dart:convert';

SpecificProductosResponse specificProductosResponseFromJson(String str) => SpecificProductosResponse.fromJson(json.decode(str));

String specificProductosResponseToJson(SpecificProductosResponse data) => json.encode(data.toJson());

class SpecificProductosResponse {
    SpecificProductosResponse({
        required this.ok,
        required this.myProducts,
    });

    bool ok;
    List<SpecificProduct> myProducts;

    factory SpecificProductosResponse.fromJson(Map<String, dynamic> json) => SpecificProductosResponse(
        ok: json["ok"],
        myProducts: List<SpecificProduct>.from(json["myProducts"].map((x) => SpecificProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "myProducts": List<dynamic>.from(myProducts.map((x) => x.toJson())),
    };
}

class SpecificProduct {
    SpecificProduct({
        required this.id,
        required this.fechaVencimiento,
        required this.producto,
    });

    String id;
    DateTime fechaVencimiento;
    Producto producto;

    factory SpecificProduct.fromJson(Map<String, dynamic> json) => SpecificProduct(
        id: json["_id"],
        fechaVencimiento: DateTime.parse(json["fechaVencimiento"]),
        producto: Producto.fromJson(json["producto"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fechaVencimiento": fechaVencimiento.toIso8601String(),
        "producto": producto.toJson(),
    };
}

class Producto {
    Producto({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
    };
}

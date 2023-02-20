// To parse this JSON data, do
//
//     final uniqueProducto = uniqueProductoFromJson(jsonString);

import 'dart:convert';

UniqueProducto uniqueProductoFromJson(String str) => UniqueProducto.fromJson(json.decode(str));

String uniqueProductoToJson(UniqueProducto data) => json.encode(data.toJson());

class UniqueProducto {
    UniqueProducto({
        required this.ok,
        required this.producto,
    });

    bool ok;
    Producto producto;

    factory UniqueProducto.fromJson(Map<String, dynamic> json) => UniqueProducto(
        ok: json["ok"],
        producto: Producto.fromJson(json["producto"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
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

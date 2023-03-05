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
    Producto2 producto;

    factory UniqueProducto.fromJson(Map<String, dynamic> json) => UniqueProducto(
        ok: json["ok"],
        producto: Producto2.fromJson(json["producto"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "producto": producto.toJson(),
    };
}

class Producto2 {
    Producto2({
        required this.id,
        required this.foto,
        required this.fechaCreacion,
        required this.fechaVencimiento,
        required this.nombre,
    });

    String id;
    String foto;
    DateTime fechaCreacion;
    DateTime fechaVencimiento;
    String nombre;

    factory Producto2.fromJson(Map<String, dynamic> json) => Producto2(
        id: json["_id"],
        foto: json["foto"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaVencimiento: DateTime.parse(json["fechaVencimiento"]),
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "foto": foto,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaVencimiento": fechaVencimiento.toIso8601String(),
        "nombre": nombre,
    };
}

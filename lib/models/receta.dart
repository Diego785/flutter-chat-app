// To parse this JSON data, do
//
//     final receta = recetaFromJson(jsonString);

import 'dart:convert';

Receta recetaFromJson(String str) => Receta.fromJson(json.decode(str));

String recetaToJson(Receta data) => json.encode(data.toJson());

class Receta {
    Receta({
        required this.ok,
        required this.myReceta,
    });

    bool ok;
    List<MyReceta> myReceta;

    factory Receta.fromJson(Map<String, dynamic> json) => Receta(
        ok: json["ok"],
        myReceta: List<MyReceta>.from(json["myReceta"].map((x) => MyReceta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "myReceta": List<dynamic>.from(myReceta.map((x) => x.toJson())),
    };
}

class MyReceta {
    MyReceta({
        required this.id,
        required this.vendedor,
        required this.cliente,
        required this.fecha,
    });

    String id;
    String vendedor;
    Cliente cliente;
    DateTime fecha;

    factory MyReceta.fromJson(Map<String, dynamic> json) => MyReceta(
        id: json["_id"],
        vendedor: json["vendedor"],
        cliente: Cliente.fromJson(json["cliente"]),
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "vendedor": vendedor,
        "cliente": cliente.toJson(),
        "fecha": fecha.toIso8601String(),
    };
}

class Cliente {
    Cliente({
        required this.nombre,
        required this.uid,
    });

    String nombre;
    String uid;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nombre: json["nombre"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "uid": uid,
    };
}

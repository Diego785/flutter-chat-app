// To parse this JSON data, do
//
//     final prescripcion = prescripcionFromJson(jsonString);

import 'dart:convert';

Prescripcion prescripcionFromJson(String str) => Prescripcion.fromJson(json.decode(str));

String prescripcionToJson(Prescripcion data) => json.encode(data.toJson());

class Prescripcion {
    Prescripcion({
        required this.ok,
        required this.prescripcion,
    });

    bool ok;
    List<PrescripcionElement> prescripcion;

    factory Prescripcion.fromJson(Map<String, dynamic> json) => Prescripcion(
        ok: json["ok"],
        prescripcion: List<PrescripcionElement>.from(json["prescripcion"].map((x) => PrescripcionElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "prescripcion": List<dynamic>.from(prescripcion.map((x) => x.toJson())),
    };
}

class PrescripcionElement {
    PrescripcionElement({
        required this.id,
        required this.receta,
        required this.producto,
        required this.dosis,
        required this.instruccion,
    });

    String id;
    String receta;
    Producto producto;
    int dosis;
    String instruccion;

    factory PrescripcionElement.fromJson(Map<String, dynamic> json) => PrescripcionElement(
        id: json["_id"],
        receta: json["receta"],
        producto: Producto.fromJson(json["producto"]),
        dosis: json["dosis"],
        instruccion: json["instruccion"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "receta": receta,
        "producto": producto.toJson(),
        "dosis": dosis,
        "instruccion": instruccion,
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

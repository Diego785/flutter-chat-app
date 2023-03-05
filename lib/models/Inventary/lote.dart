// To parse this JSON data, do
//
//     final loteResponse = loteResponseFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat/models/Inventary/producto.dart';

LoteResponse loteResponseFromJson(String str) => LoteResponse.fromJson(json.decode(str));

String loteResponseToJson(LoteResponse data) => json.encode(data.toJson());

class LoteResponse {
    LoteResponse({
        required this.ok,
        required this.lote,
    });

    bool ok;
    List<Lote> lote;

    factory LoteResponse.fromJson(Map<String, dynamic> json) => LoteResponse(
        ok: json["ok"],
        lote: List<Lote>.from(json["lote"].map((x) => Lote.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "lote": List<dynamic>.from(lote.map((x) => x.toJson())),
    };
}

class Lote {
    Lote({
        required this.id,
        required this.fechaCreacion,
        required this.fechaVencimiento,
        required this.cantidad,
        required this.producto,
    });

    String id;
    DateTime fechaCreacion;
    DateTime fechaVencimiento;
    int cantidad;
    Producto producto;

    factory Lote.fromJson(Map<String, dynamic> json) => Lote(
        id: json["_id"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaVencimiento: DateTime.parse(json["fechaVencimiento"]),
        cantidad: json["cantidad"],
        producto: Producto.fromJson(json["producto"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaVencimiento": fechaVencimiento.toIso8601String(),
        "cantidad": cantidad,
        "producto": producto.toJson(),
    };
}

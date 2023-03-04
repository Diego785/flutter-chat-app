// To parse this JSON data, do
//
//     final administrador = administradorFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat/models/receta.dart';

Administrador administradorFromJson(String str) => Administrador.fromJson(json.decode(str));

String administradorToJson(Administrador data) => json.encode(data.toJson());

class Administrador {
    Administrador({
        required this.ok,
        required this.myAdministrador,
    });

    bool ok;
    MyAdministrador myAdministrador;

    factory Administrador.fromJson(Map<String, dynamic> json) => Administrador(
        ok: json["ok"],
        myAdministrador: MyAdministrador.fromJson(json["myAdministrador"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "myAdministrador": myAdministrador.toJson(),
    };
}

class MyAdministrador {
    MyAdministrador({
        required this.id,
        required this.usuario,
        required this.especialidad,
    });

    String id;
    Usuario usuario;
    String especialidad;

    factory MyAdministrador.fromJson(Map<String, dynamic> json) => MyAdministrador(
        id: json["_id"],
        usuario: Usuario.fromJson(json["usuario"]),
        especialidad: json["especialidad"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "usuario": usuario.toJson(),
        "especialidad": especialidad,
    };
}

// To parse this JSON data, do
//
//     final pacientes = pacientesFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat/models/receta.dart';

Paciente pacienteFromJson(String str) => Paciente.fromJson(json.decode(str));

String pacienteToJson(Paciente data) => json.encode(data.toJson());

class Paciente {
  Paciente({
    required this.ok,
    required this.myPaciente,
  });

  bool ok;
  List<MyPaciente2> myPaciente;

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        ok: json["ok"],
        myPaciente: List<MyPaciente2>.from(
            json["myPaciente"].map((x) => MyPaciente2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "myPaciente": List<dynamic>.from(myPaciente.map((x) => x.toJson())),
      };
}

class MyPaciente2 {
  MyPaciente2({
    required this.id,
    required this.fechaNacimiento,
    required this.usuario,
  });

  String id;
  DateTime fechaNacimiento;
  Usuario usuario;

  factory MyPaciente2.fromJson(Map<String, dynamic> json) => MyPaciente2(
        id: json["_id"],
        fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
        usuario: Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "usuario": usuario.toJson(),
      };
}

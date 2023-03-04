// To parse this JSON data, do
//
//     final pacientes = pacientesFromJson(jsonString);

import 'dart:convert';

Pacientes pacientesFromJson(String str) => Pacientes.fromJson(json.decode(str));

String pacientesToJson(Pacientes data) => json.encode(data.toJson());

class Pacientes {
    Pacientes({
        required this.ok,
        required this.myPacientes,
    });

    bool ok;
    List<MyPaciente> myPacientes;

    factory Pacientes.fromJson(Map<String, dynamic> json) => Pacientes(
        ok: json["ok"],
        myPacientes: List<MyPaciente>.from(json["myPacientes"].map((x) => MyPaciente.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "myPacientes": List<dynamic>.from(myPacientes.map((x) => x.toJson())),
    };
}

class MyPaciente {
    MyPaciente({
        required this.nombre,
        required this.apellido,
        required this.uid,
    });

    String nombre;
    String apellido;
    String uid;

    factory MyPaciente.fromJson(Map<String, dynamic> json) => MyPaciente(
        nombre: json["nombre"],
        apellido: json["apellido"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "uid": uid,
    };
}

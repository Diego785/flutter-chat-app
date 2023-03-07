import 'dart:convert';

ProveedoresResponse proveedorResponseFromJson(String str) =>
    ProveedoresResponse.fromJson(json.decode(str));
String proveedorResponseToJson(ProveedoresResponse data) =>
    json.encode(data.toJson());

class ProveedoresResponse {
  ProveedoresResponse({
    required this.ok,
    required this.myProveedor,
  });

  bool ok;
  List<Proveedor> myProveedor;

  factory ProveedoresResponse.fromJson(Map<String, dynamic> json) =>
      ProveedoresResponse(
        ok: json["ok"],
        myProveedor: List<Proveedor>.from(
            json["myProveedor"].map((x) => Proveedor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "myProveedor": List<dynamic>.from(myProveedor.map((x) => x.toJson())),
      };
}

class Proveedor {
  Proveedor({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.email,
    required this.telefono,
  });
  String id;
  String nombre;
  String direccion;
  String telefono;
  String email;

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        id: json["_id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
      };
}

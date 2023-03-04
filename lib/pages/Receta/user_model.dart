class RecetaModel {
  String? cliente;
  List<String>? producto;
  List<int>? dosis;
  List<String>? instruccion;

  RecetaModel({
    this.cliente,
    this.producto,
    this.dosis,
    this.instruccion,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['cliente'] = cliente;
    data['producto'] = producto;
    data['dosis'] = dosis;
    data['instruccion'] = instruccion;

    return data;
  }
}

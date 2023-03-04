import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:realtime_chat/models/pacientes.dart';
import 'package:realtime_chat/models/productos.dart';
import 'package:realtime_chat/pages/Receta/receta_page.dart';
import 'package:realtime_chat/pages/Receta/user_model.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/services/recetas_service.dart';
import 'package:realtime_chat/widgets/alertas.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:realtime_chat/global/environment.dart';
import 'package:http/http.dart' as http;

class RecetaCreate extends StatefulWidget {
  RecetaCreate({Key? key}) : super(key: key);

  @override
  State<RecetaCreate> createState() => _RecetaCreateState();
}

class _RecetaCreateState extends State<RecetaCreate> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  RecetaModel userModel = RecetaModel();
  final productsService = new ProductsService();
  List<MyProduct> _productos = [];
  final pacientesService = new RecetasService();
  List<MyPaciente> _pacientes = [];
  String? _selectedValue;
  List<String?> _selectedValue2 = [];
  List<DropdownMenuItem<String>> _menuItems = [];
  List<DropdownMenuItem<String>> _menuItems2 = [];

  @override
  void initState() {
    super.initState();
    pacientesService.getPacientesName().then((pacientes) {
      setState(() {
        _pacientes = pacientes;
        _menuItems = List.generate(
          _pacientes.length,
          (i) => DropdownMenuItem<String>(
            value: _pacientes[i].uid,
            child: Text("${_pacientes[i].nombre} ${_pacientes[i].apellido}"),
          ),
        );
      });
    });
    productsService.getProductsName().then((productos) {
      setState(() {
        _productos = productos;
        _menuItems2 = List.generate(
          _productos.length,
          (i) => DropdownMenuItem<String>(
            value: _productos[i].id,
            child: Text(_productos[i].nombre),
          ),
        );
      });
    });
    userModel.producto = List<String>.empty(growable: true);
    userModel.producto!.add("");
    userModel.dosis = List<int>.empty(growable: true);
    userModel.dosis!.add(0);
    userModel.instruccion = List<String>.empty(growable: true);
    userModel.instruccion!.add("");
    _selectedValue2.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Creando Receta..."),
        backgroundColor: Colors.blue,
      ),
      body: _uiWidget(),
    );
  }

  Widget _uiWidget() {
    return Form(
      key: globalKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Paciente",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Colors.blue,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonFormField<String>(
                  hint: const Text(
                    "Selecciona un paciente",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  validator: (value) => value == null ? 'Por favor seleccione un paciente' : null,
                  isExpanded: true,
                  items: _menuItems,
                  value: _selectedValue,
                  onChanged: (value) => setState(() {
                    _selectedValue = value!;
                    userModel.cliente = _selectedValue;
                  }),
                ),
              ),
              _productosContainer(),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: FormHelper.submitButton("Save",
                      btnColor: Colors.blue, borderColor: Colors.blue, () {
                    if (validateAndSave()) {
                      print(userModel.toJson());
                      crearReceta(userModel.cliente!, userModel.producto!,
                          userModel.dosis!, userModel.instruccion!, context);
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _productosContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Prescripción de la receta",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent
            ),
          ),
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Producto",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  productoUI(index),
                  prescripcionUI(index),
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 20, color: Colors.blue, thickness: 5),
            itemCount: userModel.producto!.length),
      ],
    );
  }

  Widget productoUI(index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: Row(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.blue, style: BorderStyle.solid, width: 0.80),
              ),
              child: DropdownButtonFormField<String>(
                hint: const Text(
                  "Selecciona un producto",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                validator: (value) => value == null ? 'Por favor seleccione un producto' : null,
                isExpanded: true,
                items: _menuItems2,
                value: _selectedValue2[index],
                onChanged: (value) => setState(() {
                  _selectedValue2[index] = value!;
                  userModel.producto![index] = value;
                }),
              ),
            ),
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addProductoControl();
                },
              ),
            ),
            visible: index == userModel.producto!.length - 1,
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  removeProductoControl(index);
                },
              ),
            ),
            visible: index > 0,
          ),
        ],
      ),
    );
  }

  Widget prescripcionUI(index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: FormHelper.inputFieldWidgetWithLabel(
              context,
              "dosis_$index",
              "Dosis",
              "",
              (onValidateVal){
                if (onValidateVal.isEmpty) {
                  return 'Dosis${index + 1} no debe de estar vacío';
                } else if (onValidateVal == "0"){
                  return 'No debe ser 0';
                }else if(!isNumeric(onValidateVal)){
                  return 'Debe ser un número';
                }
                return null;
              },
              (onSavedVal) {
                userModel.dosis![index] = int.parse(onSavedVal);
              },
              initialValue: userModel.dosis![index].toString(),
              borderColor: Colors.blue,
              borderFocusColor: Colors.blue,
              borderRadius: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 3,
            child: FormHelper.inputFieldWidgetWithLabel(
              context,
              "instruccion_$index",
              "Instruccion",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Instruccion${index + 1} no debe de estar vacio';
                }
                return null;
              },
              (onSavedVal) {
                userModel.instruccion![index] = onSavedVal;
              },
              initialValue: userModel.instruccion![index],
              borderColor: Colors.blue,
              borderFocusColor: Colors.blue,
              borderRadius: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIcon: Icon(Icons.mail),
            ),
          ),
        ],
      ),
    );
  }

  void addProductoControl() {
    setState(() {
      userModel.producto!.add("");
      userModel.dosis!.add(0);
      userModel.instruccion!.add("");
      _selectedValue2.add(null);
    });
  }

  void removeProductoControl(index) {
    setState(() {
      if (userModel.producto!.length > 1) {
        userModel.producto!.removeAt(index);
        userModel.dosis!.removeAt(index);
        userModel.instruccion!.removeAt(index);
        _selectedValue2.removeAt(index);
      }
    });
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}

crearReceta(String cliente, List<String> producto, List<int> dosis,
    List<String> instruccion, BuildContext context) async {
  mostrarLoading(context, true);
  final uri = Uri.parse('${Environment.apiUrl}/prescripciones/new');
  final resp = await http.post(
    uri,
    body: jsonEncode({
      'cliente': cliente,
      'producto': producto,
      'dosis': dosis,
      'instruccion': instruccion
    }),
    headers: {'Content-Type': 'application/json'},
  );
  // final respuesta = jsonDecode(resp.body);
  // print(respuesta);
  Navigator.pop(context);
  if (200 == resp.statusCode) {
    // serverProvider.token = respuesta['token'];
    // Provider.of<ConsultaProvider>(context, listen: false).consultas = null;
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (
              _,
              __,
              ___,
            ) =>
                RecetaPage(),
            transitionDuration: Duration(milliseconds: 0)));
  } else {
    const mensajeErroneo = "Surgió un error";
    mostrarAlerta(context, 'Error', mensajeErroneo);
  }
}

bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return int.tryParse(s) != null;
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:realtime_chat/services/proveedor.dart';
import 'package:realtime_chat/widgets/headers.dart';

class CreateProveedorPage extends StatefulWidget {
  const CreateProveedorPage({super.key});

  @override
  State<CreateProveedorPage> createState() => _CreateProveedorPageState();
}

class _CreateProveedorPageState extends State<CreateProveedorPage> {
  final _textControllerNombre = TextEditingController();
  final _textControllerdireccion = TextEditingController();
  final _textControllerTelefono = TextEditingController();
  final _textControlleremail = TextEditingController();
  bool isVerifying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: const [
              IconHeader(
                titulo: 'Proveedores',
                color1: Color(0xff317183),
                color2: Color(0xff46997D),
                grosor: 160,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                TextField(
                  style: TextStyle(color: Colors.cyan.shade900, fontSize: 20),
                  controller: _textControllerNombre,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "name of the proveedor",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textControllerNombre.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
                (isVerifying && _textControllerNombre.text.isEmpty)
                    ? Text(
                        "Complete the name correctly!",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.cyan.shade900, fontSize: 20),
                  controller: _textControllerdireccion,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter the direccion to Proveedor",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textControllerdireccion.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
                (isVerifying && _textControllerdireccion.text.isEmpty)
                    ? Text(
                        "Complete the direccion correctly!",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.cyan.shade900, fontSize: 20),
                  controller: _textControllerTelefono,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter the Number to Proveedor",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textControllerTelefono.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
                (isVerifying && _textControllerTelefono.text.isEmpty)
                    ? Text(
                        "Complete the Number correctly!",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.cyan.shade900, fontSize: 20),
                  controller: _textControlleremail,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter the email to Proveedor",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textControlleremail.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
                (isVerifying && _textControlleremail.text.isEmpty)
                    ? Text(
                        "Complete the email correctly!",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Color.fromARGB(255, 16, 160, 129),
                  hoverColor: Colors.cyan.shade900,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Save Proveedor",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  onPressed: () async {
                    if (_textControllerNombre.text.isEmpty ||
                        _textControllerdireccion.text.isEmpty ||
                        _textControllerTelefono.text.isEmpty ||
                        _textControlleremail.text.isEmpty) {
                      isVerifying = true;
                      Timer(Duration(seconds: 2), () {
                        // <-- Delay here
                        setState(() {
                          isVerifying = false; // <-- Code run after delay
                        });
                      });
                      setState(() {});
                      return;
                    }

                    final productServices = ProveedorService();
                    await productServices.createProveedor(
                        _textControllerNombre.text,
                        _textControllerdireccion.text,
                        _textControllerTelefono.text,
                        _textControlleremail.text);

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

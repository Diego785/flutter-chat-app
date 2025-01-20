import 'dart:async';

import "package:flutter/material.dart";
import 'package:realtime_chat/components/loading_page.dart';
import 'package:realtime_chat/models/proveedor.dart';
import 'package:realtime_chat/services/proveedor.dart';
import 'package:realtime_chat/widgets/headers.dart';

class EditProveedorPage extends StatefulWidget {
  final Proveedor proveedor;
  const EditProveedorPage({super.key, required this.proveedor});

  @override
  State<EditProveedorPage> createState() => _EditProveedorPageState();
}

class _EditProveedorPageState extends State<EditProveedorPage> {
  final _textControllerNombre = TextEditingController();
  final _textControllerdireccion = TextEditingController();
  final _textControllerTelefono = TextEditingController();
  final _textControlleremail = TextEditingController();
  bool isLoading = true;
  bool isVerifying = false;

  @override
  void initState() {
    _textControllerNombre.text = widget.proveedor.nombre;
    _textControllerdireccion.text = widget.proveedor.direccion;
    _textControllerTelefono.text = widget.proveedor.telefono;
    _textControlleremail.text = widget.proveedor.email;
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!isLoading)
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //proveedores
                  Stack(
                    children: <Widget>[
                      IconHeader(
                        titulo: 'Proveedores',
                        color1: Color(0xff317183),
                        color2: Color(0xff46997D),
                        grosor: 150,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.cyan.shade900, fontSize: 20),
                          controller: _textControllerNombre,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter the name of the proveedor",
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
                                "Complete the Nombre correctly!",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.cyan.shade900, fontSize: 20),
                          controller: _textControllerdireccion,
                          maxLines: 4,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter the direccion to proveedor",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.cyan.shade900, fontSize: 20),
                          controller: _textControllerTelefono,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter the telefono of the Proveedor",
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
                                "Complete the telefono correctly!",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.cyan.shade900, fontSize: 20),
                          controller: _textControlleremail,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter the email of the product",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Color.fromARGB(255, 1, 122, 102),
                          hoverColor: Colors.cyan.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            "Update Proveedor",
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
                                  isVerifying =
                                      false; // <-- Code run after delay
                                });
                              });
                              setState(() {});
                              return;
                            }

                            setState(() {});
                            isLoading = true;

                            final productServices = ProveedorService();
                            await productServices.updateProveedor(
                                widget.proveedor.id,
                                _textControllerNombre.text,
                                _textControllerdireccion.text,
                                _textControllerTelefono.text,
                                _textControlleremail.text);

                            Navigator.pop(context);

                            isLoading = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const LoadingPage2();
  }
}

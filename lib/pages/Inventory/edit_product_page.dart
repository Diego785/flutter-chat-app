import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/components/loading_page.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/widgets/headers.dart';

class EditProductPage extends StatefulWidget {
  final Producto product;
  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _textControllerName = TextEditingController();
  final _textControllerDescription = TextEditingController();
  bool isLoading = true;
  bool isVerifying = false;

  @override
  void initState() {
    // TODO: implement initState
    _textControllerName.text = widget.product.nombre;
    _textControllerDescription.text = widget.product.descripcion;
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!isLoading)
        ? Scaffold(
            backgroundColor: Colors.cyan.shade300,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      IconHeader(
                        titulo: 'Inventory',
                        color1: Color(0xff536CF6),
                        color2: Color(0xff66A9F2),
                        grosor: 175,
                      ),
                      Positioned(
                          right: 0,
                          top: 45,
                          child: RawMaterialButton(
                              onPressed: () {},
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15.0),
                              child: FaIcon(FontAwesomeIcons.ellipsisV,
                                  color: Colors.white)))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.cyan.shade900, fontSize: 20),
                          controller: _textControllerName,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter the name of the product",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _textControllerName.clear();
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        ),
                        (isVerifying && _textControllerName.text.isEmpty)
                            ? Text(
                                "Complete the name correctly!",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 80,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.cyan.shade900, fontSize: 20),
                          controller: _textControllerDescription,
                          maxLines: 10,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter the description of the product",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _textControllerDescription.clear();
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        ),
                        (isVerifying && _textControllerDescription.text.isEmpty)
                            ? Text(
                                "Complete the description correctly!",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 80,
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.cyan.shade900,
                          hoverColor: Colors.cyan.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            "Update Product",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () async {
                            if (_textControllerName.text.isEmpty ||
                                _textControllerDescription.text.isEmpty) {
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

                            final productServices = ProductsService();
                            await productServices.updateProduct(
                                widget.product.id,
                                _textControllerName.text,
                                _textControllerDescription.text);

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

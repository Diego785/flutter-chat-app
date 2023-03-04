import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/components/loading_page.dart';
import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/widgets/headers.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _textControllerName = TextEditingController();
  final _textControllerPhoto = TextEditingController();
  final _textControllerDescription = TextEditingController();
  List<Category> categories = [];
  String? categoryId;
  bool isLoading = true;
  bool isVerifying = false;

  void loadCategories() async {
    final productService = ProductsService();
    categories = await productService.getCategories();
    isLoading = false;
    print(categories);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!isLoading)
        ? SafeArea(
            child: Scaffold(
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
                            height: 80,
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            style: TextStyle(
                                color: Colors.cyan.shade900, fontSize: 20),
                            controller: _textControllerPhoto,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter the link of the product",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _textControllerPhoto.clear();
                                },
                                icon: Icon(Icons.clear),
                              ),
                            ),
                          ),
                          (isVerifying && _textControllerPhoto.text.isEmpty)
                              ? Text(
                                  "Complete the link correctly!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 40,
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
                          (isVerifying &&
                                  _textControllerDescription.text.isEmpty)
                              ? Text(
                                  "Complete the description correctly!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white, //<-- SEE HERE
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: DropdownButton(
                              style: TextStyle(
                                  color: Colors.cyan.shade900, fontSize: 20),
                              hint: const Text(
                                "Select a category",
                                style: TextStyle(color: Colors.grey),
                              ),
                              value: categoryId,
                              items: categories.map((e) {
                                return DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.name));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  categoryId = newValue.toString();
                                  print(categoryId);
                                });
                              },
                            ),
                          ),
                          (isVerifying && categoryId == null)
                              ? Text(
                                  "Select the category correctly!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 40,
                          ),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.cyan.shade900,
                            hoverColor: Colors.cyan.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              "Save Product",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            onPressed: () async {
                              if (_textControllerName.text.isEmpty ||
                                  _textControllerPhoto.text.isEmpty ||
                                  _textControllerDescription.text.isEmpty ||
                                  categoryId == null) {
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
                              await productServices.createProduct(
                                  _textControllerName.text,
                                  _textControllerPhoto.text,
                                  _textControllerDescription.text,
                                  categoryId!);

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
            ),
          )
        : const LoadingPage2();
  }
}

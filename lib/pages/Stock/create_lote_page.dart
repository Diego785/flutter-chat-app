import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:realtime_chat/components/loading_page.dart';
import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/services/Inventory/lote_service.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/widgets/headers.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class CreateLotePage extends StatefulWidget {
  const CreateLotePage({super.key});

  @override
  State<CreateLotePage> createState() => _CreateLotePageState();
}

class _CreateLotePageState extends State<CreateLotePage> {
  TextEditingController _creationDateTimeController = TextEditingController();
  TextEditingController _expirationDateTimeController = TextEditingController();
  TextEditingController _deliveryDateTimeController = TextEditingController();
  TextEditingController _productSelectedTextController =
      TextEditingController();

  TextEditingController _cantidadTextController = TextEditingController();

  String _idProductoSelected = "";

  DateTime? _creationDateTime = DateTime.now();
  DateTime? _expirationDateTime = DateTime.now();
  DateTime? _deliveryDateTime = DateTime.now();
  List<Producto> _listProducts = [];
  List<Producto> _listProductsSearcher = [];
  int _currentQuantity = 0;
  bool showProducts = false;
  bool _isVerifying = false;

  void loadProductos() async {
    final productService = ProductsService();
    _listProducts = await productService.getProducts();
    _listProductsSearcher = _listProducts;
    setState(() {});
  }

  void updateList(String value) {
    if (value.isEmpty) {
      showProducts = false;
      setState(() {});
      return;
    }
    _listProducts = _listProductsSearcher
        .where((element) =>
            element.nombre.toLowerCase().contains(value.toLowerCase()))
        .toList();
    if (_listProducts.isEmpty || _listProductsSearcher.isEmpty) {
      showProducts = false;
    } else {
      showProducts = true;
    }
    setState(() {});
  }

  final leftEditIcon = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: const Color.fromARGB(255, 94, 102, 168).withOpacity(0.5),
    alignment: Alignment.center,
    child: const Icon(Icons.visibility, color: Colors.white),
  );

  final rightEditIcon = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: const Color.fromARGB(255, 94, 102, 168).withOpacity(0.5),
    alignment: Alignment.center,
    child: const Icon(Icons.info, color: Colors.white),
  );

  void _selectCreationDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        if (value != null) {
          _creationDateTime = value;
        }
        _creationDateTimeController.text = _creationDateTime.toString();
      });
    });
  }

  void _selectExpirationDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        if (value != null) {
          _expirationDateTime = value;
        }
        _expirationDateTimeController.text = _expirationDateTime.toString();
      });
    });
  }

  void _selectDeliveryDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        if (value != null) {
          _deliveryDateTime = value;
        }
        _deliveryDateTimeController.text = _deliveryDateTime.toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadProductos();
    print(_listProducts);
    // if(_listProducts.isNotEmpty){

    //  _productSelectedTextController.text = _listProducts[0].nombre;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_listProducts.isEmpty && showProducts == false)
        ? const LoadingPage2()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.cyan.shade300,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: <Widget>[
                        IconHeader(
                          titulo: 'Stock',
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
                            height: 20,
                          ),
                          TextField(
                            controller: _creationDateTimeController,
                            style: TextStyle(
                                color: Colors.cyan.shade900, fontSize: 20),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: _creationDateTime.toString(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    _creationDateTimeController.clear(),
                                icon: Icon(Icons.clear),
                              ),
                            ),
                          ),
                          (_isVerifying &&
                                  _creationDateTimeController.text == "")
                              ? Text(
                                  "¡Selecciona la fecha de creación correctamente!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.cyan.shade900,
                            hoverColor: Colors.cyan.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              "Choose the Creation Date",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            onPressed: () => _selectCreationDatePicker(),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: _expirationDateTimeController,
                            style: TextStyle(
                                color: Colors.cyan.shade900, fontSize: 20),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: _expirationDateTime.toString(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    _expirationDateTimeController.clear(),
                                icon: Icon(Icons.clear),
                              ),
                            ),
                          ),
                          (_isVerifying &&
                                  _expirationDateTimeController.text == "")
                              ? Text(
                                  "¡Selecciona la fecha de expiración correctamente!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.cyan.shade900,
                            hoverColor: Colors.cyan.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              "Choose the Expriration Date",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            onPressed: () => _selectExpirationDatePicker(),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: _deliveryDateTimeController,
                            style: TextStyle(
                                color: Colors.cyan.shade900, fontSize: 20),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: _deliveryDateTime.toString(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    _deliveryDateTimeController.clear(),
                                icon: Icon(Icons.clear),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          (_isVerifying &&
                                  _deliveryDateTimeController.text == "")
                              ? Text(
                                  "¡Selecciona la fecha de entrega correctamente!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.cyan.shade900,
                            hoverColor: Colors.cyan.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              "Choose the Delivery Date",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            onPressed: () => _selectDeliveryDatePicker(),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: _productSelectedTextController,
                            onChanged: (value) => updateList(value),
                            style: TextStyle(
                                color: Colors.cyan.shade900, fontSize: 20),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Ejm: Paracetamol",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _productSelectedTextController.clear();
                                    _currentQuantity = 0;
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.clear),
                                ),
                                prefixIconColor: Colors.blue.shade900),
                          ),
                          (_isVerifying &&
                                  _productSelectedTextController.text == "")
                              ? Text(
                                  "¡Selecciona el medicamento correctamente!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                )
                              : SizedBox.shrink(),
                          (showProducts)
                              ? Column(
                                  children: [
                                    // MOSTRAR LA LISTA DE MICROS
                                    ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(10),
                                        itemCount: _listProducts.length,
                                        itemBuilder: (context, index) {
                                          return Dismissible(
                                            background: leftEditIcon,
                                            secondaryBackground: rightEditIcon,
                                            onDismissed:
                                                (DismissDirection direction) {
                                              print("after dismiss");
                                            },
                                            confirmDismiss: (DismissDirection
                                                direction) async {},
                                            key: ObjectKey(index),
                                            child: ListTile(
                                                selectedColor:
                                                    Colors.green.shade900,
                                                hoverColor:
                                                    Colors.green.shade900,
                                                minLeadingWidth: 80,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: 15),
                                                selected: true,
                                                title: Text(
                                                  _listProducts[index].nombre,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.blue.shade900,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    _listProducts[index].foto,
                                                    width: 100,
                                                    height: 100,
                                                    scale: 10,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                trailing: const Icon(
                                                  Icons.compare_arrows,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  _productSelectedTextController
                                                          .text =
                                                      _listProducts[index]
                                                          .nombre;
                                                  _idProductoSelected =
                                                      _listProducts[index].id;
                                                  print(
                                                      _productSelectedTextController
                                                          .text);
                                                  updateList(
                                                      _productSelectedTextController
                                                          .text);
                                                  showProducts = false;
                                                  _currentQuantity = 0;
                                                  setState(() {});
                                                }),
                                          );
                                        }

                                        /*ListTile(
                     selectedColor: Colors.green.shade900,
                     hoverColor: Colors.green.shade900,
                     minLeadingWidth: 80,
                     contentPadding:
                         const EdgeInsets.only(top: 15),
                     selected: true,
                     title: Text(
                       _listProducts[index].code,
                       style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     leading: Image.asset("assets/logo.png"),
                   ),*/
                                        ),
                                    //getData(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: const Text(
                                        "Escriba el nombre del medicamento que pertenece a este lote.",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    NumberPicker(
                                      value: _currentQuantity,
                                      minValue: 0,
                                      maxValue: 100,
                                      haptics: true,
                                      axis: Axis.horizontal,
                                      onChanged: (value) => setState(
                                          () => _currentQuantity = value),
                                    ),
                                    SizedBox(height: 32),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () => setState(() {
                                            final newValue =
                                                _currentQuantity - 10;
                                            _currentQuantity =
                                                newValue.clamp(0, 100);
                                          }),
                                        ),
                                        Text(
                                            'Current quantity of products: $_currentQuantity'),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () => setState(() {
                                            final newValue =
                                                _currentQuantity + 20;
                                            _currentQuantity =
                                                newValue.clamp(0, 100);
                                          }),
                                        ),
                                      ],
                                    ),
                                    (_isVerifying && _currentQuantity == 0)
                                        ? Text(
                                            "¡Selecciona un stock válido!",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          (showProducts == false)
                              ? MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  height: 50,
                                  color: Colors.red.shade700,
                                  hoverColor: Colors.red.shade900,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Text(
                                    "Save Lote",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  onPressed: () async {
                                    if (_creationDateTimeController.text == "" ||
                                        _expirationDateTimeController.text ==
                                            "" ||
                                        _deliveryDateTimeController.text ==
                                            "" ||
                                        _idProductoSelected == "" ||
                                        _currentQuantity == 0) {
                                      _isVerifying = true;
                                      Timer(Duration(seconds: 2), () {
                                        // <-- Delay here
                                        setState(() {
                                          _isVerifying =
                                              false; // <-- Code run after delay
                                        });
                                      });
                                      setState(() {});
                                      return;
                                    }

                                    showProducts = true;
                                    final _loteService = LoteService();
                                    await _loteService.createLote(
                                        DateTime.parse(
                                            _creationDateTimeController.text),
                                        DateTime.parse(
                                            _expirationDateTimeController.text),
                                        DateTime.parse(
                                            _deliveryDateTimeController.text),
                                        _idProductoSelected,
                                        _currentQuantity);
                                    Navigator.pop(context);
                                    setState(() {
                                      showProducts = false;
                                    });
                                  },
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

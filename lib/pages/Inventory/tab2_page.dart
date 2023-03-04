import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/pages/Inventory/details_products_page.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/widgets/my_button_dissmissible.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  List<Producto> _listProducts = [];
  List<Producto> _listProductsSearcher = [];
  bool showProducts = false;

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

  @override
  void initState() {
    loadProductos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    return Container(
      padding: const EdgeInsets.all(20),
      width: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Escriba el nombre de un producto.",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (value) => updateList(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Ejm: Paracetamol",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blue.shade900,
                ),
                prefixIconColor: Colors.blue.shade900),
          ),
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
                            onDismissed: (DismissDirection direction) {
                              print("after dismiss");
                            },
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            DetailsProductsPage(
                                                product: _listProducts[index],
                                                index: index))));
                                return false;
                              } else {
                                showModalBottomSheet(
                                    backgroundColor:
                                        Colors.transparent.withOpacity(0.1),
                                    barrierColor:
                                        Colors.transparent.withOpacity(0.9),
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                        height: 550,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2e3253)
                                              .withOpacity(0.4),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Colocar los botones
                                              const Text(
                                                "Información del Micro: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: Image.network(
                                                  _listProducts[index].foto,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                  scale: 10,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Id: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    _listProducts[index].id,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .cyan.shade500),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Nombre: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    _listProducts[index].nombre,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .cyan.shade500),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              //  Row(
                                              //    mainAxisAlignment:
                                              //        MainAxisAlignment
                                              //            .center,
                                              //    children: [
                                              //      const Text(
                                              //        "Dirección: ",
                                              //        style: TextStyle(
                                              //            fontWeight:
                                              //                FontWeight
                                              //                    .bold,
                                              //            fontSize:
                                              //                15,
                                              //            color: Colors
                                              //                .white),
                                              //      ),
                                              //      Text(
                                              //        _listProducts[
                                              //                index]
                                              //            .,
                                              //        style: TextStyle(
                                              //            fontStyle:
                                              //                FontStyle
                                              //                    .italic,
                                              //            fontSize:
                                              //                15,
                                              //            fontWeight:
                                              //                FontWeight
                                              //                    .bold,
                                              //            color: Colors
                                              //                .green
                                              //                .shade500),
                                              //      ),
                                              //    ],
                                              //  ),
                                              //  const SizedBox(
                                              //    height: 10,
                                              //  ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Categoría: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    _listProducts[index]
                                                        .categoria
                                                        .nombre,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.cyan.shade500),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              //  Row(
                                              //    mainAxisAlignment:
                                              //        MainAxisAlignment
                                              //            .center,
                                              //    children: [
                                              //      const Text(
                                              //        "Email: ",
                                              //        style: TextStyle(
                                              //            fontWeight:
                                              //                FontWeight
                                              //                    .bold,
                                              //            fontSize:
                                              //                15,
                                              //            color: Colors
                                              //                .white),
                                              //      ),
                                              //      Text(
                                              //        _listProducts[
                                              //                index]
                                              //            .email,
                                              //        style: TextStyle(
                                              //            fontStyle:
                                              //                FontStyle
                                              //                    .italic,
                                              //            fontSize:
                                              //                15,
                                              //            fontWeight:
                                              //                FontWeight
                                              //                    .bold,
                                              //            color: Colors
                                              //                .green
                                              //                .shade500),
                                              //      ),
                                              //    ],
                                              //  ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.center,
                                              //   children: [
                                              //     const Text(
                                              //       "Descripción: ",
                                              //       style: TextStyle(
                                              //           fontWeight:
                                              //               FontWeight.bold,
                                              //           fontSize: 15,
                                              //           color: Colors.white),
                                              //     ),
                                              //     SizedBox(
                                              //       width: 200,
                                              //       child: Text(
                                              //         _listProducts[index]
                                              //             .descripcion,
                                              //         style: TextStyle(
                                              //             fontStyle:
                                              //                 FontStyle.italic,
                                              //             fontSize: 15,
                                              //             fontWeight:
                                              //                 FontWeight.bold,
                                              //             color: Colors
                                              //                 .green.shade500),
                                              //         maxLines: 5,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                return false;
                              }
                            },
                            key: ObjectKey(index),
                            child: ListTile(
                              selectedColor: Colors.green.shade900,
                              hoverColor: Colors.green.shade900,
                              minLeadingWidth: 80,
                              contentPadding: const EdgeInsets.only(top: 15),
                              selected: true,
                              title: Text(
                                _listProducts[index].nombre,
                                style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
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
                            ),
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
              : Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "No existen medicamentos con ese nombre.",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red[900],
                        fontSize: 15),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

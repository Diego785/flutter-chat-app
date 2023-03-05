import 'package:flutter/material.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/pages/Inventory/edit_product_page.dart';

class DetailsProductsPage extends StatelessWidget {
  final Producto product;
  final int index;
  const DetailsProductsPage({
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: '${product.foto}$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(product.foto), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Container(
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.nombre,
                          style: TextStyle(
                            color: Colors.cyan.shade300,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //  Text(
                        //    "Created: " + lote.fechaCreacion.toString(),
                        //    style: TextStyle(
                        //      fontSize: 15,
                        //      fontWeight: FontWeight.w400,
                        //    ),
                        //  ),
                        //  Text(
                        //    "Expiration: " + lote.fechaVencimiento.toString(),
                        //    style: TextStyle(
                        //      fontSize: 15,
                        //      fontWeight: FontWeight.w400,
                        //    ),
                        //  ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.descripcion,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.lightBlueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.lightBlueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProductPage(
                                          product: product,
                                        ))),
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

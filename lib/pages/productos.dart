import 'package:flutter/material.dart';

import '../models/producto.dart';

class ProductosContainer extends StatelessWidget {
  final Product producto;
  const ProductosContainer({
    Key? key,
    required this.producto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            color: Color.fromARGB(255, 53, 58, 126).withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageSection(producto),
          SizedBox(width: 15),
          _detailSection(producto),
        ],
      ),
    );
  }
}

Container _imageSection(Product producto) {
  return Container(
    height: 70,
    width: 90,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 69, 222, 176),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(producto.foto, scale: 15))),
  );
}

Column _detailSection(Product producto) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            'Nombre: ' + producto.nombre,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10,
      ),
      Text(
            'Fecha de Vencimiento: ',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
            producto.fechaVencimiento.toString().substring(0, 10),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
      ),
    ],
  );
}

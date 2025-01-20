import 'package:flutter/material.dart';
import 'package:realtime_chat/models/proveedor.dart';
import 'package:realtime_chat/pages/Suppliers/edit_proveedor_page.dart';

class ProveedoresContainer extends StatelessWidget {
  final Proveedor proveedor;
  const ProveedoresContainer({
    Key? key,
    required this.proveedor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contex) => EditProveedorPage(
                          proveedor: proveedor,
                        ))),
            icon: Icon(Icons.edit_sharp),
            color: Colors.lightGreen[500],
          ),
          SizedBox(width: 10),
          _detailSection(proveedor),
        ],
      ),
    );
  }
}

Column _detailSection(Proveedor proveedor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Nombre: ' + proveedor.nombre.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Telefono: ' + proveedor.telefono.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Email: ' + proveedor.email.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Direccion: ' + proveedor.direccion.toString().substring(0, 9),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        width: 5,
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/pages/Suppliers/create_proveedor_page.dart';
import 'package:realtime_chat/pages/Suppliers/proveedores_page.dart';
import 'package:realtime_chat/widgets/headers.dart';

class EncabezadoSupplier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: const [
              IconHeader(
                titulo: 'Proveedores',
                color1: Color(0xff317183),
                color2: Color(0xff46997D),
                grosor: 175,
              ),
            ],
          ),
          ProveedoresPage(),
        ],
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
              elevation: 5,
              backgroundColor: Color.fromARGB(255, 3, 131, 124),
              foregroundColor: Color.fromARGB(255, 114, 245, 201),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => const CreateProveedorPage()))),
        ),
      ),
    );
  }
}

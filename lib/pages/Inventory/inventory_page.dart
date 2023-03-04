import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/producto.dart';
import 'package:realtime_chat/pages/Inventory/details_products_page.dart';
import 'package:realtime_chat/pages/Inventory/tabs_page.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/widgets/headers.dart';

class EncabezadoInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade300,
      body: Column(
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
          Paginas(),
          //ProductsGalleryPage(),
        ],
      ),
      bottomNavigationBar: Navegacion(),
    );
  }
}



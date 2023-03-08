import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/models/uniqueproducto.dart';
import 'package:realtime_chat/pages/Inventory/details_products_page.dart';
import 'package:realtime_chat/pages/Inventory/inventory_page.dart';
import 'package:realtime_chat/pages/Patients/patient_page.dart';
import 'package:realtime_chat/pages/Receta/receta_page.dart';
import 'package:realtime_chat/pages/Stock/stock_page.dart';
import 'package:realtime_chat/pages/Suppliers/supplier_page.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/services/System/auth_service.dart';
import 'package:realtime_chat/services/System/socket_service.dart';

import 'package:realtime_chat/widgets/headers.dart';
import 'package:realtime_chat/widgets/boton_gordo.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final void Function()? onTap;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.texto, this.color1, this.color2, this.onTap);
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _data = "";

  Future<void> scan() async {
    var status = await Permission.camera.status;
    // print(status);
    if (status.isGranted) {
      String barcodeScanRes;
      try {
      // Platform messages may fail, so we use a try/catch PlatformException.
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      setState(() {
        _data = barcodeScanRes;
        // print("CCCCCCCCCC");
      });
      // print("BBBBBBB");
      // final productService = new ProductsService();
      // Producto? producto;
      // producto = await productService.getProductforId(_data);
      // // Añadir producto
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DetailsProductsPage(
      //       name: producto!.nombre,
      //       fechaCreacion: producto!.fechaCreacion,
      //       fechaVencimiento: producto!.fechaVencimiento,
      //       imagePath: producto!.foto,
      //       index: 1,
      //     ),
      //   ),
      // );
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }
      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;
    } else {
      var a = await Permission.camera.request();
      if (a.isPermanentlyDenied) {
        openAppSettings();
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final items = <ItemBoton>[
      ItemBoton(
        FontAwesomeIcons.box,
        'Inventario',
        Color(0xff6989F5),
        Color(0xff906EF5),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => EncabezadoInventory())),
      ),
      ItemBoton(
        FontAwesomeIcons.boxesPacking,
        'Stock',
        Color(0xff66A9F2),
        Color(0xff536CF6),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => EncabezadoStock())),
      ),
      ItemBoton(
        FontAwesomeIcons.hospitalUser,
        'Pacientes',
        Color(0xffF2D572),
        Color(0xffE06AA3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => EncabezadoPatient())),
      ),
      ItemBoton(
        FontAwesomeIcons.userGroup,
        'Proveedores',
        Color(0xff317183),
        Color(0xff46997D),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => EncabezadoSupplier())),
      ),
      ItemBoton(
        FontAwesomeIcons.receipt,
        'Receta Electrónica',
        Color(0xff6989F5),
        Color(0xff906EF5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => RecetaPage())),
      ),
      ItemBoton(
        FontAwesomeIcons.barcode,
        'Código de Barra',
        Color(0xff66A9F2),
        Color(0xff536CF6),
        () => scan(),
      ),
      ItemBoton(Icons.logout, 'Logout', Colors.red, Colors.orangeAccent, () {
        socketService.disconenct();
        Navigator.pushReplacementNamed(context, 'login');
        AuthService.deleteToken();
      }),
      // new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
      //     Color(0xff46997D)),
      // new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
      //     Color(0xff6989F5), Color(0xff906EF5)),
      // new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
      //     Color(0xff66A9F2), Color(0xff536CF6)),
      // new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
      //     Color(0xffF2D572), Color(0xffE06AA3)),
      // new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
      //     Color(0xff46997D)),
    ];

    List<Widget> itemMap = items
        .map((item) => FadeInLeft(
              duration: Duration(milliseconds: 250),
              child: BotonGordo(
                icon: item.icon,
                texto: item.texto,
                color1: item.color1,
                color2: item.color2,
                onPress: item.onTap,
              ),
            ))
        .toList();

    return Scaffold(
      // backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 200),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                ...itemMap
              ],
            ),
          ),
          _Encabezado()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "MainButton",
        backgroundColor: Colors.green.shade900,
        child: Icon(Icons.message),
        onPressed: () {
          // socketService.emit('emitir-mensaje',
          //     {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
          Navigator.pushNamed(context, 'usuarios');
        },
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Stack(
          children: [
            IconHeader(
              titulo: 'Farma Plus',
              logo: 'images/logo_snake.png',
              color1: Color(0xff536CF6),
              color2: Color(0xff66A9F2),
              grosor: 300,
            ),
          ],
        ),
        Positioned(
            right: 0,
            top: 45,
            child: RawMaterialButton(
                onPressed: () {},
                shape: CircleBorder(),
                padding: EdgeInsets.all(15.0),
                child: FaIcon(FontAwesomeIcons.ellipsisV, color: Colors.white)))
      ],
    );
  }
}

class BotonGordoTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotonGordo(
      icon: FontAwesomeIcons.carCrash,
      texto: 'Motor Accident',
      color1: Color(0xff6989F5),
      color2: Color(0xff906EF5),
      onPress: () {
        print('Click!');
      },
    );
  }
}

// class PageHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return IconHeader(
//       icon: FontAwesomeIcons.plus,
//       titulo: 'Asistencia Médica',
//       color1: Color(0xff526BF6),
//       color2: Color(0xff67ACF2),
//     );
//   }
//}

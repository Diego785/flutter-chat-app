import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/pages/Stock/create_lote_page.dart';
import 'package:realtime_chat/pages/Stock/lotes_page.dart';
import 'package:realtime_chat/widgets/headers.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/components/loading_page.dart';
import 'package:realtime_chat/models/Inventary/lote.dart';
import 'package:realtime_chat/pages/Stock/edit_lote_page.dart';
import 'package:realtime_chat/services/Inventory/lote_service.dart';

import 'package:realtime_chat/services/System/socket_service.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';

List<Lote> lotes = [];

class EncabezadoStock extends StatefulWidget {
  @override
  State<EncabezadoStock> createState() => _EncabezadoStockState();
}

class _EncabezadoStockState extends State<EncabezadoStock> {
  void _cargarProducts() async {
    final lotesService = LoteService();
    lotes = await lotesService.getLotes();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _cargarProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (lotes.isEmpty)
        ? const LoadingPage2()
        : Scaffold(
            body: Column(
              children: <Widget>[
                Stack(
                  children: const [
                    IconHeader(
                      titulo: 'Stock',
                      color1: Color(0xff536CF6),
                      color2: Color(0xff66A9F2),
                      grosor: 175,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                LotesPage(),
                // Text("Hola Mundo"),
              ],
            ),
            floatingActionButton: Container(
              width: 75,
              height: 75,
              child: FittedBox(
                child: FloatingActionButton(
                    heroTag: "StockPage",
                    elevation: 5,
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.black,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateLotePage(),
                        ),
                      );
                    }),
              ),
            ),
          );
  }
}

class LotesPage extends StatefulWidget {
  const LotesPage({super.key});

  @override
  State<LotesPage> createState() => _LotesPageState();
}

class _LotesPageState extends State<LotesPage> {
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  // void _load() {
  //   setState(() {});
  //   _refreshController.refreshCompleted();
  // }

  @override
  void initState() {
    super.initState();
  }

  final leftEditIcon = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: const Color.fromARGB(255, 94, 102, 168).withOpacity(0.5),
    alignment: Alignment.center,
    child: const Icon(Icons.edit, color: Colors.white),
  );

  final rightEditIcon = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: const Color.fromARGB(255, 94, 102, 168).withOpacity(0.5),
    alignment: Alignment.center,
    child: const Icon(Icons.delete, color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) {
          return Expanded(
            child: Dismissible(
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
                          builder: ((context) => EditLotePage(
                                lote: lotes[i],
                              ))));
                  return false;
                } else {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent.withOpacity(0.1),
                      barrierColor: Colors.transparent.withOpacity(0.9),
                      context: context,
                      builder: (_) {
                        return Container(
                          height: 550,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2e3253).withOpacity(0.4),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Colocar los botones
                                const Text(
                                  "Información del Lote: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: Image.network(
                                    lotes[i].producto.foto,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Id: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      lotes[i].id,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan.shade500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Fecha de Creación: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      lotes[i].fechaCreacion.toString(),
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan.shade500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Fecha de Expiración: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      lotes[i].fechaVencimiento.toString(),
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan.shade500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Fecha de Entrega: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      lotes[i].fechaEntrega.toString(),
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan.shade500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  return false;
                }
              },
              key: ObjectKey(i),
              child: Container(
                height: 150,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color:
                          Color.fromARGB(255, 53, 58, 126).withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _imageSection(lotes[i]),
                    SizedBox(width: 15),
                    _detailSection(lotes[i]),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, i) => Divider(
          thickness: 10,
          color: Colors.transparent,
        ),
        itemCount: lotes.length,
        padding: EdgeInsets.all(12),
      ),
    );
  }

  // ListView _listViewProducts() {
  //   return ListView.separated(
  //     physics: BouncingScrollPhysics(),
  //     itemBuilder: (_, i) => _productoListTile(productos[i]),
  //     separatorBuilder: (_, i) => Divider(),
  //     itemCount: productos.length,
  //   );
  // }

  // ListTile _productoListTile(Product producto) {
  //   return ListTile(
  //     title: Text(producto.nombre),
  //     subtitle: Text(producto.fechaVencimiento.toString()),
  //     leading: CircleAvatar(
  //       child: Text(producto.nombre.substring(0, 2)),
  //       backgroundColor: Colors.blue[100],
  //     ),

  //   );
  // }
}

class LotesContainer extends StatelessWidget {
  final Lote lote;
  const LotesContainer({
    Key? key,
    required this.lote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
          _imageSection(lote),
          SizedBox(width: 15),
          _detailSection(lote),
        ],
      ),
    );
  }
}

Container _imageSection(Lote lote) {
  return Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
        color: Colors.cyan.shade500,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(lote.producto.foto), fit: BoxFit.cover)),
  );
}

Column _detailSection(Lote lote) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Id: ' + lote.id.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Nombre: ' + lote.producto.nombre.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Row(
        children: [
          Text(
            'Cantidad: ' + lote.cantidad.toString(),
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
      Row(
        children: [
          Text(
            'Fecha de Creación: ',
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
            lote.fechaCreacion.toString().substring(0, 10),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10,
      ),
      Row(
        children: [
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
            lote.fechaVencimiento.toString().substring(0, 10),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10,
      ),
      Row(
        children: [
          Text(
            'Fecha de Entrega: ',
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
            lote.fechaEntrega.toString().substring(0, 10),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ],
  );
}

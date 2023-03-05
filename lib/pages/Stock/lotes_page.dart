import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/Inventary/lote.dart';
import 'package:realtime_chat/services/Inventory/lote_service.dart';

import 'package:realtime_chat/services/System/socket_service.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';

class LotesPage extends StatefulWidget {
  @override
  State<LotesPage> createState() => _LotesPageState();
}

class _LotesPageState extends State<LotesPage> {
  List<Lote> lotes = [];

  _cargarProducts() async {
    final lotesService = LoteService();
    lotes = await lotesService.getLotes();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _cargarProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarProducts,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue,
        ),
        child: _listViewProducts(),
      ),
    );
   
  }

  ListView _listViewProducts() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => LotesContainer(lote: lotes[i]),
      separatorBuilder: (_, i) => Divider(
        thickness: 10,
        color: Colors.transparent,
      ),
      itemCount: lotes.length,
      padding: EdgeInsets.all(12),
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
        image: DecorationImage(image: NetworkImage(lote.producto.foto), fit: BoxFit.cover)),
  );
}

Column _detailSection(Lote lote) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
             lote.fechaVencimiento.toString().substring(0, 10),
             style: TextStyle(
               color: Colors.black,
               fontSize: 14,
               fontWeight: FontWeight.w400,
             ),
       ),
    ],
  );
}

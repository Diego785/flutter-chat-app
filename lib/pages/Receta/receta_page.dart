import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/receta.dart';
import 'package:realtime_chat/pages/Receta/recetas.dart';
import 'package:realtime_chat/services/recetas_service.dart';


class RecetaPage extends StatefulWidget {
  @override
  State<RecetaPage> createState() => _RecetaPageState();
}

class _RecetaPageState extends State<RecetaPage> {
  final recetasService = new RecetasService();
  List<MyReceta> recetas = [];


  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._cargarRecetas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recetaService = Provider.of<RecetasService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Lista de Recetas",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        /*leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
          onPressed: () {
            //TODO: Desconectarnos del socket server
            socketService.disconenct();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),*/
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(right: 10),
        //     child: socketService.serverStatus == ServerStatus.Online
        //         ? Icon(Icons.check_circle, color: Colors.blue[400])
        //         : Icon(Icons.offline_bolt, color: Colors.red),
        //   ),
        // ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarRecetas,
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
      itemBuilder: (_, i) => RecetasContainer(receta: recetas[i]),
      separatorBuilder: (_, i) => Divider(
        thickness: 10,
        color: Colors.transparent,
      ),
      itemCount: recetas.length,
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

  _cargarRecetas() async {
    this.recetas = await recetasService.getRecetas();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

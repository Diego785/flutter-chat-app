import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/pages/productos.dart';

import 'package:realtime_chat/services/socket_service.dart';
import 'package:realtime_chat/models/producto.dart';
import 'package:realtime_chat/services/productos_service.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final productsService = new ProductsService();
  List<Product> productos = [];


  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._cargarProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Socket Notificaitons - List of Products",
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
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.blue[400])
                : Icon(Icons.offline_bolt, color: Colors.red),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarProducts,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue,
        ),
        child: _listViewProducts(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          socketService.emit('emitir-mensaje',
              {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
        },
      ),
    );
  }

  /*ListView _listViewProducts() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _productoListTile(productos[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: productos.length,
    );
  }

  ListTile _productoListTile(Product producto) {
    return ListTile(
      title: Text(producto.nombre),
      subtitle: Text(producto.fechaVencimiento.toString()),
      leading: CircleAvatar(
        child: Text(producto.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      
      
    );
  }*/

  ListView _listViewProducts() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => ProductosContainer(producto: productos[i]),
      separatorBuilder: (_, i) => Divider(
        thickness: 10,
        color: Colors.transparent,
      ),
      itemCount: productos.length,
      padding: EdgeInsets.all(12),
    );
  }

  _cargarProducts() async {
    this.productos = await productsService.getProducts();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

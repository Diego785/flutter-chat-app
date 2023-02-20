import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/uniqueproducto.dart';
import 'package:realtime_chat/services/productos_service.dart';

class EjemploScreen extends StatefulWidget {
  final String codigo;
  const EjemploScreen(this.codigo, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EjemploState();
}

class _EjemploState extends State<EjemploScreen> {
  final productosService = new ProductsService();
  Producto? producto;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    String codigo = widget.codigo;
    this._cargarProducto(codigo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
        ),
        body:  Center(
            child: Text('Nombre: ${producto!.nombre}'),
        ),
    );
  }
  _cargarProducto(String codigo) async {
    this.producto = await productosService.getProductforId(codigo);
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

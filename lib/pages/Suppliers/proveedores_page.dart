import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/proveedor.dart';
import 'package:realtime_chat/pages/Suppliers/proveedores_container.dart';
import 'package:realtime_chat/services/proveedor.dart';

class ProveedoresPage extends StatefulWidget {
  const ProveedoresPage({super.key});
  @override
  State<ProveedoresPage> createState() => _ProveedoresPageState();
}

class _ProveedoresPageState extends State<ProveedoresPage> {
  // lista donde cargare los proveedores
  List<Proveedor> proveedores = [];
  final proveedoresService = new ProveedorService();
  //para refrecar la pagina
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._cargarProveedores();
    super.initState();
  }

  _cargarProveedores() async {
    this.proveedores = await proveedoresService.getProveedores();
    // print("$proveedores" + "mi nombre");
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarProveedores,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Color(0xff46997D),
        ),
        child: _listViewProveedores(),
      ),
    );
  }

  ListView _listViewProveedores() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => ProveedoresContainer(proveedor: proveedores[i]),
      separatorBuilder: (_, i) => Divider(
        thickness: 10,
        color: Colors.transparent,
      ),
      itemCount: proveedores.length,
      padding: EdgeInsets.all(12),
    );
  }
}

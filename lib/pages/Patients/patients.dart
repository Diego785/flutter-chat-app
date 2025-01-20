import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/paciente.dart';
import 'package:realtime_chat/services/paciente.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  List<MyPaciente2> pacientes = [];
  final pacientesService = new PacienteService();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _cargarPacientes() async {
    this.pacientes = await pacientesService.getUsuarioPaciente();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    this._cargarPacientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarPacientes,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.orange,
        ),
        child: _listViewPacientes(),
      ),
    );
  }

  ListView _listViewPacientes() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => PacientesContainer(paciente: pacientes[i]),
      separatorBuilder: (_, i) => Divider(
        thickness: 10,
        color: Colors.transparent,
      ),
      itemCount: pacientes.length,
      padding: EdgeInsets.all(12),
    );
  }
}

class PacientesContainer extends StatelessWidget {
  final MyPaciente2 paciente;
  const PacientesContainer({
    Key? key,
    required this.paciente,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
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
          SizedBox(width: 10),
          _detailSection(paciente),
        ],
      ),
    );
  }
}

Column _detailSection(MyPaciente2 paciente) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Nombre: ' + paciente.usuario.nombre.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Apellido: ' + paciente.usuario.apellido.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Direccion: ' + paciente.usuario.direccion.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Telefono: ' + paciente.usuario.telefono.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Fecha: ' + paciente.fechaNacimiento.toString().substring(0, 10),
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

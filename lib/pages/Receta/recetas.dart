import 'package:flutter/material.dart';
import 'package:realtime_chat/models/receta.dart';
import 'package:realtime_chat/pages/Receta/receta_pdf.dart';

class RecetasContainer extends StatelessWidget {
  final MyReceta receta;
  const RecetasContainer({
    Key? key,
    required this.receta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _detailSection(receta),
          Align(
            alignment: Alignment.center,
            child: _button(
                receta.id,
                receta.cliente.usuario.nombre,
                receta.cliente.usuario.apellido,
                receta.cliente.usuario.telefono,
                receta.cliente.usuario.direccion,
                receta.fecha,
                context),
          )
        ],
      ),
    );
  }
}

FloatingActionButton _button(String idReceta, String nombre, String apellido,
    String telefono, String direccion, DateTime fecha, BuildContext context) {
  return FloatingActionButton.extended(
      heroTag: idReceta,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      onPressed: () {
        // print(idReceta);
        createPDF(
            idReceta, nombre, apellido, telefono, direccion, fecha, context);
      },
      backgroundColor: Colors.red,
      icon: const Icon(Icons.picture_as_pdf),
      label: const Text(
        'Generar PDF',
        style: TextStyle(color: Colors.white),
      ));
}

Container _imageSection() {
  return Container(
    height: 70,
    width: 90,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 69, 222, 176),
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            image: NetworkImage(
                "https://img.freepik.com/vector-gratis/receta-medica-blister-pastillas-sujecion-manual-paciente-tomando-medicacion-ilustracion-vectorial-plana-tratamiento-atencion-medica-concepto-farmacia-banner-diseno-sitio-web-o-pagina-web-destino_74855-24920.jpg",
                scale: 15))),
  );
}

Column _detailSection(MyReceta receta) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Paciente: ',
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        receta.cliente.usuario.nombre,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        receta.cliente.usuario.apellido,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      const Text(
        'Fecha de emisión: ',
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        receta.fecha.toString().substring(0, 10),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

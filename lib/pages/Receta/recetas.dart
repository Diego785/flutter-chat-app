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
      height: 100,
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
          // _imageSection(),
          // SizedBox(width: 15),
          _detailSection(receta),
          SizedBox(width: 40),
          _button(receta.id, receta.cliente.nombre, receta.fecha)
        ],
      ),
    );
  }
}

FloatingActionButton _button(String idReceta, String nombre, DateTime fecha) {
  return FloatingActionButton.extended(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      onPressed: () {
        // print(idReceta);
        createPDF(idReceta, nombre, fecha);
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
      Row(
        children: [
          Text(
            'Paciente: ' + receta.cliente.nombre,
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
        'Fecha de emisión: ',
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
        receta.fecha.toString().substring(0, 10),
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

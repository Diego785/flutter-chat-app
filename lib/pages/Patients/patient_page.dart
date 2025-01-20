import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/pages/Patients/patients.dart';
import 'package:realtime_chat/widgets/headers.dart';

class EncabezadoPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              IconHeader(
                titulo: 'Patients',
                color1: Color(0xffE06AA3),
                color2: Color(0xffF2D572),
                grosor: 175,
              ),
            ],
          ),
          PatientsPage()
        ],
      ),
    );
  }
}

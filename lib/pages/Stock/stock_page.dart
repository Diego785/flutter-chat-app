import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/pages/Stock/lotes_page.dart';
import 'package:realtime_chat/widgets/headers.dart';

class EncabezadoStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Positioned(
            right: 0,
            top: 45,
            child: RawMaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              padding: EdgeInsets.all(15.0),
              child: FaIcon(FontAwesomeIcons.ellipsisV, color: Colors.white),
            ),
          ),
          LotesPage(),
        ],
      ),
    );
  }
}

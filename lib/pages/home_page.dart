// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:realtime_chat/services/auth_service.dart';
// import 'package:realtime_chat/services/socket_service.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late SocketService socketService;

//   @override
//   void initState() {
//     super.initState();

//     socketService = Provider.of<SocketService>(context, listen: false);
//     socketService.connect();
//   }

//   @override
//   Widget build(BuildContext context) {
//     socketService = Provider.of<SocketService>(context);
//     final authService = Provider.of<AuthService>(context);
//     final usuario = authService.usuario;

//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             usuario.nombre,
//             style: TextStyle(color: Colors.black87),
//           ),
//         ),
//         elevation: 1,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.exit_to_app,
//             color: Colors.black87,
//           ),
//           onPressed: () {
//             //TODO: Desconectarnos del socket server
//             socketService.disconenct();
//             Navigator.pushReplacementNamed(context, 'login');
//             AuthService.deleteToken();
//           },
//         ),
//         actions: [
//           Container(
//             margin: EdgeInsets.only(right: 10),
//             child: socketService.serverStatus == ServerStatus.Online
//                 ? Icon(Icons.check_circle, color: Colors.blue[400])
//                 : Icon(Icons.offline_bolt, color: Colors.red),
//           ),
//         ],
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               socketService.serverStatus == ServerStatus.Online
//                   ? Icon(Icons.check_circle, color: Colors.blue[400], size: 70)
//                   : const Icon(Icons.offline_bolt, color: Colors.red, size: 70),
//               /*Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 margin: EdgeInsets.only(top: 400, right: 90, left: 90),
//                 decoration: BoxDecoration(
//                   color: (socketService.serverStatus == ServerStatus.Online)?
//                   Colors.red[900]: Colors.green[500],
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     ListTile(
//                       title: (socketService.serverStatus == ServerStatus.Online)?
//                        const Text(
//                         "Desconectar Socket!!!",
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontStyle: FontStyle.italic),
//                       ): const Text(
//                         "Conectar Socket!!!",
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontStyle: FontStyle.italic),
//                       ),
//                       trailing:(socketService.serverStatus == ServerStatus.Online)

//                       ?Icon(
//                         Icons.offline_bolt,
//                         color: Colors.yellow[600],
//                       ): Icon(
//                         Icons.check_circle,
//                         color: Colors.white,
//                       ),
//                       onTap: () {
//                         if (socketService.serverStatus == ServerStatus.Online) {
//                           socketService.disconenct();
//                         } else {
//                           socketService.connect();
//                         }
//                       },
//                     ),
//                     ListTile(
//                       title:
//                        const Text(
//                         "Ver Productos",
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Color.fromARGB(255, 28, 28, 28),
//                             fontStyle: FontStyle.italic),
//                       ),
//                       trailing:Icon(
//                         Icons.visibility,
//                         color: Colors.white,
//                       ),
//                       onTap: () {
//                         if (socketService.serverStatus == ServerStatus.Online) {
//                           socketService.disconenct();
//                         } else {
//                           socketService.connect();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),*/
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 margin: EdgeInsets.only(top: 200, right: 90, left: 90),
//                 decoration: BoxDecoration(
//                   color: (socketService.serverStatus == ServerStatus.Online)
//                       ? Colors.red[900]
//                       : Colors.green[500],
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: ListTile(
//                   title: (socketService.serverStatus == ServerStatus.Online)
//                       ? const Text(
//                           "Desconectar Socket!!!",
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontStyle: FontStyle.italic),
//                         )
//                       : const Text(
//                           "Conectar Socket!!!",
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontStyle: FontStyle.italic),
//                         ),
//                   trailing: (socketService.serverStatus == ServerStatus.Online)
//                       ? Icon(
//                           Icons.offline_bolt,
//                           color: Colors.yellow[600],
//                         )
//                       : Icon(
//                           Icons.check_circle,
//                           color: Colors.white,
//                         ),
//                   onTap: () {
//                     if (socketService.serverStatus == ServerStatus.Online) {
//                       socketService.disconenct();
//                     } else {
//                       socketService.connect();
//                     }
//                   },
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 margin: EdgeInsets.only(top: 50, right: 90, left: 90),
//                 decoration: BoxDecoration(
//                   color: Colors.blueAccent,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: ListTile(
//                   title: const Text(
//                     "Ver Productos",
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                         fontStyle: FontStyle.italic),
//                   ),
//                   trailing: Icon(
//                     Icons.visibility,
//                     color: Colors.white,
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(context, 'products');
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.message),
//         onPressed: () {
//           // socketService.emit('emitir-mensaje',
//           //     {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
//           socketService.connect();

//           Navigator.pushNamed(context, 'usuarios');
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/services/socket_service.dart';
import 'package:realtime_chat/widgets/my_button.dart';

class BodyMainPage extends StatefulWidget {
  const BodyMainPage({super.key});

  @override
  State<BodyMainPage> createState() => _BodyMainPageState();
}

class _BodyMainPageState extends State<BodyMainPage> {
  late SocketService socketService;

  @override
  void initState() {
    super.initState();

    socketService = Provider.of<SocketService>(context, listen: false);
    socketService.connect();
  }

  @override
  Widget build(BuildContext context) {
    socketService = Provider.of<SocketService>(context);

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/Pharmacy_logo.png",
              scale: 2,
            ),

            /*  socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.blue[400], size: 70)
                : const Icon(Icons.offline_bolt, color: Colors.red, size: 70),*/
            /*Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.only(top: 400, right: 90, left: 90),
                decoration: BoxDecoration(
                  color: (socketService.serverStatus == ServerStatus.Online)? 
                  Colors.red[900]: Colors.green[500],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: (socketService.serverStatus == ServerStatus.Online)?
                       const Text(
                        "Desconectar Socket!!!",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ): const Text(
                        "Conectar Socket!!!",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                      trailing:(socketService.serverStatus == ServerStatus.Online)

                      ?Icon(
                        Icons.offline_bolt,
                        color: Colors.yellow[600],
                      ): Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      onTap: () {
                        if (socketService.serverStatus == ServerStatus.Online) {
                          socketService.disconenct();
                        } else {
                          socketService.connect();
                        }
                      },
                    ),
                    ListTile(
                      title:
                       const Text(
                        "Ver Productos",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 28, 28, 28),
                            fontStyle: FontStyle.italic),
                      ),
                      trailing:Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ),
                      onTap: () {
                        if (socketService.serverStatus == ServerStatus.Online) {
                          socketService.disconenct();
                        } else {
                          socketService.connect();
                        }
                      },
                    ),
                  ],
                ),
              ),*/
            /*Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(top: 200, right: 90, left: 90),
              decoration: BoxDecoration(
                color: (socketService.serverStatus == ServerStatus.Online)
                    ? Colors.red[900]
                    : Colors.green[500],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              
              child: ListTile(
                title: (socketService.serverStatus == ServerStatus.Online)
                    ? const Text(
                        "Desconectar Socket!!!",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      )
                    : const Text(
                        "Conectar Socket!!!",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                trailing: (socketService.serverStatus == ServerStatus.Online)
                    ? Icon(
                        Icons.offline_bolt,
                        color: Colors.yellow[600],
                      )
                    : Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                onTap: () {
                  if (socketService.serverStatus == ServerStatus.Online) {
                    socketService.disconenct();
                  } else {
                    socketService.connect();
                  }
                },
              ),
            ),*/
            MyButton(buttonText: "Inventario", buttonColor: Colors.blueAccent, buttonIcon: Icons.add_box),
            MyButton(buttonText: "Stock", buttonColor: Colors.cyan, buttonIcon: Icons.check_box),
            MyButton(buttonText: "Clientes", buttonColor: Colors.blueAccent, buttonIcon: Icons.person),
            MyButton(buttonText: "Proveedor", buttonColor: Colors.cyan, buttonIcon: Icons.delivery_dining),
            MyButton(buttonText: "Salir", buttonColor: Colors.redAccent, buttonIcon: Icons.logout),
          
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Stack(
        children: [
          HeaderWave(),
          BodyMainPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          // socketService.emit('emitir-mensaje',
          //     {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
          Navigator.pushNamed(context, 'usuarios');
        },
      ),
    );
  }
}

class HeaderWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1000,
          width: double.infinity,
          child: CustomPaint(
            painter: _HeaderWavePainter(),
          ),
        ),
      ],
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Colors.cyan.shade800;
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.30,
        size.width * 0.5, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.20, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/Inventary/specific-products.dart';
import 'package:realtime_chat/pages/Inventory/inventory_page.dart';
import 'package:realtime_chat/services/Inventory/inventory_service.dart';

import 'package:realtime_chat/services/System/auth_service.dart';
import 'package:realtime_chat/services/System/chat_service.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/services/recetas_service.dart';
import 'package:realtime_chat/services/System/socket_service.dart';

import 'package:realtime_chat/routes/routes.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

//import 'package:workmanager/workmanager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*print("Executing Socket through Workmanager successfully in the main!!!");

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  // Periodic task registration
  await Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
    //frequency: const Duration(minutes: 15),
  );*/
  /*MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SocketService()),
    ],
  );*/
  WidgetsFlutterBinding.ensureInitialized();

  ChangeNotifierProvider<SocketService>(
    create: (context) => SocketService(),
  );

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    //'resource://drawable/res_app_icon',
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Testing my notifications',
        channelDescription: 'Testing notifications for using sockets',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
        playSound: true,
        importance: NotificationImportance.High,
      )
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
    debug: true,
  );

  final cron = Cron();
  List<SpecificProduct> productos;
  ProductsService productsService;
  cron.schedule(
      Schedule.parse('*/1 * * * *'),
      () async => {
            SocketService().connect(),
            print('Every minute'),
            productos = [],
            productsService = new ProductsService(),
            productos = await productsService.getProductwithExpirationDate(),
            if (productos.isNotEmpty)
              {
                AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    id: 10,
                    channelKey: 'basic_channel',
                    title: 'Productos próximos a vencerse: ',
                    body: changetoDays(productos).toString(),
                    // body: (productos)
                    //     .map((producto) => (changetoDays(
                    //         producto.producto.nombre,
                    //         producto.fechaVencimiento)))
                    //     .toString(),
                    notificationLayout: NotificationLayout.BigText,
                    actionType: ActionType.Default,
                  ),
                ),
              }
          });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => InventoryService()),
        ChangeNotifierProvider(create: (_) => NavegacionModel()),
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => RecetasService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}

String changetoDays(List<SpecificProduct> productos) {
  String salida = '';
  String salida2 = "Un lote del producto";
  final DateTime now = DateTime.now();
  DateTime fechaActual = DateTime(now.year, now.month, now.day);
  for (var i = 0; i < productos.length; i++) {
    DateTime fecha1 = DateTime(productos[i].fechaVencimiento.year,
        productos[i].fechaVencimiento.month, productos[i].fechaVencimiento.day);
    int diastotales = fecha1.difference(fechaActual).inDays;
    if (diastotales == 0) {
      salida =
          salida + "$salida2 ${productos[i].producto.nombre} se venció hoy";
    } else if (diastotales == 1) {
      salida =
          salida + "$salida2 ${productos[i].producto.nombre} se vencerá mañana";
    } else {
      salida = salida +
          "$salida2 ${productos[i].producto.nombre} se vencerá en $diastotales días";
    }
    if (i + 1 < productos.length) {
      salida = salida + ", ";
    }
  }
  crearNotificacion(salida, productos);
  return salida;
}

// String changetoDays(String producto, DateTime fecha) {
//   String salida = '';
//   String salida2 = "Un lote del producto";
//   final DateTime now = DateTime.now();
//   DateTime fecha1 = DateTime(fecha.year, fecha.month, fecha.day);
//   DateTime fechaActual = DateTime(now.year, now.month, now.day);
//   int diastotales = fecha1.difference(fechaActual).inDays;
//   if (diastotales == 0) {
//     salida = "$salida2 $producto se venció hoy";
//   } else if (diastotales == 1) {
//     salida = "$salida2 $producto se vencerá mañana";
//   } else {
//     salida = "$salida2 $producto se vencerá en $diastotales días";
//   }
//   // crearNotificacion(salida);
//   return salida;
// }

crearNotificacion(String contenido, List<SpecificProduct> productos) async {
  final uri = Uri.parse('${Environment.apiUrl}/cuerpos/new');
  final resp = await http.post(
    uri,
    body: jsonEncode({
      'contenido': contenido,
      'lotes': productos,
    }),
    headers: {'Content-Type': 'application/json'},
  );
}

// crearNotificacion(String salida) async {
//   final uri = Uri.parse('${Environment.apiUrl}/notificaciones/new');
//   final resp = await http.post(
//     uri,
//     body: jsonEncode({
//       'salida': salida,
//     }),
//     headers: {'Content-Type': 'application/json'},
//   );
// }

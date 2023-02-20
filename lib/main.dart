import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/pages/Inventory/tabs_page.dart';
import 'package:realtime_chat/services/Inventory/inventory_service.dart';

import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/services/socket_service.dart';

import 'package:realtime_chat/routes/routes.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';

//import 'package:workmanager/workmanager.dart';


void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
  print("Executing Socket through Workmanager successfully in the main!!!");

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
  cron.schedule(
      Schedule.parse('*/1 * * * *'),
      () async => {
            SocketService().connect(),

            print('Every minute'),
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: 'Productos próximos a vencerse: ',
                body: (await ProductsService().getProductwithExpirationDate()).isNotEmpty?
                (await ProductsService().getProductwithExpirationDate()) 
                    .map(
                      (producto) =>
                          "${producto.nombre} - ${producto.fechaVencimiento.toString().substring(0, 10)}",
                    )
                    .toString()
                    : "No hay productos próximos a vencerse :)",
                    notificationLayout: NotificationLayout.BigText,
                actionType: ActionType.Default,
              ),
            ),
          });
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) =>AuthService()),
        ChangeNotifierProvider(create: ( _ ) =>SocketService()),
        ChangeNotifierProvider(create: ( _ ) =>ChatService()),
        ChangeNotifierProvider(create: ( _ ) =>InventoryService()),
        ChangeNotifierProvider(create: ( _ ) =>NavegacionModel()),
        ChangeNotifierProvider(create: ( _ ) =>ProductsService()),
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

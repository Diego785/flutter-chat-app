

import 'package:flutter/material.dart';
import 'package:realtime_chat/pages/Home/home_page.dart';
import 'package:realtime_chat/pages/Receta/receta_create.dart';
import 'package:realtime_chat/pages/System/loading_page.dart';
import 'package:realtime_chat/pages/System/login_page.dart';
import 'package:realtime_chat/pages/Inventory/productos_page.dart';
import 'package:realtime_chat/pages/System/register_page.dart';
import 'package:realtime_chat/pages/Chat/usuarios_page.dart';
import 'package:realtime_chat/pages/Chat/chat_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': ( _ ) => HomePage(),
  'products': (_) => ProductsPage(),
  'usuarios': ( _ ) => UsuariosPage(),
  'loading': ( _ ) => LoadingPage(),
  'login': ( _ ) => LoginPage(),
  'register': ( _ ) => RegisterPage(),
  'chat': ( _ ) => ChatPage(),
  'example': ( _ ) => RecetaCreate(),
};
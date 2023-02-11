

import 'package:flutter/material.dart';
import 'package:realtime_chat/pages/chat_page.dart';
import 'package:realtime_chat/pages/loading_page.dart';
import 'package:realtime_chat/pages/login_page.dart';
import 'package:realtime_chat/pages/productos_page.dart';
import 'package:realtime_chat/pages/register_page.dart';
import 'package:realtime_chat/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': ( _ ) => UsuariosPage(),
  'products': (_) => ProductsPage(),
  'usuarios': ( _ ) => UsuariosPage(),
  'loading': ( _ ) => LoadingPage(),
  'login': ( _ ) => LoginPage(),
  'register': ( _ ) => RegisterPage(),
  'chat': ( _ ) => ChatPage(),
};
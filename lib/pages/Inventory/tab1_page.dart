import 'package:flutter/material.dart';
import 'package:realtime_chat/components/loading_page.dart';
import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/lote.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
// import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/pages/Inventory/details_products_page.dart';

import 'package:realtime_chat/services/Inventory/inventory_service.dart';
import 'package:realtime_chat/services/Inventory/lote_service.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/theme/tema.dart';
import 'package:provider/provider.dart';

List<Producto> products = [];
List<Producto> productsByCategory = [];
List<Category> categoriesProducts = [];
List<Lote> lotes = [];

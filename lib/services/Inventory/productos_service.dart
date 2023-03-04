import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/productos.dart';
import 'package:realtime_chat/models/specific-products.dart';
import 'package:realtime_chat/models/producto.dart';
import 'package:realtime_chat/models/uniqueproducto.dart';
import 'package:realtime_chat/services/auth_service.dart';

class ProductsService with ChangeNotifier {
  Future<List<Product>> getProducts() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/productos');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosResponseFromJson(resp.body);
      print(productResponse.myProducts);
      return productResponse.myProducts;
    } catch (error) {
      print('error');
      return [];
    }
  }

  Future<List<Product>> getAvailableProducts() async {
    try {
      final uri =
          Uri.parse('${Environment.apiUrl}/productos/available-products');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosResponseFromJson(resp.body);
      return productResponse.myProducts;
    } catch (error) {
      return [];
    }
  }

  Future<List<Product>> getExpiratedProducts() async {
    try {
      final uri =
          Uri.parse('${Environment.apiUrl}/productos/expirated-products');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosResponseFromJson(resp.body);
      return productResponse.myProducts;
    } catch (error) {
      return [];
    }
  }

  Future<List<SpecificProduct>> getProductwithExpirationDate() async {
    try {
      final uri =
          Uri.parse('${Environment.apiUrl}/productos/specific-products');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = specificProductosResponseFromJson(resp.body);
      return productResponse.myProducts;
    } catch (error) {
      return [];
    }
  }

  // Future<Producto?> getProductforId(String productoID) async {
  //   try {
  //     final uri = Uri.parse(
  //         '${Environment.apiUrl}/productos/unique-product/$productoID');
  //     final resp;
  //     final token = await AuthService.getToken();

  //     if (token != null) {
  //       print('TOKEN NO NULL');

  //       resp = await http.get(uri,
  //           headers: {'Content-Type': 'application/json', 'x-token': token});
  //     } else {
  //       print('TOKEN NULL');

  //       resp = await http.get(uri, headers: {
  //         'Content-Type': 'application/json',
  //       });
  //     }

  //     final productoResponse = uniqueProductoFromJson(resp.body);
  //     return productoResponse.producto;
  //   } catch (error) {
  //     return null;
  //   }
  // }

  Future<List<MyProduct>> getProductsName() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/productos/allproducts');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosFromJson(resp.body);
      print(productResponse.myProducts);
      return productResponse.myProducts;
    } catch (error) {
      // print('error');
      return [];
    }
  }
}

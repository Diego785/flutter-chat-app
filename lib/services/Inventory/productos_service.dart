import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/lote.dart';
import 'package:realtime_chat/models/Inventary/specific-products.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';

class ProductsService with ChangeNotifier {
  Future<List<Producto>> getProducts() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/productos');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosResponseFromJson(resp.body);
      return productResponse.myProducts;
    } catch (error) {
      return [];
    }
  }

  Future<List<Producto>> getAvailableProducts() async {
    try {
      final uri =
          Uri.parse('${Environment.apiUrl}/productos/available-products');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosResponseFromJson(resp.body);
      for (var i = 0; i < productResponse.myProducts.length; i++) {
        productResponse.myProducts[i].categorySelected = 'Disponibles';
      }
      return productResponse.myProducts;
    } catch (error) {
      return [];
    }
  }

  Future<List<Producto>> getExpiratedProducts() async {
    try {
      final uri =
          Uri.parse('${Environment.apiUrl}/productos/expirated-products');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosResponseFromJson(resp.body);
      for (var i = 0; i < productResponse.myProducts.length; i++) {
        productResponse.myProducts[i].categorySelected = 'Caducados';
      }
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

  Future<List<Category>> getCategories() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/productos/categories');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final categoryResponse = categoryResponseFromJson(resp.body);
      return categoryResponse.categories;
    } catch (error) {
      return [];
    }
  }

  Future<List<Producto>> getProductsByCategory(String categoryId) async {
    try {
      final uri =
          Uri.parse('${Environment.apiUrl}/productos/by-category/$categoryId');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final productResponse = productosResponseFromJson(resp.body);
      return productResponse.myProducts;
    } catch (error) {
      return [];
    }
  }

  Future updateProduct(
      String productId, String name, String description) async {
    final uri = Uri.parse('${Environment.apiUrl}/productos/edit/$productId');
    final data = {'nombre': name, 'descripcion': description};
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future createProduct(String name, String photo, String description, String categoryId) async {
    final uri = Uri.parse('${Environment.apiUrl}/productos/new');
    final data = {'nombre': name, 'foto': photo, 'descripcion': description, 'categoria': categoryId};
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }
}

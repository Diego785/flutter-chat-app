import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/receta.dart';


class RecetasService with ChangeNotifier {
  Future<List<MyReceta>> getRecetas() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/recetas');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final recetaResponse = recetaFromJson(resp.body);
      return recetaResponse.myReceta;
    } catch (error) {
      return [];
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:realtime_chat/global/environment.dart';
// import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/lote.dart';

class LoteService with ChangeNotifier {

Future<List<Lote>> getLotes() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/lotes');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final loteResponse = loteResponseFromJson(resp.body);
      return loteResponse.lote;
    } catch (error) {
      return [];
    }
  }  

}
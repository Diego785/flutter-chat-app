import 'package:flutter/material.dart';

class InventoryService with ChangeNotifier {

  String _selectedCategory = 'Todos';

  List<String> categories = ['Todos', 'Disponibles', 'Caducados' ];
  List<IconData> categoriesIcons = [Icons.all_inbox, Icons.event_available, Icons.error ];

   String get selectedCategory => this._selectedCategory;
  set selectedCategory( String valor ) {
    this._selectedCategory = valor;

    notifyListeners();
  }

}

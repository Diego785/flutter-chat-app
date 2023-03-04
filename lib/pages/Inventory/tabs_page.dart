import 'package:flutter/material.dart';
import 'package:realtime_chat/pages/Inventory/tab2_page.dart';
import 'package:realtime_chat/pages/Inventory/tab1_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Paginas(),
      bottomNavigationBar: Navegacion(),
    );
  }
}

class Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);

    return BottomNavigationBar(
        backgroundColor: Colors.cyan.shade900,
        currentIndex: navegacionModel.paginaActual,
        onTap: (i) => navegacionModel.paginaActual = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), label: 'Productos'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        ]);
  }
}

class Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);

    return  SizedBox(
            height: MediaQuery.of(context).size.height-232,
            child: PageView(
              controller: navegacionModel.pageController,
              // physics: BouncingScrollPhysics(),
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Tab1Page(),
                Tab2Page(),
              ],
            ),
          );
  }
}

class NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;

    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}

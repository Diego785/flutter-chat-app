import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/components/loading_page.dart';
import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/pages/Inventory/create_product_page.dart';
import 'package:realtime_chat/pages/Inventory/details_products_page.dart';
import 'package:realtime_chat/pages/Inventory/tab1_page.dart';
import 'package:realtime_chat/pages/Inventory/tab2_page.dart';
import 'package:realtime_chat/services/Inventory/inventory_service.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/theme/tema.dart';
import 'package:realtime_chat/widgets/headers.dart';

List<Producto> products = [];
List<Category> categoriesProducts = [];

class EncabezadoInventory extends StatefulWidget {
  @override
  State<EncabezadoInventory> createState() => _EncabezadoInventoryState();
}

class _EncabezadoInventoryState extends State<EncabezadoInventory> {
  void loadProducts() async {
    final productsService = ProductsService();
    final category = Provider.of<InventoryService>(context, listen: false);
    categoriesProducts = await productsService.getCategories();
    products = [];

    if (category.selectedCategory == 'Todos') {
      products = await productsService.getProducts();
    } else if (category.selectedCategory == 'Disponibles') {
      products = await productsService.getAvailableProducts();
    } else {
      products = await productsService.getExpiratedProducts();
    }
    setState(() {});
    //_refreshController.refreshCompleted();
  }

  @override
  void initState() {
    loadProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<InventoryService>(context, listen: false);

    return (products.isNotEmpty &&
            products[0].categorySelected == category.selectedCategory)
        ? Scaffold(
            backgroundColor: Colors.cyan.shade300,
            body: Column(
              children: [
                Stack(
                  children: <Widget>[
                    IconHeader(
                      titulo: 'Inventory',
                      color1: Color(0xff536CF6),
                      color2: Color(0xff66A9F2),
                      grosor: 175,
                    ),
                    Positioned(
                        right: 0,
                        top: 45,
                        child: RawMaterialButton(
                            onPressed: () {},
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(15.0),
                            child: FaIcon(FontAwesomeIcons.ellipsisV,
                                color: Colors.white)))
                  ],
                ),
                Paginas(),
                //ProductsGalleryPage(),
              ],
            ),
            bottomNavigationBar: Navegacion(),
            floatingActionButton: Container(
              width: 75,
              height: 75,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: "InventoryPage",
                    elevation: 5,
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.black,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const CreateProductPage()))),
              ),
            ),
          )
        : const LoadingPage2();
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
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: navegacionModel.pageController,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Tab1Page(myProducts: products),
            Tab2Page(),
          ],
        ),
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

class Tab1Page extends StatefulWidget {
  Tab1Page({required this.myProducts});
  List<Producto> myProducts;
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> {
  void loadProducts() async {
    final productsService = ProductsService();
    final category = Provider.of<InventoryService>(context, listen: false);
    categoriesProducts = await productsService.getCategories();
    products = [];

    print("RELOADING");
    if (category.selectedCategory == 'Todos') {
      products = await productsService.getProducts();
    } else if (category.selectedCategory == 'Disponibles') {
      products = await productsService.getAvailableProducts();
      print(products);
    } else {
      products = await productsService.getExpiratedProducts();
    }
    setState(() {});
    //_refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    products = widget.myProducts;
    print(products);
    print(widget.myProducts);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<InventoryService>(context, listen: false);

    return (products.isNotEmpty && widget.myProducts.isNotEmpty)
        ? Column(
            children: [
              Container(
                color: Colors.cyan.shade300,
                width: double.infinity,
                height: 80,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  // itemCount: categories.length,
                  itemCount: categories.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cName = categories.categories[index];

                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              final categories = Provider.of<InventoryService>(
                                  context,
                                  listen: false);
                              categories.selectedCategory =
                                  categories.categories[index];
                              print(categories.selectedCategory);
                              loadProducts();
                              // selectedCategoryAndProduct(index);
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 55),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Icon(
                                    categories.categoriesIcons[index],
                                    color: (categories.selectedCategory ==
                                            categories.categories[index])
                                        ? miTema.primaryColor
                                        : Colors.cyan.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(categories.categories[index]),
                        ],
                      ),
                    );
                  },
                ),
              ),
              AllProductsPage(),
            ],
          )
        : const LoadingPage2();
  }
}

class AllProductsPage extends StatefulWidget {
  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Producto> selectedCategoryAndProduct(int index, int index2) async {
      final services = ProductsService();
      productsByCategory = [];
      products = [];
      final Category categorySelected = categoriesProducts[index];
      print(categorySelected.name);

      final category = Provider.of<InventoryService>(context, listen: false);

      if (category.selectedCategory == 'Todos') {
        products = await services.getProducts();
      } else if (category.selectedCategory == 'Disponibles') {
        products = await services.getAvailableProducts();
      } else {
        products = await services.getExpiratedProducts();
      }

      for (int i = 0; i < products.length; i++) {
        if (products[i].categoria.nombre == categorySelected.name) {
          productsByCategory.add(products[i]);
        }
      }
      print(productsByCategory[index2].descripcion);
      return productsByCategory[index2];
    }

    final categories = Provider.of<InventoryService>(context, listen: false);

    return (products.isNotEmpty &&
            products[0].categorySelected == categories.selectedCategory)
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            height: MediaQuery.of(context).size.height - 312,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: false,
              itemCount: categoriesProducts.length,
              itemBuilder: (context, index) {
                double height = heightForGalleryProducts(index);
                return Column(
                  children: [
                    Text(
                      categoriesProducts[index].name,
                      style: TextStyle(
                          color: Colors.cyan.shade900,
                          fontSize: 30,
                          fontFamily: 'RobotoMono'),
                    ),
                    SizedBox(
                      height: heightForGalleryProducts(index),
                      // (products.length % 3) != 0
                      //     ? 200 * ((products.length / 3).truncate() + 1)
                      //     : 200 * (products.length / 3),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: productsByCategory.length,
                        itemBuilder: (context, index2) {
                          return (productsByCategory.isNotEmpty &&
                                  productsByCategory[0].categoria.nombre ==
                                      categoriesProducts[index].name)
                              ? Column(
                                  children: [
                                    RawMaterialButton(
                                      onPressed: () async {
                                        // final Product product = selectedCategoryAndProduct();
                                        final Producto product =
                                            await selectedCategoryAndProduct(
                                                index, index2);
                                        print(index);
                                        print(index2);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsProductsPage(
                                              product: product,
                                              index: index2,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag:
                                            '${productsByCategory[index2].foto}$index2',
                                        child: Container(
                                          height: 140,
                                          width: 140,
                                          // height: MediaQuery.of(context).size.height,
                                          // width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  productsByCategory[index2]
                                                      .foto),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(productsByCategory[index2].nombre),
                                  ],
                                )
                              : SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        : SizedBox.shrink();
  }
}

double heightForGalleryProducts(int index) {
  double result = 0;
  productsByCategory = [];

  for (var i = 0; i < products.length; i++) {
    if (products[i].categoria.nombre == categoriesProducts[index].name) {
      result = result + 1;
      productsByCategory.add(products[i]);
    }
  }
  if (result % 3 != 0) {
    result = ((result / 3).truncate() + 1) * 175;
  } else {
    result = (result / 3) * 175;
  }

  return result;
}

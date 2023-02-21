import 'package:flutter/material.dart';
import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/producto.dart';
import 'package:realtime_chat/pages/Inventory/details_products_page.dart';
import 'package:realtime_chat/pages/Inventory/inventory_page.dart';
import 'package:realtime_chat/services/Inventory/inventory_service.dart';
import 'package:realtime_chat/services/Inventory/productos_service.dart';
import 'package:realtime_chat/theme/tema.dart';
import 'package:provider/provider.dart';

List<Product> products = [];
List<Category> categoriesProducts = [];

class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _ListaCategorias(),
        //SizedBox(height: 10, child: Text("Hola"),),
        //ProductsGalleryPage(),
      ],
    );
  }
}

class _ListaCategorias extends StatefulWidget {
  _ListaCategorias();

  @override
  State<_ListaCategorias> createState() => _ListaCategoriasState();
}

class _ListaCategoriasState extends State<_ListaCategorias> {
  void loadProducts() async {
    final productsService = ProductsService();
    final category = Provider.of<InventoryService>(context, listen: false);
    categoriesProducts = await productsService.getCategories();

    print("RELOADING");
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
    final categories = Provider.of<InventoryService>(context);

    return Column(
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
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 55),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              categories.categoriesIcons[index],
                              color: (categories.selectedCategory ==
                                      categories.categories[index])
                                  ? miTema.accentColor
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
    );
  }
}

/*class ProductsMenu extends StatefulWidget {
  @override
  State<ProductsMenu> createState() => _ProductsMenuState();
}

class _ProductsMenuState extends State<ProductsMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<InventoryService>(context);

    return Container(
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
                    final categories =
                        Provider.of<InventoryService>(context, listen: false);
                    categories.selectedCategory = categories.categories[index];
                    print(categories.selectedCategory);
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 55),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          categories.categoriesIcons[index],
                          color: (categories.selectedCategory ==
                                  categories.categories[index])
                              ? miTema.accentColor
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
    );
  }
}*/

// class _CategoryButton extends StatefulWidget {
//   final IconData icon;
//   final String name;

//   // const _CategoryButton( this.categoria );
//   const _CategoryButton(this.icon, this.name);

//   @override
//   State<_CategoryButton> createState() => _CategoryButtonState();
// }

// class _CategoryButtonState extends State<_CategoryButton> {
//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categories = Provider.of<InventoryService>(context);

//     return GestureDetector(
//       onTap: () {
//         final categories =
//             Provider.of<InventoryService>(context, listen: false);
//         categories.selectedCategory = widget.name;

//         setState(() {});
//       },
//       child: Column(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             margin: EdgeInsets.symmetric(horizontal: 55),
//             decoration:
//                 BoxDecoration(shape: BoxShape.circle, color: Colors.white),
//             child: Icon(
//               this.widget.icon,
//               color: (categories.selectedCategory == this.widget.name)
//                   ? miTema.accentColor
//                   : Colors.cyan.shade900,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AllProductsPage extends StatefulWidget {
  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  //List<Product> productos = [];

// RefreshController _refreshController =
//       RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        shrinkWrap: false,
        itemCount: categoriesProducts.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                categoriesProducts[index].nombre,
                style: TextStyle(color: Colors.cyan.shade900, fontSize: 30, fontFamily: 'RobotoMono'),
              ),
              SizedBox(
                height: (products.length % 3) != 0
                    ? 200 * ((products.length / 3).truncate() + 1)
                    : 200 * (products.length / 3),
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        RawMaterialButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsProductsPage(
                                name: products[index].nombre,
                                fechaCreacion: products[index].fechaCreacion,
                                fechaVencimiento:
                                    products[index].fechaVencimiento,
                                imagePath: products[index].foto,
                                index: index,
                              ),
                            ),
                          ),
                          child: Hero(
                            tag: 'foto$index',
                            child: Container(
                              height: 140,
                              width: 140,
                              // height: MediaQuery.of(context).size.height,
                              // width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(products[index].foto),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(products[index].nombre),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

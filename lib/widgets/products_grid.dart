import 'package:collage_shoping_projectapp/provider/products.dart';
import 'package:collage_shoping_projectapp/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  bool isfavour;
  ProductsGrid(this.isfavour);


  @override
  Widget build(BuildContext context) {
    print(isfavour);
    final productsData=Provider.of<Products>(context);  /// the products cklass are stored the productData
    final products=isfavour?productsData.favoList:productsData.items;
    print(products);/// the fetched the data from products Data
    return GridView.builder(padding: const EdgeInsets.all(10.5),
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2 ,      /// to define how many Coloum are wanted in screen
          mainAxisSpacing: 15,    /// to define the distnace between two products of coloumn
          crossAxisSpacing: 10,   ///  to define the distnace between the two products of row
          childAspectRatio:4/3,    ///to define the length and breadth of a container

        ),
        itemCount:products.length ,   // to define the how many products are loaded like ( looping )
        itemBuilder: (ctx,i)=> ChangeNotifierProvider.value(value: products[i],child: ProductItem(),)// changeNotifier Provider.value is used for the only passing the single data

    );
  }
}

import 'package:collage_shoping_projectapp/provider/products.dart';
import 'package:collage_shoping_projectapp/screens/edit_product_screen.dart';
import 'package:collage_shoping_projectapp/widgets/appDrawer.dart';
import 'package:collage_shoping_projectapp/widgets/userProductItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class UserProductScreen extends StatelessWidget {
  static const routerName="/userScrenn";
  @override
  Widget build(BuildContext context) {
    final products=Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("UserProductScreen"),


        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routerName);

          })
        ],
      ),
      body: ListView.builder(itemBuilder: (ctx,i)=>Column(
        children: [
          UserProductItem(products.items[i].title, products.items[i].imageUrl,products.items[i].id),
          Divider(),
        ],
      ),itemCount: products.items.length,)
    );
  }
}

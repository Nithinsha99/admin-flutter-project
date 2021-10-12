
import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:collage_shoping_projectapp/provider/products.dart';
import 'package:collage_shoping_projectapp/screens/cart_screen.dart';
import 'package:collage_shoping_projectapp/screens/orderScreen.dart';
import 'package:collage_shoping_projectapp/widgets/appDrawer.dart';
import 'package:collage_shoping_projectapp/widgets/badget.dart';
import 'package:collage_shoping_projectapp/widgets/product_item.dart';
import 'package:collage_shoping_projectapp/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//this Class include a front View of Screen

class ProductOverviewScreen extends StatefulWidget {
  //to create a  dummy datas


  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  Future<void> refreshIndicator(BuildContext context)async{
    try{
      await Provider.of<Products>(context,listen: false).fetchItem();
    }catch(error){
      Center(child: CircularProgressIndicator(),);
    }
    

  }

@override

  @override
  Widget build(BuildContext context) {
    final prod=Provider.of<Products>(context ,listen: false);
    return Scaffold(
      drawer: AppDrawer(),

      appBar: AppBar(
        title: Text("My Shop"),

        actions: [
         IconButton(icon: Icon(prod.isFavor?Icons.favorite:Icons.favorite_border), onPressed: (){
           setState(() {
             prod.isFavor=!prod.isFavor;
             print(prod.isFavor);
           });



          }),
          Consumer<Cart>(builder: (_,cartitem,child)=>Badge(child: IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){
            Navigator.of(context).pushNamed(CartScreen.routerName);

          },), value: cartitem.cartLength.toString() ))
    ]


    ),





      // ignore: missing_return
      body: FutureBuilder(future:refreshIndicator(context),builder: (ctx,snapShot)=>snapShot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator(),
      ):RefreshIndicator(child:ProductsGrid(prod.isFavor), onRefresh: ()=>refreshIndicator(context))),


    );
  }
}

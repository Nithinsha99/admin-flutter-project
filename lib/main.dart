import 'package:collage_shoping_projectapp/provider/auth.dart';
import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:collage_shoping_projectapp/provider/orders.dart';
import 'package:collage_shoping_projectapp/provider/products.dart';
import 'package:collage_shoping_projectapp/screens/auth_Screen.dart';
import 'package:collage_shoping_projectapp/screens/cart_screen.dart';
import 'package:collage_shoping_projectapp/screens/conformPage.dart';
import 'package:collage_shoping_projectapp/screens/edit_product_screen.dart';
import 'package:collage_shoping_projectapp/screens/individualOrderScreen.dart';
import 'package:collage_shoping_projectapp/screens/orderScreen.dart';
import 'package:collage_shoping_projectapp/screens/product_detail_screen.dart';
import 'package:collage_shoping_projectapp/screens/product_overview_screen.dart';
import 'package:collage_shoping_projectapp/screens/userProductScreen.dart';
import 'package:collage_shoping_projectapp/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
// to create a MyApp class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (ctx)=>Auth()),
      ChangeNotifierProxyProvider<Auth,Products>(update: (_,auth,product)=>Products(auth.name,auth.userName,),),
      ChangeNotifierProvider(create: (ctx)=>Cart()),
     ChangeNotifierProxyProvider<Auth,Orders>( update: (_,auth,orders)=>Orders(auth.token,auth.userId1)),

    ],
        child: Consumer<Auth>(builder: (ctx,auth,_)=>MaterialApp(
            title: "shop", debugShowCheckedModeBanner: false,

            theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.deepOrange,
            ),
            home:auth.isAuth?ProductOverviewScreen():AuthScreen(),/// we call the product over screen the the screen is display the products
            routes: {

              ProductDetailScreen.routerName: (ctx) => ProductDetailScreen(),
              CartScreen.routerName:(ctx)=>CartScreen(),
              OrderScreen.routerName:(ctx)=>OrderScreen(),
              IndOrder.routerName:(ctx)=>IndOrder(),
              UserProductScreen.routerName:(ctx)=>UserProductScreen(),
              EditProductScreen.routerName:(ctx)=>EditProductScreen(),
              LastPage.routerName:(ctx)=>LastPage(),
            }
        ),));


  }
}
// Another Class is My Home page Class this class is include a Scafold body





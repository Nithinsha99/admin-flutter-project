import 'package:collage_shoping_projectapp/provider/orders.dart';
import 'package:collage_shoping_projectapp/screens/cart_screen.dart';
import 'package:collage_shoping_projectapp/screens/product_overview_screen.dart';
import 'package:collage_shoping_projectapp/widgets/order_item.dart'as ord;
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
class OrderScreen extends StatelessWidget  {
  static const routerName="/order";

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),

      ),
      body:FutureBuilder(

        // ignore: missing_return
        future: Provider.of<Orders>(context,listen: false).fetchItem(),builder: (ctx,connection){
          if(connection == ConnectionState.waiting){
            return  Center(child: CircularProgressIndicator(),);

          }else if(connection.error!=null){
              ///TODO TO SET tHE eRROR mESSAGE
            }else{
            return Consumer<Orders>(builder: (ctx,orders,child)=> ListView.builder(itemBuilder: (ctx,i)=>ord.OrderItem(orders.orders[i]),itemCount: orders.orders.length,),);

          }

      },
      )
    );

  }
}

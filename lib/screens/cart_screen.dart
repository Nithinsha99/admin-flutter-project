import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:collage_shoping_projectapp/provider/orders.dart';
import 'package:collage_shoping_projectapp/screens/conformPage.dart';
import 'package:collage_shoping_projectapp/screens/orderScreen.dart';
import 'package:collage_shoping_projectapp/widgets/cart_item.dart' as first; /// this help to have same name double class so is very confusing to understamt the
import 'package:flutter/cupertino.dart';
/// this may help
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
  static const routerName="/cartItem";

  @override
  Widget build(BuildContext context) {
    final  cartProducts=Provider.of<Cart>(context);
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffA3CB38),
        
        title: Text("your Cart"),
        actions: [
          Stack(
            children: [
              IconButton(icon: Icon(Icons.person), onPressed: (){
                Navigator.of(context).pushNamed(OrderScreen.routerName);
              },),
              Positioned(bottom: 5,

                  child: Text("Orders",style: TextStyle(fontSize: 14),)),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(

              width: MediaQuery.of(context).size.width,
              height: 550,

              child: ListView.builder(
                itemBuilder: (context, i) => first.CartItem(imageUrl: cartProducts.items.values.toList()[i].imageUrl,
                  /// CartProducts.items .value is used for to convert list this cartitems has map... items.value is to get the values from map and to convert List
                  title: cartProducts.items.values.toList()[i].tittle,
                  price: cartProducts.items.values.toList()[i].price,
                  quanity: cartProducts.items.values.toList()[i].quanity,
                  productId: cartProducts.items.keys.toList()[i],
                ),
                itemCount: cartProducts.items.length,
              ),
            ),
            Divider(
              height: 2,
              thickness: 3,
              color: Colors.black54,
            ),

            ListTile(

              leading:Text("Total Amount",style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                )
              ),) ,
              trailing: Text("\$ ${cartProducts.totalAmount1.ceil()}",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            )

          ],
        ),
      ),
      bottomNavigationBar:ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
        child: MaterialButton(
          height: 50,
          minWidth: MediaQuery.of(context).size.width,
          child: Text("Order Now",style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              )
          ),),
          color: Color(0xffbadc58),
          textColor: Colors.white,
          onPressed:(){

            cartProducts.totalAmount1==0?"":Navigator.of(context).pushNamed(LastPage.routerName);



          },
        ),
      ),
    );
  }
}


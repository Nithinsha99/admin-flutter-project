
import 'package:collage_shoping_projectapp/models/product1.dart';
import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:collage_shoping_projectapp/provider/product.dart';
import 'package:collage_shoping_projectapp/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final  String  imageUrl;
  // final  String  id;
  // final  String tittle;
  // ProductItem(this.imageUrl,this.id,this.tittle);/// teh passing details are stored in variable using contyructor

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context);/// tproducts details is stored on product using provider
    final cartItem=Provider.of<Cart>(context);



    return  ClipRRect(/// ClipRreact is used for the to change the shape of grid tile Like BorderRadius 
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child:GestureDetector(
          onTap: ()=>Navigator.of(context).pushNamed(ProductDetailScreen.routerName,arguments:product.id), /// we can only pass the id in details screenm becouse t
            /// to get the id is simble to sorting the element

            child: Image.network(product.imageUrl, fit: BoxFit.cover ,)),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(product.title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold
            )
          ),),
          leading: Consumer<Product>(builder:(context,product,child)=>IconButton(icon: Icon(product.isFavorite?Icons.favorite:Icons.favorite_border),color:Theme.of(context).accentColor,  onPressed: (){
            product.toogleFavoriteStatus(); // is true value become a false loopimng

          },),),/// using consumer is only refreh the consumer widget noit refreh the
          trailing: IconButton(icon: Icon(Icons.add_shopping_cart),onPressed: (){
            cartItem.addItem(product.id, product.title, product.price,product.imageUrl);

          },),
        ),                /// use to footer section
      ),
    );
  }
}

import 'package:collage_shoping_projectapp/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ProductDetailScreen extends StatelessWidget {
  static const routerName="/DetailScreen";    /// is used to which page is navigator
  @override
  Widget build(BuildContext context) {

    final productId=ModalRoute.of(context).settings.arguments as String;/// the id is stored the product_id id is comes from product_item.dart
    final loadedProducts=Provider.of<Products>(context,listen: false).findById(productId);



    return Scaffold(
      appBar: AppBar(
        title: Text("DetailScreen",style: GoogleFonts.robotoMono(
          textStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,

          )
        ),),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.add_shopping_cart_rounded), onPressed: (){

          })
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(

          children: [

            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xffe2ebf0 ),
                  Color(0xffFAECEB),
                  ]
                )
              ),
              child: Image.network(loadedProducts.imageUrl,width: 300,fit: BoxFit.fill,height: 200,),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                color: Color(0xfff1f2f6)

              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30,left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite_border_outlined),
                        Text("  save   "),
                        Icon(Icons.share_outlined),
                        Text("     Share"),
                      ],

                    ),
                    SizedBox(
                      height: 8,
                    ),

                    Text(loadedProducts.title.toUpperCase(),style: GoogleFonts.kanit(
                      textStyle: TextStyle(


                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black87
                      )
                    ),),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "\$ ${loadedProducts.price.toString()}",
                          style: TextStyle(fontSize: 25, color: Colors.black,fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: " "
                            ),
                            TextSpan(
                              text: '\$ ${loadedProducts.price+100}',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,

                                  decoration: TextDecoration.lineThrough,

                                  color: Colors.grey,
                              ),
                            ),
                          ]),
                    ),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final int quanity;
  final String productId;
  CartItem({@required this.imageUrl,this.price,this.title,this.quanity,this.productId});
  @override
  Widget build(BuildContext context) {
   final cart=Provider.of<Cart>(context);
    return Column(
      children: [
        Container(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                  child: Image.network(imageUrl,fit: BoxFit.cover,width: 150,
                  height: 150,),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23
                  ),),
                  SizedBox(
                    height: 6,
                  ),
                  Text("Quanity * ${quanity}",style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),),
                  SizedBox(
                    height: 6,
                  ),
                  Text("\$ ${price*quanity}",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,

                 children: [
                   Row(

                     children: [
                       IconButton(icon: Icon(Icons.add), onPressed:(){
                         cart.addItem(productId, title, price, imageUrl);
                       } ),
                       IconButton(icon: Icon(Icons.remove), onPressed: (){
                         cart.deleteSingleItem(productId);
                       })

                     ],
                   ),
                   SizedBox(
                   height: 10,
                   ),
                   IconButton(icon: Icon(Icons.delete),  color :Colors.red,onPressed: (){
                     Scaffold.of(context).showSnackBar(SnackBar(content: Text("Delete item in cart"),duration: Duration(seconds: 2)
                       ,action: SnackBarAction(label: "Yes",onPressed: (){
                         cart.delete(productId);
                       },),));
                     

                   }),
                 ],
               )

            ],
          ),
        ),
        Divider(
          thickness: 3,
        )
      ],
    );
  }
}

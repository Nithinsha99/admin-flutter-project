import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class IndOrder extends StatelessWidget {
  static const routerName="/ind name";

  @override
  Widget build(BuildContext context) {
    final indOrder=ModalRoute.of(context).settings.arguments as List<CartItem>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: ListView.builder(itemBuilder: (ctx,i){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.all(10),

              decoration: BoxDecoration(
                border:  Border.all()
              ),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(400)),

                      child: Image.network(indOrder[i].imageUrl,fit: BoxFit.cover,width: 80,
                        height: 80,),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(indOrder[i].tittle,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                      SizedBox(
                        height: 6,
                      ),
                      Text("Qty ${indOrder[i].quanity} x ${indOrder[i].price}",style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),),
                      SizedBox(
                        height: 6,
                      ),
                      Text("\$ ${indOrder[i].price*indOrder[i].quanity}",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                ],
              ),
            ),

          ],
        );
      },itemCount: indOrder.length,)

    );
  }
}

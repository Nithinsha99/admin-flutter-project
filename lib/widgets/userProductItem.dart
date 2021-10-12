import 'package:collage_shoping_projectapp/provider/products.dart';
import 'package:collage_shoping_projectapp/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final String imageurl;
  final String tittle;
  final String id;
  UserProductItem(this.tittle,this.imageurl,this.id);
  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: Text(tittle),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),radius: 30,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routerName,arguments: id);
            }),
            IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){
              Provider.of<Products>(context,listen: false).delete(id);
            })

          ],
        ),
      ),
    );
  }
}

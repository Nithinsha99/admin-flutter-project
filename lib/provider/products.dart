
import 'dart:convert';

import 'package:collage_shoping_projectapp/models/product1.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; //using prefex

class Products with ChangeNotifier{
   List<Product> _items=[
     // Product(
     //   id: 'p1',
     //   title: 'Red Shirt',
     //   decription: "is look ver good",
     //   select: 24,
     //   price: 29.99,
     //   imageUrl:
     //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
     // ),
     // Product(
     //   id: 'p2',
     //   title: 'Shoes',
     //   decription: "for exercising",
     //   select: 8,
     //   price: 289.99,
     //   imageUrl: 'https://marvel-b1-cdn.bc0a.com/f00000000114841/www.florsheim.com/shop/resources/images/index/SS21_Refresh2_DressTransit.jpg',
     // ),
     // Product(
     //   id: 'p3',
     //   title: 'Fry pan',
     //   decription: "is look ver good",
     //   select: "non stick",
     //   price: 29.99,
     //   imageUrl: 'https://n1.sdlcdn.com/imgs/i/p/j/Home-Select-Non-Stick-Aluminum-SDL677902340-1-3b0ba.jpeg',
     // ),
     // Product(
     //   id: 'p4',
     //   title: 'Fry pan',
     //   decription: "is look ver good",
     //   select: "non stick",
     //   price: 29.99,
     //   imageUrl: 'https://n1.sdlcdn.com/imgs/i/p/j/Home-Select-Non-Stick-Aluminum-SDL677902340-1-3b0ba.jpeg',
     // ),

   ]; /// we create a dummy _items list  to store the products
final String userEmail;
final String userName;

Products(this.userName,this.userEmail);




   List<Product> get items{  /// get is helpful to to get the data from starting and returm the list in items using ...notation
    return [..._items];
}
List<Product> get favoList{
     return items.where((element) => element.isFavorite).toList();
}

Future<void> fetchItem() async{
  Uri url=Uri.parse('https://admin-second-ad1eb-default-rtdb.firebaseio.com//products.json');
  try{
    var response=await http.get(url);
   final extractData=json.decode(response.body) as Map<String,dynamic>;
   if(extractData==null){
     return;
   }
    List<Product> loadingProducts=[];
   extractData.forEach((key, value) {
     loadingProducts.add(Product(id: key,title: value["tittle"],decription: value["description"],imageUrl: value["imageUrl"],price: value["price"],
         select: value["selct"],isFavorite: value["isfavorite"]));

   });
   _items=loadingProducts;

   notifyListeners();
  }catch(error){
    throw error;
  }


}
Future<void>addItem(Product product){

     Uri url=Uri.parse('https://adminprojectpage-default-rtdb.firebaseio.com//products.json');
     return
       http.post(url,body: json.encode({
         "tittle":product.title,
         "description":product.decription,
         "imageUrl":product.imageUrl,
         "price":product.price,
         "selct":product.select,
         "isfavorite":product.isFavorite,

       }),).then((response){     /// this is uswed for the in the caase of net slow that we only add the item in memory complete the storying in  server
         final newProduct=Product(title: product.title,price: product.price,imageUrl: product.imageUrl,id:json.decode(response.body)["name"],select: product.select);
         _items.add(newProduct);
         notifyListeners();

       });


}
 void updateItem(String productid,Product updaterProduct){
     final product=_items.indexWhere((element) => element.id==productid);
     _items[product]=updaterProduct;
     notifyListeners();
 }
void delete(String id){
     _items.removeWhere((element) => element.id==id);
     notifyListeners();
}

Product findById(String id){  /// is usewd for the get the elemnet id in Products we pass the elemnt id in m, 
     return items.firstWhere((element) => element.id==id);
}
 bool isFavor=false;



}

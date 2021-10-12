import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class OrderItem{
  final String id;
  final DateTime dateTime;
  final double price;
   final List<CartItem> products;
   String orderConfirmed;
   OrderItem({@required this.price,@required this.id,@required this.products,@required this.dateTime,this.orderConfirmed="Checking"});

}

class Orders with ChangeNotifier{
  List<OrderItem> _orders =[];
  List<OrderItem> get orders{
    return [..._orders];
  }
  final String _token;
  final String _userId;
  Orders(this._token,this._userId);
  
  Future<void> fetchItem()async{
    List <OrderItem>loading=[];
    Uri url=Uri.parse('https://shoppingproject-ec2a6-default-rtdb.firebaseio.com//Orders.json?auth=$_token&orderBy="userid"&equalTo="$_userId"');
   var responseData=await http.get(url);
    try{
      final datas=json.decode(responseData.body) as Map<String,dynamic>;


      if(datas==null){
        return;
      }
      datas.forEach((key, value) {
        loading.add(OrderItem(price: value["price"], id: key,orderConfirmed: value["orderConfirmed"], products: (value["products"]as List<dynamic>).map((e) =>
            CartItem(tittle: e["tittle"], id: e["id"], price: e["price"], quanity: e["quanity"],imageUrl: e["imageUrl"])).toList(), dateTime: DateTime.parse(value["DateTime"])));
      });
      _orders=loading.reversed.toList();
      notifyListeners();

    }catch(eroor){
      print(eroor);
    }
    
  }
  Future addOrders({List <CartItem> cartProducts,double totalAmount,String name, String address, String phoneNumber , String zipCode,String city ,String landMark})async{
    Uri url=Uri.parse('https://shoppingproject-ec2a6-default-rtdb.firebaseio.com//Orders.json?auth=$_token');
    Uri url2=Uri.parse('https://admin-second-ad1eb-default-rtdb.firebaseio.com//orders.json');
    var dateTime=DateTime.now();
    final response=await http.post(url,body: json.encode({
      "userid":_userId,

      "price":totalAmount,
      "DateTime":dateTime.toIso8601String(),
      "products":cartProducts.map((e) => {
       "id":e.id, 
        "tittle":e.tittle,
        "quanity":e.quanity,
        "price":e.price,
        "imageUrl":e.imageUrl,
      }).toList(),
      "orderConfirmed":"Checking",




    }));
   await http.post(url2,body: json.encode({
     "productId":"",
      "price":totalAmount,
      "DateTime":dateTime.toIso8601String(),
      "products":cartProducts.map((e) => {
        "id":e.id,
        "tittle":e.tittle,
        "quanity":e.quanity,
        "price":e.price,
        "imageUrl":e.imageUrl,

      }).toList(),
     "orderConfirmed":"Checking",
     "name":name,
     "address":address,
     "phoneNumber":phoneNumber,
     "zipCode":zipCode,
     "city":city,
     "landMark":landMark,
    }));

   final idAdmin=await http.get(url2);
   final adminId=json.decode(idAdmin.body)as Map<String,dynamic>;
   var ids=adminId.keys.toList();

    final idProduct=await http.get(url);
    final productId=json.decode(idProduct.body)as Map<String,dynamic>;
    var idss=productId.keys.toList();

    for(int i=0;i<ids.length;i++){

      Uri urlLoop=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//orders/${ids[i]}.json");
      await http.patch(urlLoop,body: json.encode({
        "productId":idss[i],
      }));


    }

    _orders.insert(0, OrderItem(price: totalAmount, id: json.decode(response.body)["name"], products: cartProducts, dateTime: DateTime.now()));
    notifyListeners();

  }

}

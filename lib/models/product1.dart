// in flutter final is used to does not change the value and is optional to define data type eg  final string name="nithinsha" Strinmg is optianal;
/// thi
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String decription;
  final double price;
  final String imageUrl;
  bool isFavorite;
  final select;
  // TO DO//
  // we use select is for the to sorting the datas in products

  // construtor in Product
  Product({
    @required this.id,
    @required this.select,
    @required this.price,
    @required this.decription,
    @required this.imageUrl,
    @required this.title,
    this.isFavorite=false
  });
  Future<void>toogleFavoriteStatus()async{
    bool oldStatus=isFavorite;
    isFavorite=!isFavorite;
    notifyListeners();
    Uri url=Uri.parse('https://admin-second-ad1eb-default-rtdb.firebaseio.com//products/$id.json');
    try{
      var response= await http.patch(url,body: json.encode({
        "isfavorite":isFavorite,

      }));
      if(response.statusCode>=400){
        isFavorite=oldStatus;
        notifyListeners();
      }

    }catch(error){
      isFavorite=oldStatus;
      notifyListeners();

    }


    print(isFavorite);
  }



}
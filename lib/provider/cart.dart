import 'package:flutter/foundation.dart';

class CartItem{
  final String tittle;
  final String id;
  final int quanity;
  final double price;
  final String imageUrl;
  CartItem({
    @required this.tittle,
    @required this.id,
    @required this.price,
    @required this.quanity,
    this.imageUrl,
  }
      );
}
class Cart with ChangeNotifier{
   Map<String,CartItem> _items={};
   Map<String,CartItem> get items{
    return {..._items};

    /// if we can create Map conatins String PRODUCTiD  WE sTRING cONATIN pRODUCTiD AND cART_ITEM CAN coNATINE cARTItem
}
int  get cartLength{
     return _items.length;

}
double get totalAmount1 {
      double totalAmount=0.0;
     _items.forEach((key, value) {totalAmount+=value.price*value.quanity;});
     return totalAmount;
}
void delete(productId){
     _items.remove(productId);
     notifyListeners();
}


void addItem( String productId,String title,double price ,String imageUrl){
     if(items.containsKey(productId)){
       _items.update(productId, (value) => CartItem(tittle: value.tittle, id: value.id, price: value.price, quanity: value.quanity+1,imageUrl: value.imageUrl));

     }else{
       _items.putIfAbsent(productId, () => CartItem(tittle: title, id: DateTime.now().toString(), price: price, quanity: 1,imageUrl: imageUrl));
     }
     notifyListeners();
}
void deleteSingleItem(String productId){
    if(_items[productId].quanity>1){
      _items.update(productId, (value) => CartItem(id: value.id,imageUrl: value.imageUrl,price: value.price,tittle: value.tittle,quanity: value.quanity-1));
    }else{
      _items.remove(productId);
    }
    notifyListeners();

}
void clear(){
     _items={};
     notifyListeners();
}


}


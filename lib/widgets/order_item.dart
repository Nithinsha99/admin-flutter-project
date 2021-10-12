import 'package:collage_shoping_projectapp/provider/orders.dart' as ord;
import 'package:collage_shoping_projectapp/screens/individualOrderScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: GestureDetector(
              onTap: (){

                Navigator.of(context).pushNamed(IndOrder.routerName,arguments: order.products);
              },
              child: Container(
                padding: EdgeInsets.all(10),

                width: 450,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: 150,
                      height: 30,



                      decoration: BoxDecoration(
                    color:order.orderConfirmed=="Checking"?Colors.lightBlue[300]:Colors.red ,
                          borderRadius: BorderRadius.all(Radius.circular(13))
                      ),
                      child: Center(child: Text(order.orderConfirmed,textAlign: TextAlign.center,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:Colors.white,
                      ),)),
                    ),
                    RichText(
                    text: TextSpan(
                        text: 'Total Amount:  ',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${order.price}',
                            style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,

                                color: Colors.black87
                            ),
                          ),
                        ]),
              ),

                   
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'purchase Date:   ',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                              text:'${DateFormat('dd-MMM-yyyy ').format(order.dateTime)}',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,

                                color: Colors.black
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'No products purchased:   ',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                              text:'${order.products.length}',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,

                                  color: Colors.black
                              ),
                            ),
                          ]),
                    ),
                   

                  ],
                ),
                height: 150,
                margin: const EdgeInsets.only(bottom: 6.0),
                //Same as `blurRadius` i guess
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

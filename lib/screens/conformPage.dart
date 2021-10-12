import 'package:collage_shoping_projectapp/provider/cart.dart';
import 'package:collage_shoping_projectapp/provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class LastPage extends StatefulWidget {
  static const routerName="/finishedPage";

  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> details = {
    "address": "",
    "name": "",
    "landMark": "",
    "phoneNumber": "",
    "city": "",
    "zipCode": "",
  };
  bool _isLoaoading = false;


  @override
  Widget build(BuildContext context) {
    final cartProducts = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Shipping", style: GoogleFonts.prompt(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 2

                  )
              ),),
              SizedBox(
                height: 40,
              ),
              Form(
                  key: formKey,
                  child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Your Name", labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter the name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        details["name"] = value;
                      },

                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "PhoneNumber", labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter the number";
                        } else if (double.tryParse(value) == null ||
                            value.length != 10) {
                          return "enter the valid Phone Number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        details["phoneNumber"] = value;
                        print(details);
                      },


                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Address", labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      ),

                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter the Address";
                        } else if (value.length < 5) {
                          return "enter the Full address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        details["address"] = value;
                      },

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "City", labelStyle: TextStyle(
                                color: Colors.grey
                            ),
                            ),
                            keyboardType: TextInputType.text,

                            validator: (value) {
                              if (value.isEmpty) {
                                return "enter the City name";
                              } else if (value.length < 3 ||
                                  value.contains(RegExp(r'[0-9]'))) {
                                return "enter the valid City";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              details["city"] = value;
                            },

                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Pin code", labelStyle: TextStyle(
                                color: Colors.grey
                            ),
                            ),

                            validator: (value) {
                              if (value.isEmpty) {
                                return "enter the pinCode";
                              } else if (value.length < 3 ||
                                  double.tryParse(value) == null) {
                                return "enter the valid pincode";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              details["zipCode"] = value;
                            },

                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "land Mark", labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      ),

                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter the land Mark useful for Delivery";
                        } else if (value.length < 3) {
                          return "enter the detail";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        details["landMark"] = value;
                      },

                    ),

                  ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height/5,
              ),

              // ignore: deprecated_member_use
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    color: Color(0xffF7F7DE),
                    boxShadow: [
                      BoxShadow(color: Colors.black, blurRadius: 2,)
                    ]
                ),

                child: FlatButton(onPressed: () async {
                  var validator = formKey.currentState.validate();
                  if (!validator) {
                    return;
                  }
                  formKey.currentState.save();
                  try {
                    setState(() {
                      _isLoaoading = true;
                    });
                    await Provider.of<Orders>(context, listen: false).addOrders(
                        cartProducts: cartProducts.items.values.toList(),
                        totalAmount: cartProducts.totalAmount1,
                        name: details["name"],
                        phoneNumber: details["phoneNumber"],
                        address: details["address"],
                        city: details["city"],
                        zipCode: details["zipCode"],
                        landMark: details["landMark"]);
                    setState(() {
                      _isLoaoading = false;
                    });
                    cartProducts.clear();
                    Navigator.of(context).pop();
                  } catch (error) {
                    Text("SomeThing Wrong");
                  }
                }
                    ,
                    child:  Text(_isLoaoading ?"Waiting..":"Conform",style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),) ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

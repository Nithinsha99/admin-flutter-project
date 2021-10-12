import 'package:collage_shoping_projectapp/provider/auth.dart';
import 'package:collage_shoping_projectapp/provider/products.dart';
import 'package:collage_shoping_projectapp/screens/orderScreen.dart';
import 'package:collage_shoping_projectapp/screens/userProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3366FF),
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(400)),
                          child: Image.network("https://img.icons8.com/pastel-glyph/2x/person-male--v2.png",width: 50,height: 50,color: Colors.white,),
                        ),
                        SizedBox(width: 10,),Text("Enjoy your Shopping ",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(Provider.of<Products>(context,listen: false).userName,style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,

                    ),),

                    Text(Provider.of<Products>(context,listen: false).userEmail,style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,

                    ),),
                  ],
                ),
              )),
          ListTile(
            title: Text("Home",style: TextStyle(fontSize: 16),),
            leading: Icon(Icons.home,size: 23,),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          ListTile(
            title: Text("My Orders",style: TextStyle(fontSize: 16),),
            leading: Icon(Icons.person,size: 23,),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>OrderScreen()));
            },


          ),
          ListTile(
            title: Text("Mange Products",style: TextStyle(fontSize: 16),),
            leading: Icon(Icons.edit,size: 23,),
            onTap: (){
              Navigator.of(context).pushNamed(UserProductScreen.routerName);
            },
          ),
          ListTile(
            title: Text("LogOut",style: TextStyle(fontSize: 16),),
            leading: Icon(Icons.person,size: 23,),
            onTap: (){
              Navigator.of(context).pop();
              Provider.of<Auth>(context,listen: false).logOut();
            },
          ),

        ],
      ),
    );
  }
}

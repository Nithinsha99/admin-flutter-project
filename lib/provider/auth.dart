import 'dart:convert';
import 'dart:io';

import 'package:collage_shoping_projectapp/models/http_execption.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Auth with ChangeNotifier{
  String _userName;
  String _name;
  DateTime _experyDate;
  String _token;
  String _userId;
  bool get isAuth{
    return token!=null;
  }
  String get userId1{
    return _userId;
  }
  String get token{
    if(_experyDate!=null&&_token!=null&&_experyDate.isAfter(DateTime.now())){
      return _token;
    }
    return null;
  }
  String get name{
    return _name;
  }
  String get userName{
    return _userName;
  }


  Future<void> _auth(String email,String password,String url1,String name)async{
    Uri url=Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:${url1}?key=AIzaSyCw33a8WbQy42JY2VEFKDh70RYVYCtBMqQ");
    try{
      final response= await http.post(url ,body: json.encode({
        "email":email,
        "password":password,
        "returnSecureToken":true,

      }));

      final _errorMessage=jsonDecode(response.body);
      print(_errorMessage);
      if(_errorMessage["error"]!=null){

        throw HttpException(_errorMessage["error"]["message"]);
      }
      _token=_errorMessage["idToken"];
      _experyDate=DateTime.now().add(Duration(
        seconds: int.parse(
          _errorMessage["expiresIn"]
        )
      ));
      _userId=_errorMessage["localId"];
      _userName=_errorMessage["email"];
      _name=name;

      notifyListeners();


    }catch(eroor){
      throw eroor;
    }


  }
  Future<void>signup(String email,String password,String name) async{
    return _auth(email, password, "signUp",name);

  }
  Future<void>login(String email,String password,String name) async{
    return _auth(email, password, "signInWithPassword",name);

  }
  void logOut(){
    _userName= null;
    _name=null;
    _experyDate=null;
    _token=null;
    _userId=null;
    notifyListeners();
  }




}
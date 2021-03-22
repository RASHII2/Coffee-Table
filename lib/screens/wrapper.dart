import  'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_chat/models/user.dart';
import 'package:u_chat/screens/authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
        //return Home or authenticate
    if(user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}
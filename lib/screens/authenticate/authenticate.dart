import 'package:flutter/material.dart';
import 'package:u_chat/screens/authenticate/register.dart';
import 'package:u_chat/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
bool showSignIn = true;
void toogleview(){
  setState(()=> showSignIn = !showSignIn);
}
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toogleview: toogleview);
    }else{
      return Register(toogleview: toogleview);
    }
  }
}
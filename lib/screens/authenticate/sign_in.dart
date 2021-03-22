import 'package:flutter/material.dart';
import 'package:u_chat/services/auth.dart';
import 'package:u_chat/shared/constants.dart';
import 'package:u_chat/shared/loading.dart';



class SignIn extends StatefulWidget {

  final Function toogleview;
  SignIn({this.toogleview});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {



final AuthService _auth = AuthService();
final _formKey = GlobalKey<FormState>();
bool loading = false;

String email= '';
String password='';
String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor:  Colors.brown[100],
      appBar: AppBar(
      backgroundColor: Colors.brown[400],
      elevation: 0.0,
      title: Text('Sign in to Coffee'),
      actions: <Widget>[
        FlatButton.icon(
          onPressed: (){
            widget.toogleview();
          }, 
          icon: Icon(Icons.person),
          label: Text('Register'),
          )
      ],
      ),
      
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=> val.isEmpty ? 'Invalid Email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                }
              ),

              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),                
                validator: (val)=> val.length < 6 ? 'Enter a password of at least 6 digit' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });

                }
              ),
               SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('Sign in', style: TextStyle(color: Colors.white),),
                onPressed: () async{
                    if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                    if(result==null){
                      setState(() {
                        error='Failded to sign in';
                        loading = false;
                      });
                    }
                    }
                },
              ),
              SizedBox(
                height:12.0
              ),
              Text(error,style:  TextStyle(color: Colors.red,fontSize: 14.0),)
              
            ],),
        ),
      )
    );
  }
}
import 'package:u_chat/models/coffee.dart';
import 'package:u_chat/screens/home/coffee_list.dart';
import 'package:u_chat/screens/home/settings_form.dart';
import 'package:u_chat/services/auth.dart';
import 'package:u_chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

      void _showSettingsPanel(){
        showModalBottomSheet(
          context: context, 
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal:60.0),
              child: SettingsForm(),
            );
          });
      }


    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffee,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: (){
                _showSettingsPanel();
              },
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: CoffeeList()
          ),
      ),
    );
  }
}
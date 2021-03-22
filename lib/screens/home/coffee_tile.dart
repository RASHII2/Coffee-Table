import 'package:flutter/material.dart';
import 'package:u_chat/models/coffee.dart';
import 'package:u_chat/screens/home/coffee_list.dart';

class CoffeeTile extends StatelessWidget {

  final Coffee coffee;
  CoffeeTile({this.coffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0 ),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,6.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.5,
            backgroundColor: Colors.brown[coffee.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(coffee.name),
          subtitle: Text('${coffee.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
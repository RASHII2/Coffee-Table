import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_chat/models/user.dart';
import 'package:u_chat/services/database.dart';
import 'package:u_chat/shared/constants.dart';
import 'package:u_chat/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);

    return ListView(
    children: <Widget>[
      StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
            return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Update your preferences',
              style: TextStyle(fontSize: 18.0)
              ),
              SizedBox(height: 20.0),
               TextFormField(
                    initialValue:  userData.name,
                    decoration: textInputDecoration,
                    validator: (val)=> val.isEmpty ? 'Please enter your name' : null,
                    onChanged: (val){
                      setState(() {
                        _currentName = val;
                      });
                    }
                  ),


                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                  );
                  }).toList(),
                  onChanged: (value) => setState(() => _currentSugars = value ),
                  ),

                Slider(
                value: (_currentStrength ?? userData.strength).toDouble(),
                activeColor: Colors.brown[_currentStrength ?? 100],
                inactiveColor: Colors.brown[_currentStrength ?? 100],
                min: 100.0,
                max: 900.0,
                divisions: 8,
                onChanged: (val) => setState(() => _currentStrength = val.round())
              ),
              
                  RaisedButton(onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                        );
                        Navigator.pop(context);
                    }
                  },
                  color: Colors.pink[400],
                  child: Text('Update',
                  style: TextStyle(color: Colors.white),
                  ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0),


            ],
          ),
        );
        }
        
        else {
              return Loading();
        }
        
      }
    )
    ]
    );
  }
}
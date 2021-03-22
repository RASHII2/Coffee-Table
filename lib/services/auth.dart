import 'package:firebase_auth/firebase_auth.dart';
import 'package:u_chat/models/user.dart';
import 'package:u_chat/services/database.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //create user obj based on firebase obj
  User _userFromFirebaseUser(FirebaseUser user){
    return user!= null ? User(uid: user.uid): null;
  }

  //auth change user
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }
    
  //sign-in anom
    Future signInAnon() async{
      try{
        AuthResult result = await _auth.signInAnonymously();
        FirebaseUser _userFromFirebaseUser = result.user;
        return _userFromFirebaseUser;
      }catch(e){
          print(e.toString());
          return null;
      }
    }


  //sign in with email &pass

   Future signInWithEmailAndPassword(String email, String password) async{
      try{
          AuthResult result = await _auth.
          signInWithEmailAndPassword(email: email,password: password);
          FirebaseUser user = result.user;
          return _userFromFirebaseUser(user);
      }catch(e){
        print(e.toString());
        return null;

      }
    }



  //register
    Future registerWithEmailAndPassword(String email, String password) async{
      try{
          AuthResult result = await _auth.
          createUserWithEmailAndPassword(email: email,password: password);
          FirebaseUser user = result.user;
          //create new doc
          await DatabaseService(uid: user.uid).updateUserData('0', 'new person', 100);
          return _userFromFirebaseUser(user);
      }catch(e){
        print(e.toString());
        return null;

      }
    }

  //sign out
  Future signOut() async{
    try{
        return await _auth.signOut();
    }catch(e){
        print(e.toString());
        return null;
    }
  }

}
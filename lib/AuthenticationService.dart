
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/Welcome/welcome_screen.dart';
import 'Screens/Preferenze/preferenze_screen.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password,BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push( context,
        MaterialPageRoute(
          builder: (context) {
            return PreferenzeScreen();
          },
        ),
      );
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Username o password errati"),
      ));
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String nome, String cognome, String email, String password,BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      createRecord(cognome, nome, email);
      Navigator.push( context,
        MaterialPageRoute(
          builder: (context) {
            return WelcomeScreen();
          },
        ),
      );
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  void createRecord(String cognome,String nome, String email){
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child("Utente/"+auth.currentUser.uid).set({
      'nome': nome,
      'Cognome': cognome,
      'email': auth.currentUser.email,
    });
  }
}
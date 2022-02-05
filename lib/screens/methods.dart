
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'note_list.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
final CollectionReference _mainCollection = firestoreInstance.collection('notes');


class MethodsHandler{

  static String ? userUid;
  FirebaseAuth _auth = FirebaseAuth.instance;




  Future<User?> createAccount({String? name,String? email,String? password, BuildContext? context}) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email.toString(), password: password.toString()).then((user){
        if(user != null)
        {
          firestoreInstance.collection('users').doc(user.user!.uid).set(
              {
                "name": name,
                "email": email,
                "password": password,
              }
          ).then((value) => print('success'));

          print('Account creation successful');
          Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
          );
          Navigator.push(context!,MaterialPageRoute(builder: (_) => NoteList()));

        }


        return user;

      });

    }on FirebaseAuthException catch(e)  {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
      );
      print(e);
    }
    return null;
  }



  void clearData(TextEditingController title, TextEditingController description){
    title.clear();
    description.clear();
  }




  Future saveData ( String title, String description ) async{
    try{

      firestoreInstance.collection('note').doc().set(
          {
            'title': title,
            'caseTitle': searchCaseByTitle(title),
            'description': description,
            'uid': _auth.currentUser!.uid.toString(),
          }
      ).then((value) => print('success'));
    }catch(e){
      print('=====================0000========================');
      print(e);
      print('====================0000=========================');
    }

  }

  searchCaseByTitle(String title) {
    List<String> _caseSearchByTitle = [];
    String temp = '';
    for(int i=0; i<title.length;i++){
      temp = temp + title[i];
      _caseSearchByTitle.add(temp);
    }
    return _caseSearchByTitle;
  }



  Future<User?>loginAccount(String email,String password) async {
    try{
      User? user=(await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      if(user!=null){
        print('login Successful');

        Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        return user;

      }
      else{
        Fluttertoast.showToast(
          msg: "Login Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        return user;
      }

    }catch(e){
      print(e);
      return null;
    }

  }

  Future<User?> signOut(BuildContext context) async {
    try{
      await _auth.signOut().then((user) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login()));
      });
    }catch(e){

    }



  }

  Future delay(BuildContext context) async{
    await new Future.delayed(new Duration(milliseconds: 15), ()
    {
      Navigator.push(context,MaterialPageRoute(builder: (_) => NoteList()));

    }
    );

  }

  Future<void> delete({ String? docId,}) async {


    await firestoreInstance.collection('note').doc(docId)
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) {

      print('0000000000000000000000000000000000000000000000');
      print(e);
      print('0000000000000000000000000000000000000000000000');
    });
  }



  Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      'caseTitle': searchCaseByTitle(title),
      "description": description,
    };

    await firestoreInstance.collection('note').doc(docId)
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

}






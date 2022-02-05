import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_provider/screens/datacontroller.dart';

import 'add_note.dart';
import 'edit_note.dart';
import 'methods.dart';


class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  late String _docId;
  late String _docId2;
  String? isExecuted="";
   //bool isExecuted = false ;
  QuerySnapshot? snapShot;
  TextEditingController controller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  MethodsHandler _methods = MethodsHandler();
  int count = 1;

  bool status = false;

  @override
  void didChangeDependencies() {
    if(controller.text.isEmpty){
      setState(() {
        isExecuted='false';
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isExecuted ='';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF2f3a58),

      appBar: AppBar(

        backgroundColor: Colors.deepPurpleAccent, //Color(0xFFfdd4ce),
        title: Text('Todos'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              _methods.signOut(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.logout),

            ),
          )
        ],

      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () {
               setState(() {
                 status = !status;
                 controller.clear();
               });
            },
            tooltip: 'Search',
            child: Icon(Icons.search_sharp),
          ),
          SizedBox(height: 5,),
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  AddNote()));
            },
            tooltip: 'Add Notes',
            child: Icon(Icons.add),
          ),
        ],
      ),


      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              status ?
              Container(
                // height: size.height * 0.1,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2,color: Colors.white),),
                  child: TextFormField(
                    controller: controller,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  //  controller: _emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(

                      suffixIcon: GetBuilder<DataController>(
                          init: DataController(),
                          builder: (value) =>
                              GestureDetector(child: IconButton(icon:Icon(Icons.search), color: Colors.deepPurpleAccent,
                                onPressed: () {
                                  value.searchData(controller.text).then((result) {

                                    if(result != null){
                                      snapShot = result;
                                      if(snapShot!.docs.isEmpty){
                                        setState(() {
                                          isExecuted = 'false';
                                        });
                                        Fluttertoast.showToast(
                                          msg: "List is empty",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 4,
                                        );
                                      }
                                      else{
                                        setState(() {
                                          isExecuted = 'true';
                                        });
                                      }
                                    }
                                    else{
                                      setState(() {
                                        isExecuted = 'false';
                                      });
                                      Fluttertoast.showToast(
                                        msg: "Data not found",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                      );
                                    }
                                  });
                                },))),
                      contentPadding: EdgeInsets.only(left: 9.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Search here',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {
                      //EmailValidator.validate(value!);
                      //   if (!EmailValidator.validate(
                      //       _emailController.text)) {
                      //     return 'Please provide valid email';
                      //   }
                      //   return null;
                    })):Container(height: 0,),

              SizedBox(
                height: 30,
              ),
              isExecuted == 'true' ?
              showData():
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('note').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return
                        streamSnapshot.data!.docs.isNotEmpty ?
                        Container(
                          width: size.width*0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (ctx, index) {
                              _docId = streamSnapshot.data!.docs[index]["uid"].toString();
                              // return
                              return _auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]["uid"].toString() ?
                             Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Color(0xFF041955),
                                    child: ListTile(
                                      title: Text(streamSnapshot.data!.docs[index]["title"]
                                          .toString(),style: TextStyle(color: Colors.white),),
                                      subtitle: Text(streamSnapshot.data!
                                          .docs[index]["description"].toString(),style: TextStyle(color: Colors.white),),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.deepPurpleAccent,
                                        child: Icon(Icons.play_arrow,),
                                      ),
                                      trailing: IconButton(

                                        onPressed: () {
                                          // _methods.delete(
                                          //     docId: streamSnapshot.data!.docs[index].id);

                                          showAlertDialog(context, streamSnapshot.data!.docs[index].id.toString());
                                        },
                                        icon: Icon(
                                            Icons.delete_outline,
                                          color: Color(0xFFf79b1b),
                                        ),
                                      ),

                                      onTap: () {
                                        // documents.forEach((element) {
                                        //   _docId = element.reference.id;
                                        // });
                                        print(_docId.toString());
                                        if (streamSnapshot.data!
                                            .docs[index].id != null) {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (c, a1, a2) =>
                                                  EditNote(
                                                    title: streamSnapshot.data!
                                                        .docs[index]["title"].toString(),
                                                    desc: streamSnapshot.data!
                                                        .docs[index]["description"]
                                                        .toString(),
                                                    status: 'Update',

                                                    docId: streamSnapshot.data!
                                                        .docs[index].id,
                                                  ),
                                              transitionsBuilder: (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim, child: child),
                                              transitionDuration: Duration(milliseconds: 0),
                                            ),
                                          );
                                        }
                                        else {
                                          Fluttertoast.showToast(
                                            msg: "Id not found",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 4,
                                          );
                                        }
                                      },
                                    ),
                                  )
                                  : Container(height: 0,);
                            },
                          ),
                        )
                            : Center(child: Container(child: Text(
                          'No Data Found', style: TextStyle(color: Colors.white),),)
                        );
                    }
                    else if (streamSnapshot.hasError) {
                      return Center(
                          child: Text('Error', style: TextStyle(color: Colors.white),));
                    }
                    else {
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),

      // FutureBuilder<QuerySnapshot>(
      //   // <2> Pass `Future<QuerySnapshot>` to future
      //     future: FirebaseFirestore.instance.collection('note').get(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         // <3> Retrieve `List<DocumentSnapshot>` from snapshot
      //
      //         final List<DocumentSnapshot> documents = snapshot.data!.docs;
      //         return
      //           ListView(
      //               children: documents
      //                   .map((doc) =>
      //               _auth.currentUser!.uid.toString() == doc["uid"].toString() ?
      //               GestureDetector(
      //                 onTap: (){
      //
      //                 },
      //                 child: Card(
      //                   child: ListTile(
      //                     title: Text(doc['title']),
      //                     subtitle: Text(doc['description']),
      //                     leading: CircleAvatar(
      //                       backgroundColor: Colors.deepOrange,
      //                       child: Icon(Icons.play_arrow,),
      //                     ),
      //
      //                     trailing: GestureDetector(
      //
      //                         onTap: (){
      //
      //                           documents.forEach((element) {
      //                             _docId = element.reference.id;
      //                           });
      //                           print(_docId);
      //
      //                           _methods.delete(docId: _docId.toString());
      //                         },
      //                         child: Icon(Icons.delete)
      //                     ),
      //                     onTap: (){
      //                       documents.forEach((element) {
      //                         _docId = element.reference.id;
      //                       });
      //                       print(_docId.toString());
      //                       _docId2 = _docId ;
      //                       if(_docId != null ) {
      //                         Navigator.push(
      //                           context,
      //                           PageRouteBuilder(
      //                             pageBuilder: (c, a1, a2) => EditNote(
      //                               title: doc['title'],
      //                               desc: doc['description'],
      //                               status: 'Update',
      //                               docId:_docId.toString(),
      //                             ),
      //                             transitionsBuilder: (c, anim, a2, child) =>
      //                                 FadeTransition(opacity: anim, child: child),
      //                             transitionDuration: Duration(milliseconds: 0),
      //                           ),
      //                         );
      //                       }
      //                       else {
      //                         Fluttertoast.showToast(
      //                           msg: "Id not found",
      //                           toastLength: Toast.LENGTH_SHORT,
      //                           gravity: ToastGravity.BOTTOM,
      //                           timeInSecForIosWeb: 4,
      //                         );
      //                       }
      //
      //                     },
      //                   ),
      //                 ),
      //               ) : Container(height: 0,)
      //               )
      //                   .toList());
      //       }
      //       else if (snapshot.hasError) {
      //         return Text('Its Error!');
      //       }
      //       else {
      //         return Container(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //     }
      //
      // ),
    );
  }

  showAlertDialog(BuildContext context, String docId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        //FirebaseFirestore.instance.collection("note").doc(docId).delete();
        _methods.delete(docId: docId);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
    title: Text("Delete"),
    content: Text("Are you sure you want to delete this item?"),
    actions: [
      cancelButton,
      continueButton,
    ],
    );

    // show the dialog
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return alert;
    },
    );

  }
  
  Widget showData(){
    print(snapShot!.docs);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapShot!.docs.length,
      itemBuilder: (ctx, int index) {
       return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color(0xFF041955),
          child: ListTile(
            title: Text(snapShot!.docs[index]["title"].toString(),style: TextStyle(color: Colors.white),),
            subtitle: Text(snapShot!.docs[index]["description"].toString(),style: TextStyle(color: Colors.white),),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.play_arrow,),
            ),
            trailing: IconButton(

              onPressed: () {
                // _methods.delete(
                //     docId: streamSnapshot.data!.docs[index].id);

                showAlertDialog(context, snapShot!.docs[index].id.toString());
              },
              icon: Icon(
                Icons.delete_outline,
                color: Color(0xFFf79b1b),
              ),
            ),

            onTap: () {
              // documents.forEach((element) {
              //   _docId = element.reference.id;
              // });
              // print(_docId.toString());
              // if (streamSnapshot.data!
              //     .docs[index].id != null) {
              //   Navigator.push(
              //     context,
              //     PageRouteBuilder(
              //       pageBuilder: (c, a1, a2) =>
              //           EditNote(
              //             title: streamSnapshot.data!
              //                 .docs[index]["title"].toString(),
              //             desc: streamSnapshot.data!
              //                 .docs[index]["description"]
              //                 .toString(),
              //             status: 'Update',
              //
              //             docId: streamSnapshot.data!
              //                 .docs[index].id,
              //           ),
              //       transitionsBuilder: (c, anim, a2, child) =>
              //           FadeTransition(
              //               opacity: anim, child: child),
              //       transitionDuration: Duration(milliseconds: 0),
              //     ),
              //   );
              // }
              // else {
              //   Fluttertoast.showToast(
              //     msg: "Id not found",
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 4,
              //   );
              // }
            },
          ),
        );
            
      },
    );
  }

}
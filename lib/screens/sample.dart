// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:todo_provider/screens/datacontroller.dart';
// import 'package:todo_provider/screens/methods.dart';
//
//
// class NoteList2 extends StatefulWidget {
//   const NoteList2({Key? key}) : super(key: key);
//
//   @override
//   _NoteList2State createState() => _NoteList2State();
// }
//
// class _NoteList2State extends State<NoteList2> {
//
//   String? isExecuted="";
//   QuerySnapshot? snapShot;
//   TextEditingController cont = TextEditingController();
//   String? _docId;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   MethodsHandler _methods=MethodsHandler();
//   int count=1;
//   Widget searchData2(){
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: snapShot!.docs.length
//         ,itemBuilder: (context, int index){
//       return Container(
//
//         child:ListTile(
//           title: Text(snapShot!.docs[index]["title"].toString()),
//           subtitle: Text(snapShot!.docs[index]["description"].toString(),),
//           leading: CircleAvatar(
//             backgroundColor: Colors.deepOrange,
//             child: Icon(Icons.play_arrow,),
//           ),
//           trailing: IconButton(
//             icon: Icon(Icons.delete_outline_outlined,color: Colors.black,),
//             onPressed: (){
//               showAlertDialog(context, snapShot!.docs[index].id.toString());
//
//             },
//           ),
//
//           onTap: (){
//             print(_docId.toString());
//             if(snapShot!.docs[index].id.isNotEmpty ) {
//               // Navigator.push(
//               //   context,
//               //   PageRouteBuilder(
//               //     pageBuilder: (c, a1, a2) => NoteDetails(
//               //       title: snapShot!.docs[index]["title"].toString(),
//               //       desc: snapShot!.docs[index]["description"].toString(),
//               //       status: 'Update',
//               //       docId:snapShot!.docs[index].id,
//               //     ),
//               //     transitionsBuilder: (c, anim, a2, child) =>
//               //         FadeTransition(opacity: anim, child: child),
//               //     transitionDuration: Duration(milliseconds: 0),
//               //   ),
//               // );
//             }
//             else {
//               Fluttertoast.showToast(
//                 msg: "Id not found",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 4,
//               );
//             }
//
//           },
//         ),
//
//
//         // Text(
//         //   snapShot!.docs[index]['title'].toString(),
//         // ),
//       );
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     if(cont.text.isEmpty){
//       setState(() {
//         isExecuted="false";
//       });
//     }
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     setState(() {
//       isExecuted = "";
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//
//       appBar: AppBar(
//
//         backgroundColor: Colors.deepPurpleAccent,
//         title: Text('Todos'),
//         centerTitle: true,
//         actions: [
//           GestureDetector(
//             onTap: (){
//               _methods.signOut(context);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Icon(Icons.logout),
//
//             ),
//           )
//         ],
//
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: Colors.deepPurpleAccent,
//       //   onPressed: (){
//       //     Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteDetails(title: '',desc: '',status: 'Save',docId: '',)));
//       //   },
//       //   tooltip: 'Add Notes',
//       //   child: Icon(Icons.add),
//       // ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.deepPurpleAccent,
//         onPressed: (){
//        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteDetails(title: '',desc: '',status: 'Save',docId: '',)));
//         },
//         tooltip: 'Add Notes',
//         child: Icon(Icons.add),
//
//         heroTag: null,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//
//             Container(
//                 child: Container(
//
//                   width: size.width * 0.95,
//                   height: size.height * 0.1,
//                   child: TextFormField(
//                     obscureText: false,
//                     // validator: (value){
//                     //   if(value!.isEmpty){
//                     //     return 'Please type $hintText';
//                     //   }
//                     //
//                     //
//                     //
//                     //
//                     // },
//                     controller: cont,
//                     decoration: InputDecoration(
//                       suffixIcon: GetBuilder<DataController>(
//                           init: DataController(),
//                           builder: (value) =>
//                               GestureDetector(child: IconButton(icon:Icon(Icons.search), color: Colors.deepPurpleAccent,
//                                 onPressed: () {
//                                   value.searchData(cont.text).then((result) {
//
//                                     if(result != null){
//                                       snapShot = result;
//                                       if(snapShot!.docs.isEmpty){
//                                         setState(() {
//                                           isExecuted = "false";
//                                         });
//                                         Fluttertoast.showToast(
//                                           msg: "List is empty",
//                                           toastLength: Toast.LENGTH_SHORT,
//                                           gravity: ToastGravity.BOTTOM,
//                                           timeInSecForIosWeb: 4,
//                                         );
//                                       }
//                                       else{
//                                         setState(() {
//                                           isExecuted = "true";
//                                         });
//                                       }
//                                     }
//                                     else{
//                                       setState(() {
//                                         isExecuted = "false";
//                                       });
//                                       Fluttertoast.showToast(
//                                         msg: "Data not found",
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.BOTTOM,
//                                         timeInSecForIosWeb: 4,
//                                       );
//                                     }
//                                   });
//                                 },))),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Search here...',
//                       hintStyle: TextStyle(
//                         color: Colors.grey.withOpacity(0.5),
//                         fontSize: 13,
//                       ),
//                       isDense: true,
//                       contentPadding: EdgeInsets.fromLTRB(8, 20, 15, 0),
//                       // contentPadding: EdgeInsets.only(left: 8,right: 8),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(2.0),
//                         borderSide: BorderSide(
//                           color: Colors.deepPurpleAccent,
//                           width: 0.5,
//                         ),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(2.0),
//                         borderSide: BorderSide(
//                           color: Colors.red,
//                           width: 0.5,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(2.0),
//                         borderSide: BorderSide(
//                           color: Colors.deepPurpleAccent,
//                           width: 0.5,
//                         ),
//                       ),
//
//                       //filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(2.0),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                           width: 0.5,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//             ),
//             isExecuted == 'true' ? searchData2(): Container(
//               child: StreamBuilder(
//                   stream: FirebaseFirestore.instance.collection('note').snapshots(),
//                   builder:
//                       (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
//
//                     if (streamSnapshot.hasData) {
//                       return
//                         streamSnapshot.data!.docs.isNotEmpty ?
//                         ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: streamSnapshot.data!.docs.length,
//                           itemBuilder: (ctx, index){
//                             _docId = streamSnapshot.data!.docs[index]["uid"].toString();
//                             // return
//                             return _auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]["uid"].toString() ?
//                             GestureDetector(
//                               onTap: (){
//
//                               },
//                               child: Card(
//                                 child: ListTile(
//                                   title: Text(streamSnapshot.data!.docs[index]["title"].toString()),
//                                   subtitle: Text(streamSnapshot.data!.docs[index]["description"].toString(),),
//                                   leading: CircleAvatar(
//                                     backgroundColor: Colors.deepOrange,
//                                     child: Icon(Icons.play_arrow,),
//                                   ),
//                                   trailing: IconButton(
//                                     icon: Icon(Icons.delete_outline_outlined,color: Colors.black,),
//                                     onPressed: (){
//                                       showAlertDialog(context, streamSnapshot.data!.docs[index].id.toString());
//
//                                     },
//                                   ),
//
//                                   onTap: (){
//                                     print(_docId.toString());
//                                     if(streamSnapshot.data!.docs[index].id.isNotEmpty ) {
//                                       // Navigator.push(
//                                       //   context,
//                                       //   PageRouteBuilder(
//                                       //     pageBuilder: (c, a1, a2) => NoteDetails(
//                                       //       title: streamSnapshot.data!.docs[index]["title"].toString(),
//                                       //       desc: streamSnapshot.data!.docs[index]["description"].toString(),
//                                       //       status: 'Update',
//                                       //       docId:streamSnapshot.data!.docs[index].id,
//                                       //     ),
//                                       //     transitionsBuilder: (c, anim, a2, child) =>
//                                       //         FadeTransition(opacity: anim, child: child),
//                                       //     transitionDuration: Duration(milliseconds: 0),
//                                       //   ),
//                                       // );
//                                     }
//                                     else {
//                                       Fluttertoast.showToast(
//                                         msg: "Id not found",
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.BOTTOM,
//                                         timeInSecForIosWeb: 4,
//                                       );
//                                     }
//
//                                   },
//                                 ),
//                               ),
//                             ) : Container(height: 0,);
//
//                           },
//                         )
//                             : Center(child: Container(child: Text('Please add some notes', style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w400,),),)
//                         );
//                     }
//                     else if (streamSnapshot.hasError) {
//                       return Center(child: Text('Error', style: TextStyle(color: Colors.black),));
//                     }
//                     else {
//                       return Container(
//                         child: Center(child: CircularProgressIndicator()),
//                       );
//                     }
//                   }
//               ),
//             ),
//           ],
//         ),
//       ),
//
//
//     );
//
//   }
//   showAlertDialog(BuildContext context, String docId) {
//
//     // set up the buttons
//     Widget cancelButton = TextButton(
//       child: Text("Cancel"),
//       onPressed:  () {
//         Navigator.pop(context);
//
//       },
//     );
//     Widget continueButton = TextButton(
//       child: Text("Confirm"),
//       onPressed:  () {
//         //FirebaseFirestore.instance.collection("note").doc(docId).delete();
//         _methods.delete(docId: docId);
//         Navigator.pop(context);
//         Fluttertoast.showToast(
//           msg: "Note deleted successfully",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 4,
//         );
//
//       },
//     );
//
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("Delete"),
//       content: Text("Are you sure you want to delete this item?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//
//
// }
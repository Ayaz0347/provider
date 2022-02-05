import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'methods.dart';

class EditNote extends StatefulWidget {
  final String desc;
  final String title;
  final String status;
  final String docId;
  const EditNote(
      {Key? key,
      required this.docId,
      required this.title,
      required this.desc,
      required this.status})
      : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final String desc = '';
  final String title = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  MethodsHandler _methods = MethodsHandler();
  GlobalKey<FormState> _key = GlobalKey();

  var items = ['High', 'Low'];
  String dropdownValue = 'Low';

  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _title.text = widget.title;
      _description.text = widget.desc;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //TextStyle? textStyle = Theme.of(context).textTheme.title;
    TextInputType textInputType = TextInputType.multiline;
    return Scaffold(
      backgroundColor: Color(0xFF3450a1),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Edit Note'),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15),
          child: Center(
            child: Container(
              width: size.width*0.95,
              child: ListView(
                children: [
                  Container(
                    width: size.width*0.7,
                    child: Theme(

                      data: Theme.of(context).copyWith(canvasColor: Colors.deepPurpleAccent),
                      child: DropdownButton(
                        focusColor:Colors.black,
                        style: TextStyle(color:Colors.white ),
                        iconEnabledColor: Colors.white,
                        value: dropdownValue,
                        //  style: textStyle,
                        onChanged: (String? valueSelectedByUser) {
                          setState(() {
                            dropdownValue = valueSelectedByUser!;
                          });
                        },
                        items: <String>[
                          'Low',
                          'High',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: size.height * 0.1,
                        maxHeight: size.height * 0.1,
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          title != value;
                        },
                        keyboardType: TextInputType.text,
                        controller: _title,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'title',
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontSize: 13,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(8, 20, 15, 0),
                          // contentPadding: EdgeInsets.only(left: 8,right: 8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.deepPurpleAccent,
                              width: 0.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.deepPurpleAccent,
                              width: 0.5,
                            ),
                          ),

                          //filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write something';
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: size.height * 0.3,
                        maxHeight: size.height * 0.5,
                      ),
                      child: TextFormField(
                        maxLines: 9,
                        onSaved: (value) {
                          desc != value;
                        },
                        keyboardType: TextInputType.text,
                        controller: _description,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Description',
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontSize: 13,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(8, 20, 15, 0),
                          // contentPadding: EdgeInsets.only(left: 8,right: 8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.deepPurpleAccent,
                              width: 0.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.deepPurpleAccent,
                              width: 0.5,
                            ),
                          ),

                          //filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write something';
                          }
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      getButton(
                        size: size,
                        text: widget.status == 'Update' ? 'Update' : 'Save',
                      ),
                      getButton(
                        size: size,
                        text: 'Clear',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getButton({Size? size, String? text, TextStyle? textStyle}) {
    return (Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 2, left: 2),
      child: Container(
        height: size!.height * 0.05,
        width: size.width * 0.455,
        child: ElevatedButton(
          onPressed: () {
            // if(_key.currentState!.validate()){
            //   print('validated');
            // }
            if (text == "Update") {
              if (_key.currentState!.validate()) {
                _methods
                    .updateItem(
                        title: _title.text,
                        description: _description.text,
                        docId: widget.docId)
                    .then((value) => Navigator.pop(context));

                print('validated and save');
              }
            } else if (text == 'Save') {
              if (_key.currentState!.validate()) {
                _methods
                    .saveData(_title.text, _description.text)
                    .then((value) => Navigator.pop(context));
                print('hello');
              }
            } else {
              print('clear');
              _methods.clearData(_title, _description);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurpleAccent,
          ),
          child: Center(
            child: Text(
              text!,
              style: textStyle,
            ),
          ),
        ),
      ),
    ));
  }
}

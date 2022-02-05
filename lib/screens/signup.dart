import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'login.dart';
import 'methods.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MethodsHandler _methodsHandler = MethodsHandler();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: size.width * 0.5,
                  //   height: size.height * 0.07,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.6,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: Container(
                        child: const Text("Welcome",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: Container(
                        width: size.width * 0.8,
                        alignment: Alignment.center,
                        child: const Text("Please create Your Accont",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Container(
                      // height: size.height * 0.1,
                        width: size.width * 0.8,
                        // decoration: BoxDecoration(
                        //   border: Border.all(width: 2,color: Colors.blue),
                        // ),

                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
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
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            //EmailValidator.validate(value!);
                            if (value!.isEmpty) {
                              return 'Please provide valid name';
                            }
                            return null;
                          },
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Container(
                      // height: size.height * 0.1,
                        width: size.width * 0.8,
                        // decoration: BoxDecoration(
                        //   border: Border.all(width: 2,color: Colors.blue),
                        // ),

                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
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
                            hintText: 'Enter Email account',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            //EmailValidator.validate(value!);
                            if (!EmailValidator.validate(
                                _emailController.text)) {
                              return 'Please provide valid email';
                            }
                            return null;
                          },
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: size.width * 0.8,
                      child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              //  labelText: "Enter Email",
                              fillColor: Colors.white,
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
                              hintText: "Enter Password"),
                        validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter valid password';
                            }
                            else
                              return null;
                        },
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _methodsHandler.createAccount(name: _nameController.text,email: _emailController.text,
                              password: _passwordController.text, context: context);
                        }
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.8,
                    child: RichText(
                        text: TextSpan(
                            text: 'Already have account? ',
                            style:
                            TextStyle(color: Colors.black, fontSize: 14.0),
                            children: [
                              TextSpan(
                                  text: 'Login ',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    Navigator.push(context,MaterialPageRoute(builder: (_) => Login()));
                                  }
                              ),

                            ])),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: RichText(
                        text: TextSpan(
                            text: 'By continuing you agree to Our app\'s ',
                            style:
                            TextStyle(color: Colors.black, fontSize: 10.0),
                            children: [
                              TextSpan(
                                text: 'term of use ',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                              ),
                              TextSpan(
                                text: 'and Confirm that you have read our app\'s ',
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy policy',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                              ),
                            ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

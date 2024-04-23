import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../UiHelper/Textfield.dart';
import 'Login.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController pass = TextEditingController();

  Signup() async {
    if (email == "" && pass == "") {
      log("message");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: pass.text)
            .then((value) => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Login())));
      } on FirebaseAuthException catch (ex) {
        return ex.code.toString();
      }
    }
  }

  addUser(String name, String email, String number, String pass) async {
    if(name=="" && email=="" && number=="" && pass==""){
      log("message");
    }else{
       FirebaseFirestore.instance.collection("Profile").doc(name).set({
         "Name" : name,
         "Email" : email,
         "Number": number,
         "Password" : pass
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              CircleAvatar(
                radius: 60,
                child: Text(
                  'SignUP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Costum.textField(name, 'Enter your Full Name', Icon(Icons.person)),
              Costum.textField(email, 'Enter Your Mail', Icon(Icons.lock)),
              Costum.textField(number, 'Enter your Number', Icon(Icons.email)),
              Costum.textField(pass, 'Enter Your Password', Icon(Icons.lock)),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  Signup();
                  addUser(name.text.toString(), email.text.toString(), number.text.toString(), pass.text.toString());
                },
                child: Text(
                  'SignUP',
                  style: TextStyle(fontSize: 23),
                ),
                style: ElevatedButton.styleFrom(minimumSize: Size(300, 50)),
              ),
              SizedBox(
                height: 42,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Already Login ?',
                    style: TextStyle(fontSize: 17),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Login()));
                      },
                      child: Text(
                        'Login here',
                        style:
                            TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}

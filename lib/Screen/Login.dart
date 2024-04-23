import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_task/Screen/SignUp.dart';
import 'package:login_task/UiHelper/Textfield.dart';

import 'Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  login ()async{

    if(email=="" && pass=="") {
      return AlertDialog(
        title: Text('Enter Required details'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Ok'))
        ],
      );
    }
    else{
      UserCredential ? usercredential;
      try{
        usercredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: pass.text)
            .then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen())))
        ;
      }
      on FirebaseAuthException catch(ex){
        return ex.code.toString();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              child: Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Costum.textField(email, 'Enter your Mail', Icon(Icons.email)),
            Costum.textField(pass, 'Enter Your Password', Icon(Icons.lock)),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
login();
              },
              child: Text('Login'),
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
                  'Are you not Registered ?',
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUP()));
                    },
                    child: Text(
                      'Register here',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ));
  }
}

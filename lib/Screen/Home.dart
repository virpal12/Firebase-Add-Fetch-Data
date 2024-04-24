import 'package:flutter/material.dart';
import 'package:login_task/Screen/Upload.dart';
import 'package:login_task/Screen/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade200,
        appBar: AppBar(
          title: Text('Home Screen', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
          centerTitle: true,
          elevation: 5,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile()));

                },
                child: CircleAvatar(
                  radius: 50,
                  child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile()));

                  }, icon: Icon(Icons.person, size: 44), ),
                ),
              ),

              SizedBox(height: 50,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Upload()));
                },
                child: Container(

                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(child: Text('Upload Image', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

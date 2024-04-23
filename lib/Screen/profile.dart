import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:                                   Text(
          'Personal Details',
          style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold),
        ),

      ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Profile").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 178.0),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              height: 300,
                              width: 350,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Text(
                                      'Name:${snapshot.data!.docs[index]['Name']}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true),
                                  Text(
                                      'Email:${snapshot.data!.docs[index]['Email']}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis),
                                  Text(
                                      'Number:${snapshot.data!.docs[index]['Number']}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      'Password:${snapshot.data!.docs[index]['Password']}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasData) {
                return Center(
                  child: Text(snapshot.hasError.toString()),
                );
              } else {
                return Center(
                  child: Text('No Data Found'),
                );
              }
            }));
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  bool selected = false;
  File? pickedImage;

  auth() {
    if (pickedImage == null) {
      return Text('Image not Uploded');
    } else {
      return uploadImage();
    }
  }

  _showDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pick Image From'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  title: Text('Camera'),
                  leading: Icon(Icons.camera_alt),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  title: Text('Gallery'),
                  leading: Icon(Icons.image),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                _showDialog();
                auth();
              },
              child: Text(
                'Upload Image',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Images")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    height: 300,
                                    width: 300,
                                    child: Image(
                                      image: NetworkImage(snapshot
                                          .data!.docs[index]['Image Url']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: selected
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(Icons.favorite_border),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selected = !selected;
                                    });
                                  },
                                ),
                              ],
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
                  }),
            )
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    final photo = await ImagePicker().pickImage(source: imageSource);

    try {
      if (photo == null) return;
      final tempImage = File(photo.path);

      setState(() {
        pickedImage = tempImage;
        uploadImage();
      });
    } catch (ex) {
      return ex.toString();
    }
  }

  uploadImage() async {
    final Reference storageRef = FirebaseStorage.instance.ref();

    final imagesRef = storageRef.child("images");

    String name = pickedImage!.path.split("/").last;

    await imagesRef.child(name).putFile(File(pickedImage!.path));

    String imageURL = await imagesRef.child(name).getDownloadURL();

    FirebaseFirestore.instance
        .collection("Images")
        .doc()
        .set({"Name": name, "Image Url": imageURL}).then(
            (value) => Text('Image Uploaded'));
  }
}

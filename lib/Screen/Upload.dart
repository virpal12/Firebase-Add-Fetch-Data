import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class upload extends StatefulWidget {
  const upload({super.key});

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  bool selected = false;
  File? _image;

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  // height: 500,
                  // width: 450,

                  child: _image == null?
                Text("No Image Selected")
                   : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      
                ),
              ),
              InkWell(
                child: Container(
                  height: 50,
                  width: 50,
                  child: selected
                      ? Image(
                          image: AssetImage('Assets/Images/heart (1) (1).png'),
                          color: Colors.red,
                        )
                      : Image(image: AssetImage('Assets/Images/heart 3.png')),
                ),
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
              ),
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: const Icon(Icons.photo_camera_back),
        ),
      ),
    );
  }
}

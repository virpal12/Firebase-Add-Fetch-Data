

import 'package:flutter/material.dart';

class Costum {
  static textField (TextEditingController controller, String text, Icon icon){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: TextField(

        controller: controller,

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: text,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),

          ),
        ),
      ),
    );

  }


}
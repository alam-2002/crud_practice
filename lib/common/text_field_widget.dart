import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final ValueChanged<String>? onChanged;
  final String hintText;

  const TextFieldWidget({
    super.key,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          label: Text(hintText),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

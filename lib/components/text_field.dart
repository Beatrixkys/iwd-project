import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final String title;
  final String hinttext;
  final Function(String?) onSaved;
  final FormFieldValidator validator;
  final TextEditingController controller;

  const RoundTextField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.hinttext,
      required this.onSaved,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hinttext,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: title,
        ),
        //initialValue: hinttext,
        onSaved: onSaved,
        controller: controller,
        validator: validator,
      ),
    );
  }
}

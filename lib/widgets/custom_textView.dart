import 'package:flutter/material.dart';
import '../constants.dart';

class CustomeTextField extends StatelessWidget {
 String  initValue;
  String hintText;
  IconData iconText;
  final Function onClick;
  CustomeTextField({@required this.onClick,@required this.hintText,@required this.iconText,this.initValue});
  String validateString(String hintText){
    switch(hintText) {
      case "enter your name":
        return "name not valid";
      case "enter your email":
        return "email not valid";
      case "enter your password":
        return "password not valid";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30),
      child: TextFormField(
        initialValue: initValue,
        validator: (value){
          if(value.isEmpty){
            return validateString(hintText);
          }
//          else return "";
        },
        onSaved: onClick,
        obscureText: hintText=="enter your password"?true:false,
        cursorColor: KMainColor,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: KTextFieldColor,
          prefixIcon: Icon(iconText,color: KMainColor,),
          enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1,color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
              ,borderRadius: BorderRadius.circular(20)),
          border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
              ,borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}

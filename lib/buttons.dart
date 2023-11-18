import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  MyButtonWidget({this.color, this.textColor,required this.buttonText,this.buttonTapped});
  /*MyButtonWidget(
  buttonText: 'Click Me!',
  color: Colors.blue, // Optional, sets the button background color
  textColor: Colors.white, // Optional, sets the button text color
)*/
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:Container(
            color:color,
            child: Center(child: Text(buttonText,style: TextStyle(color:textColor,fontSize: 20),)),
          )
        ),
      ),
    );
  }
}
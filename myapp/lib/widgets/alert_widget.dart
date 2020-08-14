import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function onPressedOK;
  final Function onPressedCancel;
  AlertWidget({
    @required this.title,
    @required this.message,
    this.onPressedOK,
    this.onPressedCancel
  }): super();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(this.message, style: TextStyle(fontSize: 20,)),
              Row(
                children: [
                  RaisedButton(
                    onPressed: this.onPressedOK,
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                  this.onPressedCancel != null ?
                  RaisedButton(
                    onPressed: this.onPressedCancel,
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ): Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
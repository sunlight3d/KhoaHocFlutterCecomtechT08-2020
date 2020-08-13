import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/types/screen_type.dart';

class HeaderButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isShowBottomLine;
  HeaderButton({this.title, this.onPressed, this.isShowBottomLine});
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children: [
        FlatButton(
            onPressed: this.onPressed,
            child: Text(this.title,
              style: TextStyle(
                  fontSize: 22, color: Colors.black),)),
        isShowBottomLine == true ? Container(
          child: SizedBox(
            height: 2,
            width: 100,
          ),
          color: Colors.redAccent,
        ) : Container()
      ],
    ));
  }
}
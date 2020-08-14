import 'package:flutter/material.dart';

class BusinessWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BusinessWidget();
}
class _BusinessWidget extends State<BusinessWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text('Business', style: TextStyle(fontSize: 30),),
    );
  }
}
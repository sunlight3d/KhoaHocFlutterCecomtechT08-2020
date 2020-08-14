import 'package:flutter/material.dart';

class SettingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingWidget();
}
class _SettingWidget extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text('Setting', style: TextStyle(fontSize: 30),),
    );
  }
}
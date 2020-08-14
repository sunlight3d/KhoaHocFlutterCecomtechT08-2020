import 'package:flutter/material.dart';

class ProductsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsWidget();
}
class _ProductsWidget extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text('Products', style: TextStyle(fontSize: 30),),
    );
  }
}
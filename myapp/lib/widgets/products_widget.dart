import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsWidget();
}
final products = [
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  )
];
class _ProductsWidget extends State<ProductsWidget> {
  final _scrollController = ScrollController();
  final _scrollThreadhold = 250.0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if(maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        print('scroll xuong cuoi');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemBuilder: (BuildContext buildContext, int index) {
          final product = products[index];
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    'images/logo.jpeg',
                    width: 100,
                    height: 100,
                  ),
                  imageUrl:
                  product.url,
                  width: 100,
                  height: 100,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                        Text('Price: ${product.price}', style: TextStyle(
                          fontSize: 22,
                        ))
                      ],
                    )
                )
              ],
            ),
          );
        },
        itemCount: products.length,
        controller:_scrollController
    );
  }
}
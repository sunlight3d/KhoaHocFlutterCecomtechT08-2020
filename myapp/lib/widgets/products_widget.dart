import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/products/bloc.dart';
import 'package:myapp/blocs/products/events.dart';
import 'package:myapp/blocs/products/states.dart';
import 'package:myapp/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsWidget();
}

class _ProductsWidget extends State<ProductsWidget> {
  final _scrollController = ScrollController();
  final _scrollThreadhold = 250.0;
  var currentPage = 1;
  @override
  void initState() {
    super.initState();
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    BlocProvider.of<ProductsBloc>(context)
        .add(ProductsEventFetch(limit:10));

    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if(maxScrollExtent - currentScroll <= _scrollThreadhold) {
        currentPage = currentPage + 1;
        final productsBloc = BlocProvider.of<ProductsBloc>(context);
        productsBloc.add(ProductsEventFetch(limit:10));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder:  (context, productsState) {
        var products = List<Product>();
        if(productsState is ProductsStateFetching) {
          return Center(
            child: CircularProgressIndicator(

            ),
          );
        } else {
          products = productsState.products;
        }
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
      },
    );

  }
}
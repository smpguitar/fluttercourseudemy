import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';
import '../Widgets/ui_elements/title_default.dart';
import '../scoped-models/products.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
final int productIndex;

  ProductPage(this.productIndex);


Widget _buildAddressPriceRow(String location, double price){
  return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Location: ',
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey, fontFamily: 'Oswald'),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    '|',
                    style: TextStyle(color: Colors.grey, fontFamily: 'Oswald'),
                  ),
                ),
                Text(
                  'Price: \$${price.toString()}',
                  style: TextStyle(color: Colors.grey, fontFamily: 'Oswald'),
                ),
              ],
            );
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('back button pressed');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<ProductsModel>(builder: (BuildContext context, Widget child, ProductsModel model){
      final Product product = model.products[productIndex];
      return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(product.image),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(product.title),
            ),
            _buildAddressPriceRow(product.location, product.price),
            SizedBox(height: 5.0),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                product.description,
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      );
       }
      ),
       
      );
     
  }
}

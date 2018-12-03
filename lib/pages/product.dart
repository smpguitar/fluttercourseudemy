import 'dart:async';

import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final String location;

  ProductPage(
      this.title, this.imageUrl, this.description, this.price, this.location);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print('back button pressed');
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
            Image.asset(imageUrl),
            Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald',
                  ),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text('Location: ',
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold)),
              Text(location,
                  style: TextStyle(color: Colors.grey, fontFamily: 'Oswald')),
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
            ]),
            SizedBox(height: 5.0),
            Container(
                margin: EdgeInsets.all(10.0),
                child: Text(description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                    ))),
          ]),
        ));
  }
}

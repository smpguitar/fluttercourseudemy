import 'dart:async';

import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final String location;
 

  ProductPage(this.title, this.imageUrl, this.description, this.price, this.location);

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
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(imageUrl),
                  Container(padding: EdgeInsets.all(10.0), 
                  child: Text(
                    title, 
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald',),)),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(children: <Widget> [
                      Text('Descrtiption: ' + description),
                      SizedBox(height: 10.0,),
                      Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(
                            (5.0),
                          )),
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                      child: Text('Price: \$${price.toString()}', 
                      style: TextStyle(
                        color: Colors.white),),),
                      SizedBox(height: 10.0),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                      Text('Location: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(location) ]
                      ),
                  ]))
                ])));
  }
}

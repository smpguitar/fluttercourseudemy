import 'package:flutter/material.dart';

import '../Widgets/helpers/ensure-visible.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'location': null,
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();

  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Product Title'),
        initialValue: widget.product == null ? '' : widget.product['title'],
        validator: (String value) {
          if (value.isEmpty || value.length < 5) {
            return 'Title is required and should be 5+ characters long';
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: InputDecoration(labelText: 'Product Description'),
        initialValue:
            widget.product == null ? '' : widget.product['description'],
        validator: (String value) {
          if (value.isEmpty || value.length < 10) {
            return 'Description is required to be 10+ characters long';
          }
        },
        maxLines: 4,
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: 'Product Price'),
        initialValue:
            widget.product == null ? '' : widget.product['price'].toString(),
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
            return 'Price is required and should be a number';
          }
        },
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        },
      ),
    );
  }

  Widget _buildLocationTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _locationFocusNode,
      child: TextFormField(
        focusNode: _locationFocusNode,
        decoration: InputDecoration(labelText: 'Product Location'),
        initialValue: widget.product == null ? '' : widget.product['location'],
        validator: (String value) {
          if (value.isEmpty || value.length < 5) {
            return 'Location is required and should be 5+ characters long';
          }
        },
        onSaved: (String value) {
          _formData['location'] = value;
        },
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * .95;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                _buildTitleTextField(),
                _buildDescriptionTextField(),
                _buildPriceTextField(),
                _buildLocationTextField(),
                SizedBox(height: 10.0),
                RaisedButton(
                    child: Text('Save'),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    onPressed: _submitForm),
                // GestureDetector(
                //   onTap: _submitForm,
                //   child: Container(
                //     color: Colors.green,
                //     padding: EdgeInsets.all(5.0),
                //     child: Text('MyButton'),
                //   ),
                // ),
              ],
            ),
          ),
        ));
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}

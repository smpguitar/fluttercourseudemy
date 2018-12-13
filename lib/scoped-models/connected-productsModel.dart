import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;

  void addProduct(String title, String description, double price, String image, 
      String location) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        location: location,
        userEmail: _authenticatedUser.email,
        userID: _authenticatedUser.password);
    _products.add(newProduct);
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel {
 

  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

   List<Product> get displayedProducts {
    if(_showFavorites){
    return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (_selProductIndex== null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  bool get displayFavoritesOnly{
    return _showFavorites;
  }

  

  void updateProduct(String title, String description, double price, String image, String location) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        location: location,
        userEmail: selectedProduct.userEmail,
        userID: selectedProduct.userID);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    notifyListeners();
  }

  void toggleProductFavoriteStatus(){
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
      title: selectedProduct.title, 
      description: selectedProduct.description,
      price: selectedProduct.price,
      image: selectedProduct.image,
      location: selectedProduct.location,
      userEmail: selectedProduct.userEmail,
      userID: selectedProduct.userID,
      isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode(){
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

}

mixin UserModel on ConnectedProductsModel{
  

  void login(String email, String password){
    _authenticatedUser = User(id: 'fqpfdwpiehn', email: email, password: password);
  }

}


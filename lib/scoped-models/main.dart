import 'package:scoped_model/scoped_model.dart';


import './connected-productsModel.dart';

class MainModel extends Model with 
  ConnectedProductsModel, UserModel, ProductsModel {}
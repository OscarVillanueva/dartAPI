import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/Categories.dart';
import 'package:firstapi/models/OrdersDetails.dart';

class Products extends ManagedObject<tblProducts> implements tblProducts {}

// Campos de la tabla
class tblProducts {
  @primaryKey
  int idProduct;

  @Column(unique: true)
  String productName;

  double price;
  int stock;
  bool discontinued;

  @Relate(#fkCategory)
  Categories idCategory;

  ManagedSet<OrdersDetails> fkProduct;
}

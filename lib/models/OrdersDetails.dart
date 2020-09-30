import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/Orders.dart';
import 'package:firstapi/models/Products.dart';

class OrdersDetails extends ManagedObject<tblOrdersDetails>
    implements tblOrdersDetails {}

// Campos de la tabla
class tblOrdersDetails {
  @primaryKey
  int idDetail;

  @Relate(#fkProduct)
  Products idProduct;

  @Relate(#fkOrder)
  Orders idOrder;

  double price;
  double discount;
  double quantity;
}

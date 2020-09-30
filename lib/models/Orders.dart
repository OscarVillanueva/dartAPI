import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/OrdersDetails.dart';

import 'Customers.dart';

class Orders extends ManagedObject<tblOrders> implements tblOrders {}

// Campos de la tabla
class tblOrders {
  @primaryKey
  int idOrder;

  @Column(indexed: true)
  DateTime dateOrder;

  @Column(indexed: true)
  DateTime shippedDate;

  @Relate(#fkCustomer)
  Customers idCustomer;

  ManagedSet<OrdersDetails> fkOrder;
}

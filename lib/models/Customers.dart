import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/Orders.dart';

class Customers extends ManagedObject<tblCustomers> implements tblCustomers {}

// Campos de la tabla
class tblCustomers {
  @primaryKey
  int idCustomer;

  String customerName;
  String address;
  String customerPhone;

  @Column(unique: true)
  String email;

  ManagedSet<Orders> fkCustomer;
}

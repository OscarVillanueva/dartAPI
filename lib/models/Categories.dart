import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/Products.dart';

class Categories extends ManagedObject<tblCategories> implements tblCategories {
}

// Campos de la tabla
class tblCategories {
  @primaryKey
  int idCategory;

  @Column(unique: true)
  String categoryName;

  // Se manda la llave primaria 1:M
  ManagedSet<Products> fkCategory;
}

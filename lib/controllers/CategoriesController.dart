import 'package:firstapi/firstapi.dart';
import 'package:firstapi/helpers/Properties.dart';
import 'package:firstapi/models/Categories.dart';

class CategoriesController extends ResourceController {
  CategoriesController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCategories(
      @Bind.header("authorization") String authHeader) async {
    // only allow with correct username and password
    if (!Properties.isAuthorized(authHeader)) {
      return Response.forbidden();
    }

    // Consulta al modelo
    final categoriesQuery = Query<Categories>(context);

    // Leemos los productos de la consulta
    final categories = await categoriesQuery.fetch();

    return Response.ok(categories);
  }

  @Operation.get("idCategory")
  Future<Response> getCategory(@Bind.path("idCategory") int id) async {
    // Consulta al modelo
    final categoryQuery = Query<Categories>(context)
      ..where((x) => x.idCategory).equalTo(id);

    // Leemos los productos
    final category = await categoryQuery.fetchOne();

    return category != null ? Response.ok(category) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addCategory() async {
    // Decodicamos los datos por parametro
    final category = Categories()
      ..read(await request.body.decode(), ignore: ["idCategory"]);

    // Hacemos el query
    final categoryQuery = Query<Categories>(context)..values = category;

    // Insertamos el producto
    final addCategory = await categoryQuery.insert();

    return Response.ok(addCategory);
  }

  @Operation.put("idCategory")
  Future<Response> updateCategory(@Bind.path("idCategory") int id) async {
    // Construimos el producto
    final category = Categories()..read(await request.body.decode());

    // Hacemos el query
    final categoryQuery = Query<Categories>(context)
      ..where((x) => x.idCategory).equalTo(id)
      ..values = category;

    // Ejecutamos
    final updatedCategory = await categoryQuery.update();

    return updatedCategory != null
        ? Response.ok(updatedCategory)
        : Response.notFound();
  }

  @Operation.delete("idCategory")
  Future<Response> deleteCategory(@Bind.path("idCategory") int id) async {
    // Hacemos el query
    final categoryQuery = Query<Categories>(context)
      ..where((x) => x.idCategory).equalTo(id);

    // Ejecutamos
    final deletedQuery = await categoryQuery.delete();

    return deletedQuery != null
        ? Response.ok(deletedQuery)
        : Response.notFound();
  }
}

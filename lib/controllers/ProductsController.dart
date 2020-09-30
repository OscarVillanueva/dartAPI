import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/Products.dart';

class ProductsController extends ResourceController {
  ProductsController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllProduct() async {
    // Consulta al modelo
    final productsQuery = Query<Products>(context);

    // Leemos los productos de la consulta
    final products = await productsQuery.fetch();

    return Response.ok(products);
  }

  @Operation.get("idProduct")
  Future<Response> getProduct(@Bind.path("idProduct") int id) async {
    // Consulta al modelo
    final productQuery = Query<Products>(context)
      ..where((x) => x.idProduct).equalTo(id);

    // Leemos los productos
    final product = await productQuery.fetchOne();

    return product != null ? Response.ok(product) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addProduct() async {
    // Decodicamos los datos por parametro
    final product = Products()
      ..read(await request.body.decode(), ignore: ["idProduct"]);

    // Hacemos el query
    final productQuery = Query<Products>(context)..values = product;

    // Insertamos el producto
    final addProduct = await productQuery.insert();

    return Response.ok(addProduct);
  }

  @Operation.put("idProduct")
  Future<Response> updateProduct(@Bind.path("idProduct") int id) async {
    // Construimos el producto
    final product = Products()..read(await request.body.decode());

    // Hacemos el query
    final productQuery = Query<Products>(context)
      ..where((x) => x.idProduct).equalTo(id)
      ..values = product;

    // Ejecutamos
    final updatedProduct = await productQuery.update();

    return updatedProduct != null
        ? Response.ok(updatedProduct)
        : Response.notFound();
  }

  @Operation.delete("idProduct")
  Future<Response> deleteProduct(@Bind.path("idProduct") int id) async {
    // Hacemos el query
    final productQuery = Query<Products>(context)
      ..where((x) => x.idProduct).equalTo(id);

    // Ejecutamos
    final deletedProduct = await productQuery.delete();

    return deletedProduct != null
        ? Response.ok(deletedProduct)
        : Response.notFound();
  }
}

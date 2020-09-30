import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/Customers.dart';

class CustomersController extends ResourceController {
  CustomersController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCustomers() async {
    // Consulta al modelo
    final customersQuery = Query<Customers>(context);

    // Leemos los productos de la consulta
    final customers = await customersQuery.fetch();

    return Response.ok(customers);
  }

  @Operation.get("idCustomer")
  Future<Response> getCustomer(@Bind.path("idCustomer") int id) async {
    // Consulta al modelo
    final customerQuery = Query<Customers>(context)
      ..where((x) => x.idCustomer).equalTo(id);

    // Leemos los productos
    final customer = await customerQuery.fetchOne();

    return customer != null ? Response.ok(customer) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addCustomer() async {
    // Decodicamos los datos por parametro
    final customer = Customers()
      ..read(await request.body.decode(), ignore: ["idCustomer"]);

    // Hacemos el query
    final customerQuery = Query<Customers>(context)..values = customer;

    // Insertamos el producto
    final addCustomer = await customerQuery.insert();

    return Response.ok(addCustomer);
  }

  @Operation.put("idCustomer")
  Future<Response> updateCustomer(@Bind.path("idCustomer") int id) async {
    // Construimos el producto
    final customer = Customers()..read(await request.body.decode());

    // Hacemos el query
    final customerQuery = Query<Customers>(context)
      ..where((x) => x.idCustomer).equalTo(id)
      ..values = customer;

    // Ejecutamos
    final updatedCustomer = await customerQuery.update();

    return updatedCustomer != null
        ? Response.ok(updatedCustomer)
        : Response.notFound();
  }

  @Operation.delete("idCustomer")
  Future<Response> deleteCustomer(@Bind.path("idCustomer") int id) async {
    // Hacemos el query
    final customerQuery = Query<Customers>(context)
      ..where((x) => x.idCustomer).equalTo(id);

    // Ejecutamos
    final deletedCustomer = await customerQuery.delete();

    return deletedCustomer != null
        ? Response.ok(deletedCustomer)
        : Response.notFound();
  }
}

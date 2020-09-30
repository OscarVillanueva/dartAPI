import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/Orders.dart';

class OrderController extends ResourceController {
  OrderController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllOrders() async {
    // Consulta al modelo
    final orderQuery = Query<Orders>(context);

    // Leemos los productos de la consulta
    final orders = await orderQuery.fetch();

    return Response.ok(orders);
  }

  @Operation.get("idOrder")
  Future<Response> getOrder(@Bind.path("idOrder") int id) async {
    // Consulta al modelo
    final orderQuery = Query<Orders>(context)
      ..where((x) => x.idOrder).equalTo(id);

    // Leemos los productos
    final order = await orderQuery.fetchOne();

    return order != null ? Response.ok(order) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addOrder() async {
    // Decodicamos los datos por parametro
    final order = Orders()
      ..read(await request.body.decode(), ignore: ["idOrder"]);

    // Hacemos el query
    final orderQuery = Query<Orders>(context)..values = order;

    // Insertamos el producto
    final addOrder = await orderQuery.insert();

    return Response.ok(addOrder);
  }

  @Operation.put("idOrder")
  Future<Response> updateOrder(@Bind.path("idOrder") int id) async {
    // Construimos el producto
    final order = Orders()..read(await request.body.decode());

    // Hacemos el query
    final orderQuery = Query<Orders>(context)
      ..where((x) => x.idOrder).equalTo(id)
      ..values = order;

    // Ejecutamos
    final updatedOrder = await orderQuery.update();

    return updatedOrder != null
        ? Response.ok(updatedOrder)
        : Response.notFound();
  }

  @Operation.delete("idOrder")
  Future<Response> deleteOrder(@Bind.path("idOrder") int id) async {
    // Hacemos el query
    final orderQuery = Query<Orders>(context)
      ..where((x) => x.idOrder).equalTo(id);

    // Ejecutamos
    final deletedOrder = await orderQuery.delete();

    return deletedOrder != null
        ? Response.ok(deletedOrder)
        : Response.notFound();
  }
}

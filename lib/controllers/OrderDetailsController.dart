import 'package:firstapi/firstapi.dart';
import 'package:firstapi/models/OrdersDetails.dart';

class OrderDetailsController extends ResourceController {
  OrderDetailsController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllDetails() async {
    // Consulta al modelo
    final detailQuery = Query<OrdersDetails>(context);

    // Leemos los productos de la consulta
    final details = await detailQuery.fetch();

    return Response.ok(details);
  }

  @Operation.get("idDetail")
  Future<Response> getDetail(@Bind.path("idDetail") int id) async {
    // Consulta al modelo
    final detailQuery = Query<OrdersDetails>(context)
      ..where((x) => x.idDetail).equalTo(id);

    // Leemos los productos
    final detail = await detailQuery.fetchOne();

    return detail != null ? Response.ok(detail) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addDetail() async {
    // Decodicamos los datos por parametro
    final detail = OrdersDetails()
      ..read(await request.body.decode(), ignore: ["idDetail"]);

    // Hacemos el query
    final detailQuery = Query<OrdersDetails>(context)..values = detail;

    // Insertamos el producto
    final addDetail = await detailQuery.insert();

    return Response.ok(addDetail);
  }

  @Operation.put("idDetail")
  Future<Response> updateDetail(@Bind.path("idDetail") int id) async {
    // Construimos el producto
    final detail = OrdersDetails()..read(await request.body.decode());

    // Hacemos el query
    final detailQuery = Query<OrdersDetails>(context)
      ..where((x) => x.idDetail).equalTo(id)
      ..values = detail;

    // Ejecutamos
    final updatedDetail = await detailQuery.update();

    return updatedDetail != null
        ? Response.ok(updatedDetail)
        : Response.notFound();
  }

  @Operation.delete("idDetail")
  Future<Response> deleteDetail(@Bind.path("idDetail") int id) async {
    // Hacemos el query
    final detailQuery = Query<OrdersDetails>(context)
      ..where((x) => x.idDetail).equalTo(id);

    // Ejecutamos
    final deletedDetail = await detailQuery.delete();

    return deletedDetail != null
        ? Response.ok(deletedDetail)
        : Response.notFound();
  }
}

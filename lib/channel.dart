import 'package:firstapi/controllers/CategoriesController.dart';
import 'package:firstapi/controllers/CustomersController.dart';
import 'package:firstapi/controllers/OrderDetailsController.dart';
import 'package:firstapi/controllers/OrdersController.dart';
import 'package:firstapi/controllers/RestrictedController.dart';
import 'package:firstapi/controllers/SignupController.dart';

import 'controllers/ProductsController.dart';
import 'firstapi.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class FirstapiChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  /// Contexto de la base de datos
  ManagedContext context;
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore(
        "helpDeskA", "helpdeska", "192.168.1.82", 5432, "sales");
    context = ManagedContext(dataModel, persistentStore);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    // router.route("/example").linkFunction((request) async {
    //   return Response.ok({"key": "value"});
    // });

    router
        .route("/products[/:idProduct]")
        .link(() => ProductsController(context));

    router
        .route("/categories[/:idCategory]")
        .link(() => CategoriesController(context));

    router
        .route("/customers[/:idCustomer]")
        .link(() => CustomersController(context));

    router
        .route("/details[/:idDetail]")
        .link(() => OrderDetailsController(context));

    router.route("/orders[/:idOrder]").link(() => OrderController(context));
    router.route("/signup").link(() => SignupController());
    router.route("/restricted").link(() => RestrictedController());

    return router;
  }
}

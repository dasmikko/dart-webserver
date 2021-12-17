import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiController {
  Response _rootHandler(Request req) {
    return Response.ok('Hello from API');
  }

  Router router() {
    var router = Router();

    router.get('/', _rootHandler);

    return router;
  }
}

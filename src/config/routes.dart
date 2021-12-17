import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/ApiController.dart';

class Routes {
  // Setup the routes
  Router setupRoutes() {
    var router = Router();

    // API Calls
    router.mount('/api/', ApiController().router());

    // Pass all other requests to the SPA
    router.all('/<name|.*>', (Request req) async {
      var indexFile = await File(Directory.current.path + '/public/index.html')
          .readAsString();
      return Response.ok(indexFile, headers: {'content-type': 'text/html'});
    });

    return router;
  }
}

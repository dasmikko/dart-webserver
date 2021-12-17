import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import '../src/config/routes.dart';

// Configure routes.
final _router = Routes().setupRoutes();

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final cascade = Cascade()
      // First, serve files from the 'public' directory
      .add(createStaticHandler('public', defaultDocument: 'index.html'))
      // If a corresponding file is not found, send requests to a `Router`
      .add(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await io.serve(
      logRequests()
          // See https://pub.dev/documentation/shelf/latest/shelf/MiddlewareExtensions/addHandler.html
          .addHandler(cascade.handler),
      ip,
      port);
  print('Server listening on ${server.address.host}:${server.port}');
}

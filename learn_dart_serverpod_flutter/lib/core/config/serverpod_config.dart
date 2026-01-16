import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:learn_dart_serverpod_client/learn_dart_serverpod_client.dart';

/// Serverpod client configuration
class ServerpodClientConfig {
  static late Client client;

  /// Initialize the Serverpod client
  static void initialize() {
    client = Client(
      'http://localhost:8083/',
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_dart_serverpod_client/learn_dart_serverpod_client.dart';
import '../config/serverpod_config.dart';

/// Provider for Serverpod client
final serverpodClientProvider = Provider<Client>((ref) {
  return ServerpodClientConfig.client;
});

/// Provider for current user ID (hardcoded for now, replace with auth later)
final currentUserIdProvider = Provider<int>((ref) {
  return 1; // TODO: Replace with actual authenticated user ID
});

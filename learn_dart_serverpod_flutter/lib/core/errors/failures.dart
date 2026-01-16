import 'package:dartz/dartz.dart';

/// Base class for all failures in the application
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Generic failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}

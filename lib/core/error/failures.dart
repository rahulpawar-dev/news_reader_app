abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'A server error occurred. Please try again.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection. Please check your network.']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Connection timed out. Please try again.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to load offline data.']);
}
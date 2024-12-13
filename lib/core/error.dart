class CustomError {
  final String message;

  CustomError([this.message = '']);

  @override
  String toString() => message;
}

class NetworkError extends CustomError {
  NetworkError([super.message = 'A network error occurred']);
}

class ServerError extends CustomError {
  ServerError([super.message = 'A server error occurred']);
}

class CacheError extends CustomError {
  CacheError([super.message = 'A cache error occurred']);
}

class AuthenticationError extends CustomError {
  AuthenticationError([super.message = 'Authentication failed']);
}

class UnknownError extends CustomError {
  UnknownError([super.message = 'An unknown error occurred']);
}

CustomError exceptionToError(dynamic e, [String? message]) {
  switch (e.runtimeType) {
    case const (CacheError):
      return CacheError(message ??
          'Failed to get user data from cache. Please try again later.');
    case const (AuthenticationError):
      return AuthenticationError(
          message ?? 'Invalid credentials. Please try again.');

    default:
      return UnknownError(
          message ?? 'An unexpected error occurred. Please try again later.');
  }
}

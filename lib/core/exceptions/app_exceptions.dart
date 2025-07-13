class AppException implements Exception {
  final String message;
  final String prefix;

  AppException(this.message, this.prefix);

  @override
  String toString() {
    return '$prefix: $message';
  }
}

class InternetException extends AppException {
  InternetException([String? message])
      : super(message ?? 'No internet', 'Internet');
}

class RequestTimeoutException extends AppException {
  RequestTimeoutException([String? message])
      : super(message ?? 'Request timed out', 'Request Timeout');
}

class ServerException extends AppException {
  ServerException([String? message])
      : super(message ?? 'Internal server error', 'Server');
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message])
      : super(message ?? 'Invalid URL', 'Invalid URL');
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message ?? 'Error during data fetching', 'Fetch Data');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message])
      : super(message ?? 'Error during data fetching', 'UnAuthorized');
}

class AuthException extends AppException {
  final String message;
  AuthException(this.message) : super(message, "");
}

// AuthException mapFirebaseAuthException(FirebaseAuthException e) {
//   switch (e.code) {
//     case 'invalid-email':
//       return AuthException('Invalid email format.');
//     case 'user-disabled':
//       return AuthException('This user account has been disabled.');
//     case 'user-not-found':
//       return AuthException('No user found with that email.');
//     case 'wrong-password':
//       return AuthException('Incorrect password.');
//     case 'email-already-in-use':
//       return AuthException(
//           'The email address is already in use by another account.');
//     case 'operation-not-allowed':
//       return AuthException('Email/password accounts are not enabled.');
//     case 'weak-password':
//       return AuthException('The password is too weak.');
//     default:
//       return AuthException('Authentication failed: ${e.message}');
//   }
// }

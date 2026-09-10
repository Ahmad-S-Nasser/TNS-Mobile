part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? userId;
  final String? email;
  final String? role;
  final bool isSubmitting;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.userId,
    this.email,
    this.role,
    this.isSubmitting = false,
    this.errorMessage,
  });

  const AuthState.unknown() : this(status: AuthStatus.unknown);

  const AuthState.unauthenticated({String? errorMessage})
      : this(status: AuthStatus.unauthenticated, errorMessage: errorMessage);

  const AuthState.authenticated({
    required String userId,
    required String email,
    required String role,
  }) : this(
          status: AuthStatus.authenticated,
          userId: userId,
          email: email,
          role: role,
        );

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({bool? isSubmitting, String? errorMessage}) => AuthState(
        status: status,
        userId: userId,
        email: email,
        role: role,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props =>
      [status, userId, email, role, isSubmitting, errorMessage];
}

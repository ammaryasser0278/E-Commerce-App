import 'package:equatable/equatable.dart';

/// Base class for all authentication states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app starts
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state during authentication operations
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Success state when authentication is successful
class AuthSuccess extends AuthState {
  final String message;
  final String? userId;

  const AuthSuccess({required this.message, this.userId});

  @override
  List<Object?> get props => [message, userId];
}

/// Error state when authentication fails
class AuthError extends AuthState {
  final String message;
  final String? errorCode;

  const AuthError({required this.message, this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}

/// State when user is signed out
class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

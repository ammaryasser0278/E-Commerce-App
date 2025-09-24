import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supplements_app/features/auth_feature/logic/repository/auth_repository.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_state.dart';

/// Cubit for managing authentication state and business logic
/// This class handles all authentication operations and state management
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository(),
      super(const AuthInitial());

  /// Get the current user
  User? get currentUser => _authRepository.currentUser;

  /// Get authentication state stream
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  /// Sign up with email and password
  /// Emits loading state, then success or error state
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthLoading());

      final userCredential = await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        emit(
          AuthSuccess(
            message: 'Account created successfully! Please verify your email.',
            userId: userCredential.user!.uid,
          ),
        );

        // Send email verification
        await _sendEmailVerification();
      } else {
        emit(
          const AuthError(
            message: 'Failed to create account. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(AuthError(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Sign in with email and password
  /// Emits loading state, then success or error state
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthLoading());

      final userCredential = await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        emit(
          AuthSuccess(
            message: 'Welcome back! You have signed in successfully.',
            userId: userCredential.user!.uid,
          ),
        );
      } else {
        emit(const AuthError(message: 'Failed to sign in. Please try again.'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Sign out the current user
  /// Emits loading state, then signed out state
  Future<void> signOut() async {
    try {
      emit(const AuthLoading());

      await _authRepository.signOut();

      emit(const AuthSignedOut());
    } catch (e) {
      emit(AuthError(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Send password reset email
  /// Emits loading state, then success or error state
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      emit(const AuthLoading());

      await _authRepository.sendPasswordResetEmail(email: email);

      emit(
        const AuthSuccess(
          message: 'Password reset email sent! Please check your inbox.',
        ),
      );
    } catch (e) {
      emit(AuthError(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Send email verification to the current user
  /// This is called internally after successful sign up
  Future<void> _sendEmailVerification() async {
    try {
      await _authRepository.sendEmailVerification();
    } catch (e) {
      // Don't emit error for email verification failure
      // as the user is already signed up successfully
      // print('Failed to send email verification: ${e.toString()}');
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Check if user's email is verified
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  /// Get user's email
  String? get userEmail => currentUser?.email;

  /// Get user's display name
  String? get userDisplayName => currentUser?.displayName;

  /// Reset state to initial
  void resetState() {
    emit(const AuthInitial());
  }
}

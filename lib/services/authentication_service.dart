import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  User? get user => FirebaseAuth.instance.currentUser;

  Future<Either<String, Unit>> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      try {
        await credential.user?.updateDisplayName(name);
      } on FirebaseAuthException catch (err) {
        // El usuario ya fue creado; un fallo al guardar el nombre no debe
        // invalidar el registro.
        debugPrint('Error updating display name: $err');
      }

      return right(unit);
    } on FirebaseAuthException catch (err) {
      debugPrint('Error creating user: $err');

      return left(_authErrorMessage(err));
    } catch (err) {
      debugPrint('Unexpected error creating user: $err');

      return left('Ocurrió un error inesperado. Inténtalo de nuevo.');
    }
  }

  Future<Either<String, Unit>> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(unit);
    } on FirebaseAuthException catch (err) {
      debugPrint('Error signing in: $err');

      return left(_authErrorMessage(err));
    } catch (err) {
      debugPrint('Unexpected error signing in: $err');

      return left('Ocurrió un error inesperado. Inténtalo de nuevo.');
    }
  }

  Future<Either<String, Unit>> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();

      return right(unit);
    } catch (err) {
      debugPrint('Error signing out: $err');

      return left('No se pudo cerrar la sesión. Inténtalo de nuevo.');
    }
  }

  String _authErrorMessage(FirebaseAuthException err) {
    switch (err.code) {
      case 'weak-password':
        return 'La contraseña proporcionada es demasiado débil.';
      case 'email-already-in-use':
        return 'El correo ya se encuentra registrado.';
      case 'invalid-email':
        return 'El correo electrónico no es válido.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'user-disabled':
        return 'Esta cuenta se encuentra deshabilitada.';
      case 'too-many-requests':
        return 'Demasiados intentos fallidos. Inténtalo más tarde.';
      case 'network-request-failed':
        return 'No se pudo conectar con el servidor. '
            'Verifica tu conexión a internet.';
      case 'operation-not-allowed':
        return 'El inicio de sesión con correo no está habilitado.';
      default:
        return 'Ocurrió un error inesperado. Inténtalo de nuevo.';
    }
  }
}

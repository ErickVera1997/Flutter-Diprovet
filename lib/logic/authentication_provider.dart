import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_diprovet_cliente/services/authentication_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider({required this.service});

  final AuthenticationService service;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? get user => service.user;

  Future<Either<String, Unit>> createUser({
    required String name,
    required String email,
    required String password,
  }) {
    return _run(
      () => service.createUser(name: name, email: email, password: password),
    );
  }

  Future<Either<String, Unit>> signInUser({
    required String email,
    required String password,
  }) {
    return _run(() => service.signInUser(email: email, password: password));
  }

  Future<Either<String, Unit>> logOutUser() {
    return _run(service.logOutUser);
  }

  Future<Either<String, Unit>> _run(
    Future<Either<String, Unit>> Function() action,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      return await action();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

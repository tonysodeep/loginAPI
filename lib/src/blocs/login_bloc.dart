import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:login_bloc/src/blocs/validators.dart';

class LoginBloc with Validators {
  int a = 0;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _authController = BehaviorSubject();

  //Change data
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  //add data to stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _authController.sink.add(validateEmail);
    _authController.sink.add(validPassword);
    
    print('Email is $validEmail and password $validPassword');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _authController.close();
  }
}

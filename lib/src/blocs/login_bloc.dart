import 'dart:async';
import 'package:login_bloc/src/models/login_model.dart';
import 'package:login_bloc/src/resources/login_api_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:login_bloc/src/blocs/validators.dart';

class LoginBloc with Validators {
  int a = 0;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _authController = BehaviorSubject<LoginResponseModel>();
  final _repository = LoginAPIProvider();

  //Change data
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  Stream<LoginResponseModel> get authValidation => _authController.stream;

  //add data to stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit() async {
    final requestModel = LoginRequestModel(
      email: _emailController.value,
      password: _passwordController.value,
    );
    final response = await _repository.login(requestModel);
    _authController.sink.add(response);
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _authController.close();
  }
}

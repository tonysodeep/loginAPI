import 'dart:async';
import 'package:login_bloc/src/models/login_model.dart';
import 'package:login_bloc/src/models/password_icon_event.dart';
import 'package:login_bloc/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:login_bloc/src/blocs/validators.dart';

class LoginBloc with Validators {
  bool obscure = true;
  String _passwordText = '';
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _authController = BehaviorSubject<LoginResponseModel>();
  final _obscureControllerEvent = StreamController<PasswordIconEvent>();
  final _obscureControllerState = BehaviorSubject<bool>.seeded(true);
  final _repository = Repository();

  //Change data
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  Stream<LoginResponseModel> get authValidation => _authController.stream;

  Stream<bool> get obscureState => _obscureControllerState.stream;
  LoginBloc() {
    _obscureControllerEvent.stream.listen((data) {
      if (data is PasswordIconHideEvent) {
        obscure = false;
      } else {
        obscure = true;
      }
      _obscureControllerState.sink.add(obscure);
    });
  }

  //add data to stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String getPassword() {
    return this._passwordText;
  }

  setPassword(String pass) {
    this._passwordText = pass;
  }

  StreamSink<PasswordIconEvent> get obscureEvent =>
      _obscureControllerEvent.sink;

  submit() async {
    final requestModel = LoginRequestModel(
      email: _emailController.value,
      password: _passwordController.value,
    );

    print(requestModel.email);
    final response = await _repository.login(requestModel);
    response.isClicked = true;
    _authController.sink.add(response);
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _authController.close();
    _obscureControllerEvent.close();
    _obscureControllerState.close();
  }
}

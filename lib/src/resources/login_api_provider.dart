import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:login_bloc/src/models/login_model.dart';
import 'package:login_bloc/src/resources/repository.dart';

final _root = 'reqres.in';

class LoginAPIProvider implements Author {
  Client client = new Client();

  @override
  Future<LoginResponseModel> loginApi(LoginRequestModel loginRequestModel) async{
    final response = await client.post(
      Uri.https(
        _root,
        'api/login',
      ),
      body: loginRequestModel.toJson(),
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(LoginResponseModel.fromJson(json.decode(response.body)).token);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}

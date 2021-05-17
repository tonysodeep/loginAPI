import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:login_bloc/src/models/login_model.dart';

final _root = 'reqres.in';

class LoginAPIProvider {
  Client client = new Client();
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    final response = await client.post(
      Uri.https(
        _root,
        'api/login',
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      // print(LoginResponseModel.fromJson(json.decode(response.body)).error);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
